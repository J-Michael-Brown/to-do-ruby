require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/list')
require('./lib/task')
require('pry')
require('pg')

DB = PG.connect({:dbname => "to_do"})

get ('/') do
  @lists = List.all
  erb(:input)
end

post ('/') do
  new_list_owner = params.fetch('new-list')
  temp_list = List.new({:name => new_list_owner, :id => nil})
  # new_owner_tasks =
  temp_list.save
  @lists = List.all
  erb(:input)
end

get ('/my_list/:list_id') do
  list_id = params[:list_id].to_i
  @list = List.find(list_id)
  @tasks = Task.for_list_id(list_id)
  erb(:my_list)
end

post ('/my_list/:list_id') do
  list_id = params[:list_id].to_i
  @list = List.find(list_id)
  new_description = params.fetch('new-task')
  new_task = Task.new({:description => new_description, :list_id => list_id})
  new_task.save
  @tasks = Task.for_list_id(list_id)
  erb(:my_list)
end

get ('/my_list/task/:task_id') do
  @task = Task.find(params[:task_id])
  erb(:task)
end

patch ('/my_list/task/:task_id') do
  description = params.fetch("description")
  @task = Task.find(params[:task_id].to_i)
  @task.update({:description => description})
  erb(:task)
end

delete ('/my_list/:list_id/:task_id') do
  task_id = params[:task_id].to_i
  task = Task.find(task_id)
  task.delete
  list_id = params[:list_id].to_i

  @list = List.find(list_id)
  @tasks = Task.for_list_id(list_id)
  erb(:my_list)
end

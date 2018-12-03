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
  new_owner_tasks =
  temp_list.save
  @lists = List.all
  erb(:input)
end

get ('/my_list/:list_id') do
  list_id = params[:list_id].to_i
  current_list = List.all[list_id-1]
  @list = current_list
  all_tasks = Task.all
  display_tasks = []
  all_tasks.each do |task|
    if task.list_id == list_id
      display_tasks.push(task)
    end
  end
  @tasks = display_tasks
  erb(:my_list)
end

require('capybara/rspec')
require('./app')
require('pry')
require('list')
require('task')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('Task add testing', {:type => :feature}) do

  test_list = List.new({:name => "tester", :id =>nil})
  test_list.save
  test_id = test_list.id.to_i

  it('view new task') do
    site = ('/my_list/' + test_id.to_s)
    visit(site)
    expect(page).to have_content('tester')
  end


end

require('capybara/rspec')
require('./app')
require('pry')
require('list')
require('task')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

def start_test(list)
  visit('/')
  fill_in('new-list', :with => list)
  click_button('Make My List!')
  click_link(list)
end

describe('Add task to list', {:type => :feature}) do

  it('view new task') do
    start_test('new task test')
    expect(page).to have_content('Enter task description:')
  end

  it('view new task') do
    start_test('view task test')
    fill_in('new-task', :with => 'This is a new task!')
    click_button('Submit!')
    expect(page).to have_content('This is a new task!')
  end

end

require('capybara/rspec')
require('./app')
require('pry')
require('list')
require('task')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

def start_test(string)
  visit('/')
  fill_in('new-list', :with => string)
  click_button('Make My List!')
  click_link(string)
end

describe('Task add testing', {:type => :feature}) do

  it('view new task') do
    start_test('tester')
    expect(page).to have_content('Enter task description:')
  end

  it('view new task') do
    start_test('tester')
    fill_in('new-task', :with => 'This is a new task!')
    click_button('Submit!')
    expect(page).to have_content('This is a new task!')
  end

end

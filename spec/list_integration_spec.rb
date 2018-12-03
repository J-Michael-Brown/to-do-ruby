require('capybara/rspec')
require('./app')
require('pry')
require('list')
require('task')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('website testing', {:type => :feature}) do
  it('User Input new List item') do
    visit('/')
    fill_in('new-list', :with => 'My List 1')
    click_button('Make My List!')
    fill_in('new-list', :with => 'My List 2')
    click_button('Make My List!')
    fill_in('new-list', :with => 'My List 3')
    click_button('Make My List!')
    expect(page).to have_content('My List 1')
    expect(page).to have_content('My List 2')
    expect(page).to have_content('My List 3')
  end


end

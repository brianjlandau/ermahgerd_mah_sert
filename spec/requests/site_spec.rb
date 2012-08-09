require "spec_helper"

feature 'ERMAHGERD MAH SERT' do
  scenario "A visitor goes to the homepage" do
    visit "/"
    page.should have_content("ERMAHGERD MAH SERT")
  end
end

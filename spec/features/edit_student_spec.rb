require 'rails_helper'

RSpec.describe 'Edit student', type: :feature do
  let!(:student) { create(:student) }

  scenario 'good - valid attributes' do
    visit students_path
    find_link(href: "/students/#{student.id}").click
    find_link(href: "/students/#{student.id}/edit").click
    fill_in 'Name', with: 'New name'
    fill_in 'Email', with: 'new_email@example.com'
    find("button[type='submit']").click

    expect(page).to have_content('Student successfully updated.')
    expect(page).to have_current_path(students_path)
  end

  scenario 'bad - invald atributes' do
    visit students_path
    find_link(href: "/students/#{student.id}").click
    find_link(href: "/students/#{student.id}/edit").click
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'invalid_email.something.@com'
    find("button[type='submit']").click

    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Email is invalid')
  end
end
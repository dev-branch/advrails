require 'rails_helper'

RSpec.feature "Klasses", type: :feature do
    context 'authenticated' do
    before(:each) do
      visit '/users/sign_in'
      fill_in 'user[email]', with: 'sue@aol.com'
      fill_in 'user[password]', with: 'pass1234'
      click_button 'Log in'
    end

    scenario 'view list of users' do
      visit '/klasses'
      expect(page).to have_text('Functional Programming')
    end

    scenario 'add a klass' do
      visit '/klasses/new'
      fill_in 'klass[name]', with: 'biology'
      fill_in 'klass[subject]', with: 'science'
      fill_in 'klass[level]', with: '275'
      fill_in 'klass[credits]', with: '5'
      click_button 'Create Class'
      expect(page).to have_text('biology')
    end
  end
end

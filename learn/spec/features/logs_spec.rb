require 'rails_helper'

RSpec.feature "Logs", type: :feature do
  context 'authenticated' do
    before(:each) do
      visit '/users/sign_in'
      fill_in 'user[email]', with: 'sue@aol.com'
      fill_in 'user[password]', with: 'pass1234'
      click_button 'Log in'
    end

    scenario 'view access logs' do
      visit '/logs'
      expect(page).to have_text('home')
      expect(page).to have_text('index')
      expect(page).to have_text('sessions')
    end
  end
end

require 'rails_helper'

RSpec.feature "Registrations", type: :feature do
    context 'authenticated' do
    before(:each) do
      visit '/users/sign_in'
      fill_in 'user[email]', with: 'sue@aol.com'
      fill_in 'user[password]', with: 'pass1234'
      click_button 'Log in'
    end

    scenario 'view list of registrations' do
      visit '/registrations'
      expect(page).to have_text('English')
    end

    scenario 'add a registration' do
      visit '/registrations/new'
      fill_in 'registration[year]', with: '2017'
      fill_in 'registration[capacity]', with: '999'
      select 'Physics 2', from: 'registration[klass_id]'
      select 'sue@aol.com', from: 'registration[teacher_id]'
      select 'Spring', from: 'registration[semester]'
      click_button 'Create Registration'
      expect(page).to have_text('999')
    end
  end
end

# Capybara Debugging Examples
#
# # Method 1: Using save_and_open_page
# it 'allows a vendor to sign up' do
#   visit '/login?vendor=true'
#   save_and_open_page
#   # ... rest of the test
# end
#
# # Method 2: Using binding.pry
# require 'pry'
#
# it 'allows a vendor to sign up' do
#   visit '/login?vendor=true'
#   binding.pry
#   # ... rest of the test
# end
#
# # Method 3: Using Capybara's pause method
# it 'allows a vendor to sign up' do
#   visit '/login?vendor=true'
#   page.pause
#   # ... rest of the test
# end
#
# # Method 4: Taking a screenshot
# it 'allows a vendor to sign up' do
#   visit '/login?vendor=true'
#   page.save_screenshot('screenshot.png')
#   # ... rest of the test
# end

require 'rails_helper'

RSpec.describe 'Vendor Sign Up', type: :feature do
  it 'allows a vendor to sign up' do
    visit '/login?vendor=true'

    # Ensure we're on the sign up form
    expect(page).to have_content('Vendor Sign Up')

    # Fill in the form fields
    within '#signup_form' do
      fill_in 'identifier', with: 'vendor@example.com'
      fill_in 'password', with: 'password123'
      fill_in 'password_confirmation', with: 'password123'
      select 'Eat & Drink', from: 'category'
      fill_in 'name', with: 'My Awesome Business'

      click_button 'Sign Up'
    end

    # Expectations after successful sign up
    # Note: You'll need to adjust these based on your actual application behavior
    expect(page).to have_content('Preview Listing') # Or whatever success message you display
    expect(page).to have_content('Edit Listing') # Or whatever success message you display
    # expect(page).to have_current_path('/dashboard') # Adjust to your actual post-signup path

    # Check if the user was created in the database
    expect(User.find_by(identifier: 'vendor@example.com')).to be_present
  end

  it 'shows error messages for invalid input' do
    visit '/login?vendor=true'

    within '#signup_form' do
      # Submit the form without filling in any fields
      click_button 'Sign Up'
    end

    # Expect error messages
    expect(page).to have_content('Please provide a valid email address')
    expect(page).to have_content('Please enter your password')
    expect(page).to have_content('Please confirm your password')
    expect(page).to have_content('Please select a category')
    expect(page).to have_content('Please enter your business name')
  end

  it 'allows switching between sign up and sign in forms' do
    visit '/login?vendor=true'

    expect(page).to have_content('Vendor Sign Up')

    # Switch to sign in
    find('label', text: 'Sign In').click
    expect(page).to have_content('Vendor Sign In')
    expect(page).not_to have_content('Vendor Sign Up')

    # Switch back to sign up
    find('label', text: 'Sign Up').click
    expect(page).to have_content('Vendor Sign Up')
    expect(page).not_to have_content('Vendor Sign In')
  end
end

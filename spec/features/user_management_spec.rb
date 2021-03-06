require_relative '../web_helper.rb'
require_relative '../helpers/session.rb'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'requires a matching confirmation password' do
    expect{ sign_up(password_confirmation: 'wrong')}.not_to change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Password does not match the confirmation'
  end

  def sign_up(email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
    visit '/users/new'
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end

  scenario "user can't sign up without an email" do
    expect {sign_up(email: nil)}.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Email must not be blank")
  end

  scenario "user can't sign up with an invalid email address" do
    expect{sign_up(email: "invalid@email") }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Email has an invalid format")
  end

  scenario "user cannot sign up with an existing user" do
    sign_up
    expect {sign_up}.to_not change(User, :count)
    expect(page).to have_content('Email is already taken')
  end
end

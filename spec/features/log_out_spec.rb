feature 'User logs out' do

  before(:each) do
    User.create(email: 'test@test.com', password: 'test', password_confirmation: 'test')
  end

  scenario 'while being signed in' do
    log_in( email: 'test@test.com', password: 'test')
    click_button 'Log out'
    expect(page).to have_content('goodbye!')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

  # def log_in(email:, password:)
  #   visit ('/sessions/new')
  #   fill_in 'email', with: email
  #   fill_in :password, with: password
  #   click_button 'Log in'
  # end
end

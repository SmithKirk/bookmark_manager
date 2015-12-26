feature 'user log in' do

  let(:user) do
    User.create(email: 'user@example.com', password: 'secret1234', password_confirmation: 'secret1234')
  end

  scenario 'with correct credentials' do
    log_in(email: user.email, password: user.password)
    expect(page).to have_content("Welcome, #{user.email}")
  end

  def log_in(email:, password:)
    visit ('/sessions/new')
    fill_in 'email', with: email
    fill_in :password, with: password
    click_button 'Log in'
  end
end

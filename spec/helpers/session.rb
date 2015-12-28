module SessionHelpers

  def log_in(email:, password:)
    visit ('/sessions/new')
    fill_in 'email', with: email
    fill_in :password, with: password
    click_button 'Log in'
  end

  def sign_up(email: 'alice@example.com', password: '12345678', password_confirmation: '12345678')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email,     with: 'alice@example.com'
    fill_in :password,  with: 'oranges!'
    click_button 'Sign up'
  end
end

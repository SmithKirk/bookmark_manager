feature 'Creating links' do
  scenario 'add links to bookmark' do
    visit('/links')
    click_link('Add bookmark')
    fill_in 'title', with: 'This is Zombocom'
    fill_in 'url', with: 'http://www.zombo.com/'
    click_button 'Create link'
    expect(current_path).to eq '/links'
    within 'ul#links' do
      expect(page).to have_content('This is Zombocom')
    end
  end
end

feature 'should add tag to link' do
  scenario 'add tag to a tag' do
    visit('/')
    click_link('Add bookmark')
    fill_in 'title', with: 'This is Zombocom'
    fill_in 'url', with: 'http://www.zombo.com/'
    fill_in 'title' with: 'News'
    click_button('Create')
    expect(current_path).to eq '/links'
    expect(page).to have_content 'News'
  end

end

feature 'should add tag to link' do
  scenario 'add tag to a tag' do
    visit('/')
    click_link('Add bookmark')
    fill_in 'title', with: 'This is Zombocom'
    fill_in 'url', with: 'http://www.zombo.com/'
    fill_in 'tags', with: 'News'
    click_button('Create')
    expect(current_path).to eq '/links'
    expect(page).to have_content 'News'
  end

  scenario 'I can add a single tag to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tags',  with: 'education'

    click_button 'Create link'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
  end

end

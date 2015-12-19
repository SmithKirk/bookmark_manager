feature 'Viewing links' do
  scenario 'see bookmarked links on homepage' do
    Link.create(url: 'http://makersacademy.com', title: 'Makers Academy')

    visit '/links'

    expect(page.status_code).to eq 200 #quick check, remove later
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end


  
end

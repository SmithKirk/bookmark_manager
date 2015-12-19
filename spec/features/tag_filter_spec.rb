feature 'can filter links by tag' do
  scenario 'user can view links with matching tags' do
    education_tag = Tag.create(name: 'Education')
    news_tag = Tag.create(name: 'News')
    gaming_tag = Tag.create(name: 'Gaming')

    Link.create(url: 'http://makersacademy.com', title: 'Makers Academy', tags: [education_tag])
    Link.create(url: 'http://bbc.com', title: 'BBC', tags: [news_tag])
    Link.create(url: 'http://sky.com', title: 'Sky', tags: [news_tag])
    Link.create(url: 'http://game.com', title: 'Game', tags: [gaming_tag])

    visit '/tags/news'
    within 'ul#links' do
      expect(page).to have_content 'Title: BBC URL: http://bbc.com Title: Sky URL: http://sky.com'
      expect(page).not_to have_content 'Title: Gsme URL: http://game.com'
    end
  end
end

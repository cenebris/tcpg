require 'rails_helper'

describe 'Movies requests', type: :request do

  describe 'movie index acion' do
    let!(:movie) { FactoryGirl.create(:movie) }
    it 'displays movie index' do
      visit '/movies'
      expect(page).to have_selector('h1', text: 'Movie')
      expect(page).to have_selector('.navbar-default .navbar-nav > li > a', text: 'Movies')
      expect(page).to have_selector('.navbar-default .navbar-nav > li > a', text: 'Genres')

      expect(page).to have_selector('body > main > div > div.row > div > table > tbody > tr:nth-child(1) > td:nth-child(3) > h4 > a',
                                    text: "#{movie.title}")

    end
  end

  describe 'movie show action' do
    let!(:movie) { FactoryGirl.create(:movie, title: 'Godfather').decorate }
    let(:overview) { 'Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.' }
    let(:vote_average) { 8.3 }
    let(:poster) { 'https://image.tmdb.org/t/p/w500/d4KNaTrltq6bpkFS01pYtyXa09m.jpg' }
    it 'gets data from tmdb' do
      expect(movie.tmdb_poster).to eq poster
      expect(movie.tmdb_vote_average).to eq vote_average
      expect(movie.tmdb_overview).to eq overview
    end

    it 'renders data from tmdb' do
      visit "/movies/#{movie.id}"
      expect(page).to have_selector('body > main > div > div.jumbotron > div > div:nth-child(2) > div:nth-child(2)', text: overview)
      expect(page).to have_selector('body > main > div > div.jumbotron > div > div:nth-child(2) > div:nth-child(2)', text: vote_average)
      expect(page).to have_css("img[src*='image.tmdb.org']")
    end
  end

end

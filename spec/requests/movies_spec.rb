require 'rails_helper'

describe 'Movies requests', type: :request do

  describe 'movies list in json' do
    let!(:movie) { FactoryGirl.create(:movie) }
    let!(:movie2) { FactoryGirl.create(:movie) }
    it 'displays movies list in json format' do
      headers = { 'ACCEPT' => 'application/json' }
      get '/api/movies', headers
      expect(response.content_type).to eq 'application/json'
      expect(response).to have_http_status :ok
      expect(response.body).to eq "[{\"id\":#{movie.id},\"title\":\"#{movie.title}\"},{\"id\":#{movie2.id},\"title\":\"#{movie2.title}\"}]"
    end
    it 'displays single movie in json format' do
      headers = { 'ACCEPT' => 'application/json' }
      get "/api/movies/#{movie.id}", headers
      expect(response.content_type).to eq 'application/json'
      expect(response).to have_http_status :ok
      expect(response.body).to eq "{\"id\":#{movie.id},\"title\":\"#{movie.title}\"}"
    end
  end

end

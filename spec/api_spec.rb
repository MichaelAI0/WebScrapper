# spec/api_spec.rb
require 'rspec'
require 'json'
require 'open-uri'
require_relative '../lib/api'

describe API do
  let(:api) { API.new("your-search-query") }

  describe '#search_anime' do
    it 'returns a Nokogiri::HTML::Document object' do
      expect(api.search_anime).to be_a(Nokogiri::HTML::Document)
    end
  end

  describe '#search_manga' do
    it 'returns a Nokogiri::HTML::Document object' do
      expect(api.search_manga).to be_a(Nokogiri::HTML::Document)
    end
  end

  describe '#parse_results_anime' do
    it 'returns a JSON string' do
      expect(api.parse_results_anime).to be_a(String)
      expect { JSON.parse(api.parse_results_anime) }.not_to raise_error
    end

    it 'returns a list of anime data' do
      anime_data = JSON.parse(api.parse_results_anime)
      expect(anime_data).to be_a(Array)
      expect(anime_data.first).to have_key('title')
      expect(anime_data.first).to have_key('description')
    end
  end

  describe '#parse_results_manga' do
    it 'returns a JSON string' do
      expect(api.parse_results_manga).to be_a(String)
      expect { JSON.parse(api.parse_results_manga) }.not_to raise_error
    end

    it 'returns a list of manga data' do
      manga_data = JSON.parse(api.parse_results_manga)
      expect(manga_data).to be_a(Array)
      expect(manga_data.first).to have_key('title')
      expect(manga_data.first).to have_key('description')
    end
  end
end
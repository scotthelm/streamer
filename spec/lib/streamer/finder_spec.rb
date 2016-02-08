require 'spec_helper'
describe Streamer::Finder do
  before :each do
    @finder = Streamer::Finder.new(
      Streamer::FactProviders::HashProvider.new(
        example: {
          nfl_teams: {
            panthers: {
              wins: 15
            }
          }
        }
      )
    )
  end

  it 'must have a fact provider' do
    @finder.fact_provider.wont_be_nil
  end

  it 'finds a value for a given key' do
    @finder.find('example.nfl_teams.panthers.wins').must_equal 15
  end

  it 'has a default provider' do
    Streamer::Finder.new.fact_provider
                    .must_be_kind_of Streamer::FactProviders::HashProvider
  end
end

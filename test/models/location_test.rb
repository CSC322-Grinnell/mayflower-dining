require 'test_helper'

class LocationTest < ActiveSupport::TestCase
    test 'get locations' do
        locs=Location.all
        assert locs.length()==3
        locs.each do |loc|
            assert_instance_of(String,loc.name)
            assert_instance_of(Integer,loc.population)
            assert loc.population>=0
        end
    end
end

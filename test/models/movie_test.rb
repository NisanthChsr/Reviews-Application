require 'test-helper'

class MovieTest < ActiveSupport::TestCase

    test 'Is a Movie valid?' do
        @movie = Movie.new(title: 'test_Movie_title', director: 'test_Movie_director', rating: 7)
        assert @movie.valid?
    end

    test 'can the Title be empty?' do
        @movie = Movie.new(title: '', director: 'check', rating: 1)
        assert_not @movie.valid?
      end
    
      test 'can the director be empty?' do
        @movie = Movie.new(title: 'Test', director: ' ', rating: 1)
        assert_not @movie.valid?
      end
    
      test 'can the Rating be empty?' do
        @movie = Movie.new(title: 'Test', director: 'check', rating: ' ')
        assert_not @movie.valid?
      end

end
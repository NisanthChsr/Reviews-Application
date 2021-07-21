require 'test-helper'

class BookTest < ActiveSupport::TestCase

    test 'Is a Book valid?' do
        @book = Book.new(title: 'test_book_title', author: 'test_book_author', rating: 7)
        assert @book.valid?
    end

    test 'can the Title be empty?' do
        @book = Book.new(title: '', author: 'check', rating: 1)
        assert_not @book.valid?
      end
    
      test 'can the Authorbe empty?' do
        @book = Book.new(title: 'Test', author: ' ', rating: 1)
        assert_not @book.valid?
      end
    
      test 'can the Rating be empty?' do
        @book = Book.new(title: 'Test', author: 'check', rating: ' ')
        assert_not @book.valid?
      end

end
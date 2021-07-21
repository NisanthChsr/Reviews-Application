class Post < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  has_many :comments, dependent: :destroy
end

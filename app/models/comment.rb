class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :request


  validates_presence_of :content
  validates_length_of :content, within: 1..100, message: "comment must be between 10 and 100 characters"

  default_scope { order(created_at: :asc) }
  
end

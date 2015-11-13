class Sentence < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 200 }
  validates :body, presence: true, length: { maximum: 100000 }

  extend FriendlyId
  friendly_id :title, use: :slugged
end

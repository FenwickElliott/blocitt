class Sponsoredpost < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :topic
end

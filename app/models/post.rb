class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :topic
    belongs_to :user

    default_scope {order('created_at DESC')}
    scope :ordered_by_title, -> {order('title DESC')}
    scope :order_by_reverse_created_at, -> {order('created_at ASC')}

    validates :title, length: {minimum: 5, maximum: 100}, presence: true
    validates :body, length: {minimum: 20}, presence: true
    validates :topic, presence: true
    validates :user, presence: true
end

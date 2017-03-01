class User < ApplicationRecord
    before_save { self.email = email.downcase if email.present? }

    before_save :pCase

    validates :name, length: {minimum: 1, maximum: 100 }, presence: true

    validates :password, presence: true, length: { minimum: 6}, if: "password_digest.nil?"
    validates :password, length: {minimum: 6}, allow_blank: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 3, maxium: 254}

    has_secure_password

    def pCase
        if name
            n = self.name.downcase.split
            n.each do |i|
                i.capitalize!
            end
            self.name = n.join(' ')
        end
    end

end

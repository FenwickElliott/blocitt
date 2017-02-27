require 'rails_helper'

RSpec.describe Advertisement, type: :model do
    let (:advertisement) {Advertisement.create!}

    attr = [:title, :copy, :price]

    describe "attributes" do
        attr.each do |x|
            it "responds to #{x}" do
                expect(advertisement).to respond_to(x)
            end
        end
    end
end

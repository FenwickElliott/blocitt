require 'rails_helper'

RSpec.describe Question, type: :model do
    let (:question) {Question.create}

    attr = [:title, :body, :resolved]

    describe "attributes" do
        attr.each do |x|
            it "responds to #{x}" do
                expect(question).to respond_to(x)
            end
        end
    end
end

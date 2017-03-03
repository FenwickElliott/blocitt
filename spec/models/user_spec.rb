require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) {User.create!(name: 'Charles', email: 'charles@bloc.io', password: 'psswrd')}

    it { is_expected.to have_many(:posts)}

    # Shoulda tests
    it { is_expected.to validate_presence_of(:name)}
    it { is_expected.to validate_length_of(:name).is_at_least(1)}

    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_uniqueness_of(:email)}
    it {is_expected.to validate_length_of(:email).is_at_least(3)}
    it {is_expected.to allow_value("charles@bloc.io").for(:email)}

    it {is_expected.to validate_presence_of(:password)}
    it {is_expected.to have_secure_password }
    it {is_expected.to validate_length_of(:password).is_at_least(6)}

    describe "attributes" do
        it 'should have name and email attributes' do
            expect(user).to have_attributes(name: "Charles", email: 'charles@bloc.io')
        end
    end

    describe "invalid user" do
        let(:invalid_name) { User.new(name: '', email: 'user@bloc.io')}
        let(:invalid_email) { User.new(name: 'Charles', email: '')}

        it "should be invalid due to blank name" do
            expect(invalid_name).to_not be_valid
        end

        it 'should be invalid due to blank email' do
            expect(invalid_email).to_not be_valid
        end
    end

    describe 'name format' do
        let(:unformatted_name) {User.new(name: RandomData.nAme)}
        puts :unformatted_name

        # let(:unformatted_name) {User.new(name: 'Charles Fenwick')}

        it 'should contain capitals' do
            expect(unformatted_name.name).to match(/[A-Z]/)
        end
        it 'first name should start with a capital' do
            expect(unformatted_name.name).to match(/(^)[A-Z]/)
        end
        it 'all other names should stat with a capital' do
            expect(unformatted_name.name).to_not match(/(\S)[A-Z]/)
        end
        it 'all other charactors should be lower case' do
            expect(unformatted_name.name).to_not match(/(\w)[A-Z]/)
        end
    end
end

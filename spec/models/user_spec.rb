require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) {User.create!(name: 'Charles', email: 'charles@bloc.io', password: 'psswrd')}

    # Shoulda tests
    it { is_expected.to have_many(:posts)}

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

        it "responds to role" do
            expect(user).to respond_to(:role)
        end

        it "responds to admin?" do
            expect(user).to respond_to(:admin?)
        end

        it "respondst to moderator?" do
            expect(user).to respond_to(:moderator?)
        end

        it "responds to member?" do
            expect(user).to respond_to(:member?)
        end
    end

    describe "roles" do
        it "is member by default" do
            expect(user.role).to eql("member")
        end

        context "member user" do
            it "returns true for #member?" do
                expect(user.member?).to be_truthy
            end

            it "returns false for #admin?" do
                expect(user.admin?).to be_falsey
            end
        end

        context "moderator" do
            before do
                user.moderator!
            end

            it "returs false for #member?" do
                expect(user.member?).to be_falsey
            end

            it "returns true for #moderator?" do
                expect(user.moderator?).to be_truthy
            end

            it "returns fasle for #amdin?" do
                expect(user.admin?).to be_falsey
            end
        end            

        context "member admin" do
            before do
                user.admin!
            end

            it "returns false for #member?" do
                expect(user.member?).to be_falsey
            end

            it "returns true to #admin?" do
                expect(user.admin?).to be_truthy
            end
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

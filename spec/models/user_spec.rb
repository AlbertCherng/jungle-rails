require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    # describe 'Validate Save' do
    #   it "should validate that a product is saved" do
    #     category = Category.find_by name: 'Apparel'
    #     product = Product.new(name: "Pants", price: 10, quantity: 12, category_id: category.id)
    #     expect(product.save!).to eql true
    #   end
    # end

    # describe 'Validate Match' do
    #   it "should validate that password and password_confirmation matches" do
    #     category = Category.find_by name: 'Apparel'
    #     product = Product.new(price: 999, quantity: 12, category: category)
    #     expect(product.valid?).to eql false
    #     expect(product.errors[:name]).to eql ["can't be blank"]
    #   end
    # end

    describe 'Validate Email Duplication' do
      it "should validate that users cannot have the same email" do
        user1 = User.new(email: "Johndoe@gmail.com", first_name: "John", last_name: "Doe", password: "123456", password_confirmation: "123456")
        user2 = User.new(email: "johndoe@gmail.Com", first_name: "Johnn", last_name: "Doee", password: "123456", password_confirmation: "123456")
        expect(user2.valid?).to eql false
      end
    end

    describe 'Validate Password Length' do
      it "should validate that password is more than 5 characters" do
        user = User.new(email: "johndoe@gmail.com", first_name: "John", last_name: "Doe", password: "1234", password_confirmation: "1234")
        expect(user.valid?).to eql false
        expect(user.errors[:password]).to eql [ "is too short (minimum is 6 characters)"]
      end
    end

    describe 'Validate Match' do
      it "should validate that password and password_confirmation matches" do
        user = User.new(email: "johndoe@gmail.com", first_name: "John", last_name: "Doe", password: "123456", password_confirmation: "12345")
        expect(user.password).not_to eql user.password_confirmation
      end
    end

    describe 'Validate Password' do
      it "should validate that password is present" do
        user = User.new(first_name: "John", last_name: "Doe",  password_confirmation: "12345")
        expect(user.valid?).to eql false
        expect(user.errors[:password]).to eql ["can't be blank", "is too short (minimum is 6 characters)"]
      end
    end

    describe 'Validate Email' do
      it "should validate that a email is present" do
        user = User.new(first_name: "John", last_name: "Doe", password: "12345", password_confirmation: "12345")
        expect(user.valid?).to eql false
        expect(user.errors[:email]).to eql ["can't be blank"]
      end
    end

    describe 'Validate First Name' do
      it "should validate that a first_name is present" do
        user = User.new(email: "johndoe@gmail.com", last_name: "Doe", password: "12345", password_confirmation: "12345")
        expect(user.valid?).to eql false
        expect(user.errors[:first_name]).to eql ["can't be blank"]
      end
    end

    describe 'Validate Last Name' do
      it "should validate that a last_name is present" do
        user = User.new(email: "johndoe@gmail.com", first_name: "John", password: "12345", password_confirmation: "12345")
        expect(user.valid?).to eql false
        expect(user.errors[:last_name]).to eql ["can't be blank"]
      end
    end

  end

  describe '.authenticate_with_credentials' do
    it "should return a new user if they exist" do
      dummy = User.create!(first_name: 'John', last_name: "doe", email: "johndoe3@gmail.com", password: "12345678", password_confirmation: "12345678")
      user = User.authenticate_with_credentials("johndoe3@gmail.com", "12345678")
      expect(user.id).to eql dummy.id
    end
    it "should return no new user, if no such user exists" do
      dummy = User.create!(first_name: 'John', last_name: "doe", email: "johndoe3@gmail.com", password: "12345678", password_confirmation: "12345678")
      user = User.authenticate_with_credentials("johndoe6@gmail.com", "12345678")
      expect(user).to eql nil
    end
    it "should log user in, even if they have spaces in before/after their email" do
      dummy = User.create!(first_name: 'John', last_name: "doe", email: "johndoe3@gmail.com", password: "12345678", password_confirmation: "12345678")
      user = User.authenticate_with_credentials(" johndoe3@gmail.com", "12345678")
      expect(user.id).to eql dummy.id
    end
    it "should log user in, even if they used the wrong case when typing their credentials" do
      dummy = User.create!(first_name: 'John', last_name: "doe", email: "johndoe3@gmail.com", password: "12345678", password_confirmation: "12345678")
      user = User.authenticate_with_credentials("johnDOE3@gmail.COM", "12345678")
      expect(user.id).to eql dummy.id
    end
  end
end



# t must be created with a password and password_confirmation fields
# These need to match so you should have an example for where they are not the same
# These are required when creating the model so you should also have an example for this
# Emails must be unique and case sensitivity should not be taken into account (TEST@TEST.com should not be allowed if test@test.COM is in the database)

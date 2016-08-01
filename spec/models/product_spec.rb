require 'rails_helper'


RSpec.describe Product, type: :model do

  describe 'Validations' do

    describe 'Validate Save' do
      it "should validate that a product is saved" do
        category = Category.find_by name: 'Apparel'
        product = Product.new(name: "Pants", price: 10, quantity: 12, category_id: category.id)
        expect(product.save!).to eql true
      end
    end

    describe 'Validate Name' do
      it "should validate that a name is present" do
        category = Category.find_by name: 'Apparel'
        product = Product.new(price: 999, quantity: 12, category: category)
        expect(product.valid?).to eql false
        expect(product.errors[:name]).to eql ["can't be blank"]
      end
    end

    describe 'Validate Price' do
      it "should validate that a price is present" do
        category = Category.find_by name: 'Apparel'
        product = Product.new(name: "Pants", quantity: 12, category: category)
        expect(product.valid?).to eql false
        expect(product.errors[:price]).to eql ["is not a number", "can't be blank"]
      end
    end

    describe 'Validate Quantity' do
      it "should validate that a quantity is present" do
        category = Category.find_by name: 'Apparel'
        product = Product.new(name: "Tie", price: 999, category: category)
        expect(product.valid?).to eql false
        expect(product.errors[:quantity]).to eql ["can't be blank"]
      end
    end

    describe 'Validate Category' do
      it "should validate that a category is present" do
        product = Product.new(name: "Shirt", price: 999, quantity: 12)
        expect(product.valid?).to eql false
        expect(product.errors[:category_id]).to eql ["can't be blank"]
      end
    end

  end

end



      # customer = User.new(email: "bob@gmail.com", location: "EU", date_joined: 2.year.ago)
      # expect(customer.valid?).to eql false
      # expect(customer.errors[:location]).to eql ["is not included in the list"]
require 'rails_helper'

RSpec.feature "Visitor clicks on product", type: :feature, js:true do
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "They see product details" do
    # ACT
    visit root_path
    first('.actions').click_on("Details")

    # DEBUG / VERIFY
    expect(page).to have_content 'Product Details'
    save_screenshot
    puts page.html


  end

end
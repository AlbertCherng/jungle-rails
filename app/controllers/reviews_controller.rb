class ReviewsController < ApplicationController


  def create
    @product = Product.find params[:product_id]
    @user = current_user
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = @user

    if @review.save

      redirect_to product_path(@product), notice: 'Review created!'
    else
      redirect_to product_path(@product)
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

end


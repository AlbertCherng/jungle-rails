class ReviewsController < ApplicationController

before_filter :check_privileges!


  def check_privileges!
    redirect_to root_path, notice: 'You dont have enough permissions to be here' unless current_user
  end

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

  def destroy
    @review = Review.find params[:id]
    @product = Product.find params[:product_id]
    @review.destroy
    redirect_to [@product], notice: 'Review deleted!'
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

end


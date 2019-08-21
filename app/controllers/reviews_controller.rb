class ReviewsController < ApplicationController
  before_action :fetch_restaurant
  # GET /restaurants
  def index
    @reviews = Review.where(restaurant_id: @restaurant.id)
  end

  # GET /restaurants/new
  def new
    @review = Review.new
  end

  # POST /restaurants
  def create
    @review = Review.new(review_params)
    @review.restaurant = @restaurant
    if @review.save # true / false
      redirect_to @restaurant, notice: 'Review was successfully created.'
    else
      # Will render /views/restaurants/new.html.erb
      # @restaurant.errors will not be empty!
      render :new
    end
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  # Get restaurant ID from the URL
  def fetch_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end

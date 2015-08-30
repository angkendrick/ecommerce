class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! #devise makes sure user is signed in


  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id]) #gets params from url:id
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @listing = Listing.find(params[:listing_id]) #gets params from url:id
    @seller = @listing.user

    @order.listing_id = @listing.id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id

      if @order.save
        format.html { redirect_to root_url, notice: 'Order was successfully created.' }
      else
        format.html { render :new }
      end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @order.destroy
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:address, :city, :state)
    end
end

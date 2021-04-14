# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.html do
          redirect_to @line_item.cart,
                      notice: 'Line item was successfully created.'
        end
        format.json do
          render :show,
                 status: :created, location: @line_item
        end
      else
        format.html { render :new }
        format.json do
          render json: @line_item.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def total_price
    product.price * quantity
  end
end

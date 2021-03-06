module Promotion
  class ProductDiscount
    attr_accessor :order_item, :product, :product_discount

    def initialize(order_item)
      @order_item = order_item
      @product = order_item.product
      @product_discount = @product.product_discount
      @total_price = 0
    end

    def calculate
      calculate_product_price_without_discount if product_discount.blank?
      calculate_product_price_with_discount unless product_discount.blank?
      return @total_price
    end
    
    private
    def calculate_product_price_with_discount
      number_of_group = (order_quantity / discount_quantity)
      number_of_ungroup = (order_quantity % discount_quantity)
      unless number_of_group.eql?(0)
        discount = (product_price - discount_price) 
        @total_price = (number_of_group * discount_quantity * discount)
      end
      @total_price += (number_of_ungroup * product_price).to_f unless number_of_ungroup.eql?(0)
    end

    def calculate_product_price_without_discount
      @total_price = (order_quantity * product_price)
    end

    def product_price
      product.price
    end

    def discount_price
      product_discount.discount_price
    end    

    def discount_quantity
      product_discount.no_of_products
    end   

    def order_quantity
      order_item.quantity
    end
  end
end
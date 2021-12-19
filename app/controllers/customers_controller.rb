class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    customer = Customer.new(customer_params)
    customer.save!
    redirect_to customers_url, notice: "「#{customer.name}様」を登録しました。"
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def update
  end

 private
   def customer_params
    params.require(:customer).permit(:name, :birthday, :gender, :phone, :address)
   end
end

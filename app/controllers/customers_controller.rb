class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: "「#{@customer.name}様」を登録しました。"
    else
      render :new
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
    redirect_to @customer, notice: "顧客情報を更新しました。"
    else
      render :edit
    end
  end

 private
   def customer_params
    params.require(:customer).permit(:name, :birthday, :address, :phone, :gender)
   end
end

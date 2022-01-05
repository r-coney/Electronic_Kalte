class CustomersController < ApplicationController
before_action :set_customer, only: [:show, :edit, :update]

  def index
    customers = Customer.all
    @q = customers.ransack(params[:q])
    @customers = @q.result(distinct: true).recent
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, flash: { success: "「#{@customer.name}様」を登録しました" }
    else
      render :new
    end
  end

  def show
    @kaltes = @customer.kaltes
  end

  def edit
  end
  
  def update
    if @customer.update(customer_params)
    redirect_to @customer, flash: { success: "顧客情報を更新しました" }
    else
      render :edit
    end
  end

 private
   def customer_params
    params.require(:customer).permit(:name, :birthday, :address, :phone, :gender)
   end

   def set_customer
    @customer = Customer.find(params[:id])
   end
end

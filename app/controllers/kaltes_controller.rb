class KaltesController < ApplicationController
  def new
    @kalte = Kalte.new
    @customer = Customer.find_by(params[:id])
  end
  
  def show
    @kalte = Kalte.find(params[:id])
  end
  
  def create
    @customer =  Customer.find(params[:customer_id])
    @kalte = Kalte.new(kalte_params)
    if @kalte.save
      redirect_to customer_kalte_path(@kalte.customer_id, @kalte.id), notice: 'カルテを作成しました'
    else
      render :new
    end
  end

  def edit
    @customer = Customer.find(params[:customer_id])
    @kalte = Kalte.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:customer_id])
    @kalte = Kalte.find(params[:id])
    if @kalte.update(kalte_params)
      redirect_to customer_kalte_path(@kalte.customer_id, @kalte.id), notice: 'カルテを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @kalte = Kalte.find(params[:id])
    @kalte.destroy
  end

  private
    def kalte_params 
      params.require(:kalte).permit(:menu, :request, :menu_description, :note).merge(customer_id: params[:customer_id])
    end
end

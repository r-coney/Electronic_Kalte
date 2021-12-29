class KaltesController < ApplicationController
  before_action :current_customer
  def new
    @kalte = Kalte.new
  end
  
  def show
    @kalte = Kalte.find(params[:id])
  end
  
  def create
    @kalte = Kalte.new(kalte_params)
    if @kalte.save
      redirect_to customer_kalte_path(@kalte.customer_id, @kalte.id), notice: 'カルテを作成しました'
    else
      render :new
    end
  end

  def edit
    @kalte = Kalte.find(params[:id])
  end
  
  def update
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
    redirect_to customer_path(@kalte.customer_id), notice: "カルテを削除しました"
  end

  private
    def kalte_params 
      params.require(:kalte).permit(:menu, :request, :menu_description, :note).merge(customer_id: params[:customer_id])
    end

    def current_customer
      @customer = Customer.find(params[:customer_id])
    end
end

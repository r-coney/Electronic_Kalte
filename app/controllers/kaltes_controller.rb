class KaltesController < ApplicationController
  before_action :current_customer
  before_action :set_kalte, only: [:show, :edit, :update, :destroy]

  def new
    @kalte = Kalte.new
  end
  
  def show
  end
  
  def create
    @kalte = Kalte.new(kalte_params)
    if @kalte.save
      redirect_to customer_kalte_path(@kalte.customer_id, @kalte.id), flash: { success: 'カルテを作成しました' }
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @kalte.update(kalte_params)
      redirect_to customer_kalte_path(@kalte.customer_id, @kalte.id), flash: { success: 'カルテを更新しました' }
    else
      render :edit
    end
  end

  def destroy
    @kalte.destroy
    redirect_to customer_path(@kalte.customer_id), flash: { success: "カルテを削除しました" }
  end

  private
    def kalte_params 
      params.require(:kalte).permit(:menu, :request, :menu_description, :note, :image).merge(customer_id: params[:customer_id])
    end

    def current_customer
      @customer = Customer.find(params[:customer_id])
    end

    def set_kalte
      @kalte = Kalte.find(params[:id])
    end
end

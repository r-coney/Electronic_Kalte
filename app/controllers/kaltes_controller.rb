class KaltesController < ApplicationController
  def new
    @kalte = Kalte.new
  end

  def show
    @kalte = Kalte.find(params[:id])
  end
  
  def create
    @kalte = Kalte.new(kalte_params)
    if @kalte.save
      redirect_to @kalte, notice: 'カルテを作成しました'
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
      redirect_to @kalte, notice: 'カルテを更新しました'
    else
      render :edit
    end
  end

  private
    def kalte_params 
      params.require(:kalte).permit(:menu, :request, :menu_description, :note)
    end
end

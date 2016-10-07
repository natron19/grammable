class GramsController < ApplicationController
  def index
  end

  def new
    @gram = Gram.new
  end

  def create
    @gram = Gram.new(gram_params)
    if @gram.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end
end

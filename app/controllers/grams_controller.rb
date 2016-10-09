class GramsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  before_action :current_gram, only: [:show, :edit, :update]

  def index
    @grams = Gram.all
  end

  def show

  end

  def edit
  end

  def update
    if @gram.update_attributes(gram_params)
      redirect_to root_path, notice: "Gram updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @gram = Gram.new
  end

  def create
    @gram = current_user.grams.new(gram_params)
    if @gram.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def current_gram
    @gram ||= Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def render_not_found
    render text: "Not Found", status: :not_found
  end

  def gram_params
    params.require(:gram).permit(:message)
  end
end

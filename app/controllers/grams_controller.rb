class GramsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :current_gram, only: [:show, :edit, :update, :destroy]

  def index
    @grams = Gram.all
  end

  def show

  end

  def edit
    return render_not_found(:forbidden) if @gram.user != current_user
  end

  def update
    return render_not_found(:forbidden) if @gram.user != current_user
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

  def destroy
    return render_not_found(:forbidden) if @gram.user != current_user
    @gram.destroy
    redirect_to root_path, alert: "Gram successfuly deleted"
  end

  private

  def current_gram
    @gram ||= Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def render_not_found(status=:not_found)
    render text: "#{status.to_s.titleize}", status: status
  end

  def gram_params
    params.require(:gram).permit(:message, :picture)
  end
end

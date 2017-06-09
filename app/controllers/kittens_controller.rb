class KittensController < ApplicationController
  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitteh_params)
    if @kitten.save
      flash[:success] = "A new kitteh joins our ranks!"
      redirect_to @kitten
    else
      flash[:error] = "Oh noes! Kitteh could not find its way home!"
      render 'new'
    end
  end

  def show
    @kitten = Kitten.find_by(id: params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @kitten}
    end
  end

  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def edit
    @kitten = Kitten.find_by(id: params[:id])
  end

  def update
    @kitten = Kitten.find_by(id: params[:id])
    if @kitten.update(kitteh_params)
      flash[:success] = "The kitteh has been updated!"
      redirect_to @kitten
    else
      flash[:error] = "Oh noes! Dere was a error!"
      render 'edit'
    end
  end

  def destroy
    kitten = Kitten.find_by(id: params[:id])
    kitten.delete
    flash[:success] = "Kitteh has left da building!"
    redirect_to '/'
  end

  private
    def kitteh_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end

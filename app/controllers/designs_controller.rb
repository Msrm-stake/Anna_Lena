class DesignsController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update destroy remove_photo]
  before_action :set_design, only: %i[show edit update destroy remove_photo]
  
  def index
    @designs = Design.all
  end

  def show
    @design = Design.find(params[:id])
  end

  def new
    @design = Design.new
  end

  def create
    @design = current_user.designs.build(design_params)
    if @design.save
      redirect_to @design, notice: 'Design was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @design = Design.find(params[:id])
  end
  
  def update
    @design = Design.find(params[:id])
  
    if @design.update(design_params)
      if params[:design][:photos]
        # Clear existing photos before attaching new ones
        @design.photos.purge
        params[:design][:photos].each do |photo|
          @design.photos.attach(photo)
        end
      end
      redirect_to @design, notice: 'Design was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def remove_photo
    @design = Design.find(params[:id])
    photo = @design.photos.find(params[:photo_id])
    photo.purge
    redirect_to @design, notice: 'Photo was successfully removed.'
  end

  def destroy
    @design = Design.find(params[:id])
    @design.destroy

    redirect_to designs_path, status: :see_other
  end
  

  private

  def set_design
    @design = Design.find(params[:id])
  end

  def design_params
    params.require(:design).permit(:name, :description, :descriptionfr,:profile_picture, photos: [])
  end
end

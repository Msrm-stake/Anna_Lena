class ResearchesController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update destroy remove_photo]
  before_action :set_research, only: %i[show edit update destroy remove_photo]
  
  def index
    @researches = Research.all
  end

  def show
    @research = Research.find(params[:id])
  end

  def new
    @research = Research.new
  end

  def create
    @research = current_user.researches.build(research_params)
    if @research.save
      redirect_to @research, notice: 'Research was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @research = Research.find(params[:id])
  end
  
  def update
    @research = Research.find(params[:id])
  
    if @research.update(research_params)
      if params[:research][:photos]
        # Clear existing photos before attaching new ones
        @research.photos.purge
        params[:research][:photos].each do |photo|
          @research.photos.attach(photo)
        end
      end
      redirect_to @research, notice: 'Research was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def remove_photo
    @research = Research.find(params[:id])
    photo = @research.photos.find(params[:photo_id])
    photo.purge
    redirect_to @research, notice: 'Photo was successfully removed.'
  end

  def destroy
    @research = Research.find(params[:id])
    @research.destroy

    redirect_to researches_path, status: :see_other
  end
  

  private

  def set_research
    @research = Research.find(params[:id])
  end

  def research_params
    params.require(:research).permit(:name, :description, :descriptionfr, :profile_picture, photos: [])
  end
end

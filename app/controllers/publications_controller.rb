class PublicationsController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update destroy remove_photo]
  before_action :set_publication, only: %i[show edit update destroy remove_photo]
  
  def index
    @publications = Publication.all
  end

  def show
    @publication = Publication.find(params[:id])
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = current_user.publications.build(publication_params)
    if @publication.save
      redirect_to @publication, notice: 'Publication was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @publication = Publication.find(params[:id])
  end
  
  def update
    @publication = Publication.find(params[:id])
  
    if @publication.update(publication_params)
      if params[:publication][:photos]
        # Clear existing photos before attaching new ones
        @publication.photos.purge
        params[:publication][:photos].each do |photo|
          @publication.photos.attach(photo)
        end
      end
      redirect_to @publication, notice: 'Publication was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def remove_photo
    @publication = Publication.find(params[:id])
    photo = @publication.photos.find(params[:photo_id])
    photo.purge
    redirect_to @publication, notice: 'Photo was successfully removed.'
  end

  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy

    redirect_to publications_path, status: :see_other
  end
  

  private

  def set_publication
    @publication = Publication.find(params[:id])
  end

  def publication_params
    params.require(:publication).permit(:name, :description, :descriptionfr, :profile_picture, photos: [])
  end
end

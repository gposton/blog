class PhotosController < ApplicationController
  set_tab :picture_frame

  before_filter :authenticated?, :except => [:show]

  def create
    @photo = Photo.new(params[:photo])
    @photo.album = Album.find_by_name 'New' unless current_user.admin?
    @photo.uploaded_by = current_user
    if @photo.save
      PictureFrame.replace_displayed_with(@photo)
      Notifier.new_photo(@photo).deliver
      redirect_to albums_path
    else
      redirect_to albums_path
    end
  end

  def show
    @photo = Photo.find_by_id params[:id]
  end

  def edit
    @photo = Photo.find_by_id params[:id]
    PictureFrame.replace_displayed_with(@photo)
    logger.info "#{@photo} displayed by #{current_user.name}"
    redirect_to picture_frame_show_path
  end

end

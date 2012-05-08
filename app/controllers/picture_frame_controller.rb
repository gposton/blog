class PictureFrameController < ApplicationController
  def show
    if PictureFrame.currently_displayed.nil?
      flash[:notice] = "No pictures to display.  Why don't you upload one?"
      redirect_to new_album_photo_path
    end
    @photo = PictureFrame.currently_displayed
    render :show, :layout => false
  end

  def update
    PictureFrame.replace_displayed_with(Photo.find params[:id])
    redirect_to albums_path
  end
end

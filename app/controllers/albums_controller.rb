class AlbumsController < ApplicationController
  set_tab :picture_frame

  before_filter :authorize, :only => [:create]

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(params[:album])
    if @album.save
      redirect_to albums_path
    else
      render :action => 'new'
    end
  end

  def show
    @album = Album.find_by_name(params[:id])
  end

  def index
    @albums = Album.includes(:photos).all
  end
end

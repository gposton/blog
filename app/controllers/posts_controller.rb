class PostsController < ApplicationController
  set_tab :blog

  before_filter :authorize, :except => [:index, :show]

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by_web_title params[:id]
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      tags = params[:tags].split(',').map{|tag|tag.strip}
      tags.each do |tag|
        @post.tags << Tag.find_or_create_by_name(tag)
      end
      redirect_to post_path(@post.web_title)
    else
      render :action => 'new'
    end
  end

  def update
    @post = Post.find_by_web_title params[:id]
    @post.attributes = params[:post]
    @post.tags = []
    if @post.save
      tags = params[:tags].split(',').map{|tag|tag.strip}
      tags.each do |tag|
        @post.tags << Tag.find_or_create_by_name(tag)
      end
      redirect_to post_path(@post.web_title)
    else
      render :action => 'edit'
    end
  end

  def show
    @post = Post.find_by_web_title params[:id]
  end

  def index
    if params[:tag]
      @posts = Tag.find_by_name(params[:tag].gsub('_', ' ')).posts.reverse rescue []
    else
      @posts = Post.all.reverse
    end
  end
end


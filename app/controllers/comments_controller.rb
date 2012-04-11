class CommentsController < ApplicationController
  set_tab :blog

  before_filter :authenticated?, :except => [:index, :show]

  def new
    @post = Post.find_by_web_title params[:post_id]
    @comment = Comment.new
  end

  def edit
    @post = Post.find_by_web_title params[:post_id]
    @comment = Comment.find params[:id]
  end

  def create
    @post = Post.find_by_web_title params[:post_id]
    @comment = Comment.new(params[:comment])
    @comment.user_id = @current_user.id
    @comment.commentable_id = @post.id
    @comment.commentable_type = @post.class.name
    if @comment.save
      Notifier.new_comment(@comment, @post).deliver
      redirect_to post_path @post
    else
      render :action => 'new'
    end
  end

  def update
    @post = Post.find_by_web_title params[:post_id]
    @comment = Comment.find params[:id]
    @comment.attributes = params[:content]
    if @comment.save
      redirect_to post_path @post
    else
      render :action => 'edit'
    end
  end

end


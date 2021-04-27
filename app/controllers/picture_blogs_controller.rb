class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  skip_before_action :login_required, only: [:new, :create]
  def index
    @picture_blogs = Picture_blog.all
  end

  def new
    @picture_blog = Picture_blog.new
  end

  def create
    @picture_blog = Picture_blog.new(picture_blog_params)
    if params[:back]
      render :new
    else
      if @picture_blog.save
      redirect_to picture_blogs_path, notice: "ブログを作成しました！"
    else
      render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @picture_blog.update(picture_blog_params)
      redirect_to picture_blogs_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @picture_blog.destroy
    redirect_to picture_blogs_path, notice:"ブログを削除しました！"
  end

  def confirm
    @picture_blog = Picture_blog.new(picture_blog_params)
    render :new if @picture_blog.invalid?
  end

  private
  def picture_blog_params
    params.require(:picture_blog).permit(:title, :content)
  end

  def set_blog
    @picture_blog = Picture_blog.find(picture_params[:id])
  end
end

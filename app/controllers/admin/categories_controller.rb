class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin
  layout "admin"

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @parent_categories = Category.where(:is_main_category => true)

    if @category.save
      redirect_to admin_categories_path, :notice => "Category Created"
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)
      redirect_to admin_categories_path, :notice => "Category Updated."
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:warning] = "Category Deleted."
    redirect_to admin_categories_path
  end


  private

    def category_params
      params.require(:category).permit(:name, :is_main_category, :parent_category_id)
    end





end
class WishesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_page
  respond_to :html, :js
  
  def show
    @wish = @page.wishes.find(params[:id])
    respond_with(@wish)
  end

  def edit
    @wish = @page.wishes.find(params[:id])
    respond_with(@wish)
  end

  def new
    respond_with(@wish = @page.wishes.new)   
  end 

  def create
    @wish = @page.wishes.new(params[:wish])
    if @wish.save
      respond_with(@wish)
    else
      respond_with(@wish.errors)
    end
  end

  def update
    @wish = @page.wishes.find(params[:id])
    @wish.update_attributes(params[:wish])
    
    respond_with([@page,@wish])
  end

  private
    def find_page
      @page = current_user.pages.find(params[:page_id])
    end

end

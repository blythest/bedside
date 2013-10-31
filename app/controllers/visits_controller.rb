class VisitsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_page
  respond_to :html, :js
  
  def show
    @visit = @page.visits.find(params[:id])
    respond_with(@visit)
  end

  def edit
    @visit = @page.visits.find(params[:id])
    respond_with(@visit)
  end

  def new
    @hours_dropdown = hours_dropdown
    respond_with(@visit = @page.visits.new)   
  end 

  def create
    @visit = @page.visits.new
    day = params[:visit][:start_day]
    hour = params[:visit][:start_hour]

    @visit.start_time = "#{day} #{hour}".to_datetime
    @visit.user_id = current_user.id
    if @visit.save
      @schedule = @page.get_schedule
      respond_with([@page,@visit])
    else
      respond_with(@visit.errors)
    end
  end

  def destroy
    
    @visit = @page.visits.find(params[:id])

    @visit.delete if current_user.id == @visit.user_id or @page.can_edit?(current_user)

    @schedule = @page.get_schedule
  end

  def update
    @visit = @page.visits.find(params[:id])
    @visit.update_attributes(params[:visit])
    
    respond_with([@page,@visit])
  end

  def hours_dropdown
    hours = []
    (5..11).each do |h|
      hours << h.to_s + "am"
    end
    hours << "12pm"
    (1..11).each do |h|
      hours << h.to_s + "pm"
    end
    hours
  end

  private
    def find_page
      @page = current_user.pages.find(params[:page_id])
    end

end

class AppointmentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_page
  respond_to :html, :js
  
  def show
    @appointment = @page.appointments.find(params[:id])
    respond_with(@appointment)
  end

  def edit
    @appointment = @page.appointments.find(params[:id])
    respond_with(@appointment)
  end

  def new
    @hours_dropdown = hours_dropdown
    respond_with(@appointment = @page.appointments.new)   
  end 

  def create
    @appointment = @page.appointments.new
    day = params[:appointment][:start_day]
    hour = params[:appointment][:start_hour]

    @appointment.start_time = "#{day} #{hour}".to_datetime
    @appointment.user_id = current_user.id
    if @appointment.save
      @schedule = @page.get_shorter_schedule
      respond_with([@page,@appointment])
    else
      respond_with(@appointment.errors)
    end
  end

  def destroy
    
    @appointment = @page.appointments.find(params[:id])

    @appointment.delete if current_user.id == @appointment.user_id or @page.can_edit?(current_user)

    @schedule = @page.get_shorter_schedule
  end

  def update
    @appointment = @page.appointments.find(params[:id])
])
    
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

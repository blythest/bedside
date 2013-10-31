class  < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :page_id, :start_day, :start_hour
  belongs_to :user
  belongs_to :page
  def start_hour
    return '12pm' if start_time.blank?
    start_time.strftime('%l%p')
  end
end

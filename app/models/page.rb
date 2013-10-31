class Page < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :hospital, :room, :tips, :overview, :visiting_hours, :patient_name, :avatar_url
  has_many :page_participations
  has_many :users, :through => :page_participations, :autosave => true
  has_many :posts
  has_many :visits
  has_many :wishes

  acts_as_commentable

  def can_edit?(user)
    pp = user.page_participations.find_by_page_id(self.id)
    !pp.nil? && (pp.permission_level == PageParticipation::PermissionLevel::OWNER || pp.permission_level == PageParticipation::PermissionLevel::PATIENT)
  end


  def next_two_weeks
    days = {}
    (0..13).each do |offset|
      d = Time.now + offset.days
      daystring = d.strftime('%Y%m%d')
      days[daystring] = {:date => d, :visits => []}
    end
    days
  end

  def next_weeks
    days = {}
    (0..8).each do |offset|
      d = Time.now + offset.days
      daystring = d.strftime('%Y%m%d')
      days[daystring] = {:date => d, :visits => []}
    end
    days
  end

  def get_schedule
    today = 
    visits = self.visits.where('start_time < ? AND start_time > ?', Time.now + 13.days, Time.now.beginning_of_day)
    days = self.next_two_weeks

    visits.each do |v|
      daystring = v.start_time.strftime('%Y%m%d')
      days[daystring][:visits] << v
    end
    days
  end

  def get_shorter_schedule
    today = 
    visits = self.visits.where('start_time < ? AND start_time > ?', Time.now + 7.days, Time.now.beginning_of_day)
    days = self.next_two_weeks

    visits.each do |v|
      daystring = v.start_time.strftime('%Y%m%d')
      days[daystring][:visits] << v
    end
    days
  end

end

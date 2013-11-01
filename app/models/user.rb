class User < ActiveRecord::Base
  rolify
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :async, :invitable,:database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_many :page_participations
  has_many :pages, :through => :page_participations, :autosave => true
  has_many :posts
  has_many :visits
  has_many :appointments
  has_many :wishes, :foreign_key => 'claimed_by'
  has_many :comments

    # devise confirm! method overriden
  private
    def send_welcome_email
      # Don't send a welcome if this user is invited (we'll send an invite instead)
      if self.invitation_token.blank?
        BedsideMailer.welcome(self.id).deliver
      end
    end
  
end

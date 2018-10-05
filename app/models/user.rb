class User < ApplicationRecord
  has_many :requests
  has_many :tasks, :class_name => 'Request', :foreign_key => 'recipient_id'


  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable


  def timeout_in
    if Rails.env.development?
      60.minutes
    else
      super
    end
  end

  def display_name(full=true)
    if self.firstname.present?
      # full name
      name = self.firstname + ( self.lastname.present? ? " " + self.lastname[0].concat(".") : "" )
      return name if full
      # initials
      name.split(" ").collect { |n|
        n[0]
      }.join("")
    else
      self.email
    end
  end

  def user_initials
    # puts self
    # self.split(" ").each { |word|
    #   word[0]
    # }.join(". ")
  end

  def is_self(user)
    user.id == self.id
  end



end

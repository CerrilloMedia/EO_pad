class User < ApplicationRecord
  has_many :requests
  has_many :tasks, :class_name => 'Request', :foreign_key => 'recipient'


  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable


  def timeout_in
    if Rails.env.development?
      60.minutes
    else
      super
    end
  end

  def display_name
    if self.firstname.present?
      self.firstname + ( self.lastname.present? ? " " + self.lastname[0].concat(".") : "" )
    else
      self.email
    end
  end

  def is_self(user)
    user.id == self.id
  end


end

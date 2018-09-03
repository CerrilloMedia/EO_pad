class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :confirmable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def timeout_in
    if Rails.env.production?
      super
    else
      15.minutes
    end
  end


end

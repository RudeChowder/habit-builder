class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :checkins
  has_many :habits, through: :checkins

  def short_name
    email.split("@")[0]
  end

  def current_habits
    habits.uniq
  end

  def last_three_checkins
    checkins.order(date: :desc).limit(3)
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 , maximum: 128}
  validates :password_confirmation, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  has_many :items, dependent: :destroy
end

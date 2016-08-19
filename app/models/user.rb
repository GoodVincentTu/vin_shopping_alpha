class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :address, :country, :state, :city, :zip_code, :phone

  def full_address
  <<EOF
#{address}
#{zip_code} #{city}
#{state}
#{country}
EOF
  end
end

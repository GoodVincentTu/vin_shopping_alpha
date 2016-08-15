class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email

  # def full_address
  # <<EOF
##{address}
##{postal_code} #{city}
##{state}
##{country}
  # end
end

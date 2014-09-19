class User < ActiveRecord::Base
  has_secure_password
  has_many :projects, foreign_key: :initiator_id
  has_many :versions, foreign_key: :contributor_id
  has_many :votes


end

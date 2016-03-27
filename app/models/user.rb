class User < ApplicationRecord
  validates :name, precense: true
end

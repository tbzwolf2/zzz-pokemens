class Pokemon < ApplicationRecord
  has_many :types, class_name: :type", foreign_key: "type"
end

class Type < ApplicationRecord
  # if the full pokemon api was to be replicated this would be a many to many relationship of type to pokemon since the offical api has pokemon on the type too
  # but since here we are just returning pokemon the relationship is unnecessary
end

class Priority < ApplicationRecord
   has_many :tasks                  # enables the connection of priorities database to tasks database
end

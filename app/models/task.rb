class Task < ApplicationRecord
  belongs_to :bucket                                  # maintain the primary key-foreign key relationship wih bucket
  has_one :priority, foreign_key: :priority_id        # connected to priority which has a foreign key (id)
  validates :name, presence: true                     # ensures that all tasks have names

  def self.get_by_status(status)                      # checking the current status of the tasks
    self.all.select do |task|
        task.status == status
    end
  end
end

class Task < ApplicationRecord
  belongs_to :bucket
  has_one :priority, foreign_key: :priority_id

  def self.get_by_status(status)
    self.all.select do |task|
        task.status == status
    end
  end
end
class Bucket < ApplicationRecord
    has_many :tasks, :dependent => :destroy                             # enables the connection of tasks and buckets and ensure that the buckets can be deleted even when there is a task inside
    validates :name, presence: true                                     # ensures that all bucket have names

    def self.get_by_status(status)                                      # method to get the current status of the bucket
        self.all.select do |bucket|
            bucket.status == status
        end
    end

    def update_status                                                  # method to check what is the current status of the bucket
        if self.tasks == []
            self.status = "Empty"
        elsif self.tasks.any?{|task| task.status == "Pending"}
            self.status = "Pending"
        else
            self.status = "Completed"
        end
        self.save
    end

    def tasks_by_status(status)                                        # method to acquire the status of the tasks
        self.tasks.select do |task|
            task.status == status
        end
    end

end
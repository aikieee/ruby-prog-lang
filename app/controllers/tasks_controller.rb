class TasksController < ApplicationController
    def index                                                        # method to help with the status of the tasks
        @pending_tasks = Task.get_by_status("Pending")
        @completed_tasks = Task.get_by_status("Completed")
    end

    def new                                                          # method for initiating new task
        @task = Task.new
    end

    def create                                                       # method for creating the bucket
        @task = Task.create(task_params(:name, :description, :bucket_id, :priority_id)) 
        @task.status = "Pending"
        @task.save
        @task.bucket.update_status
        redirect_to task_path(@task)
    rescue NoMethodError                                            # Exception Handling if bucket or task is failed to be recognized
        render :file => "#{Rails.root}/public/alert.html"
    rescue ActionController::UrlGenerationError                     # Exception Handling if the next path's creation failed
        render :file => "#{Rails.root}/public/alert.html"
    end

    def show                                                        # method for showing all records of tasks
        @task = Task.find(params[:id])
    end

    def edit                                                        # method to initiate editing of the tasks
        @task = Task.find(params[:id])
    end

    def update                                                      # method for updating the content of the tasks
        @task = Task.find(params[:id])
        @task.update(task_params(:name, :description, :status, :bucket_id, :priority_id))
        @bucket = @task.bucket.update_status
        redirect_to task_path(@task)
    end

    def destroy                                                     # method for deleting tasks
        @task = Task.find(params[:id]).destroy
        redirect_to tasks_path
    end

    private                                                         # method for defining which parameter is required and which objects is permitted to be updated
    def task_params(*args)
        params.require(:task).permit(*args)
    end
end

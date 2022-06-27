class BucketsController < ApplicationController
    def index                                                        # method to help with the status of the buckets
        @empty_buckets = Bucket.get_by_status("Empty")
        @pending_buckets = Bucket.get_by_status("Pending")
        @completed_buckets = Bucket.get_by_status("Completed")
    end

    def new                                                          # method for initiating new bucket
        @bucket = Bucket.new
    end

    def create                                                       # method for creating the bucket
        @bucket = Bucket.create(bucket_params(:name, :description))  # creates bucket from user's name and description
        @bucket.status = "Empty"                                     # initiating the bucket's status as empty
        @bucket.save                                                 # saving the bucket in the database
        redirect_to bucket_path(@bucket)                             # after the creation of the bucket, the user will be redirected to the next path
    rescue ActionController::UrlGenerationError                      # Exception Handling if the next path's creation failed
        render :file => "#{Rails.root}/public/alert.html"
    end

    def show                                                         # method for showing all records of buckets
        @bucket = Bucket.find(params[:id])                           
    rescue ActiveRecord::RecordNotFound                              # Exception Handling
        redirect_to root_path                                        # if the bucket's id is deleted or no longer available, this will redirect the user to the root path
    end

    def edit                                                         # method for editing a bucket
        @bucket = Bucket.find(params[:id])
    end

    def update                                                       # method for updating bucket's contents
        @bucket = Bucket.find(params[:id])
        @bucket.update(bucket_params(:name, :description))           
        @bucket.update_status
        redirect_to bucket_path(@bucket)
    end

    def destroy                                                      # method for deleting bucket
        @bucket = Bucket.find(params[:id])
        @bucket.destroy
        redirect_to bucket_path
    end

    private                                                          # method for defining which parameter is required and which objects is permitted to be updated
    def bucket_params(*args)
        params.require(:bucket).permit(*args)
    end
end

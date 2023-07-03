class InstructorsController < ApplicationController
    def index
        instructors = Instructor.all
        render json: instructors, status: :created    
        end
    
        def show
        instructor = find_instructor
        render json: instructor.to_json(except: [:created_at, :updated_at]), status: :created
        end
    
        def create
        instructor = Instructor.new(instructor_params)
        if instructor.save
            render json: instructor.to_json(except: [:created_at, :updated_at]), status: :created
          else
            render json: { errors: instructor.errors.full_messages }, status: :unprocessable_entity
          end
        end
    
        def update
            instructor = find_instructor
            if instructor
              if instructor.update(instructor_params)
                render json: { result: "Instructor updated successfully", instructor: instructor }, status: :ok
              else
                render json: { errors: instructor.errors.full_messages }, status: :unprocessable_entity
              end
            else
              render json: { errors: "Oops! Instructor not found" }, status: :not_found
            end
          end
       
        def destroy
        instructor = find_instructor
        if instructor
        instructor.destroy
        head :no_content 
        else
            render json: { errors: "Oops! Instructor not found"}, status: :not_found 
        end
    end
    
    private
    def find_instructor
        Instructor.find_by(id: params[:id])
    end
    
    private 
    def instructor_params
        params.permit(:name)
    end
    
end

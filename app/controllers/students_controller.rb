class StudentsController < ApplicationController
    def index
        students = Student.all
        render json: students, status: :ok
      end
      
    
      def show
        student = find_student
        if student
          render json: student.to_json(except: [:created_at, :updated_at]), status: :ok
        else
          render json: { errors: "Oops! Student not found" }, status: :not_found
        end
      end

      def create
        student = Student.new(student_params)
        if student.save
          render json: { result: "Student created successfully", student: student }, status: :created
        else
          render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      def update
        student = find_student
        if student
          if student.update(student_params)
            render json: { result: "Student updated successfully", student: student }, status: :ok
          else
            render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: "Oops! Student not found" }, status: :not_found
        end
      end
       
     def destroy
        student = find_student
        if student
        student.destroy
        head :no_content 
        else
            render json: { errors: "Oops! student not found"}, status: :not_found 
        end
    end
    
    private
    def find_student
        Student.find_by(id: params[:id])
    end
    
    private 
    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end

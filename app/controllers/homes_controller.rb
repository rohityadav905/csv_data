class HomesController < ApplicationController
	helper_method :sort_column, :sort_direction
	before_action :get_question, only: [:destroy]

	# Show all questions
	def index
		@questions = Question.all.paginate(page: params[:page], per_page: 10).order(sort_column + " " + sort_direction)
	end

	# Import CSV data in PostgreSql tables
	def import_csv
		begin
			file = Rails.root.join("public", "CSV_Data.csv")	             
			CSV.foreach(file, headers: true) do |row|
				mapping  =  Mapping.find_or_create_by(name: row["Mapping"])
				role     =  Role.find_or_create_by(name: row["Role"])
				question =  role.questions.find_or_create_by(pri: row["Pri"], question: row["Question"], teaming_stage: row["Teaming Stages"], appear_days: row["Appears (Day)"], frequency: row["Frequency"], q_type: row["Type"], required: row["Required?"], conditions: row["Conditions"], mapping_id: mapping.id)
				puts "Question - #{question.question}, Mapping - #{mapping.name}, Role - #{role.name} imported successfully."
			end
			puts "CSV data imported successfully."
			redirect_to root_path
		rescue => e
			Rails.logger.info e.message		
		end
	end

	# Delete all data from the database tables
	def delete_all_data
		begin
			Question.destroy_all
			Mapping.destroy_all
			Role.destroy_all
			puts "All CSV data deleted successfully."
			redirect_to root_path
		rescue => e
			Rails.logger.error e.message
		end
	end

	# Delete specific question
	def destroy
		begin
			@question.destroy
			puts "Question deleted successfully."
			redirect_to root_path
		rescue => e
			Rails.logger.error e.message
		end
	end

	private
		# Sort the columns
		def sort_column
			Question.column_names.include?(params[:sort]) ? params[:sort] : "pri"
		end

		# Change the sort column asc/desc
		def sort_direction
			%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
		end

		# Get question with ID
		def get_question
			@question = Question.find(params[:question_id])
		end
end
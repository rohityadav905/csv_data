class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
    	t.integer :pri
    	t.string :question
    	t.string :teaming_stage
    	t.integer :appear_days
    	t.string :frequency
    	t.string :q_type
    	t.string :required
    	t.string :conditions
    	t.integer :role_id
    	t.integer :mapping_id
    	
      t.timestamps
    end
  end
end

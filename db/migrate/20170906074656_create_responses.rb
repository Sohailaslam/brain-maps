class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :question_id
      t.integer :answer_id
      t.integer :student_id
      t.integer :attempt_id
      t.boolean :is_correct

      t.timestamps null: false
    end
  end
end

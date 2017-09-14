class CreateLearningOutcomes < ActiveRecord::Migration
  def change
    create_table :learning_outcomes do |t|
      t.text :title
      t.integer :course_id

      t.timestamps null: false
    end
  end
end

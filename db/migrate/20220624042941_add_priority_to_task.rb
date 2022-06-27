class AddPriorityToTask < ActiveRecord::Migration[7.0]
  def change                                                              # database that lets the user adds priority to tasks
    add_reference :tasks, :priority, null: false, foreign_key: true
  end
end

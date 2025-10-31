class ChangeArgumentsTypeInSolidQueueJobs < ActiveRecord::Migration[7.0]
  def up
    change_column :solid_queue_jobs, :arguments, :text
  end

  def down
    change_column :solid_queue_jobs, :arguments, :jsonb, default: {}
  end
end
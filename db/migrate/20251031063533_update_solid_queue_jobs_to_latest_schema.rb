class UpdateSolidQueueJobsToLatestSchema < ActiveRecord::Migration[8.0]
  def change
    # Add missing columns safely (won’t break if they already exist)
    add_column :solid_queue_jobs, :active_job_id, :string unless column_exists?(:solid_queue_jobs, :active_job_id)
    add_column :solid_queue_jobs, :priority, :integer, default: 0, null: false unless column_exists?(:solid_queue_jobs, :priority)
    add_column :solid_queue_jobs, :concurrency_key, :string unless column_exists?(:solid_queue_jobs, :concurrency_key)
    add_column :solid_queue_jobs, :expires_at, :datetime unless column_exists?(:solid_queue_jobs, :expires_at)
  end
end
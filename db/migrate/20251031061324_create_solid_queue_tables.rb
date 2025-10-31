class CreateSolidQueueTables < ActiveRecord::Migration[7.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.string :job_class, null: false
      t.jsonb :arguments, default: {}
      t.datetime :scheduled_at
      t.datetime :finished_at
      t.string :status, default: "queued"
      t.timestamps
    end

    add_index :solid_queue_jobs, :queue_name
    add_index :solid_queue_jobs, :status

    create_table :solid_queue_queues do |t|
      t.string :name, null: false
      t.integer :job_count, default: 0
      t.timestamps
    end

    create_table :solid_queue_executions do |t|
      t.references :solid_queue_job, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at
      t.timestamps
    end
  end
end
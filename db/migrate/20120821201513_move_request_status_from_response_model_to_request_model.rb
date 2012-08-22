class MoveRequestStatusFromResponseModelToRequestModel < ActiveRecord::Migration
  def up
    remove_column :responses, :status
    add_column :requests, :status, :string
  end

  def down
    remove_column :requests, :status
    add_column :responses, :status, :string
  end
end

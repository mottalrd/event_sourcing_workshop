class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table 'events', force: :cascade do |t|
      t.string 'event_type', null: false
      t.json 'data', null: false
      t.string 'entity_type', null: false
      t.string 'entity_id', null: false
      t.datetime 'created_at', null: false
      t.index ['entity_id'], name: 'index_events_on_entity_id'
    end
  end
end

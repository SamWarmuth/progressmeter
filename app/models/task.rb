class Task < CouchRest::ExtendedDocument
  use_database COUCHDB_SERVER

  property :name

  property :date, :default => Proc.new{Time.now.to_i}
  property :finished_value
  property :current_progress
  
  property :deleted, :default => false
  
  
    
  def percent_progress
    return (1000*(self.current_progress.to_f)/self.finished_value).floor.to_f/10
  end
end

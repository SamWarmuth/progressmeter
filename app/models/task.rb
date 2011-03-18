class Task < CouchRest::ExtendedDocument
  use_database COUCHDB_SERVER

  property :name

  property :date, :default => Proc.new{Time.now.to_i}
  
  
  property :finished_value
  property :current_progress
  
  property :deleted, :default => false
  property :completed, :default => false
  
  
    
  def percent_progress
    return (1000*(self.current_progress.to_f)/(self.finished_value.to_f+0.01)).floor.to_f/10
  end
end

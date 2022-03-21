class ImportProgressChannel < ApplicationCable::Channel
  def subscribed
    stream_from "catalog_marc_record_import_progress"
  end

  def unsubscribed
    stop_all_streams
  end
end

module Catalog
  class MARC::Record::ImporterJob
    include Parallelixir::Job
    # queue_as :default
    # sidekiq_options retry: false

    def perform(marc, format, record_type, encoding, on_duplicate)
      records, record_type_class =
        MARC::Record.read(
          marc: marc,
          format: format,
          record_type: record_type.to_sym,
          encoding: encoding,
          autosave: true,
          on_duplicate: on_duplicate
        )

      batch_size = 1000

      progress_callback = -> (rows_size, num_batches, current_batch_number, _batch_duration_in_secs) {
        last_batch = current_batch_number == num_batches
        remainder  = rows_size.remainder(batch_size)

        records_inserted =
          if last_batch && remainder > 0
            batch_size * (current_batch_number - 1) + remainder
          else
            batch_size * current_batch_number
          end

        records_left = rows_size - records_inserted

        batches_inserted = current_batch_number
        batches_left     = num_batches - current_batch_number

        payload = {
          records_inserted: records_inserted,
          records_left: records_left,
          batches_inserted: batches_inserted,
          batches_left: batches_left,
          rows_size: rows_size,
          num_batches: num_batches,
          result: nil
        }

        html = Catalog::MARC::RecordsController.render(
          partial: "import_progress",
          locals: payload
        )

        ActionCable.server.broadcast(
          "catalog_marc_record_import_progress",
          {
            html: html
          }
        )
      }

      result = record_type_class.bulk_import(
        records.to_a,
        batch_size: batch_size,
        batch_progress: progress_callback,
        recursive: true
      )

      p result

      html = Catalog::MARC::RecordsController.render(
        partial: "import_progress",
        locals: { result: result }
      )

      ActionCable.server.broadcast(
        "catalog_marc_record_import_progress",
        {
          html: html
        }
      )

      # MARC::Record::IndexerJob.perform(records)
      records.each do |record|
        record = record.marc_record

        if record.persisted?
          record.__elasticsearch__.index_document
        else
          next
        end
      end
    end
  end
end

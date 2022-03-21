module Catalog
  class MARC::Record::ImportController < ApplicationController
    def new
    end

    def create
      file, format, record_type, encoding, on_duplicate = import_params.values

      unless file.respond_to? :tempfile
        render :new
        return
      end

      marc = File.read(file.to_path)

      MARC::Record::ImporterJob.perform_later(
        marc,
        format,
        record_type,
        encoding,
        on_duplicate
      )

      redirect_to catalog_marc_records_path(record_type: record_type)
    end

    private

    def import_params
      params.permit(:file, :format, :record_type, :encoding, :on_duplicate)
    end
  end
end

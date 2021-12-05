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

      records, record_type_class =
        MARC::Record.read(
          file.tempfile,
          format: format,
          record_type: record_type.to_sym,
          encoding: encoding,
          autosave: true,
          on_duplicate: on_duplicate
        )

      result  = record_type_class.bulk_import(
        records.to_a,
        batch_size: 1000,
        recursive: true
      )

      redirect_to catalog_marc_records_path(record_type: record_type), flash: { import_report: result }
    end

    private

    def import_params
      params.permit(:file, :format, :record_type, :encoding, :on_duplicate)
    end
  end
end

class SomeJob
  include Parallelixir::Job

  def perform(marc, format, record_type, encoding, on_duplicate)
    records, record_type_class =
      Catalog::MARC::Record.read(
        marc: marc,
        format: format,
        record_type: record_type.to_sym,
        encoding: encoding,
        autosave: true,
        on_duplicate: on_duplicate
      )

    records
    p marc
  end
end

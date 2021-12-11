module Catalog
  class MARC::RecordsController < ApplicationController
    def index
      case params[:record_type]
      when "authority"
        @records = MARC::Record.authority
      else
        @records = MARC::Record.bibliographic
      end
    end

    def show
      @record = MARC::Record.find(params[:id])
    end

    def edit
      @record = MARC::Record.find(params[:id])
    end

    def update
      @record = MARC::Record.find(params[:id])

      if @record.update(record_params)
        redirect_to @record
      else
        render :edit
      end
    end

    private

    def record_params
      params.require(:catalog_marc_record).permit(:record_type, fields_attributes: [
        :id,
        :tag,
        :value,
        :indicator1,
        :indicator2,
        subfields_attributes: [:id, :code, :value]
      ])
    end
  end
end

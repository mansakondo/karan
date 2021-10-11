module Importing
  extend ActiveSupport::Concern

  included do
    adapter = ActiveRecord::Base.connection.adapter_name.downcase

    require "activerecord-import/base"
    require "activerecord-import/active_record/adapters/#{adapter}_adapter"
  end
end

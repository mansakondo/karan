module Catalog
  class SearchController < ApplicationController
    include Faceting

    def index
      entry = search_params[:query] || nil

      if (filter_params = search_params[:filter_by])
        filters = filter_params.to_h.each_with_object([]) do |(name, _), filters|
          path  = filter_params[name][:path]

          if filter_params[name][:entries]
            filter_params[name][:entries].each do |_, entry|
              field = entry[:field]
              value = entry[:value]

              if field && value
                filter =
                  if path
                    {
                      nested: {
                        path: path,
                        query: {
                          bool: {
                            filter: {
                              term: {
                                "#{field}": value
                              }
                            }
                          }
                        }
                      }
                    }
                  else
                    { term: { "#{field}": value }}
                  end

                filters << filter
              end
            end
          end
        end
      end

      @response = MARC::Record.bibliographic.search query(entry, filters).merge(facets)
    end

    private

    def search_params
      params.permit(:query, :sort_by, :commit, filter_by: {})
    end
  end
end

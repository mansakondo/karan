module Faceting
  extend ActiveSupport::Concern

  included do
    def query(query = nil, filters = [])
      match_query =
        if query.present?
          { multi_match: { query: query } }
        else
          { match_all: {} }
        end

      {
        query: {
          bool: {
            must: [
              { term: { "marc_recordable_type.keyword": "Catalog::MARC::Record::BibliographicRecord" }},
              **match_query
            ],
            filter: filters
          }
        }
      }
    end

    def facets
      {
        aggregations: {
          genre: {
            terms: { field: "genre.entry.raw" },
            meta: { field: "genre.entry.raw" }
          },
          subjects: {
            nested: {
              path: :subjects
            },
            aggregations: {
              entry: {
                terms: { field: "subjects.entry.raw" },
                meta: {
                  field: "subjects.entry.raw",
                  path: :subjects
                },
                aggregations: {
                  child: {
                    terms: { field: "subjects.level1.raw" },
                    meta: {
                      field: "subjects.level1.raw",
                      path: :subjects
                    },
                    aggregations: {
                      child: {
                        terms: { field: "subjects.level2.raw" },
                        meta: {
                          field: "subjects.level2.raw",
                          path: :subjects
                        },
                        aggregations: {
                          child: {
                            terms: { field: "subjects.level3.raw" },
                            meta: {
                              field: "subjects.level3.raw",
                              path: :subjects
                            },
                            aggregations: {
                              child: {
                                terms: { field: "subjects.level4.raw" },
                                meta: {
                                  field: "subjects.level4.raw",
                                  path: :subjects
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          },
          authors: {
            nested: {
              path: :authors
            },
            aggregations: {
              entry: {
                terms: { field: "authors.entry.raw" },
                meta: {
                  field: "authors.entry.raw",
                  path: :authors
                }
              }
            }
          }
        }
      }
    end
  end
end

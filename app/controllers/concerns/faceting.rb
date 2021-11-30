module Faceting
  extend ActiveSupport::Concern

  included do
    def facets
      {
        aggregations: {
          genre: {
            terms: { field: "genre.entry" },
            meta: { field: "genre.entry" }
          },
          subjects: {
            nested: {
              path: :subjects
            },
            aggregations: {
              entry: {
                terms: { field: "subjects.entry" },
                meta: {
                  field: "subjects.entry",
                },
                aggregations: {
                  child: {
                    terms: { field: "subjects.level1" },
                    meta: {
                      field: "subjects.level1",
                    },
                    aggregations: {
                      child: {
                        terms: { field: "subjects.level2" },
                        meta: {
                          field: "subjects.level2",
                        },
                        aggregations: {
                          child: {
                            terms: { field: "subjects.level3" },
                            meta: { field: "subjects.level3" },
                            aggregations: {
                              child: {
                                terms: { field: "subjects.level4" },
                                meta: { field: "subjects.level4" }
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
                terms: { field: "authors.entry" },
                meta: { field: "authors.entry" }
              }
            }
          }
        }
      }
    end
  end
end

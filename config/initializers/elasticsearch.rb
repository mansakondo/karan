Elasticsearch::Model.client = Elasticsearch::Transport::Client.new http: { user: "elastic", password: ENV["ELASTIC_PASSWORD"] }

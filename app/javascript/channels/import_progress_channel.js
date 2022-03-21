import consumer from "./consumer"

consumer.subscriptions.create("ImportProgressChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Hello!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    document.getElementById("import_progress").innerHTML = data.html

    const records = document.getElementById("catalog_marc_records")
    records.src = window.location.href
    records.reload()
  }
});

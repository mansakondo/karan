import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

// Connects to data-controller="import-progress"
export default class extends Controller {
  connect() {
    // this.subscription = consumer.subscriptions.create("ImportProgressChannel", {
    //   connected: this._connected.bind(this),
    //   disconnected: this._disconnected.bind(this),
    //   received: this._received.bind(this)
    // })
  }

  _connected() {
    console.log(`Connected to ${this.subscription.identifier}`);
  }

  _disconnected() {
  }

  _received(data) {
    this.element.innerHTML = data.html
  }
}

import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { ajax } from "discourse/lib/ajax";
import { action } from "@ember/object";
import { inject as service } from "@ember/service";

export default class MyModal extends Component {
  @service modal;
  @tracked email = "";
  @tracked id = "";

  @action
  submit() {
    ajax("/my_plugin/submit", {
      type: "POST",
      data: { email: this.email, id: this.id }
    }).then(() => {
      this.modal.close();
    });
  }
}
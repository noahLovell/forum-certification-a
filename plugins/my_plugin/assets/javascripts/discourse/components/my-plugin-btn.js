import Component from "@glimmer/component";
import { action } from "@ember/object";
import { inject as service } from "@ember/service";

export default class MyPluginBtn extends Component {
  @service modal;
  
  @action
  openModal() {
    this.modal.show("my-modal");
  }
}
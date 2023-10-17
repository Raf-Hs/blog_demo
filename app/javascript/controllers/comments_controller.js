import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  initialize() {
    document.addEventListener('turbo:before-stream-render', (event) => {
      // Evita el desplazamiento hacia arriba al actualizar la página con Turbo Streams
      window.scrollTo(0, window.scrollY);
    });
  }

  connect() {}

  toggleForm(event) {
    console.log("Hello");
    event.preventDefault();
    event.stopPropagation();

    const formID = event.currentTarget.getAttribute("data-comments-form-param"); // Cambiado de event.params a event.currentTarget.getAttribute
    const commentContentId = event.currentTarget.getAttribute("data-comments-content-param"); // Cambiado de event.params a event.currentTarget.getAttribute

    const form = document.getElementById(formID);
    form.classList.toggle("d-none");
    form.classList.toggle("mt-5");
    const commentContent = document.getElementById(commentContentId);
    commentContent.classList.toggle("d-none");
  }
}
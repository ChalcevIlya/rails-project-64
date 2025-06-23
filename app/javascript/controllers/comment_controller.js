import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["replyForm"]

  connect() {
    console.log("Comment controller connected")
  }

  toggleReplyForm(event) {
    const clickedId = event.currentTarget.dataset.commentId
    const allForms = this.element.querySelectorAll('.reply-form')

    allForms.forEach(form => {
      if (form.dataset.commentId === clickedId) {
        form.classList.toggle('d-none') // переключаем видимость для текущей формы
      } else {
        form.classList.add('d-none') // прячем все остальные формы
      }
    })
  }
}
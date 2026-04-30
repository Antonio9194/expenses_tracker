let skipTransition = false

document.addEventListener("click", (e) => {
  if (e.target.closest("[data-no-transition]")) {
    skipTransition = true
  }
})

document.addEventListener("turbo:visit", () => {
  if (skipTransition) {
    skipTransition = false
    return
  }
  document.body.classList.add("turbo-exit");
});

document.addEventListener("turbo:before-render", (event) => {
  if (document.body.classList.contains("turbo-exit")) {
    event.preventDefault();
    setTimeout(() => {
      event.detail.resume();
    }, 200);
  }
});

document.addEventListener("turbo:render", () => {
  document.body.classList.remove("turbo-exit");
});

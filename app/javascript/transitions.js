document.addEventListener("turbo:visit", () => {
  document.body.classList.add("turbo-exit");
});

document.addEventListener("turbo:before-render", (event) => {
  event.preventDefault();
  setTimeout(() => {
    event.detail.resume();
  }, 200);
});

document.addEventListener("turbo:render", () => {
  document.body.classList.remove("turbo-exit");
});

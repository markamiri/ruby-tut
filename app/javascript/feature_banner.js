// app/javascript/feature_banner.js
document.addEventListener("turbo:load", () => {
  const banner = document.getElementById("feature-banner-img");
  const wrapper = document.querySelector(".feature-banner");

  if (!banner || !wrapper) return;

  const images = JSON.parse(wrapper.dataset.images || "[]");
  if (images.length <= 1) return;

  let index = 0;

  setInterval(() => {
    index = (index + 1) % images.length;
    banner.src = images[index];
  }, 5000);
});
window.$ = $;
window.jQuery = $;

document.addEventListener("turbo:load", () => {
  console.log("✅ holo_cards.js loaded");

  let x;
  const cards = document.querySelectorAll(".card, .product-card");

  cards.forEach(card => {
    card.addEventListener("mousemove", e => {
      const rect = card.getBoundingClientRect();
      const l = e.clientX - rect.left;
      const t = e.clientY - rect.top;
      const h = card.offsetHeight;
      const w = card.offsetWidth;

      const px = Math.abs(Math.floor(100 / w * l) - 100);
      const py = Math.abs(Math.floor(100 / h * t) - 100);
      const lp = (50 + (px - 50) / 1.5);
      const tp = (50 + (py - 50) / 1.5);
      const ty = ((tp - 50) / 2) * -1;
      const tx = ((lp - 50) / 1.5) * 0.5;

      card.style.setProperty('--pointer-x', `${lp}%`);
      card.style.setProperty('--pointer-y', `${tp}%`);
      card.style.setProperty('--rotate-x', `${ty}deg`);
      card.style.setProperty('--rotate-y', `${tx}deg`);
      card.style.setProperty('--card-opacity', '1');

      card.classList.remove("card_animated_cat_section");
      clearTimeout(x);
    });

    card.addEventListener("mouseleave", () => {
      card.style.setProperty('--card-opacity', '0');
      card.style.setProperty('--rotate-x', '0deg');
      card.style.setProperty('--rotate-y', '0deg');

      x = setTimeout(() => {
        card.classList.add("card_animated_cat_section");
      }, 2500);
    });
  });
});

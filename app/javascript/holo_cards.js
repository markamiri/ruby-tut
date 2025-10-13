window.$ = $;
window.jQuery = $;

document.addEventListener("turbo:load", () => {
  console.log("✅ holo_cards.js loaded");

  let x;
  const cards = document.querySelectorAll(".card, .product-card"); // <-- FIXED
  const styleTag = document.querySelector(".hover");

  cards.forEach(card => {
    card.addEventListener("mousemove", e => {
      const rect = card.getBoundingClientRect();
      const l = e.clientX - rect.left;
      const t = e.clientY - rect.top;
      const h = card.offsetHeight;
      const w = card.offsetWidth;

      const px = Math.abs(Math.floor(100 / w * l) - 100);
      const py = Math.abs(Math.floor(100 / h * t) - 100);
      const pa = (50 - px) + (50 - py);

      const lp = (50 + (px - 50) / 1.5);
      const tp = (50 + (py - 50) / 1.5);
      const pxSpark = (50 + (px - 50) / 7);
      const pySpark = (50 + (py - 50) / 7);
      const pOpc = 20 + (Math.abs(pa) * 1.5);
      const ty = ((tp - 50) / 2) * -1;
      const tx = ((lp - 50) / 1.5) * 0.5;

      const gradPos = `background-position: ${lp}% ${tp}%;`;
      const sprkPos = `background-position: ${pxSpark}% ${pySpark}%;`;
      const opc = `opacity: ${pOpc / 100};`;
const tf = `rotateX(${ty}deg) rotateY(${tx}deg)`;

      const style = `
        .card:hover:before { ${gradPos} }  
        .card:hover:after  { ${sprkPos} ${opc} }   
      `;

      card.classList.remove("card_animated_cat_section");
    card.style.transform = tf;   // ✅ only touches transform
      //styleTag.innerHTML = style;
      clearTimeout(x);
    });

    card.addEventListener("mouseleave", () => {
      styleTag.innerHTML = "";
        card.style.transform = "";
      x = setTimeout(() => {
        card.classList.add("card_animated_cat_section");
      }, 2500);
    });
  });
});

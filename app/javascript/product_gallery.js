// app/javascript/product_gallery.js
import Sortable from "sortablejs";

window.swapMainImage = function (thumbnail) {
  const mainImage = document.getElementById("main-product-image");
  if (mainImage && thumbnail.src) {
    mainImage.src = thumbnail.src;
  }
};

document.addEventListener("turbo:load", () => {
  const gallery = document.querySelector(".photo-gallery");

  if (gallery) {
    Sortable.create(gallery, {
      animation: 150,
      onEnd: () => {
        const ids = Array.from(gallery.children).map(el => el.dataset.id);

        fetch(`/products/${gallery.dataset.productId}/reorder_images`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
          },
          body: JSON.stringify({ order: ids })
        });
      }
    });
  }
});

document.addEventListener("turbo:load", () => {
  console.log("✅ slideshow_controller.js loaded");

  const gallery = document.querySelector(".slideshow-thumbs");
  const saveButton = document.getElementById("save-order-btn");
  const mainImage = document.getElementById("main-slide-image");

  if (!gallery || !mainImage) return;

  let draggedItem = null;

  // ------------------------
  // ENABLE DRAGGABLE ITEMS
  // ------------------------
  gallery.querySelectorAll(".slide-item").forEach(item => {
    item.draggable = true;

    

    // CLICK → UPDATE MAIN IMAGE
    const thumb = item.querySelector(".slideshow-thumb");
    if (thumb) {
      thumb.addEventListener("click", () => {
        mainImage.src = thumb.dataset.full;

        document
          .querySelectorAll(".slideshow-thumb")
          .forEach(t => t.classList.remove("active"));

        thumb.classList.add("active");
      });
    }

    // DRAG START
    item.addEventListener("dragstart", () => {
      draggedItem = item;
      item.classList.add("dragging");
    });

    // DRAG END
    item.addEventListener("dragend", () => {
      item.classList.remove("dragging");
      draggedItem = null;
    });
  });

  // ------------------------
  // CONTAINER DRAGOVER (IMPORTANT)
  // ------------------------
  gallery.addEventListener("dragover", e => {
    e.preventDefault();
    if (!draggedItem) return;

    const afterElement = getDragAfterElement(gallery, e.clientX);

    if (afterElement == null) {
      gallery.appendChild(draggedItem);
    } else {
      gallery.insertBefore(draggedItem, afterElement);
    }
  });

  function getDragAfterElement(container, x) {
    const draggableElements = [
      ...container.querySelectorAll(".slide-item:not(.dragging)")
    ];

    return draggableElements.reduce(
      (closest, child) => {
        const box = child.getBoundingClientRect();
        const offset = x - box.left - box.width / 2;

        if (offset < 0 && offset > closest.offset) {
          return { offset, element: child };
        }
        return closest;
      },
      { offset: Number.NEGATIVE_INFINITY }
    ).element;
  }

  // ------------------------
  // SAVE ORDER
  // ------------------------
  if (saveButton) {
    saveButton.addEventListener("click", e => {
      e.preventDefault();

      const order = [...gallery.querySelectorAll(".slide-item")].map(
        el => el.dataset.id
      );

      fetch("/slide_shows/reorder", {
        method: "POST",
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ order })
      }).then(res => {
        if (res.ok) window.location.reload();
      });
    });
  }
});
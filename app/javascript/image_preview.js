document.addEventListener("turbo:load", () => {
  function setupPreview(inputId, previewId, instructionsId) {
    const input = document.getElementById(inputId);
    const previewContainer = document.getElementById(previewId);
    const instructions = instructionsId ? document.getElementById(instructionsId) : null;

    if (input && previewContainer) {
      input.addEventListener("change", () => {
        if (instructions) {
          instructions.textContent = input.files.length > 0
            ? "Press Update Product to upload photos"
            : "Upload Photos";
        }

        previewContainer.innerHTML = "";

        Array.from(input.files).forEach(file => {
          if (!file.type.startsWith("image/")) return;

          const reader = new FileReader();
          reader.onload = (e) => {
            const img = document.createElement("img");
            img.src = e.target.result;
            img.classList.add("preview-thumb");
            previewContainer.appendChild(img);
          };
          reader.readAsDataURL(file);
        });
      });
    }
  }

  // Multi
  setupPreview("product_images_input", "image-preview-container", "upload-instructions");

  // Single
  setupPreview("product_image_input", "single-image-preview", "upload-instructions");
});


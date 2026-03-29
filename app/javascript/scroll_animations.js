document.addEventListener("turbo:load", () => {
  if (typeof gsap === "undefined" || typeof ScrollTrigger === "undefined") return;

  gsap.registerPlugin(ScrollTrigger);

  gsap.from(".special-collection", {
    scrollTrigger: {
      trigger: ".special-collection",
      start: "top 85%",
    },
    opacity: 0,
    y: 60,
    duration: 1.2,
    ease: "power2.out"
  });

  gsap.from(".popular-section", {
    scrollTrigger: {
      trigger: ".popular-section",
      start: "top 80%",
      end: "top 30%",
      scrub: 1,
    },
    opacity: 0,
    y: 80,
    scale: 0.95,
    ease: "power2.out"
  });

  gsap.from(".best-section", {
    scrollTrigger: {
      trigger: ".best-section",
      start: "top 80%",
      end: "top 30%",
      scrub: 1,
    },
    opacity: 0,
    scale: 0.92,
    y: 60,
    ease: "power2.out"
  });
});

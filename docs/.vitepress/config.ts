import { defineConfig } from "vitepress"

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "Eluga Docs",
  description: "The Eluga Docs",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: "Home", link: "/" },
      { text: "Manual", link: "/manual/" },
      { text: "Download", link: "/download" },
    ],

    sidebar: [
      {
        text: "Getting started",
        items: [{ text: "Download", link: "/download" }],
      },
      {
        text: "Manual",
        items: [
          { text: "Intro", link: "/manual/" },
          { text: "Engine", link: "/manual/engine" },
        ],
      },
    ],

    socialLinks: [
      { icon: "github", link: "https://github.com/majikiti/eluga" },
    ],
  },
})

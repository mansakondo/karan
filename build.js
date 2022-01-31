#!/usr/bin/env node

const importGlobPlugin = require("esbuild-plugin-import-glob");

require("esbuild").build({
  entryPoints: ["app/javascript/application.js"],
  outdir: "app/assets/builds/",
  bundle: true,
  plugins: [
    importGlobPlugin.default(),
  ],
  watch: process.argv.includes("--watch"),
}).catch(() => process.exit(1))


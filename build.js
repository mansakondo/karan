#!/usr/bin/env node

const path             = require("path")
const importGlobPlugin = require("esbuild-plugin-import-glob");

const watchMode = process.argv.includes("--watch")
const onRebuild = {
  onRebuild(error, result) {
    if (error) console.error('watch build failed:', error)
    else console.log('watch build succeeded:', result)
  }
}

require("esbuild").build({
  entryPoints: ["application.js"],
  outdir: path.join(process.cwd(), "app/assets/builds/"),
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  bundle: true,
  plugins: [
    importGlobPlugin.default(),
  ],
  watch: watchMode ? onRebuild : false,
}).then(() => {
  console.log("Watching...")
}).catch(() => {
  process.exit(1)
})

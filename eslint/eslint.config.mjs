/**
 * This is a default eslint config used if no config is found.
 * needs npm packages "eslint" and "typescript-eslint" installed
 */

// @ts-check

import eslint from "@eslint/js";
import { defineConfig } from "eslint/config";
import tseslint from "typescript-eslint";

export default defineConfig(
  eslint.configs.recommended,
  tseslint.configs.recommended,
);

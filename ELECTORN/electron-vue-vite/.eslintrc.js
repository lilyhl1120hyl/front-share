module.exports = {
    root: true,
    env: {
      node: true,
      // The Follow config only works with eslint-plugin-vue v8.0.0+
      "vue/setup-compiler-macros": true,
    },
    extends: [
      "plugin:vue/vue3-essential",
      "eslint:recommended",
      "@vue/typescript/recommended",
      "plugin:prettier/recommended",
    ],
    plugins: ["vue"],
    parser: "vue-eslint-parser",
    parserOptions: {
      parser: "@typescript-eslint/parser",
      ecmaVersion: 2020, 
      sourceType: "module",
    },
    rules: {
      "no-console": import.meta.env.NODE_ENV === "production" ? "warn" : "off",
      "no-debugger": import.meta.env.NODE_ENV === "production" ? "warn" : "off",
      "prettier/prettier": ["error", { endOfLine: "auto" }],
      "no-unreachable": "warn",
      "vue/no-unused-vars": "warn",
      "@typescript-eslint/no-var-requires": "off",
    },
    globals: {},
  };
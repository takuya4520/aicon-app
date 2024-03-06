module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        header_name: ['Gloria Hallelujah', 'cursive'],
        body_style: ['Zen Maru Gothic', 'serif']
      }
    }
  },  
  plugins: [require("daisyui")],
  daisyui: {
    themes: [
      "winter"
    ],
  }
}
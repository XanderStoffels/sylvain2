// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    modules: ['@nuxtjs/tailwindcss'],
    app: {
        head: {
            title: "Vakantiehuis Sylvain",
            meta: [],
            link: []
        }
    },
    runtimeConfig: {
        apiKey: process.env.API_KEY,
    }
})

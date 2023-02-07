<template>
    <div>
        <nav class="px-4 py-2 lg:px-4 lg:py-4 flex justify-between items-center bg-white">
            <div class="lg:hidden">
                <button class="navbar-burger flex items-center text-gray-600 p-3" @click="showSideMenu = !showSideMenu">
                    <svg class="block h-4 w-4 fill-current" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                        <title>Mobile menu</title>
                        <path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"></path>
                    </svg>
                </button>
            </div>
            <ul class="hidden lg:mx-auto lg:flex lg:items-center lg:w-auto lg:space-x-12 text-gray-500">
                <NuxtLink to="/">WELKOM</NuxtLink>
                <NuxtLink to="/fotos">FOTO'S</NuxtLink>
                <NuxtLink to="/vakantiewoning">VAKANTIEWONING</NuxtLink>
                <NuxtLink to="/reservaties">RESERVEREN</NuxtLink>
                <NuxtLink to="/ligging">LIGGING</NuxtLink>
                <NuxtLink to="/contact">CONTACT</NuxtLink>
            </ul>
        </nav>

        <n-drawer v-model:show="showSideMenu" placement="left">
            <n-drawer-content title="Navigatie" closeable>
                <ul>
                    <NuxtLink to="/" @click="showSideMenu = false"
                        class="block p-4 text-sm font-semibold text-gray-400 hover:bg-blue-50 hover:text-blue-600 rounded">
                        WELKOM</NuxtLink>
                    <NuxtLink to="/fotos" @click="showSideMenu = false"
                        class="block p-4 text-sm font-semibold text-gray-400 hover:bg-blue-50 hover:text-blue-600 rounded">
                        FOTO'S</NuxtLink>
                    <NuxtLink to="/vakantiewoning" @click="showSideMenu = false"
                        class="block p-4 text-sm font-semibold text-gray-400 hover:bg-blue-50 hover:text-blue-600 rounded">
                        VAKANTIEWONING</NuxtLink>
                    <NuxtLink to="/reservaties" @click="showSideMenu = false"
                        class="block p-4 text-sm font-semibold text-gray-400 hover:bg-blue-50 hover:text-blue-600 rounded">
                        RESERVEREN</NuxtLink>
                    <NuxtLink to="/ligging" @click="showSideMenu = false"
                        class="block p-4 text-sm font-semibold text-gray-400 hover:bg-blue-50 hover:text-blue-600 rounded">
                        LIGGING</NuxtLink>
                    <NuxtLink to="/contact" @click="showSideMenu = false"
                        class="block p-4 text-sm font-semibold text-gray-400 hover:bg-blue-50 hover:text-blue-600 rounded">
                        CONTACT</NuxtLink>

                </ul>
            </n-drawer-content>
        </n-drawer>

        <n-message-provider placement="top">
            <div class="container mx-auto px-4">
                <slot></slot>
            </div>
        </n-message-provider>

    </div>
</template>

<script setup lang="ts">

import { NDrawer, NDrawerContent, NMessageProvider } from 'naive-ui';

const showSideMenu = ref(false);


</script>


<style scoped>
.router-link-exact-active {
    color: #000000;
}
</style>
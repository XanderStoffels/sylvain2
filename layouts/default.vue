<template>
    <div>
        <header class="shadow-sm bg-white">
            <nav class="container mx-auto p-4 flex justify-between">
                <NuxtLink to="/" class="font-bold">Vakantiehuis Sylvain</NuxtLink>
                <ul class="flex gap-4">
                    <li>
                        <NuxtLink to="/">Home</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/about">About</NuxtLink>
                    </li>
                    <li>
                        <NuxtLink to="/reserveringen" class="btn">Reserveringen</NuxtLink>
                    </li>

                </ul>
            </nav>
        </header>
        <div class="container mx-auto p-4">
            <slot />
        </div>
        <hr>
    </div>
</template>

<style scoped>
.router-link-exact-active {
    color: #12b488;
}
</style>
<template>
    <div>
        <p>{{ product.title }}</p>
        <p>{{ product.price }}</p>
        <p>{{ product.id }}</p>
    </div>
</template>

<script lang="ts" setup>
const route = useRoute();
const id = route.params.id;

const uri = `https://fakestoreapi.com/products/${id}`;
const { data: product } = await useFetch(uri, { key: id });


</script>

<style scoped>

</style>
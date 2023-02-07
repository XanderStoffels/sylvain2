<template>
    <div>
        <h1>Reservering lookup by id: {{ id }}}</h1>
    </div>
</template>

<script lang="ts" setup>
const route = useRoute();
const id = route.params.id;

</script>

<style scoped>

</style>
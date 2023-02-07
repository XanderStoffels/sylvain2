<template>
  <n-back-top :bottom="50" :visibility-height="300" :style="{
    transition: 'all .3s cubic-bezier(.4, 0, .2, 1)'
  }">
    <div class="icon-container">
      <n-icon size="40">
        <ArrowUpOutline />
      </n-icon>
    </div>
  </n-back-top>
  <div>
    <div v-show="photos.length === 0" class="flex justify-center pt-20">
      <n-spin size="large" />
    </div>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 justify-items-center">
      <n-image v-for="photo in photos" :key="photo" :src="photo" class="w-[350px] h-[350px] md:w-[400px] md:h-[400px]
        object-cover rounded-sm justify-center bg-gray-200" object-fit="cover" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { NSpin, NImage, NBackTop, NIcon } from 'naive-ui';
import { ArrowUpOutline } from '@vicons/ionicons5';

const imports = import.meta.glob('@/assets/img/gallery/*');
const photos = ref<string[]>([]);

onMounted(async () => {
  // Import photos dynamically.
  const tasks = Object.keys(imports).map(path => imports[path]());
  const importedPhotos = await Promise.all(tasks);
  importedPhotos.forEach(m => photos.value.push(m.default));
});


</script>

<style scoped>
.icon-container {
  width: 100px;
  height: 40px;
  line-height: 40px;
  text-align: center;
  font-size: 14px;
}
</style>
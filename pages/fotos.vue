<template>
  <div v-show="!showModal">
    <n-back-top :bottom="50" :visibility-height="300" :style="{
      transition: 'all .3s cubic-bezier(.4, 0, .2, 1)'
    }">
      <div class="icon-container">
        <n-icon size="40">
          <ArrowUpOutline />
        </n-icon>
      </div>
    </n-back-top>
  </div>

  <div v-show="showModal" @click="showModal = false"
    class="fixed top-0 left-0 z-80 w-screen h-screen bg-black/70 flex justify-center items-center">
    <a @click="showModal = false"
      class="cursor-pointer fixed z-90 top-6 right-8 text-white text-5xl font-bold">&times;</a>
    <img :src="selectedPhoto" class="object-contain max-w-[800px] max-h-[600px]" />
  </div>
  <div class="container">
    <div class="flex flex-wrap">
      <div v-for="photo, index in photos" :key="photo" class="aspect-square py-1 md:p-2 w-1/1 md:w-1/2 xl:w-1/3 ">
        <img class="block h-full w-full object-cover" :src="photo" @click="photoClick(index)" />
        <!-- <n-image :src="photo" class="block h-full w-full" /> -->
      </div>
    </div>
</div>
</template>

<script setup lang="ts">
import { NBackTop, NIcon } from 'naive-ui';
import { ArrowUpOutline } from '@vicons/ionicons5';

const { photos } = useGalleryImages();

const showModal = ref(false);
const photoIndex = ref(0);
const selectedPhoto = ref<string>(photos.value[photoIndex.value]);

function photoClick(photoIndex: number) {
  selectedPhoto.value = photos.value[photoIndex];
  showModal.value = true;
}

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
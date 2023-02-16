export const useGalleryImages = () => {
    const imports = import.meta.glob('@/assets/img/gallery/*');
    const photos = ref<string[]>([]);

    onMounted(async () => {
        await loadPhotosAsync();
    });

    async function loadPhotosAsync() {
        // Import photos dynamically.
        if (photos.value.length > 0) return;
        const tasks = Object.keys(imports).map(path => imports[path]());
        const importedPhotos = await Promise.all(tasks);
        importedPhotos.forEach(m => photos.value.push(m.default));
    }

    return { photos };

}
<template>
  <header class="flex justify-center">
    <div class="flex-col align-middle justify-center text-center mb-4" @click="copyAddressToClipboard">
      <h1 class="text-4xl mb-3">Ligging</h1>
      <h4 class="text-xl">Vakantiehuis Sylvain</h4>
      <h4 class="text-xl">Bosakkerstraat 73</h4>
      <h4 class="text-xl">8700 Tielt (Meulebeke ingeven in GPS)</h4>
    </div>
  </header>
  <div class="hidden lg:flex lg:flex-row lg:justify-center lg:text-center">
    <div class="p-4">
      <h1 class="text-4xl mb-3">Marialoop</h1>
      <h4 class="text-xl">Onze-Lieve-Vrouw en Sint-Leokerk</h4>
      <h4 class="text-xl">Kapel van Onze-Lieve-Vrouw van Marialoop</h4>
      <h4 class="text-xl">Bakkerij Carlo</h4>
      <h4 class="text-xl">Kruidenierszaak 't Hoeveke</h4>
      <h4 class="text-xl">Apotheek Aernout</h4>
      <h4 class="text-xl">Marialooppad</h4>
    </div>
    <div class="p-4">
      <h1 class="text-4xl mb-3">Tielt</h1>
      <h4 class="text-xl">Tal van restaurants en café's</h4>
      <h4 class="text-xl">waaronder Koffie-en Eethuys Bellevue.</h4>
      <h4 class="text-xl">Allerlei wandelroutes</h4>
      <h4 class="text-xl">De Poelberg</h4>
      <h4 class="text-xl">Fietsknooppuntenroutes</h4>
      <h4 class="text-xl"><a href="www.visittielt.be">www.visittielt.be</a></h4>
    </div>
  </div>
  <footer id="map" class="w-full">
    <iframe width="100%" height="450" style="border:0" loading="lazy" allowfullscreen
      src="https://www.google.com/maps/embed/v1/place?q=50.9678937%2C%203.3321391&key=AIzaSyCAm0jWckf_LC8MNwq5dL_Sc3TMSzx1984"></iframe>
  </footer>
</template>

<script setup lang="ts">
import { useMessage } from "naive-ui";

const message = useMessage();

function copyAddressToClipboard() {
  navigator.clipboard.writeText("Bosakkerstraat 73, 8700 Meulebeke, Belgie");
  message.info("Adres gekopieerd naar klembord");
}


</script>

<style scoped>

</style>
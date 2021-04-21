<template>
  <div class="container">
    <div id="dropdown-search">
      <b-dropdown text="Search for..." class="m-md-2">
        <b-dropdown-item v-for="query in querys" :key="query.text">
          {{ query.text }}
          <b-dropdown-divider></b-dropdown-divider>
        </b-dropdown-item>
      </b-dropdown>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { BootstrapVue, DropdownPlugin } from "bootstrap-vue";
Vue.use(BootstrapVue);
Vue.use(DropdownPlugin);

export default {
  data() {
    return {
      querys: [
        { text: "Session" },
        { text: "Talks" },
        { text: "Docs" },
        { text: "Conten" },
        { text: "MPs" },
      ],
    };
  },
};
</script>

<style>
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
}

.title {
  font-family: "Quicksand", "Source Sans Pro", -apple-system, BlinkMacSystemFont,
    "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
  display: block;
  font-weight: 300;
  font-size: 100px;
  color: #35495e;
  letter-spacing: 1px;
}

.subtitle {
  font-weight: 300;
  font-size: 42px;
  color: #526488;
  word-spacing: 5px;
  padding-bottom: 15px;
}

.links {
  padding-top: 15px;
}
</style>

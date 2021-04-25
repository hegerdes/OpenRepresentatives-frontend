<template>
  <div id="main">
    <div id="nav-bar">
      <NavBar
        @update-data="refresh()"
      />
    </div>
    <div class="container">
      <div id="dropdown-search">
        <b-dropdown :text="searchMsg" class="m-md-2">
          <b-dropdown-item v-for="query in querys" :key="query.text" @click="searchSelected(query.text)">
            {{ query.text }}
            <b-dropdown-divider />
          </b-dropdown-item>
        </b-dropdown>
      </div>
      <div id="session-search-options">
        <b-form-datepicker
          id="start-datepicker"
          v-model="startDate"
          :date-disabled-fn="dateDisabled"
          locale="de"
          placeholder="Start Date"
        />
        <b-form-datepicker
          id="end-datepicker"
          v-model="endDate"
          :date-disabled-fn="dateDisabled"
          locale="de"
          placeholder="End Date"
        />
      </div>
    </div>
  </div>
</template>

<script lang='ts'>
import Vue from 'vue'
import { BootstrapVue, DropdownPlugin, BootstrapVueIcons } from 'bootstrap-vue'
// import navbar from '~/components/navbar.vue'
Vue.use(BootstrapVue)
Vue.use(DropdownPlugin)
Vue.use(BootstrapVueIcons)

export default Vue.extend({
  data () {
    return {
      searchMsg: 'Search for...',
      startDate: '',
      endDate: '',
      querys: [
        { text: 'Sessions' },
        { text: 'Talks' },
        { text: 'Docs' },
        { text: 'Content' },
        { text: 'MPs' }
      ]
    }
  },
  methods: {
    dateDisabled (_ymd: String, date: Date) {
      // Disable weekends (Sunday = `0`, Saturday = `6`) and
      // disable days that fall on the 13th of the month
      const weekday = date.getDay()
      const day = date.getDate()
      // Return `true` if the date should be disabled
      return weekday === 0 || weekday === 6 || day === 13
    },
    searchSelected (searchType: string) {
      this.searchMsg = searchType
    }
  }
})
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

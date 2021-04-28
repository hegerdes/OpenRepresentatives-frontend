<template>
  <div id="main">
    <div id="nav-bar">
      <NavBar
        @update-data="refresh()"
      />
    </div>
    <div class="container">
      <div id="dropdown-search">
        <b-dropdown :text="searchType.text" class="mb-2 mr-sm-4 mb-sm-0">
          <b-dropdown-item v-for="query in querys" :key="query.text" @click="searchSelected(query)">
            {{ query.text }}
            <b-dropdown-divider />
          </b-dropdown-item>
        </b-dropdown>
      </div>
      <div id="session-search-options">
        <b-form v-if="searchType.id === 1" inline @submit.stop.prevent>
          <label class="sr-only" for="inline-form-input-start-date">Start Date</label>
          <b-form-datepicker
            id="start-datepicker"
            v-model="startDate"
            class="mb-2 mr-sm-2 mb-sm-0"
            :date-disabled-fn="dateDisabled"
            locale="de"
            placeholder="Start Date"
          />
          <label class="sr-only" for="inline-form-input-end-date">End Date</label>
          <b-form-datepicker
            id="end-datepicker"
            v-model="endDate"
            class="mb-2 mr-sm-2 mb-sm-0"
            :date-disabled-fn="dateDisabled"
            locale="de"
            placeholder="End Date"
          />
          <b-form-text id="input-session-info" class="mb-2 mr-sm-2 mb-sm-0">
            Or
          </b-form-text>
          <label class="sr-only" for="inline-form-input-session">SessionSearch</label>
          <b-form-input
            id="session-search-in"
            v-model="sessionIndices"
            name="session-imput-1"
            :state="sessionState('name')"
            aria-describedby="input-live-feedback"
            placeholder="SessionIDs"
            trim
          />
          <!-- This will only be shown if the preceding input has an invalid state -->
          <b-form-invalid-feedback id="input-live-feedback">
            Enter at least 3 letters
          </b-form-invalid-feedback>
        </b-form>
        <b-form v-if="searchType.id === 2" inline @submit.stop.prevent>
          <label class="sr-only" for="inline-form-input-start-date">Start Date</label>
          <b-form-datepicker
            id="session-datepicker"
            v-model="startDate"
            class="mb-2 mr-sm-2 mb-sm-0"
            :date-disabled-fn="dateDisabled"
            locale="de"
            placeholder="Date"
          />
          <b-form-text id="input-session-info" class="mb-2 mr-sm-2 mb-sm-0">
            Or
          </b-form-text>
          <label class="sr-only" for="inline-form-input-session">SessionSearch</label>
          <b-form-input
            id="session-search-in"
            v-model="sessionIndices"
            class="mb-2 mr-sm-2 mb-sm-0"
            name="session-imput-1"
            :state="sessionState('name')"
            aria-describedby="input-live-feedback"
            placeholder="SessionID"
            trim
          />
          <b-form-text id="input-session-info" class="mb-2 mr-sm-2 mb-sm-0">
            Or
          </b-form-text>
          <label class="sr-only" for="inline-form-input-session">SessionSearch</label>
          <b-form-input
            id="mp-search-in"
            v-model="mpName"
            class="mb-2 mr-sm-2 mb-sm-0"
            name="mp-imput-1"
            :state="mpState('name')"
            aria-describedby="input-live-feedback"
            placeholder="MP name or ID"
            trim
          />

          <!-- This will only be shown if the preceding input has an invalid state -->
          <b-form-invalid-feedback id="input-live-feedback">
            Enter at least 3 letters
          </b-form-invalid-feedback>
        </b-form>
      </div>
    </div>
  </div>
</template>

<script lang='ts'>
import Vue from 'vue'
import { BootstrapVue, DropdownPlugin, BootstrapVueIcons } from 'bootstrap-vue'
Vue.use(BootstrapVue)
Vue.use(DropdownPlugin)
Vue.use(BootstrapVueIcons)

interface SearchOptions {
  id: number;
  text: string;
}

export default Vue.extend({
  data () {
    return {
      startDate: '',
      endDate: '',
      sessionIndices: '',
      mpName: '',
      searchType: { id: 0, text: 'Search for...' },
      querys: [
        { id: 1, text: 'Sessions' },
        { id: 2, text: 'Talks' },
        { id: 3, text: 'Docs' },
        { id: 4, text: 'Content' },
        { id: 5, text: 'MPs' }
      ]
    }
  },
  computed: {
    sessionStateOld () {
      return false
    }
  },
  methods: {
    sessionState (_session: String) {
      return null
    },
    mpState (_session: String) {
      return null
    },
    dateDisabled (_ymd: String, date: Date) {
      // Disable weekends (Sunday = `0`, Saturday = `6`) and
      // disable days that fall on the 13th of the month
      const weekday = date.getDay()
      const day = date.getDate()
      // Return `true` if the date should be disabled
      return weekday === 0 || weekday === 6 || day === 13
    },
    searchSelected (searchType: SearchOptions) {
      this.searchType = searchType
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

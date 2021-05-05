<template>
  <div id="main">
    <div id="nav-bar">
      <NavBar
        @update-data="refresh()"
      />
    </div>
    <b-container fluid>
      <b-form-row align-v="stretch" align="left" class="top-buffer h-100">
        <b-col id="dropdown-search" sm="2">
          <b-dropdown :text="searchType.text" class="mb-2 mr-sm-4 mb-sm-0">
            <b-dropdown-item v-for="query in querys" :key="query.id" @click="searchSelected(query)">
              {{ query.text }}
              <b-dropdown-divider />
            </b-dropdown-item>
          </b-dropdown>
        </b-col>
        <b-col id="session-search-options" sm="10">
          <!-- Session Search -->
          <b-form v-if="searchType.id === 1" inline @submit.stop.prevent="onSubmit">
            <b-form-group id="session-date-picker-1" label-for="session-start-date-input">
              <!-- Start date -->
              <b-form-datepicker
                id="session-start-date-input"
                v-model="$v.formSession.startDate.$model"
                name="session-start-date-input"
                class="mb-2 mr-sm-2 mb-sm-0"
                :state="validateState('formSession', 'startDate')"
                :date-disabled-fn="dateDisabled"
                locale="de"
                aria-describedby="input-start-date-live-feedback"
                placeholder="Start Date"
              />
              <b-form-invalid-feedback id="input-start-date-live-feedback">
                There are no sessions on this date
              </b-form-invalid-feedback>
            </b-form-group>
            <b-form-group id="session-date-picker-2" label-for="session-end-date-input">
              <!-- End date -->
              <b-form-datepicker
                id="session-end-date-input"
                v-model="$v.formSession.endDate.$model"
                name="session-end-date-input"
                class="mb-2 mr-sm-2 mb-sm-0"
                :state="validateState('formSession', 'endDate')"
                :date-disabled-fn="dateDisabled"
                locale="de"
                aria-describedby="input-start-date-live-feedback"
                placeholder="End Date"
              />
              <b-form-invalid-feedback id="input-start-date-live-feedback">
                There are no sessions on this date
              </b-form-invalid-feedback>
            </b-form-group>
            <b-form-text id="input-session-info" class="mb-2 mr-sm-2 mb-sm-0">
              Or
            </b-form-text>
            <!-- Sessin ID search -->
            <b-form-group id="session-id-search" label-for="session-search-id-in">
              <b-form-input
                id="session-search-id-in"
                v-model.trim="$v.formSession.sessionIndices.$model"
                name="session-search-id-in"
                :state="validateState('formSession', 'sessionIndices')"
                aria-describedby="input-live-feedback"
                placeholder="SessionIDs"
                trim
              />
              <b-form-invalid-feedback id="input-live-feedback" aria-live="polite" class="inline">
                Enter at least 3 letters
              </b-form-invalid-feedback>
            </b-form-group>
          </b-form>

          <!-- Talk search -->
          <b-form v-if="searchType.id === 2" inline @submit.stop.prevent>
            <!-- Date -->
            <b-form-group id="talk-date-picker" label-for="talk-date-input">
              <b-form-datepicker
                id="talk-date-input"
                v-model="$v.formTalk.date.$model"
                name="talk-date-input"
                class="mb-2 mr-sm-2 mb-sm-0"
                :date-disabled-fn="dateDisabled"
                locale="de"
                aria-describedby="input-date-live-feedback"
                placeholder="Date"
              />
              <b-form-invalid-feedback id="input-date-live-feedback">
                There are no sessions on this date
              </b-form-invalid-feedback>
            </b-form-group>
            <b-form-text id="input-session-info" class="mb-2 mr-sm-2 mb-sm-0">
              Or
            </b-form-text>
            <!-- Session -->
            <b-form-group id="talk-session-form" label-for="talk-session-in">
              <b-form-input
                id="talk-session-in"
                v-model.trim="$v.formTalk.sessionIndices.$model"
                class="mb-2 mr-sm-2 mb-sm-0"
                name="talk-session-in"
                :state="validateState('formTalk', 'sessionIndices')"
                aria-describedby="input-live-feedback"
                placeholder="SessionID"
                trim
              />
              <b-form-invalid-feedback id="input-live-feedback">
                Enter at least 3 letters
              </b-form-invalid-feedback>
            </b-form-group>
            <b-form-text id="input-session-info" class="mb-2 mr-sm-2 mb-sm-0">
              Or
            </b-form-text>
            <!-- MPs -->
            <b-form-group id="talk-mp-form" label-for="talk-mp-in">
              <b-form-input
                id="talk-mp-in"
                v-model.trim="$v.formTalk.mpName.$model"
                class="mb-2 mr-sm-2 mb-sm-0"
                name="talk-mp-in"
                :state="validateState('formTalk', 'mpName')"
                aria-describedby="input-live-feedback"
                placeholder="MP name or ID"
                trim
              />
              <b-form-invalid-feedback id="input-live-feedback">
                Enter at least 3 letters
              </b-form-invalid-feedback>
            </b-form-group>
          </b-form>
        </b-col>
      </b-form-row>
    </b-container>
  </div>
</template>

<script lang='ts'>
import Vue from 'vue'
import { BootstrapVue, DropdownPlugin, BootstrapVueIcons } from 'bootstrap-vue'
import { validationMixin } from 'vuelidate'
import { required, minLength } from 'vuelidate/lib/validators'

Vue.use(BootstrapVue)
Vue.use(DropdownPlugin)
Vue.use(BootstrapVueIcons)

interface SearchOptions {
  id: number;
  text: string;
}

export default Vue.extend({
  mixins: [validationMixin],
  data () {
    return {
      searchType: { id: 0, text: 'Search for...' },
      querys: [
        { id: 1, text: 'Sessions' },
        { id: 2, text: 'Talks' },
        { id: 3, text: 'Docs' },
        { id: 4, text: 'Content' },
        { id: 5, text: 'MPs' }
      ],
      formSession: {
        startDate: null,
        endDate: null,
        sessionIndices: null
      },
      formTalk: {
        date: null,
        sessionIndices: null,
        mpName: null
      }
    }
  },
  validations: {
    formSession: {
      startDate: {
        required
      },
      endDate: {
        required
      },
      sessionIndices: {
        minLength: minLength(4)
      }
    },
    formTalk: {
      date: {
        required
      },
      sessionIndices: {
        minLength: minLength(4)
      },
      mpName: {
        minLength: minLength(4)
      }
    }
  },
  computed: {
    sessionStateOld () {
      return false
    }
  },
  methods: {
    validateState (form: string, index: string) {
      let prop: any
      if (form === 'formSession') {
        prop = this.$v.formSession[index]
      } else if (form === 'formTalk') {
        prop = this.$v.formTalk[index]
      }
      const { $dirty, $error } = prop
      return $dirty ? !$error : null
    },
    resetForm () {
      this.formSession = {
        startDate: null,
        endDate: null,
        sessionIndices: null
      }

      this.$nextTick(() => {
        this.$v.$reset()
      })
    },
    onSubmit () {
      this.$v.form.$touch()
      if (this.$v.form.$anyError) {
        return
      }

      alert('Form submitted!')
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

.top-buffer { margin-top:20px; }

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

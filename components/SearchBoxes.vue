<template>
  <div id="search-boxes">
    <!-- Session Search -->
    <b-form v-if="searchType.id === 1" inline @submit.stop.prevent="onSubmit(searchType.id)">
      <b-form-group id="session-date-picker-1" label-for="session-start-date-input">
        <!-- Start date -->
        <b-form-datepicker
          id="session-start-date-input"
          v-model="$v.formSession.startDate.$model"
          name="session-start-date-input"
          class="mb-2 mr-sm-2 mb-sm-0"
          :state="validateState('formSession', 'startDate')"
          :date-format-options="{ year: 'numeric', month: 'numeric', day: 'numeric', weekday: 'short'}"
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
          :date-format-options="{ year: 'numeric', month: 'numeric', day: 'numeric', weekday: 'short'}"
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
          class="mb-2 mr-sm-2 mb-sm-0"
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

      <b-button type="submit" variant="primary">
        Submit
      </b-button>
    </b-form>

    <!-- Talk search -->
    <b-form v-if="searchType.id === 2" inline @submit.stop.prevent="onSubmit(searchType.id)">
      <!-- Date -->
      <b-form-group id="talk-date-picker" label-for="talk-date-input">
        <b-form-datepicker
          id="talk-date-input"
          v-model="$v.formTalk.date.$model"
          name="talk-date-input"
          class="mb-2 mr-sm-2 mb-sm-0"
          :date-disabled-fn="dateDisabled"
          :date-format-options="{ year: 'numeric', month: 'numeric', day: 'numeric', weekday: 'short',}"
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
      <b-form-text id="input-session-info" class="mb-2 mr-sm-2 mb-sm-0">
        Or
      </b-form-text>
      <!-- Topic -->
      <b-form-group id="talk-topic-form" label-for="talk-topic-in">
        <b-form-input
          id="talk-topic-in"
          v-model.trim="$v.formTalk.topic.$model"
          class="mb-2 mr-sm-2 mb-sm-0"
          name="talk-topic-in"
          :state="validateState('formTalk', 'topic')"
          aria-describedby="input-live-feedback"
          placeholder="Topic"
          trim
        />
        <b-form-invalid-feedback id="input-live-feedback">
          Enter at least 3 letters
        </b-form-invalid-feedback>
      </b-form-group>
      <b-button type="submit" variant="primary">
        Submit
      </b-button>
    </b-form>
    <!-- Doc search -->
    <b-form v-if="searchType.id === 3" inline @submit.stop.prevent>
      <!-- DocName -->
      <b-form-group id="doc-name-form" label-for="doc-name-in">
        <b-form-input
          id="doc-name-in"
          v-model.trim="$v.formDocs.docName.$model"
          class="mb-2 mr-sm-2 mb-sm-0"
          name="doc-name-in"
          :state="validateState('formDocs', 'docName')"
          aria-describedby="input-live-feedback"
          placeholder="DocName"
          trim
        />
        <b-form-invalid-feedback id="input-live-feedback">
          Enter at least 3 letters
        </b-form-invalid-feedback>
      </b-form-group>
      <b-form-text id="input-session-info" class="mb-2 mr-sm-2 mb-sm-0">
        Or
      </b-form-text>
      <!-- Session -->
      <b-form-group id="doc-session-form" label-for="doc-session-in">
        <b-form-input
          id="doc-session-in"
          v-model.trim="$v.formDocs.sessionIndices.$model"
          class="mb-2 mr-sm-2 mb-sm-0"
          name="doc-session-in"
          :state="validateState('formDocs', 'sessionIndices')"
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
      <!-- Date -->
      <b-form-group id="doc-date-picker" label-for="doc-date-input">
        <b-form-datepicker
          id="doc-date-input"
          v-model="$v.formDocs.date.$model"
          name="doc-date-input"
          class="mb-2 mr-sm-2 mb-sm-0"
          :date-disabled-fn="dateDisabled"
          :date-format-options="{
            year: 'numeric',
            month: 'numeric',
            day: 'numeric',
            weekday: 'short',
          }"
          locale="de"
          aria-describedby="input-date-live-feedback"
          placeholder="Date"
        />
        <b-form-invalid-feedback id="input-date-live-feedback">
          There are no sessions on this date
        </b-form-invalid-feedback>
      </b-form-group>
    </b-form>
  </div>
</template>

<script lang='ts'>

import Vue from 'vue'
import { validationMixin } from 'vuelidate'
import { required, minLength } from 'vuelidate/lib/validators'

export default Vue.extend({
  name: 'SearchBoxes',
  mixins: [validationMixin],
  props: {
    searchType: {
      type: Object,
      default () {
        return {}
      }
    }
  },
  data () {
    return {
      formSession: {tartDate: null, endDate: null, sessionIndices: null },
      formTalk: {date: null, sessionIndices: null, mpName: null, topic: null },
      formDocs: {date: null, sessionIndices: null, docName: null }
    }
  },
  methods: {
    validateState (form: string, index: string) {
      let prop: any
      if (form === 'formSession') {
        prop = this.$v.formSession[index]
      } else if (form === 'formTalk') {
        prop = this.$v.formTalk[index]
      } else if (form === 'formDocs') {
        prop = this.$v.formDocs[index]
      } else {
        return null
      }
      const { $dirty, $error } = prop
      return $dirty ? !$error : null
    },
    resetForm () {
      this.$nextTick(() => {
        this.$v.$reset()
      })
    },
    onSubmit (_fromType: Number) {
      this.$v.formSession.$touch()
      if (this.$v.formSession.$anyError) {
        alert('Hey there')
      }
    },
    dateDisabled (_ymd: String, date: Date) {
      // Disable weekends (Sunday = `0`, Saturday = `6`) and
      const weekday = date.getDay()
      // Return `true` if the date should be disabled
      return weekday === 0 || weekday === 6
    }
  },
  validations: {
    formSession: {
      startDate: { required },
      endDate: { required },
      sessionIndices: { minLength: minLength(4) }
    },
    formTalk: {
      date: { required },
      sessionIndices: { minLength: minLength(4) },
      mpName: { minLength: minLength(4) },
      topic: { minLength: minLength(4) }
    },
    formDocs: {
      sessionIndices: { minLength: minLength(4) },
      docName: { minLength: minLength(4) },
      date: { required }
    }
  }
})
</script>

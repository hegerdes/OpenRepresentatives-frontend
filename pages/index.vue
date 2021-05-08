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
            <b-dropdown-item v-for="query in querys" :key="query.id" @click="searchSelected(query) ">
              <div v-if="query.id > 0">
                {{ query.text }}
                <b-dropdown-divider />
              </div>
            </b-dropdown-item>
          </b-dropdown>
        </b-col>
        <b-col id="session-search-options" sm="10">
          <SearchBoxes
            :search-type="searchType"
          />
        </b-col>
      </b-form-row>
      <b-row class="container">
        <b-button variant="primary" @click="getX">
          GraphQLTest
        </b-button>
      </b-row>
      <b-row class="container">
        <b-card>
          {{ queryRes }}
        </b-card>
      </b-row>
    </b-container>
  </div>
</template>

<script lang='ts'>
import Vue from 'vue'
import { BootstrapVue, DropdownPlugin, BootstrapVueIcons } from 'bootstrap-vue'
import { validationMixin } from 'vuelidate'
import VueApollo from 'vue-apollo'
import ApolloClient, { ApolloQueryResult, NetworkStatus } from 'apollo-boost'
import { gql } from 'graphql-tag'
import SearchBoxes from '~/components/SearchBoxes.vue'

Vue.use(VueApollo)
Vue.use(BootstrapVue)
Vue.use(DropdownPlugin)
Vue.use(BootstrapVueIcons)

interface SearchOptions {
  id: number;
  text: string;
}

const apolloProvider = new VueApollo({
  defaultClient: new ApolloClient({
    uri: 'https://open-representatives.herokuapp.com/graphql'
  }),
  errorHandler (error) {
    console.log('GraphQL err:', error)
  }
})

const tmpres: ApolloQueryResult<any> = {
  data: null,
  loading: false,
  stale: false,
  networkStatus: NetworkStatus.ready
}

export default Vue.extend({
  components: { SearchBoxes },
  mixins: [validationMixin],
  apolloProvider,
  data () {
    return {
      queryRes: tmpres,
      searchType: { id: 0, text: 'Search for...' },
      querys: [
        { id: 0, text: 'Search for...' },
        { id: 1, text: 'Sessions' },
        { id: 2, text: 'Talks' },
        { id: 3, text: 'Docs' },
        { id: 4, text: 'Content' },
        { id: 5, text: 'MPs' }
      ]
    }
  },
  validations: { },
  computed: {},
  methods: {
    async getX () {
      await this.$apollo.query({
        query: gql`query {
          getMPs(party:"spd"){
            f_name
            s_name
            mp_id
            role
            party
          }
        }`
      }).then((res) => {
        this.queryRes = res
      }).catch((error) => {
        this.queryRes = {
          data: error,
          loading: false,
          stale: false,
          networkStatus: NetworkStatus.ready
        }
      })
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
  min-height: 10vh;
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

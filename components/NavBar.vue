<template>
  <div id="nav-bar-elem">
    <b-navbar toggleable="sm" type="light" variant="light" sticky>
      <b-navbar-toggle target="nav-text-collapse" />
      <b-navbar-brand>OpenRepresentives</b-navbar-brand>

      <b-collapse id="nav-text-collapse" is-nav>
        <b-navbar-nav>
          <b-nav-item href="#">
            Home
          </b-nav-item>
          <b-nav-item href="#">
            About
          </b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav class="ml-auto">
          <b-nav-item href="https://github.com/hegerdes/OpenRepresentatives-frontend" target="_blank">
            GitHub
          </b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
export default {
  name: 'NavBar'
}
</script>

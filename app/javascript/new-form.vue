<template>
  <form class='form' v-bind:action='diariesPath' method='post'>
    <h2>観戦日記をつける</h2>
    <input type='hidden' name='authenticity_token' v-bind:value='token()'>
    <input type='hidden' name='diary[game_id]' v-bind:value='game.id'>
    <div class='field'>
      <label class='label'>日記</label>
      <div class='control'>
        <textarea class='textarea' name='diary[comment]'></textarea>
      </div>
    </div>
    <div class='field'>
      <label class='label'>ニュースのリンク</label>
      <div class='link' v-for='link in links' :key='link.key'>
        <input type='hidden' v-bind:name="`diary[links_attributes][${link.id}][url]`" v-bind:value='link.url'>
        <input type='hidden' v-bind:name="`diary[links_attributes][${link.id}][title]`" v-bind:value='link.title'>
        {{ link.title }}
      </div>
      <div class='control'>
        <p>URL</p>
        <input type='text' class='input is-small' v-model='url'>
        <p>タイトル</p>
        <input type='text' class='input is-small' v-model='title'>
        <input type='button' @click='addLink()' value='追加' class='button'>
      </div>
    </div>
    <div class='field'>
      <div class='control'>
        <label class='checkbox'>
          <input type='checkbox' name='diary[published]'>
          公開する
        </label>
      </div>
    </div>
    <div class='field is-grouped'>
      <div class='control'>
        <button class='button'>保存</button>
      </div>
      <div class='control'>
        <button class='button is-light' type='button' onclick='history.back()'>キャンセル</button>
      </div>
    </div>
  </form>
</template>

<script>
export default {
  props: {
    game: { type: Object, required: true },
    diariesPath: { type: String, required: true }
  },
  data() {
    return {
      url: '',
      title: '',
      key: 0,
      links: [],
      comment: '',
      published: false,
    }
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    addLink() {
      if (!(this.url === '') && !(this.title === '')) {
        const id = new Date().getTime()
        this.links.push({id: id, key: this.key, url: this.url, title: this.title})
        this.key ++
        this.url = ''
        this.title = ''
      }
    },
  },
}
</script>

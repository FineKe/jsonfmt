<template>
  <div id="app">
    <h1>JSON Formatter</h1>
    <div class="container" ref="container">
      <div class="left-panel" ref="leftPanel">
        <h2>Raw JSON</h2>
        <textarea v-model="rawJson" placeholder="Paste your JSON here..."></textarea>
      </div>
      <div class="right-panel" ref="rightPanel">
        <h2>Formatted JSON</h2>
        <div class="json-viewer">
          <vue-json-viewer
              v-if="parsedJson"
              :value="parsedJson"
              :expand-depth="999"
              :copyable="true"
              :show-double-quotes="false"
              :show-array-index="true"
              :show-line="true"
              :sort="false"
              :preview-mode="true"
              :highlight-mouseover-node="true"
          />
          <div v-else class="error">Invalid JSON</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import VueJsonViewer from 'vue-json-viewer';
import 'vue-json-viewer/style.css'
import Split from 'split.js';

export default {
  name: 'App',
  components: {
    VueJsonViewer
  },
  data() {
    return {
      rawJson: '',
      parsedJson: null,
      expanded: false
    };
  },
  watch: {
    rawJson(newValue) {
      try {
        this.parsedJson = JSON.parse(newValue);
      } catch (e) {
        this.parsedJson = null;
      }
    }
  },
  mounted() {
    // 初始化 Split.js
    Split([this.$refs.leftPanel, this.$refs.rightPanel],{
      direction: 'horizontal', // 水平分割
      sizes: [30, 70], // 初始比例
      minSize: [15, 100], // 最小宽度
      gutterSize: 8, // 分割条宽度
      snapOffset: 0,
      gutterAlign: 'end',
      dragInterval: 7,
      cursor: 'col-resize' // 鼠标样式
    });
  },
};
</script>

<style>
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 20px;
  height: 100vh;
  box-sizing: border-box;
}
h1 {
  text-align: center;
  margin-bottom: 20px;
}
.controls {
  text-align: center;
  margin-bottom: 20px;
}
button {
  padding: 8px 16px;
  font-size: 14px;
  cursor: pointer;
  border: 1px solid #ccc;
  border-radius: 4px;
  background-color: #f9f9f9;
}
button:hover {
  background-color: #eee;
}
.container {
  display: flex;
  height: calc(100vh - 160px);
  gap: 0;
}
.left-panel, .right-panel {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}
h2 {
  margin-bottom: 10px;
}
textarea {
  width: 100%;
  flex: 1;
  font-family: monospace;
  padding: 10px;
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: none;
}
.json-viewer {
  flex: 1;
  border: 1px solid #ccc;
  border-radius: 4px;
  padding: 10px;
  overflow: auto;
  background-color: #f9f9f9;
}
.error {
  color: red;
  font-weight: bold;
}
.splitter {
  width: 8px;
  background-color: #eee;
  cursor: col-resize;
}

.split {
  display: flex;
  flex-direction: row;
}

.gutter {
  background-color: #eee;
  background-repeat: no-repeat;
  background-position: 50%;
}

.gutter.gutter-horizontal {
  background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAeCAYAAADkftS9AAAAIklEQVQoU2M4c+bMfxAGAgYYmwGrIIiDjrELjpo5aiZeMwF+yNnOs5KSvgAAAABJRU5ErkJggg==');
  cursor: col-resize;
}
</style>

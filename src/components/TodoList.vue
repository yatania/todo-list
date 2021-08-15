<template>
  <div class="app container is-max-desktop">
    <h1 class="title has-text-centered has-text-primary
    is-uppercase">Todolist</h1>

    <button v-if="!isInputVisible" @click="showInput" class="button is-primary mr-4">Write new task</button>

    <div v-else class="field">
      <label class="label">{{ todosTitle }}</label>
      <div class="control">
        <input
          class="input"
          type="text"
          :placeholder="placeholderInput"
          v-model="inputValue"
          @keypress.enter="addNewNote"
        >
      </div>
      <div class="control pt-4">
        <button @click="addNewNote" class="button is-link">Add</button>
      </div>
      <button @click="showInput" class="button is-warning mt-3">Go to main screen</button>
    </div>

    <button v-if="!isListVisible" @click="showList" class="button is-primary">See all my todos</button>

    <div v-else class="container mt-5">
    <button @click="showList" class="button is-light mb-5">Hide list of todos</button>
      <ul class="container" v-if="listOfTodos.length !== 0">
        <li 
          class="card p-4 is-flex is-justify-content-space-between
          is-align-items-center has-background-warning-light mb-2"
          v-for="(myNote, index) in listOfTodos"
          :key="myNote.id"
        >
          <span :class="{
              'has-text-success': myNote.completed,
              'has-text-weight-semibold' : !myNote.completed,
            }"
          >
            #{{ index + 1}} {{ toUpperCase(myNote.title) }}
          </span>
          <button v-if="myNote.completed" class="button is-danger" @click="deleteNote(index)">Delete</button>
          <button v-else class="button is-success" @click="completeNote(index)">Complete</button>
        </li>
      </ul>
      <div class="title is-3" v-else>
        Nothing todo :)
      </div>
      <p>all todos: {{ listOfTodos.length }}</p>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'TodoList',

    async mounted() {
      const response = await fetch('https://jsonplaceholder.typicode.com/todos');
      const todos = await response.json();
      this.listOfTodos = todos;
    },

    data() {
      return {
        todosTitle: 'New task:',
        placeholderInput: 'Text input',
        inputValue: '',
        listOfTodos: [],
        isInputVisible: false,
        isListVisible: false,
      }
    },

    methods: {
      addNewNote() {
        if (this.inputValue !== '') {
          this.listOfTodos.push({
            id: Math.random(), title: this.inputValue, completed: false
          });
          this.inputValue = '';
        }
      },

      toUpperCase(item) {
        return item.toUpperCase();
      },

      deleteNote(index) {
        this.listOfTodos.splice(index, 1);
      },

      completeNote(index) {
        this.listOfTodos[index].completed = !this.listOfTodos[index].completed;
      },

      showInput() {
        this.isInputVisible = !this.isInputVisible;
      },

      showList() {
        this.isListVisible = !this.isListVisible;
      }
    }
  }
</script>


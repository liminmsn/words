<template>
	<view class="content">
		{{data}}
		<button @click="getData()">test</button>
	</view>
</template>

<script setup lang="ts">
	import { ref } from 'vue';
	const title = ref("hello world");
	const data = ref();
	async function getData() {
		data.value = await fetch('https://fc-mp-00fbb6fa-0b8f-41d8-ac0c-122a477de70e.next.bspapp.com/test',{
			method:'get',
			headers:{
				'id':"19239421jfdslkjl213jfioj2jif"
			}
		});
		console.log(data.value);	
	}
</script>

<style>
	.content {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}
</style>
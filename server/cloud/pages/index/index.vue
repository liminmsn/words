<template>
	<view class="content">
		<view class="li li_hear">
			<view class="li_item li_key">密钥key</view>
			<view class="li_item">密钥类型</view>
			<view class="li_item">创建时间</view>
			<view class="li_item">使用用户</view>
			<view class="li_item">激活状态</view>
		</view>
		<unicloud-db class="body" collection="sys_keys" v-slot:default="{data, loading, error, options}">
			<scroll-view scroll-y class="scview">
				<view v-for="item in data" class="li">
					<view class="li">
						<view class="li_item li_key">
							{{item.key}}
						</view>
						<view class="li_item">
							{{item.keyType}}
						</view>
						<view class="li_item">
							{{fromDate(item.createTime)}}
						</view>
						<view class="li_item">
							{{item.usrid??'无'}}
						</view>
						<view class="li_item">
							<checkbox style="transform: scale(0.6);" :value="item.active" />
						</view>
					</view>
				</view>
			</scroll-view>
		</unicloud-db>
		<!-- <button @click="getData()">test</button> -->
	</view>
</template>

<script setup lang="ts">
	import { ref } from 'vue';
	function fromDate(time : number) {
		const time_0 = new Date(time).toLocaleDateString();
		const time_1 = new Date(time).toLocaleTimeString();
		return time_0.concat(" ").concat(time_1);
	}
	const data = ref();
	async function getData() {
		data.value = await fetch('https://fc-mp-00fbb6fa-0b8f-41d8-ac0c-122a477de70e.next.bspapp.com/words/createkey', {
			method: 'post',
			headers: {
				'id': "19239421jfdslkjl213jfioj2jif"
			},
			body: new FormData()
		});
		console.log(data.value);
	}
</script>

<style lang="scss">
	.content {
		// box-sizing: border-box;
		// padding: 10px;
		.li_hear {
			// position: fixed;
			// top: 0;
			// z-index: 2;
			background-color: rebeccapurple;
			color: white;
			box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.5);
		}

		.li {
			flex: 1;
			font-size: 10pt;
			display: grid;
			grid-template-columns: 30vw 10vw 30vw 20vw 10vw;
			text-align: center;
			line-height: 3;

			.li_key {}

			.li_item {
				padding: 2pt;
				border: 0.1pt solid rebeccapurple;
				overflow: hidden;
			}

			// background-color: red;
		}
	}
</style>
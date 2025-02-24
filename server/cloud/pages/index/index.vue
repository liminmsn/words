<template>
	<view class="content">
		<view class="li li_hear">
			<view class="li_item">序号</view>
			<view class="li_item li_key">密钥key</view>
			<view class="li_item">密钥类型</view>
			<view class="li_item">激活状态</view>
		</view>
		<unicloud-db ref="udb" class="body" collection="sys_keys" :page-size="10" :page-current="current"
			v-slot:default="{data, loading, error, pagination}">
			<scroll-view scroll-y class="scview">
				<view v-if="error">{{error.message}}</view>
				<view v-else-if="loading">正在加载...</view>
				<view v-for="(item,idx) in data" class="li" v-else>
					<view class="li_item">
						{{idx+1}}
					</view>
					<view class="li_item li_key">
						{{item.key}}
					</view>
					<view class="li_item">
						{{formType(item.keyType)}}
					</view>
					<view class="li_item">
						<checkbox style="transform: scale(0.6);" :value="item.active" />
					</view>
				</view>
			</scroll-view>
			<view class="page">
				<label @click="current > 1 && toggleCureent(-1)">&lt;</label>
				<label>{{pagination['current']}} <span style="font-size: 10pt;">/</span>
					{{pagination['count']+1}}</label>
				<label @click="current < pagination['count']+1 && toggleCureent(+1)">&gt;</label>
			</view>
			<view class="createKey">
				<view class="createKey_btn" @click="show_cre = true">
					创建密钥
				</view>
				<view class="createkey_body" v-if="show_cre">
					<view class="createkey_body_content">
						<view style="margin-bottom: 2vw;">会员key</view>
						<radio-group style="margin-block: 5vw;">
							<radio v-for="(item,index) in items" :value="item.value" :checked="index === current_"
								@click="current_ = index">
								{{item.name}}
								&nbsp;&nbsp;&nbsp;
							</radio>
						</radio-group>
						<view v-if="show_cre_btn" class="createkey_body_content_btns"
							style="margin-bottom: 2vw;text-align: right;">
							<label @click="show_cre = false,toggleCureent(0)">关闭</label>
							<label @click="createKey">创建</label>
						</view>
						<view v-else>
							创建中...
						</view>
						<view v-if="show_key" style="margin-top: 5vw;" @click="copyText">
							{{key}}
						</view>
					</view>
				</view>
			</view>
		</unicloud-db>
	</view>
</template>

<script setup lang="ts">
	import { ref } from 'vue';
	const udb = ref();
	const current = ref(1);
	//切换分页
	function toggleCureent(val : 0 | 1 | -1) {
		current.value += val;
		udb.value['clear']();
	}
	//格式化订阅类型
	function formType(val : number) {
		switch (val) {
			case 0: return '3day';
			case 1: return '7day';
			case 2: return '30day';
		}
	}
	//创建key
	const items = [
		{
			value: '0',
			name: '3天',
			checked: 'true'
		},
		{
			value: '1',
			name: '7天',
		},
		{
			value: '2',
			name: '30天',
		},
	];
	const current_ = ref(0);
	const show_cre = ref(false);
	const show_cre_btn = ref(true);
	const show_key = ref(false);
	const key = ref("");
	async function createKey() {
		show_cre_btn.value = false;
		show_key.value = false;
		const form = new FormData();
		form.set('keyType', items[current_.value].value);
		let data = await fetch('https://fc-mp-00fbb6fa-0b8f-41d8-ac0c-122a477de70e.next.bspapp.com/words/createkey', {
			method: 'post',
			headers: {
				'id': "1234"
			},
			body: form,
		});
		data = await data.json();
		show_key.value = true;
		key.value = data['key'];
		show_cre_btn.value = true;
	}

	function copyText() {
		uni.setClipboardData({
			data: key.value,
			success: function () {
				uni.showToast({
					title: '复制成功',
					icon: 'none'
				});
			}
		});
	}
</script>

<style lang="scss">
	.content {

		.li_hear {
			// position: fixed;
			// top: 0;
			// z-index: 2;
			text-align: left !important;
			background-color: rebeccapurple;
			color: white;
			box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.5);
		}

		.li {
			flex: 1;
			font-size: 10pt;
			display: grid;
			grid-template-columns: 10vw 50vw 20vw 20vw;

			.li_key {}

			.li_item {
				padding: 2pt;
				border: 0.1pt solid $uni-border-color;
				border-top: none;
				border-right: none;
				overflow: hidden;
			}

			// background-color: red;
		}

		.page {
			box-sizing: border-box;
			padding: 10px;
			text-align: center;

			label {
				border: 0.1px solid $uni-border-color;
				padding: 2px 10px;

				&:nth-child(2) {
					padding-inline: 10px;
					margin-inline: 10px;
				}
			}
		}

		.createKey {
			text-align: center;

			.createKey_btn {
				width: 20%;
				border: 0.1px solid $uni-border-color;
			}

			.createkey_body {
				position: absolute;
				top: 0;
				left: 0;
				right: 0;
				bottom: 0;
				background-color: rgba(0, 0, 0, 0.5);

				.createkey_body_content {
					margin: auto;
					margin-top: 20vh;
					width: 80vw;
					background-color: white;
					border-radius: 5vw;
					box-sizing: border-box;
					padding: 5vw;

					.createkey_body_content_btns {
						label {
							padding: 2vw;
							color: white;
							background-color: $uni-color-warning;
							margin-right: 2vw;
							border-radius: 2vw;

							&:nth-child(2) {
								background-color: $uni-color-primary;
							}
						}
					}
				}
			}
		}
	}
</style>
<template>
	<view class="content">
		<view class="li li_hear">
			<view class="li_item">序号</view>
			<view class="li_item li_key">密钥key(点击复制)</view>
			<view class="li_item">密钥类型</view>
			<view class="li_item">激活状态</view>
		</view>
		<unicloud-db ref="udb" class="body" collection="sys_keys" orderby="createTime desc" :page-size="10" getcount
			:page-current="current" v-slot:default="{data,pagination,loading,error,options}">
			<scroll-view scroll-y class="scview">
				<view v-if="error">{{error.message}}</view>
				<view v-else-if="loading" style="text-align: center;margin-top: 10px;">正在加载...</view>
				<view v-else>
					<view v-if="data.length == 0" style="text-align: center;margin-top: 10px;">无数据</view>
					<view v-else v-for="(item,idx) in data" class="li">
						<view class="li_item">
							{{idx+1}}
						</view>
						<view class="li_item li_key" @click="()=>item.active ? '':copyText()">
							{{item.key}}
						</view>
						<view class="li_item">
							{{item.keyType}}天
						</view>
						<view class="li_item">
							<checkbox style="transform: scale(0.6);" color="#4cd964" :checked="item.active" />
						</view>
					</view>
					<view class="page" v-show="data.length>0">
						<label @click="current > 1 && toggleCureent(-1)">&lt;</label>
						<label>
							{{pagination['current']}}
							<span style="font-size: 10pt;">/</span>
							{{Math.ceil((pagination['count'] / 10))}}
						</label>
						<label @click="pagination['current'] < Math.ceil((pagination['count'] / 10)) &&toggleCureent(+1)">&gt;</label>
					</view>
				</view>
			</scroll-view>
			<view class="createKey" style="display: flex;gap: 2vw;">
				<view class="" style="width: 100%;display: flex;justify-content: center;gap: 2vw;">
					<view class="createKey_btn" @click="show_cre = true">
						创建密钥
					</view>
					<view class="createKey_btn" @click="toggleCureent(0)">
						刷新
					</view>
				</view>
				<view class="createkey_body" v-if="show_cre">
					<view class="createkey_body_content">
						<view style="margin-bottom: 2vw;">会员key</view>
						<radio-group style="margin-block: 2vw;">
							<radio v-for="(item,index) in items" :key="index" :value="item.value.toString()"
								:checked="index === current_" @click="current_ = index,keyType = item.value">
								{{item.name}}
								&nbsp;&nbsp;&nbsp;
							</radio>
						</radio-group>
						<view class="ipt">
							<!-- <text>天</text> -->
							<input maxlength="2" v-model="keyType" />
						</view>
						<view v-if="show_cre_btn" class="createkey_body_content_btns" style="text-align: center;">
							<label @click="createKey">创建</label>
							<label @click="show_cre = false">关闭</label>
						</view>
						<view v-else>
							创建中...
						</view>
						<view v-if="show_key" style="margin-top: 10px;" @click="copyText">
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
	const ipt_val = ref("MTc0MDM4NTI1MTEwOQ==");
	async function active() {
		const res = await uni.request({
			method: 'GET',
			url: 'https://fc-mp-00fbb6fa-0b8f-41d8-ac0c-122a477de70e.next.bspapp.com/words/isactive',
			data: {
				"key": ipt_val.value
			},
			header: {
				'deviceId': "1234"
			}
		}).then();
		console.log(res);
	}

	const udb = ref();
	const current = ref(1);
	//切换分页
	function toggleCureent(val : 0 | 1 | -1) {
		if (val == 0) {
			current.value = 1;
			udb.value['clear']();
			setTimeout(() => udb.value['loadData'](), 100);
			return;
		}
		current.value += val;
		udb.value['clear']();
		setTimeout(() => udb.value['loadData'](), 100);
	}
	//创建key
	const items = [
		{
			value: 1,
			name: '1天',
			checked: 'true'
		},
		{
			value: 3,
			name: '3天',
		},
		{
			value: 7,
			name: '7天',
		},
	];
	const current_ = ref(0);
	const show_cre = ref(false);
	const show_cre_btn = ref(true);
	const show_key = ref(false);
	const key = ref("");
	const keyType = ref(1);
	async function createKey() {
		show_cre_btn.value = false;
		show_key.value = false;
		const res = await uni.request({
			method: 'POST',
			url: 'https://fc-mp-00fbb6fa-0b8f-41d8-ac0c-122a477de70e.next.bspapp.com/words/createkey',
			data: {
				'keyType': keyType.value
			},
			header: {
				'id': "1234"
			}
		}).then();
		if (res.statusCode == 200) {
			toggleCureent(0);
			key.value = res.data['key'];
			show_key.value = true;
			show_cre_btn.value = true;
		}
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
			background-color: $uni-color-success;
			color: white;
			// box-shadow: 0 0 2px 2px rgba(0, 0, 0, 0.5);
		}

		.li {
			flex: 1;
			font-size: 10pt;
			display: grid;
			grid-template-columns: 10vw 50vw 20vw 20vw;

			&:nth-child(even) {
				background-color: $uni-bg-color-hover;
			}

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
			margin-top: 10px;
			text-align: center;

			.createKey_btn {
				padding: 5px;
				width: 20%;
				border: 0.1px solid $uni-border-color;
				background-color: $uni-bg-color-hover;
				transition: 25ms ease all;

				&:active {
					transform: scale(0.99);
				}
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
					width: 300px;
					background-color: white;
					border-radius: 5vw;
					box-sizing: border-box;
					padding: 5vw;
					display: flex;
					flex-direction: column;

					.ipt {
						// height: 30px;
						margin-bottom: 20px;
						display: flex;
						justify-content: center;

						input {
							height: 30px;
							flex: 0.3;
							box-sizing: border-box;
							border: 0.1px solid $uni-border-color;
							position: relative;

							&::before {
								height: 100%;
								position: absolute;
								right: 10%;
								opacity: 0.2;
								// background-color: red;
								content: '天';
								line-height: 1.8;
							}
						}
					}

					.createkey_body_content_btns {
						height: 30px;
						// display: flex;
						// justify-content: center;

						label {
							display: inline-block;
							line-height: 2;
							height: 100%;
							// padding: 2vw;
							padding: 0 10px;
							// color: white;
							// background-color: $uni-color-warning;
							margin-right: 2vw;
							border: 0.1px solid $uni-border-color;
							background-color: $uni-bg-color-hover;

							// &:nth-child(2) {
							// 	background-color: $uni-color-primary;
							// }
						}
					}
				}
			}
		}
	}
</style>
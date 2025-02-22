'use strict';
exports.main = async (event, context) => {
	//event为客户端上传的参数
	console.log('event : ', event)

	const res = class {
		code = 0;
		data = {};
		constructor(data) {
			
		}
	}

	const db = uniCloud.database();
	switch (event['httpMethod']) {
		case 'GET':
			break;
		case 'POST':
			switch (event['path']) {
				case '/createkey':
					const time = Date.now();
					const res = await db.collection("sys_keys").add({
						key: btoa(time),
						createTime: time,
					});
					return res;
					break;
			}
			break;
	}
	//返回数据给客户端
	return {
		event,
		context
	}
};
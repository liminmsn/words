'use strict';
exports.main = async (event, context) => {
	//event为客户端上传的参数
	console.log('event : ', event)

	const db = uniCloud.database();
	switch (event['httpMethod']) {
		case 'GET':
			break;
		case 'POST':
			switch (event['path']) {
				case '/createkey':
					const time = Date.now();
					const data = {
						keyType: event.queryStringParameters['keyType'],
						key: btoa(time),
						createTime: time,
					};
					const res = await db.collection("sys_keys").add(data);
					return data;
					break;
				case '/get_all':
					const list = db.collection('sys_keys').get();
					return list;
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
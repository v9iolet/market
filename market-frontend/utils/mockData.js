export const orderDemoData = [
  {
    orderId: 'ORD20260614001',
    status: '待发货',
    productInfo: {
      image: '/static/images/demo1.png',
      name: 'Sony PlayStation 5 光驱版 国行',
      price: '3899.00'
    },
    latestLogistics: {
      time: '2026-06-14 10:00',
      statusText: '卖家已发货，等待快递揽收',
      location: '北京市海淀区'
    }
  },
  {
    orderId: 'ORD20260614002',
    status: '待付款',
    productInfo: {
      image: '/static/images/demo2.png',
      name: 'Apple AirPods Pro (第二代)',
      price: '1899.00'
    },
    latestLogistics: null // 待付款无物流
  },
  {
    orderId: 'ORD20260614003',
    status: '待收货',
    productInfo: {
      image: '/static/images/demo3.png',
      name: 'Nintendo Switch OLED 日版',
      price: '2199.00'
    },
    latestLogistics: {
      time: '2026-06-14 12:30',
      statusText: '【深圳市】快件已到达 南山区南头营业部，准备派送',
      location: '深圳市'
    }
  },
  {
    orderId: 'ORD20260614004',
    status: '退款中',
    productInfo: {
      image: '/static/images/demo4.png',
      name: 'Logitech G Pro X Superlight 狗屁王二代',
      price: '799.00'
    },
    latestLogistics: {
      time: '2026-06-13 18:45',
      statusText: '商家已同意退款，请填写退货物流单号',
      location: '售后处理'
    }
  }
];

export const transactionNoticesDemoData = [
  {
    id: 't1',
    orderId: 'ORD20260614002',
    statusTitle: '待付款',
    time: '2026-06-14 10:30',
    productImg: '/static/images/demo2.png',
    productName: 'Apple AirPods Pro (第二代)',
    desc: '您的订单尚未付款，请尽快完成支付，以免订单取消。'
  },
  {
    id: 't2',
    orderId: 'ORD20260614001',
    statusTitle: '待发货',
    time: '2026-06-14 09:15',
    productImg: '/static/images/demo1.png',
    productName: 'Sony PlayStation 5 光驱版 国行',
    desc: '买家已付款，等待卖家发货。'
  },
  {
    id: 't3',
    orderId: 'ORD20260614003',
    statusTitle: '待收货',
    time: '2026-06-13 14:20',
    productImg: '/static/images/demo3.png',
    productName: 'Nintendo Switch OLED 日版',
    desc: '卖家已发货，包裹正在路上，请耐心等待。'
  },
  {
    id: 't4',
    orderId: 'ORD20260614004',
    statusTitle: '退款中',
    time: '2026-06-13 18:45',
    productImg: '/static/images/demo4.png',
    productName: 'Logitech G Pro X Superlight 狗屁王二代',
    desc: '您的退款申请正在处理中，商家已同意退款。'
  }
];

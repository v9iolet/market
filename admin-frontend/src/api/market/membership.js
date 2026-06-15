import request from '@/utils/request'

// 模拟接口 (由于后端暂未开发，此处返回Mock数据)
// 实际开发完成后请替换为真实接口

// 获取会员等级列表
export function listMembership(query) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        code: 200,
        rows: [
          { id: 1, levelName: '普通会员', pointThreshold: 0, discountRate: 1.00 },
          { id: 2, levelName: '白银会员', pointThreshold: 500, discountRate: 0.98 },
          { id: 3, levelName: '黄金会员', pointThreshold: 2000, discountRate: 0.95 },
          { id: 4, levelName: '钻石会员', pointThreshold: 5000, discountRate: 0.90 }
        ],
        total: 4
      })
    }, 300)
  })
}

// 查询会员等级详细
export function getMembership(id) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        code: 200,
        data: { id: id, levelName: '测试会员', pointThreshold: 1000, discountRate: 0.95 }
      })
    }, 300)
  })
}

// 新增会员等级
export function addMembership(data) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({ code: 200, msg: "操作成功" })
    }, 300)
  })
}

// 修改会员等级
export function updateMembership(data) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({ code: 200, msg: "操作成功" })
    }, 300)
  })
}

// 删除会员等级
export function delMembership(id) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({ code: 200, msg: "操作成功" })
    }, 300)
  })
}

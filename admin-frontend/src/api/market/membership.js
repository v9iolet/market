import request from '@/utils/request'

// 模拟接口 (由于后端暂未开发，此处返回Mock数据)
// 实际开发完成后请替换为真实接口

// 查询会员等级配置列表
export function listMembership(query) {
  return request({
    url: '/system/membership/list',
    method: 'get',
    params: query
  })
}

// 查询会员等级配置详细
export function getMembership(id) {
  return request({
    url: '/system/membership/' + id,
    method: 'get'
  })
}

// 新增会员等级配置
export function addMembership(data) {
  return request({
    url: '/system/membership',
    method: 'post',
    data: data
  })
}

// 修改会员等级配置
export function updateMembership(data) {
  return request({
    url: '/system/membership',
    method: 'put',
    data: data
  })
}

// 删除会员等级配置
export function delMembership(id) {
  return request({
    url: '/system/membership/' + id,
    method: 'delete'
  })
}

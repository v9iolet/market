package com.ruoyi.system.service;

import java.math.BigDecimal;

/**
 * 市场订单测试Service接口
 */
public interface IMktOrderService {
    
    /**
     * 订单完成，增加积分并重估等级
     * 
     * @param userId 用户ID
     * @param orderAmount 订单支付金额
     */
    public void completeOrder(Long userId, BigDecimal orderAmount);

    /**
     * 订单退款，扣除积分并重估等级（可能降级）
     * 
     * @param userId 用户ID
     * @param refundAmount 退款金额
     */
    public void refundOrder(Long userId, BigDecimal refundAmount);

    /**
     * 获取用户创建订单时的最终应付折扣和金额
     * 
     * @param userId 用户ID
     * @param originalAmount 原价
     * @return 折后价
     */
    public BigDecimal calculateDiscountedAmount(Long userId, BigDecimal originalAmount);
}

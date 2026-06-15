package com.ruoyi.system.service.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ruoyi.system.domain.MktMembershipLevel;
import com.ruoyi.system.mapper.MktUserMapper;
import com.ruoyi.system.service.IMktMembershipLevelService;
import com.ruoyi.system.service.IMktOrderService;

@Service
public class MktOrderServiceImpl implements IMktOrderService {

    @Autowired
    private MktUserMapper mktUserMapper;

    @Autowired
    private IMktMembershipLevelService membershipLevelService;

    @Override
    @Transactional
    public void completeOrder(Long userId, BigDecimal orderAmount) {
        if (orderAmount == null || orderAmount.compareTo(BigDecimal.ZERO) <= 0) {
            return;
        }
        
        // 计算获得积分：每10元1积分 (向下取整)
        int earnedPoints = orderAmount.divide(new BigDecimal("10"), 0, RoundingMode.DOWN).intValue();
        if (earnedPoints > 0) {
            Integer currentPoints = mktUserMapper.getUserPoints(userId);
            if (currentPoints == null) currentPoints = 0;
            
            // 更新积分 (暂时不带LevelID)
            mktUserMapper.updateUserPointsAndLevel(userId, currentPoints + earnedPoints, null);
            
            // 重新评估等级
            membershipLevelService.recalculateUserLevel(userId);
        }
    }

    @Override
    @Transactional
    public void refundOrder(Long userId, BigDecimal refundAmount) {
        if (refundAmount == null || refundAmount.compareTo(BigDecimal.ZERO) <= 0) {
            return;
        }

        // 计算扣除积分
        int deductedPoints = refundAmount.divide(new BigDecimal("10"), 0, RoundingMode.DOWN).intValue();
        if (deductedPoints > 0) {
            Integer currentPoints = mktUserMapper.getUserPoints(userId);
            if (currentPoints == null) currentPoints = 0;

            int newPoints = Math.max(0, currentPoints - deductedPoints);
            
            // 更新积分
            mktUserMapper.updateUserPointsAndLevel(userId, newPoints, null);
            
            // 重新评估等级 (可能降级)
            membershipLevelService.recalculateUserLevel(userId);
        }
    }

    @Override
    public BigDecimal calculateDiscountedAmount(Long userId, BigDecimal originalAmount) {
        if (originalAmount == null || originalAmount.compareTo(BigDecimal.ZERO) <= 0) {
            return originalAmount;
        }

        Long levelId = mktUserMapper.getUserMembershipLevelId(userId);
        if (levelId != null) {
            MktMembershipLevel level = membershipLevelService.selectMktMembershipLevelById(levelId);
            if (level != null && level.getDiscountRate() != null) {
                return originalAmount.multiply(level.getDiscountRate()).setScale(2, RoundingMode.HALF_UP);
            }
        }
        
        return originalAmount;
    }
}

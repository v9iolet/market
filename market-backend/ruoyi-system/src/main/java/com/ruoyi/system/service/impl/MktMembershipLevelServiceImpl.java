package com.ruoyi.system.service.impl;

import java.util.List;
import com.ruoyi.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.MktMembershipLevelMapper;
import com.ruoyi.system.mapper.MktUserMapper;
import com.ruoyi.system.domain.MktMembershipLevel;
import com.ruoyi.system.service.IMktMembershipLevelService;

/**
 * 会员等级配置Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-06-15
 */
@Service
public class MktMembershipLevelServiceImpl implements IMktMembershipLevelService 
{
    @Autowired
    private MktMembershipLevelMapper mktMembershipLevelMapper;
    
    @Autowired
    private MktUserMapper mktUserMapper;

    /**
     * 查询会员等级配置
     * 
     * @param id 会员等级配置主键
     * @return 会员等级配置
     */
    @Override
    public MktMembershipLevel selectMktMembershipLevelById(Long id)
    {
        return mktMembershipLevelMapper.selectMktMembershipLevelById(id);
    }

    /**
     * 查询会员等级配置列表
     * 
     * @param mktMembershipLevel 会员等级配置
     * @return 会员等级配置
     */
    @Override
    public List<MktMembershipLevel> selectMktMembershipLevelList(MktMembershipLevel mktMembershipLevel)
    {
        return mktMembershipLevelMapper.selectMktMembershipLevelList(mktMembershipLevel);
    }

    /**
     * 新增会员等级配置
     * 
     * @param mktMembershipLevel 会员等级配置
     * @return 结果
     */
    @Override
    public int insertMktMembershipLevel(MktMembershipLevel mktMembershipLevel)
    {
        mktMembershipLevel.setCreateTime(DateUtils.getNowDate());
        return mktMembershipLevelMapper.insertMktMembershipLevel(mktMembershipLevel);
    }

    /**
     * 修改会员等级配置
     * 
     * @param mktMembershipLevel 会员等级配置
     * @return 结果
     */
    @Override
    public int updateMktMembershipLevel(MktMembershipLevel mktMembershipLevel)
    {
        mktMembershipLevel.setUpdateTime(DateUtils.getNowDate());
        return mktMembershipLevelMapper.updateMktMembershipLevel(mktMembershipLevel);
    }

    /**
     * 批量删除会员等级配置
     * 
     * @param ids 需要删除的会员等级配置主键
     * @return 结果
     */
    @Override
    public int deleteMktMembershipLevelByIds(Long[] ids)
    {
        return mktMembershipLevelMapper.deleteMktMembershipLevelByIds(ids);
    }

    /**
     * 删除会员等级配置信息
     * 
     * @param id 会员等级配置主键
     * @return 结果
     */
    @Override
    public int deleteMktMembershipLevelById(Long id)
    {
        return mktMembershipLevelMapper.deleteMktMembershipLevelById(id);
    }
    
    /**
     * 根据用户积分重新评估会员等级
     * 
     * @param userId 用户ID
     * @return 评估后的会员等级ID
     */
    @Override
    public Long recalculateUserLevel(Long userId) {
        Integer points = mktUserMapper.getUserPoints(userId);
        if (points == null) {
            return null;
        }
        
        List<MktMembershipLevel> levels = mktMembershipLevelMapper.selectMktMembershipLevelList(new MktMembershipLevel());
        Long targetLevelId = null;
        
        // levels is ordered by point_threshold ASC from mapper
        for (MktMembershipLevel level : levels) {
            if (points >= level.getPointThreshold()) {
                targetLevelId = level.getId();
            } else {
                break;
            }
        }
        
        mktUserMapper.updateUserPointsAndLevel(userId, points, targetLevelId);
        return targetLevelId;
    }
}

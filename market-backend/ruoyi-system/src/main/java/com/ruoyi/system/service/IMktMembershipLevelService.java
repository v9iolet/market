package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.MktMembershipLevel;

/**
 * 会员等级配置Service接口
 * 
 * @author ruoyi
 * @date 2026-06-15
 */
public interface IMktMembershipLevelService 
{
    /**
     * 查询会员等级配置
     * 
     * @param id 会员等级配置主键
     * @return 会员等级配置
     */
    public MktMembershipLevel selectMktMembershipLevelById(Long id);

    /**
     * 查询会员等级配置列表
     * 
     * @param mktMembershipLevel 会员等级配置
     * @return 会员等级配置集合
     */
    public List<MktMembershipLevel> selectMktMembershipLevelList(MktMembershipLevel mktMembershipLevel);

    /**
     * 新增会员等级配置
     * 
     * @param mktMembershipLevel 会员等级配置
     * @return 结果
     */
    public int insertMktMembershipLevel(MktMembershipLevel mktMembershipLevel);

    /**
     * 修改会员等级配置
     * 
     * @param mktMembershipLevel 会员等级配置
     * @return 结果
     */
    public int updateMktMembershipLevel(MktMembershipLevel mktMembershipLevel);

    /**
     * 批量删除会员等级配置
     * 
     * @param ids 需要删除的会员等级配置主键集合
     * @return 结果
     */
    public int deleteMktMembershipLevelByIds(Long[] ids);

    /**
     * 删除会员等级配置信息
     * 
     * @param id 会员等级配置主键
     * @return 结果
     */
    public int deleteMktMembershipLevelById(Long id);
    
    /**
     * 根据用户积分重新评估会员等级
     * 
     * @param userId 用户ID
     * @return 评估后的会员等级ID
     */
    public Long recalculateUserLevel(Long userId);
}

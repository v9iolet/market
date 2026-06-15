package com.ruoyi.system.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * 市场用户简单Mapper接口
 */
public interface MktUserMapper 
{
    /**
     * 获取用户当前积分余额
     */
    @Select("select points from mkt_user where id = #{userId}")
    public Integer getUserPoints(Long userId);

    /**
     * 更新用户积分与等级
     */
    @Update("update mkt_user set points = #{points}, membership_level_id = #{levelId} where id = #{userId}")
    public int updateUserPointsAndLevel(@Param("userId") Long userId, @Param("points") Integer points, @Param("levelId") Long levelId);
    
    /**
     * 获取用户当前的会员等级ID
     */
    @Select("select membership_level_id from mkt_user where id = #{userId}")
    public Long getUserMembershipLevelId(Long userId);
}

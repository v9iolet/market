package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

import java.math.BigDecimal;

/**
 * 会员等级配置对象 mkt_membership_level
 * 
 * @author ruoyi
 * @date 2026-06-15
 */
public class MktMembershipLevel extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 主键ID */
    private Long id;

    /** 等级名称 */
    @Excel(name = "等级名称")
    private String levelName;

    /** 所需积分门槛 */
    @Excel(name = "所需积分门槛")
    private Integer pointThreshold;

    /** 折扣率 */
    @Excel(name = "折扣率")
    private BigDecimal discountRate;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setLevelName(String levelName) 
    {
        this.levelName = levelName;
    }

    public String getLevelName() 
    {
        return levelName;
    }
    public void setPointThreshold(Integer pointThreshold) 
    {
        this.pointThreshold = pointThreshold;
    }

    public Integer getPointThreshold() 
    {
        return pointThreshold;
    }
    public void setDiscountRate(BigDecimal discountRate) 
    {
        this.discountRate = discountRate;
    }

    public BigDecimal getDiscountRate() 
    {
        return discountRate;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("levelName", getLevelName())
            .append("pointThreshold", getPointThreshold())
            .append("discountRate", getDiscountRate())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}

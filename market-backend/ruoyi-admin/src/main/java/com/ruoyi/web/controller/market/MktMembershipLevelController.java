package com.ruoyi.web.controller.market;

import java.util.List;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.MktMembershipLevel;
import com.ruoyi.system.service.IMktMembershipLevelService;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 会员等级配置Controller
 * 
 * @author ruoyi
 * @date 2026-06-15
 */
@RestController
@RequestMapping("/system/membership")
public class MktMembershipLevelController extends BaseController
{
    @Autowired
    private IMktMembershipLevelService mktMembershipLevelService;

    /**
     * 查询会员等级配置列表
     */
    @PreAuthorize("@ss.hasPermi('market:membership:list')")
    @GetMapping("/list")
    public TableDataInfo list(MktMembershipLevel mktMembershipLevel)
    {
        startPage();
        List<MktMembershipLevel> list = mktMembershipLevelService.selectMktMembershipLevelList(mktMembershipLevel);
        return getDataTable(list);
    }

    /**
     * 获取会员等级配置详细信息
     */
    @PreAuthorize("@ss.hasPermi('market:membership:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(mktMembershipLevelService.selectMktMembershipLevelById(id));
    }

    /**
     * 新增会员等级配置
     */
    @PreAuthorize("@ss.hasPermi('market:membership:add')")
    @Log(title = "会员等级配置", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody MktMembershipLevel mktMembershipLevel)
    {
        return toAjax(mktMembershipLevelService.insertMktMembershipLevel(mktMembershipLevel));
    }

    /**
     * 修改会员等级配置
     */
    @PreAuthorize("@ss.hasPermi('market:membership:edit')")
    @Log(title = "会员等级配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody MktMembershipLevel mktMembershipLevel)
    {
        return toAjax(mktMembershipLevelService.updateMktMembershipLevel(mktMembershipLevel));
    }

    /**
     * 删除会员等级配置
     */
    @PreAuthorize("@ss.hasPermi('market:membership:remove')")
    @Log(title = "会员等级配置", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(mktMembershipLevelService.deleteMktMembershipLevelByIds(ids));
    }
}

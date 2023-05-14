Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F567701D28
	for <lists+linux-ext4@lfdr.de>; Sun, 14 May 2023 13:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjENL5O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 May 2023 07:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjENL5N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 May 2023 07:57:13 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8083173C;
        Sun, 14 May 2023 04:57:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QK1FY2Fyzz4f41VV;
        Sun, 14 May 2023 19:57:05 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgD3kpaRzGBkeTi2JQ--.6929S2;
        Sun, 14 May 2023 19:57:06 +0800 (CST)
Subject: Re: [PATCH v3 15/19] ext4: call ext4_mb_mark_group_bb in
 ext4_mb_mark_diskspace_used
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
 <20230417110617.2664129-16-shikemeng@huaweicloud.com>
 <ZGCr74q8dfqMgq0t@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <daa4430a-bd26-1b0b-eaf7-928b3af9b601@huaweicloud.com>
Date:   Sun, 14 May 2023 19:57:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ZGCr74q8dfqMgq0t@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgD3kpaRzGBkeTi2JQ--.6929S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr48GrykCFWxWFWUWF45ZFb_yoWxGFWfpr
        9IyF1UCr1fJr1DuFWI9a4qqF10kw48Gw1rJ34xG3WrAFnFkr9xAay8ta48Ca9FkF47A3Z2
        vF15ZFyUCrs7KrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 5/14/2023 5:37 PM, Ojaswin Mujoo wrote:
> On Mon, Apr 17, 2023 at 07:06:13PM +0800, Kemeng Shi wrote:
>> call ext4_mb_mark_group_bb in ext4_mb_mark_diskspace_used to:
>> 1. remove repeat code to normally update bitmap and group descriptor
>> on disk.
>> 2. call ext4_mb_mark_group_bb instead of only setting bits in block bitmap
>> to fix the bitmap. Function ext4_mb_mark_group_bb will also update
>> checksum of bitmap and other counter along with the bit change to keep
>> the cosistent with bit change or block bitmap will be marked corrupted as
>> checksum of bitmap is in inconsistent state.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Looks good, feel free to add:
> 
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> Just a minor suggestion below:
>> ---
>>  fs/ext4/mballoc.c | 90 +++++++++++++----------------------------------
>>  1 file changed, 24 insertions(+), 66 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index c3e620f6eded..bd440614db76 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -3846,9 +3846,12 @@ static noinline_for_stack int
>>  ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>>  				handle_t *handle, unsigned int reserv_clstrs)
>>  {
>> -	struct buffer_head *bitmap_bh = NULL;
>> +	struct ext4_mark_context mc = {
>> +		.handle = handle,
>> +		.sb = ac->ac_sb,
>> +		.state = 1,
>> +	};
>>  	struct ext4_group_desc *gdp;
>> -	struct buffer_head *gdp_bh;
>>  	struct ext4_sb_info *sbi;
>>  	struct super_block *sb;
>>  	ext4_fsblk_t block;
>> @@ -3860,32 +3863,13 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>>  	sb = ac->ac_sb;
>>  	sbi = EXT4_SB(sb);
>>  
>> -	bitmap_bh = ext4_read_block_bitmap(sb, ac->ac_b_ex.fe_group);
>> -	if (IS_ERR(bitmap_bh)) {
>> -		return PTR_ERR(bitmap_bh);
>> -	}
>> -
>> -	BUFFER_TRACE(bitmap_bh, "getting write access");
>> -	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
>> -					    EXT4_JTR_NONE);
>> -	if (err)
>> -		goto out_err;
>> -
>> -	err = -EIO;
>> -	gdp = ext4_get_group_desc(sb, ac->ac_b_ex.fe_group, &gdp_bh);
>> +	gdp = ext4_get_group_desc(sb, ac->ac_b_ex.fe_group, NULL);
>>  	if (!gdp)
>> -		goto out_err;
>> -
>> +		return -EIO;
>>  	ext4_debug("using block group %u(%d)\n", ac->ac_b_ex.fe_group,
>>  			ext4_free_group_clusters(sb, gdp));
>>  
>> -	BUFFER_TRACE(gdp_bh, "get_write_access");
>> -	err = ext4_journal_get_write_access(handle, sb, gdp_bh, EXT4_JTR_NONE);
>> -	if (err)
>> -		goto out_err;
>> -
>>  	block = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
>> -
>>  	len = EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>>  	if (!ext4_inode_block_valid(ac->ac_inode, block, len)) {
>>  		ext4_error(sb, "Allocating blocks %llu-%llu which overlap "
>> @@ -3894,41 +3878,30 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>>  		 * Fix the bitmap and return EFSCORRUPTED
>>  		 * We leak some of the blocks here.
>>  		 */
>> -		ext4_lock_group(sb, ac->ac_b_ex.fe_group);
>> -		mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
>> -			      ac->ac_b_ex.fe_len);
>> -		ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
>> -		err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
>> +		err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
>> +					    ac->ac_b_ex.fe_start,
>> +					    ac->ac_b_ex.fe_len,
>> +					    0);
>>  		if (!err)
>>  			err = -EFSCORRUPTED;
>> -		goto out_err;
>> +		return err;
>>  	}
>>  
>> -	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
>>  #ifdef AGGRESSIVE_CHECK
>> -	{
>> -		int i;
>> -		for (i = 0; i < ac->ac_b_ex.fe_len; i++) {
>> -			BUG_ON(mb_test_bit(ac->ac_b_ex.fe_start + i,
>> -						bitmap_bh->b_data));
>> -		}
>> -	}
>> +	err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
>> +				    ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
>> +				    EXT4_MB_BITMAP_MARKED_CHECK);
>> +#else
>> +	err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
>> +				    ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
>> +				    0);
>>  #endif
> 
> I think, the refactoring the AGGRESSIVE_CHECK as follows makes the
> intent more obvious and easier to read.
> 
> #ifdef AGGRESSIVE_CHECK
> 
> flags |= EXT4_MB_BITMAP_MARKED_CHECK;
> 
> #endif
> 
> err = ext4_mb_mark_group_bb(&mc, ac->ac_b_ex.fe_group,
> 			    ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
> 			    flags);
Although this will add a new flags variable declartion, the AGGRESSIVE_CHECK code
looks much better. Thanks for the suggestion, I will refactoring AGGRESSIVE_CHECK
in this way in this patch and patch 16.

> Regards,
> ojaswin
> 
>> -	mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
>> -		      ac->ac_b_ex.fe_len);
>> -	if (ext4_has_group_desc_csum(sb) &&
>> -	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
>> -		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
>> -		ext4_free_group_clusters_set(sb, gdp,
>> -					     ext4_free_clusters_after_init(sb,
>> -						ac->ac_b_ex.fe_group, gdp));
>> -	}
>> -	len = ext4_free_group_clusters(sb, gdp) - ac->ac_b_ex.fe_len;
>> -	ext4_free_group_clusters_set(sb, gdp, len);
>> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>> -	ext4_group_desc_csum_set(sb, ac->ac_b_ex.fe_group, gdp);
>> +	if (err && mc.changed == 0)
>> +		return err;
>>  
>> -	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
>> +#ifdef AGGRESSIVE_CHECK
>> +	BUG_ON(mc.changed != ac->ac_b_ex.fe_len);
>> +#endif
>>  	percpu_counter_sub(&sbi->s_freeclusters_counter, ac->ac_b_ex.fe_len);
>>  	/*
>>  	 * Now reduce the dirty block count also. Should not go negative
>> @@ -3938,21 +3911,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>>  		percpu_counter_sub(&sbi->s_dirtyclusters_counter,
>>  				   reserv_clstrs);
>>  
>> -	if (sbi->s_log_groups_per_flex) {
>> -		ext4_group_t flex_group = ext4_flex_group(sbi,
>> -							  ac->ac_b_ex.fe_group);
>> -		atomic64_sub(ac->ac_b_ex.fe_len,
>> -			     &sbi_array_rcu_deref(sbi, s_flex_groups,
>> -						  flex_group)->free_clusters);
>> -	}
>> -
>> -	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
>> -	if (err)
>> -		goto out_err;
>> -	err = ext4_handle_dirty_metadata(handle, NULL, gdp_bh);
>> -
>> -out_err:
>> -	brelse(bitmap_bh);
>>  	return err;
>>  }
>>  
>> -- 
>> 2.30.0
>>
> 

-- 
Best wishes
Kemeng Shi


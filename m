Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0156D78EED9
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Aug 2023 15:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbjHaNmt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 09:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346396AbjHaNmc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 09:42:32 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88FCE5A;
        Thu, 31 Aug 2023 06:42:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rc2Qj3jwwz4f3jJM;
        Thu, 31 Aug 2023 21:42:21 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgAHc2e_mPBkMJAMCA--.35476S2;
        Thu, 31 Aug 2023 21:42:25 +0800 (CST)
Subject: Re: [PATCH v6 01/11] ext4: factor out codes to update block bitmap
 and group descriptor on disk from ext4_mb_mark_bb
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87sf7z8k8d.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <f3fb910c-c170-43b9-6cac-41fe0562ad6a@huaweicloud.com>
Date:   Thu, 31 Aug 2023 21:42:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87sf7z8k8d.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgAHc2e_mPBkMJAMCA--.35476S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtryrGw4kCrWDAF1rKryfJFb_yoWfCr43pr
        yDAF1DCF43JFnruF47Z3y2q3WfKw18KF1kGryfGa4YkF9Iyr95ZF4xKFyFkF9IyFsrAFna
        vF1Yyrsrur4FkrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/31/2023 8:33 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
> Hello Kemeng,
> 
>> There are several reasons to add a general function to update block
>> bitmap and group descriptor on disk:
> 
> ... named ext4_mb_mark_context(<params>)
> 
>> 1. pair behavior of alloc/free bits. For example,
>> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
>> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
>> 2. remove repeat code to read from disk, update and write back to disk.
>> 3. reduce future unit test mocks to catch real IO to update structure
>> on disk.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> ---
>>  fs/ext4/mballoc.c | 169 +++++++++++++++++++++++++++-------------------
>>  1 file changed, 99 insertions(+), 70 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index c91db9f57524..e2be572deb75 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -3952,6 +3952,100 @@ void ext4_exit_mballoc(void)
>>  	ext4_groupinfo_destroy_slabs();
>>  }
>>  
>> +/*
>> + * Collect global setting to reduce the number of variable passing to
>> + * ext4_mb_mark_context. Pass target group blocks range directly to
>> + * reuse the prepared global setting for multiple block ranges and
>> + * to show clearly the specific block range will be marked.
>> + */
>> +struct ext4_mark_context {
>> +	struct super_block *sb;
>> +	int state;
>> +};
> 
> This structure definition does not reflect of it's naming.
> Why can't we also add cblk & clen, flags to it?
> 
> I think the idea of defining a new function named
> ext4_mb_prepare_mark_context() was that we can prepare "struct ext4_mark_context"
> with different cblk, clen & flags arguments for cases where we might
> have to call ext4_mb_mark_context() more than once in the same function
> or call ext4_mb_mark_context() anywhere but at the start of the function.
> 
> As I see it in the current series, we are calling
> ext4_mb_prepare_mark_context() at the start of every function. Just for
> this purpose we don't need an extra function, right? That we can directly do
> at the time of declaring a structure variable itself (like how you did
> in previous version)
> 
Hi Ritesh, thanks for reply. The ext4_mark_context structure aims to reduce
variable passing to ext4_mb_mark_context. If we have to prepare a lot
member in ext4_mb_prepare_mark_context, then too many variables issue occurs
in ext4_mb_prepare_mark_context.
The name of ext4_mark_context maybe not proper. Actually I want a structure
to collect information which is not strongly relevant to mark blk bits. In
this way, we can initialize them at beginning of function, then there is no
need to pay attention to them or to pass them respectively in each call to
ext4_mb_mark_context. Instead, we foucus on the useful information called
with ext4_mb_mark_context.
This design also achive the goal to define ext4_mb_mark_context once for
multiple use in the same function as ext4_mark_context unlikely changes
after initialization at beginning.
> What do you think of the approach where we add cblk, clen & flags
> variables to ext4_mark_context()? Do you see any problems/difficulties
> with that design?
> 
The providing desgin looks good to me. Please let me konw if you still
perfre this and I will do this in next version. Thanks!

>> +
>> +static inline void ext4_mb_prepare_mark_context(struct ext4_mark_context *mc,
>> +						struct super_block *sb,
>> +						int state)
>> +{
>> +	mc->sb = sb;
>> +	mc->state = state;
>> +}
>> +
>> +static int
>> +ext4_mb_mark_context(struct ext4_mark_context *mc, ext4_group_t group,
>> +		     ext4_grpblk_t blkoff, ext4_grpblk_t len)
>> +{
>> +	struct super_block *sb = mc->sb;
>> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> +	struct buffer_head *bitmap_bh = NULL;
>> +	struct ext4_group_desc *gdp;
>> +	struct buffer_head *gdp_bh;
>> +	int err;
>> +	unsigned int i, already, changed;
>> +
>> +	bitmap_bh = ext4_read_block_bitmap(sb, group);
>> +	if (IS_ERR(bitmap_bh))
>> +		return PTR_ERR(bitmap_bh);
>> +
>> +	err = -EIO;
>> +	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
>> +	if (!gdp)
>> +		goto out_err;
>> +
>> +	ext4_lock_group(sb, group);
>> +	if (ext4_has_group_desc_csum(sb) &&
>> +	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
>> +		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
>> +		ext4_free_group_clusters_set(sb, gdp,
>> +			ext4_free_clusters_after_init(sb, group, gdp));
>> +	}
>> +
>> +	already = 0;
>> +	for (i = 0; i < len; i++)
>> +		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
>> +				mc->state)
>> +			already++;
>> +	changed = len - already;
>> +
>> +	if (mc->state) {
>> +		mb_set_bits(bitmap_bh->b_data, blkoff, len);
>> +		ext4_free_group_clusters_set(sb, gdp,
>> +			ext4_free_group_clusters(sb, gdp) - changed);
>> +	} else {
>> +		mb_clear_bits(bitmap_bh->b_data, blkoff, len);
>> +		ext4_free_group_clusters_set(sb, gdp,
>> +			ext4_free_group_clusters(sb, gdp) + changed);
>> +	}
>> +
>> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>> +	ext4_group_desc_csum_set(sb, group, gdp);
>> +	ext4_unlock_group(sb, group);
>> +
>> +	if (sbi->s_log_groups_per_flex) {
>> +		ext4_group_t flex_group = ext4_flex_group(sbi, group);
>> +		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
>> +					   s_flex_groups, flex_group);
>> +
>> +		if (mc->state)
>> +			atomic64_sub(changed, &fg->free_clusters);
>> +		else
>> +			atomic64_add(changed, &fg->free_clusters);
>> +	}
>> +
>> +	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
>> +	if (err)
>> +		goto out_err;
>> +	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
>> +	if (err)
>> +		goto out_err;
>> +
>> +	sync_dirty_buffer(bitmap_bh);
>> +	sync_dirty_buffer(gdp_bh);
>> +
>> +out_err:
>> +	brelse(bitmap_bh);
>> +	return err;
>> +}
>>  
>>  /*
>>   * Check quota and mark chosen space (ac->ac_b_ex) non-free in bitmaps
>> @@ -4078,16 +4172,14 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>>  void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>>  			int len, int state)
>>  {
>> -	struct buffer_head *bitmap_bh = NULL;
>> -	struct ext4_group_desc *gdp;
>> -	struct buffer_head *gdp_bh;
>> +	struct ext4_mark_context mc;
>>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>>  	ext4_group_t group;
>>  	ext4_grpblk_t blkoff;
>> -	int i, err = 0;
>> -	int already;
>> -	unsigned int clen, clen_changed, thisgrp_len;
>> +	int err = 0;
>> +	unsigned int clen, thisgrp_len;
>>  
>> +	ext4_mb_prepare_mark_context(&mc, sb, state);
>>  	while (len > 0) {
>>  		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
>>  
>> @@ -4107,80 +4199,17 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>>  			ext4_error(sb, "Marking blocks in system zone - "
>>  				   "Block = %llu, len = %u",
>>  				   block, thisgrp_len);
>> -			bitmap_bh = NULL;
>> -			break;
>> -		}
>> -
>> -		bitmap_bh = ext4_read_block_bitmap(sb, group);
>> -		if (IS_ERR(bitmap_bh)) {
>> -			err = PTR_ERR(bitmap_bh);
>> -			bitmap_bh = NULL;
>>  			break;
>>  		}
>>  
>> -		err = -EIO;
>> -		gdp = ext4_get_group_desc(sb, group, &gdp_bh);
>> -		if (!gdp)
>> -			break;
>> -
>> -		ext4_lock_group(sb, group);
>> -		already = 0;
>> -		for (i = 0; i < clen; i++)
>> -			if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
>> -					 !state)
>> -				already++;
>> -
>> -		clen_changed = clen - already;
>> -		if (state)
>> -			mb_set_bits(bitmap_bh->b_data, blkoff, clen);
>> -		else
>> -			mb_clear_bits(bitmap_bh->b_data, blkoff, clen);
>> -		if (ext4_has_group_desc_csum(sb) &&
>> -		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
>> -			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
>> -			ext4_free_group_clusters_set(sb, gdp,
>> -			     ext4_free_clusters_after_init(sb, group, gdp));
>> -		}
>> -		if (state)
>> -			clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
>> -		else
>> -			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
>> -
>> -		ext4_free_group_clusters_set(sb, gdp, clen);
>> -		ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>> -		ext4_group_desc_csum_set(sb, group, gdp);
>> -
>> -		ext4_unlock_group(sb, group);
>> -
>> -		if (sbi->s_log_groups_per_flex) {
>> -			ext4_group_t flex_group = ext4_flex_group(sbi, group);
>> -			struct flex_groups *fg = sbi_array_rcu_deref(sbi,
>> -						   s_flex_groups, flex_group);
>> -
>> -			if (state)
>> -				atomic64_sub(clen_changed, &fg->free_clusters);
>> -			else
>> -				atomic64_add(clen_changed, &fg->free_clusters);
>> -
>> -		}
>> -
>> -		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
>> -		if (err)
>> -			break;
>> -		sync_dirty_buffer(bitmap_bh);
>> -		err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
>> -		sync_dirty_buffer(gdp_bh);
>> +		err = ext4_mb_mark_context(&mc, group, blkoff, clen);
>>  		if (err)
>>  			break;
>>  
>>  		block += thisgrp_len;
>>  		len -= thisgrp_len;
>> -		brelse(bitmap_bh);
>>  		BUG_ON(len < 0);
>>  	}
>> -
>> -	if (err)
>> -		brelse(bitmap_bh);
>>  }
>>  
>>  /*
>> -- 
>> 2.30.0
> 
> 
> -ritesh
> 


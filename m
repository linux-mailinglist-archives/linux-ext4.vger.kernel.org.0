Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75A9791035
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 04:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351148AbjIDCy5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Sep 2023 22:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351182AbjIDCyz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Sep 2023 22:54:55 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24547127;
        Sun,  3 Sep 2023 19:54:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RfCsZ34Jyz4f3mLW;
        Mon,  4 Sep 2023 10:54:42 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgBnhr71RvVkBGi0CA--.42595S2;
        Mon, 04 Sep 2023 10:54:46 +0800 (CST)
Subject: Re: [PATCH v6 04/11] ext4: call ext4_mb_mark_context in
 ext4_mb_mark_diskspace_used
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87bkem8saf.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <4c8e7fa4-9381-1f30-bb65-17b28df9b3dd@huaweicloud.com>
Date:   Mon, 4 Sep 2023 10:54:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87bkem8saf.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgBnhr71RvVkBGi0CA--.42595S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF17CrWUKw4UKFW8JF4kXrb_yoW7tw1Dpr
        9xtF1UCr1fJr1DuFWI93Wqq3W0kw4xGr18J34xG3W5CFnFkF9xAay8Ka40kasFkr47A3ZY
        vF15ZFZrCrs7KrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 9/1/2023 11:51 AM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> call ext4_mb_mark_context in ext4_mb_mark_diskspace_used to:
>> 1. remove repeat code to normally update bitmap and group descriptor
>> on disk.
>> 2. call ext4_mb_mark_context instead of only setting bits in block bitmap
>> to fix the bitmap. Function ext4_mb_mark_context will also update
>> checksum of bitmap and other counter along with the bit change to keep
>> the cosistent with bit change or block bitmap will be marked corrupted as
>> checksum of bitmap is in inconsistent state.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> ---
>>  fs/ext4/mballoc.c | 86 +++++++++++------------------------------------
>>  1 file changed, 20 insertions(+), 66 deletions(-)
> 
> I was wondering whether checking for !ext4_inode_block_valid() can also
> be part of ext4_mb_mark_context() by passing EXT4_MB_METABLOCKS_VALID_CHECK
> flag.
Looks great to me. Thanks for the suggestion, I will do this in next version.
> 
> But as for this patch. It looks good to me. Please feel free to add - 
> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> -ritesh
> 
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index b066ee018cdb..e650eac22237 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -4084,46 +4084,28 @@ static noinline_for_stack int
>>  ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>>  				handle_t *handle, unsigned int reserv_clstrs)
>>  {
>> -	struct buffer_head *bitmap_bh = NULL;
>> +	struct ext4_mark_context mc;
>>  	struct ext4_group_desc *gdp;
>> -	struct buffer_head *gdp_bh;
>>  	struct ext4_sb_info *sbi;
>>  	struct super_block *sb;
>>  	ext4_fsblk_t block;
>>  	int err, len;
>> +	int flags = 0;
>>  
>>  	BUG_ON(ac->ac_status != AC_STATUS_FOUND);
>>  	BUG_ON(ac->ac_b_ex.fe_len <= 0);
>>  
>>  	sb = ac->ac_sb;
>>  	sbi = EXT4_SB(sb);
>> +	ext4_mb_prepare_mark_context(&mc, handle, sb, 1);
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
>> @@ -4132,41 +4114,28 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>>  		 * Fix the bitmap and return EFSCORRUPTED
>>  		 * We leak some of the blocks here.
>>  		 */
>> -		ext4_lock_group(sb, ac->ac_b_ex.fe_group);
>> -		mb_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
>> -			      ac->ac_b_ex.fe_len);
>> -		ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
>> -		err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
>> +		err = ext4_mb_mark_context(&mc, ac->ac_b_ex.fe_group,
>> +					   ac->ac_b_ex.fe_start,
>> +					   ac->ac_b_ex.fe_len,
>> +					   0);
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
>> +	flags |= EXT4_MB_BITMAP_MARKED_CHECK;
>>  #endif
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
>> +	err = ext4_mb_mark_context(&mc, ac->ac_b_ex.fe_group,
>> +				   ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
>> +				   flags);
>> +
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
>> @@ -4176,21 +4145,6 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
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
> 


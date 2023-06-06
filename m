Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8D724586
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 16:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjFFOQv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjFFOQt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 10:16:49 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53082A0;
        Tue,  6 Jun 2023 07:16:46 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QbCFz3zYnz4f3l1F;
        Tue,  6 Jun 2023 22:16:39 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgB3XgzHP39kLOTxKA--.42915S2;
        Tue, 06 Jun 2023 22:16:40 +0800 (CST)
Subject: Re: [PATCH v4 16/19] ext4: call ext4_mb_mark_group_bb in
 ext4_mb_clear_bb
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
 <20230603150327.3596033-17-shikemeng@huaweicloud.com>
 <ZH7+xclxW3hKb7GA@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <bb19c6f8-d31f-f686-17f9-3fd2bb1db3dd@huaweicloud.com>
Date:   Tue, 6 Jun 2023 22:16:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <ZH7+xclxW3hKb7GA@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgB3XgzHP39kLOTxKA--.42915S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1fuw4rCF4rGw1fAF1rXrb_yoWfCF13pr
        yDCFnrCrn8GrnruF4xu34YqF1Iqw18ur47GrWfCas3Cr9Fvr93KFZ7tF93CF4qyFZ7W3Wk
        XF1Uur4Durs2k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 6/6/2023 5:39 PM, Ojaswin Mujoo wrote:
> On Sat, Jun 03, 2023 at 11:03:24PM +0800, Kemeng Shi wrote:
>> call ext4_mb_mark_group_bb in ext4_mb_clear_bb to remove repeat code
>> to update block bitmap and group descriptor on disk.
>>
>> Note: ext4_mb_clear_bb will update buddy and bitmap in two critical sections
>> instead of update in the same critical section.
>>
>> Original lock behavior introduced in 7a2fcbf7f857 ("ext4: don't use
>> blocks freed but not yet committed in buddy cache init") to avoid
>> race betwwen ext4_mb_free_blocks and ext4_mb_init_cache:
>> ext4_mb_load_buddy_gfp
>> ext4_lock_group
>> mb_clear_bits(bitmap_bh, ...)
>> mb_free_blocks/ext4_mb_free_metadata
>> ext4_unlock_group
>> ext4_mb_unload_buddy
>>
>> New lock behavior in this patch:
>> ext4_mb_load_buddy_gfp
>> ext4_lock_group
>> mb_clear_bits(bitmap_bh, ...)
>> ext4_unlock_group
>>
>> /* no ext4_mb_init_cache for the same group will be called as
>> ext4_mb_load_buddy_gfp will ensure buddy page is update-to-date */
>>
>> ext4_lock_group
>> mb_free_blocks/ext4_mb_free_metadata
>> ext4_unlock_group
>> ext4_mb_unload_buddy
>>
>> As buddy page for group is always update-to-date between
>> ext4_mb_load_buddy_gfp and ext4_mb_unload_buddy. Then no
>> ext4_mb_init_cache will be called for the same group concurrentlly when
>> we update bitmap and buddy page betwwen buddy load and unload.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Hi Kemeng,
> 
> Sorry for the late reply I was trying to understand the codepath
> properly. So I have a question here:
> 
> With the changes you've made in the patch, the flow would look something
> like:
> 
> ext4_mb_clear_bb():
>   ext4_mb_mark_group_bb():
>     ext4_group_lock()
>       - Mark bitmap free
>       - Modify gdp
>     ext4_group_unlock()
>     ext4_handle_dirty_metadata()
> 			- I understand this will add the bitmap and gdp buffers to journal's 
>         dirty metadata list
>   ...
>   ext4_group_lock()
>     ext4_mb_free_metadata()
> 			- Add ext4_free_data entries to sbi->s_freed_data_list. (On commit 
>         ext4_journal_commit_callback() will then free the buddy for these)
>   ext4_group_unlock()
> 
> My question is what happens if journal commits between
> ext4_handle_dirty_metadata() and ext4_mb_free_metadata() call (Possible?). Then we might
> never end up freeing the metadata in the buddy bitmap because the commit callback wont
> be able to find the ext4_free_data entries in sbi->s_freed_data_list.
> 
> Regards,
> ojaswin
> 
Hi Ojaswin, thanks for the reply. To my knowledge, commit should be normally done after handle
is stopped as following:
ext4_journal_start_sb
	start_this_handle
		read_lock(&journal->j_state_lock);
		atomic_inc(&transaction->t_updates);
		read_unlock(&journal->j_state_lock);

ext4_journal_stop
	jbd2_journal_stop
		stop_this_handle
			if (atomic_dec_and_test(&transaction->t_updates))
				wake_up(&journal->j_wait_updates);

jbd2_journal_commit_transaction
	jbd2_journal_wait_updates
		while (1)
			if (!atomic_read(&transaction->t_updates))
				/* break loop */
	...

	if (journal->j_commit_callback)
		journal->j_commit_callback(journal, commit_transaction);

So no commit of transaction should not happen between ext4_handle_dirty_metadata and
ext4_mb_free_metadata.

>> ---
>>  fs/ext4/mballoc.c | 90 ++++++++++++-----------------------------------
>>  1 file changed, 23 insertions(+), 67 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 46b37f5c9223..e4f1b34448e3 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6135,19 +6135,21 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>  			       ext4_fsblk_t block, unsigned long count,
>>  			       int flags)
>>  {
>> -	struct buffer_head *bitmap_bh = NULL;
>> +	struct ext4_mark_context mc = {
>> +		.handle = handle,
>> +		.sb = inode->i_sb,
>> +		.state = 0,
>> +	};
>>  	struct super_block *sb = inode->i_sb;
>> -	struct ext4_group_desc *gdp;
>>  	struct ext4_group_info *grp;
>>  	unsigned int overflow;
>>  	ext4_grpblk_t bit;
>> -	struct buffer_head *gd_bh;
>>  	ext4_group_t block_group;
>>  	struct ext4_sb_info *sbi;
>>  	struct ext4_buddy e4b;
>>  	unsigned int count_clusters;
>>  	int err = 0;
>> -	int ret;
>> +	int mark_flags = 0;
>>  
>>  	sbi = EXT4_SB(sb);
>>  
>> @@ -6179,18 +6181,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>  		/* The range changed so it's no longer validated */
>>  		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
>>  	}
>> -	count_clusters = EXT4_NUM_B2C(sbi, count);
>> -	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
>> -	if (IS_ERR(bitmap_bh)) {
>> -		err = PTR_ERR(bitmap_bh);
>> -		bitmap_bh = NULL;
>> -		goto error_return;
>> -	}
>> -	gdp = ext4_get_group_desc(sb, block_group, &gd_bh);
>> -	if (!gdp) {
>> -		err = -EIO;
>> -		goto error_return;
>> -	}
>>  
>>  	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
>>  	    !ext4_inode_block_valid(inode, block, count)) {
>> @@ -6200,28 +6190,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>  		goto error_return;
>>  	}
>>  
>> -	BUFFER_TRACE(bitmap_bh, "getting write access");
>> -	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
>> -					    EXT4_JTR_NONE);
>> -	if (err)
>> -		goto error_return;
>> -
>> -	/*
>> -	 * We are about to modify some metadata.  Call the journal APIs
>> -	 * to unshare ->b_data if a currently-committing transaction is
>> -	 * using it
>> -	 */
>> -	BUFFER_TRACE(gd_bh, "get_write_access");
>> -	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
>> -	if (err)
>> -		goto error_return;
>> -#ifdef AGGRESSIVE_CHECK
>> -	{
>> -		int i;
>> -		for (i = 0; i < count_clusters; i++)
>> -			BUG_ON(!mb_test_bit(bit + i, bitmap_bh->b_data));
>> -	}
>> -#endif
>> +	count_clusters = EXT4_NUM_B2C(sbi, count);
>>  	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
>>  
>>  	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
>> @@ -6230,6 +6199,22 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>  	if (err)
>>  		goto error_return;
>>  
>> +#ifdef AGGRESSIVE_CHECK
>> +	mark_flags |= EXT4_MB_BITMAP_MARKED_CHECK;
>> +#endif
>> +	err = ext4_mb_mark_group_bb(&mc, block_group, bit, count_clusters,
>> +				    mark_flags);
>> +
>> +
>> +	if (err && mc.changed == 0) {
>> +		ext4_mb_unload_buddy(&e4b);
>> +		goto error_return;
>> +	}
>> +
>> +#ifdef AGGRESSIVE_CHECK
>> +	BUG_ON(mc.changed != count_clusters);
>> +#endif
>> +
>>  	/*
>>  	 * We need to make sure we don't reuse the freed block until after the
>>  	 * transaction is committed. We make an exception if the inode is to be
>> @@ -6252,13 +6237,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>  		new_entry->efd_tid = handle->h_transaction->t_tid;
>>  
>>  		ext4_lock_group(sb, block_group);
>> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>  		ext4_mb_free_metadata(handle, &e4b, new_entry);
>>  	} else {
>> -		/* need to update group_info->bb_free and bitmap
>> -		 * with group lock held. generate_buddy look at
>> -		 * them with group lock_held
>> -		 */
>>  		if (test_opt(sb, DISCARD)) {
>>  			err = ext4_issue_discard(sb, block_group, bit,
>>  						 count_clusters, NULL);
>> @@ -6271,23 +6251,11 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>  			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
>>  
>>  		ext4_lock_group(sb, block_group);
>> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>  		mb_free_blocks(inode, &e4b, bit, count_clusters);
>>  	}
>>  
>> -	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
>> -	ext4_free_group_clusters_set(sb, gdp, ret);
>> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>> -	ext4_group_desc_csum_set(sb, block_group, gdp);
>>  	ext4_unlock_group(sb, block_group);
>>  
>> -	if (sbi->s_log_groups_per_flex) {
>> -		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
>> -		atomic64_add(count_clusters,
>> -			     &sbi_array_rcu_deref(sbi, s_flex_groups,
>> -						  flex_group)->free_clusters);
>> -	}
>> -
>>  	/*
>>  	 * on a bigalloc file system, defer the s_freeclusters_counter
>>  	 * update to the caller (ext4_remove_space and friends) so they
>> @@ -6302,26 +6270,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>  
>>  	ext4_mb_unload_buddy(&e4b);
>>  
>> -	/* We dirtied the bitmap block */
>> -	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
>> -	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
>> -
>> -	/* And the group descriptor block */
>> -	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
>> -	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
>> -	if (!err)
>> -		err = ret;
>> -
>>  	if (overflow && !err) {
>>  		block += count;
>>  		count = overflow;
>> -		put_bh(bitmap_bh);
>>  		/* The range changed so it's no longer validated */
>>  		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
>>  		goto do_more;
>>  	}
>>  error_return:
>> -	brelse(bitmap_bh);
>>  	ext4_std_error(sb, err);
>>  	return;
>>  }
>> -- 
>> 2.30.0
>>
> 

-- 
Best wishes
Kemeng Shi


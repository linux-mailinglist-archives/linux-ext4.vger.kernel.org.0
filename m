Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC57760CD8
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 10:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjGYIVa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGYIV1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 04:21:27 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DECE5C;
        Tue, 25 Jul 2023 01:21:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R993K3LX6z4f41Vk;
        Tue, 25 Jul 2023 16:21:17 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgCHeuj6hb9kTMLIOg--.4402S2;
        Tue, 25 Jul 2023 16:21:16 +0800 (CST)
Subject: Re: [PATCH v5 5/8] ext4: call ext4_mb_mark_group_bb in
 ext4_mb_clear_bb
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87edkzjiil.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <bb0c8088-3e06-c808-7944-39b95cca9a1f@huaweicloud.com>
Date:   Tue, 25 Jul 2023 16:21:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87edkzjiil.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgCHeuj6hb9kTMLIOg--.4402S2
X-Coremail-Antispam: 1UD129KBjvAXoW3ZFyxWF4xCw1UKw45Kw1DGFg_yoW8Gr1Duo
        WrAF42yF4xZryjyay8Ca98X3y7C34DGFWxZr1rZF45uF4jya4a9w4xCw4fXFW3Jw1Ikr9r
        KryxXFWF9FW0kF95n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 7/23/2023 1:37 PM, Ritesh Harjani wrote:
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> 
>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>>
>>> call ext4_mb_mark_group_bb in ext4_mb_clear_bb to remove repeat code
>>> to update block bitmap and group descriptor on disk.
>>>
>>> Note: ext4_mb_clear_bb will update buddy and bitmap in two critical
>>> sections instead of update in the same critical section.
>>>
>>> Original lock behavior introduced in commit 7a2fcbf7f8573 ("ext4: don't
>>> use blocks freed but not yet committed in buddy cache init") to avoid
>>> race betwwen ext4_mb_free_blocks and ext4_mb_init_cache:
>>> ext4_mb_load_buddy_gfp
>>> ext4_lock_group
>>> mb_clear_bits(bitmap_bh, ...)
>>> mb_free_blocks/ext4_mb_free_metadata
>>> ext4_unlock_group
>>> ext4_mb_unload_buddy
>>>
>>> New lock behavior in this patch:
>>> ext4_mb_load_buddy_gfp
>>> ext4_lock_group
>>> mb_clear_bits(bitmap_bh, ...)
>>> ext4_unlock_group
>>>
>>> /* no ext4_mb_init_cache for the same group will be called as
>>> ext4_mb_load_buddy_gfp will ensure buddy page is update-to-date */
>>>
>>> ext4_lock_group
>>> mb_free_blocks/ext4_mb_free_metadata
>>> ext4_unlock_group
>>> ext4_mb_unload_buddy
>>>
>>> As buddy page for group is always update-to-date between
>>> ext4_mb_load_buddy_gfp and ext4_mb_unload_buddy. Then no
>>> ext4_mb_init_cache will be called for the same group concurrentlly when
>>> we update bitmap and buddy page betwwen buddy load and unload.
>>
>> More information will definitely help.
>>
>> In ext4_mb_init_cache(), within a lock_group(), we first initialize
>> a incore bitmap from on disk block bitmap, pa and from
>> ext4_mb_generate_from_freelist() (this function basically requires
>> ext4_mb_free_metadata() to be called)
>> Then we go and initialize incore buddy within a page which utilize bitmap
>> block data (from previous step) for generating buddy info.
>> So this clearly means we need incore bitmap and mb_free_metadata() to be updated
>> together within the same group lock.
> 
> Here I meant on-disk bitmap in bitmap_bh. Anyhow I don't think this is really
> required though.
> 
> 
>>
>> Now you said that ext4_mb_init_cache() can't be called together between
>> ext4_mb_load_buddy_gfp() and unload_buddy() because buddy page is uptodate?? 
>> Can you give more details please? 
> 
> Ok. So even if the page is uptodate, ext4_mb_init_cache() can still get
> called when you have a resize and the extended group belongs to the same
> page (for bs < ps). But we don't touch the bitmap and buddy info for the
> groups which are already initialized.
> And as you said we can't be working on bitmap or buddy info unless we
> have called ext4_mb_load_buddy_gfp() which takes care of the bitmap and
> buddy initialization for this group and it will clear the
> EXT4_GROUP_INFO_NEED_INIT_BIT in grp->bb_state so that
> ext4_mb_init_cache() called due to resize doesn't re-initialize it.
> 
Yes, my point is that only first ext4_mb_load_buddy_gfp of a group will
do real buddy initialization which will generate buddy from on-disk bitmap
and data from ext4_mb_free_metadata. Any code after ext4_mb_load_buddy_gfp
has no race with buddy initialization. As ext4_mb_free_metadata is called
after ext4_mb_load_buddy_gfp, there is no race with buddy initialization.

> But one concern that I still have is - till now we update the bitmap and
> buddy info atomically within the same group lock. This patch is changing
> this behavior. So you might wanna explain that this race will never happen
> and why?
> 
> 
> ext4_mb_clear_bb()              xxxxxxxx()
> 
>     ext4_mb_load_buddy_gfp()    ext4_mb_load_buddy_gfp() // this can happen in parallel for initialized groups
>     ext4_lock_group()           ext4_lock_group()   // will wait
>     update block bitmap
>     ext4_unlock_group()
>                                 ext4_lock_group() // succeed. 
>                                 looks into bitmap and buddy info and found discripancy.
>                                 mark group corrupt or something?
>                                 ext4_unlock_group()    
> 
>     ext4_lock_group()
>     update buddy info
>     ext4_unlock_group()
>     ext4_mb_unlock_buddy()      ext4_mb_unlock_buddy()
> 
> 
> ...On more reading, I don't find a dependency between the two. 
> I see mb_free_blocks (poor naming I know...) which is responsible for
> freeing buddy info does not have any return value. So it won't return an
> error ever. Other thing to note is, ext4_mb_release_inode_pa() does
> check for bits set in bitmap and based on that call mb_free_blocks(),
> but I think we don't have a problem there since we take a group lock and
> we first update the bitmap. 
> 
> So I haven't found any dependency due to which we need to update bitmap
> and buddy info atomically. Hence IMO, we can separate it out from a common
> lock> Feel free to add/update more details if you thnk anything is missed.
After this patchset, here is all paths to cooperate update of on-disk bitmap
and buddy bitmap in seperate lock (search all functions calling
ext4_mb_load_buddy or ext4_mb_load_buddy_gfp to find potential code path to
update both on-disk bitmap and buddy bitmap):
code to free blocks:
ext4_group_add_blocks (lock is separated in this patchset)
  lock
  clear on-disk bitmap
  unlock

  lock
  clear buddy bitmap
  unlock

ext4_mb_clear_bb (lock is separated in this patchset)
  lock
  clear on-disk bitmap
  unlock

  lock
  clear buddy bitmap
  unlock

code to alloc blocks:
ext4_mb_new_blocks (lock was separated before)
  lock
  search and set buddy bitmap
  unlock

  ext4_mb_mark_diskspace_used
    lock
    set on-disk bitmap
    unlock

We always clear on-disk bitmap first, and then clear buddy bitmap during
free while we do allocation on reverse order, i.e. seach and set buddy
bitmap first, and then set on-disk bitmap.
With this order, we know that bits are cleared in both on-dism bitmap
and buddy bitmap when it's seen from allocation.

> I didn't put why journal commit cannot run between the two, because I
> think we are still in the middle of a txn.
> (i.e. we still haven't call ext4_journal_stop())
> 
Yes, this is also explained in [1].

> I am putting above information here.. so that if someone else reviews
> the code, then can find this discussion for reference.
> 
> However please note that the subject of the commit is not very
> informative. I think this patch should have been split into two - 
> 
> 1. ext4: Separate block bitmap and buddy bitmap freeing in ext4_mb_clear_bb() 
> ... In this commit message you should explain why this can be seperated.
> This way a reviewer would know that this requires a closer review to
> make sure that locking is handled correctly and/or there is no race.
> 
> 2. ext4: Make use of ext4_mb_mark_group_bb() in ext4_mb_clear_bb()
> This commit message then just becomes make use of the new function that
> you created.
> 
Sure, I will split this patch in next version and add details discussed to
commit.

[1] https://lore.kernel.org/linux-ext4/bb19c6f8-d31f-f686-17f9-3fd2bb1db3dd@huaweicloud.com/

-- 
Best wishes
Kemeng Shi

> -ritesh
> >>
>> What about if the resize gets called on the last group which is within the
>> same page on which we are operating. Also consider blocksize < pagesize.
>> That means we can have even more blocks within the same page.
>> So ext4_mb_init_cache() can still get called right while between load_buddy and unload_buddy?
>>
>> Maybe I need to take a closer look at it.
>>
>> -ritesh
>>
>>
>>>
>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>> ---
>>>  fs/ext4/mballoc.c | 90 ++++++++++++-----------------------------------
>>>  1 file changed, 23 insertions(+), 67 deletions(-)
>>>
>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>> index 34fd12aeaf8d..57cc304b724e 100644
>>> --- a/fs/ext4/mballoc.c
>>> +++ b/fs/ext4/mballoc.c
>>> @@ -6325,19 +6325,21 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>  			       ext4_fsblk_t block, unsigned long count,
>>>  			       int flags)
>>>  {
>>> -	struct buffer_head *bitmap_bh = NULL;
>>> +	struct ext4_mark_context mc = {
>>> +		.handle = handle,
>>> +		.sb = inode->i_sb,
>>> +		.state = 0,
>>> +	};
>>>  	struct super_block *sb = inode->i_sb;
>>> -	struct ext4_group_desc *gdp;
>>>  	struct ext4_group_info *grp;
>>>  	unsigned int overflow;
>>>  	ext4_grpblk_t bit;
>>> -	struct buffer_head *gd_bh;
>>>  	ext4_group_t block_group;
>>>  	struct ext4_sb_info *sbi;
>>>  	struct ext4_buddy e4b;
>>>  	unsigned int count_clusters;
>>>  	int err = 0;
>>> -	int ret;
>>> +	int mark_flags = 0;
>>>  
>>>  	sbi = EXT4_SB(sb);
>>>  
>>> @@ -6369,18 +6371,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>  		/* The range changed so it's no longer validated */
>>>  		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
>>>  	}
>>> -	count_clusters = EXT4_NUM_B2C(sbi, count);
>>> -	bitmap_bh = ext4_read_block_bitmap(sb, block_group);
>>> -	if (IS_ERR(bitmap_bh)) {
>>> -		err = PTR_ERR(bitmap_bh);
>>> -		bitmap_bh = NULL;
>>> -		goto error_return;
>>> -	}
>>> -	gdp = ext4_get_group_desc(sb, block_group, &gd_bh);
>>> -	if (!gdp) {
>>> -		err = -EIO;
>>> -		goto error_return;
>>> -	}
>>>  
>>>  	if (!(flags & EXT4_FREE_BLOCKS_VALIDATED) &&
>>>  	    !ext4_inode_block_valid(inode, block, count)) {
>>> @@ -6390,28 +6380,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>  		goto error_return;
>>>  	}
>>>  
>>> -	BUFFER_TRACE(bitmap_bh, "getting write access");
>>> -	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
>>> -					    EXT4_JTR_NONE);
>>> -	if (err)
>>> -		goto error_return;
>>> -
>>> -	/*
>>> -	 * We are about to modify some metadata.  Call the journal APIs
>>> -	 * to unshare ->b_data if a currently-committing transaction is
>>> -	 * using it
>>> -	 */
>>> -	BUFFER_TRACE(gd_bh, "get_write_access");
>>> -	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
>>> -	if (err)
>>> -		goto error_return;
>>> -#ifdef AGGRESSIVE_CHECK
>>> -	{
>>> -		int i;
>>> -		for (i = 0; i < count_clusters; i++)
>>> -			BUG_ON(!mb_test_bit(bit + i, bitmap_bh->b_data));
>>> -	}
>>> -#endif
>>> +	count_clusters = EXT4_NUM_B2C(sbi, count);
>>>  	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
>>>  
>>>  	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
>>> @@ -6420,6 +6389,22 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>  	if (err)
>>>  		goto error_return;
>>>  
>>> +#ifdef AGGRESSIVE_CHECK
>>> +	mark_flags |= EXT4_MB_BITMAP_MARKED_CHECK;
>>> +#endif
>>> +	err = ext4_mb_mark_group_bb(&mc, block_group, bit, count_clusters,
>>> +				    mark_flags);
>>> +
>>> +
>>> +	if (err && mc.changed == 0) {
>>> +		ext4_mb_unload_buddy(&e4b);
>>> +		goto error_return;
>>> +	}
>>> +
>>> +#ifdef AGGRESSIVE_CHECK
>>> +	BUG_ON(mc.changed != count_clusters);
>>> +#endif
>>> +
>>>  	/*
>>>  	 * We need to make sure we don't reuse the freed block until after the
>>>  	 * transaction is committed. We make an exception if the inode is to be
>>> @@ -6442,13 +6427,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>  		new_entry->efd_tid = handle->h_transaction->t_tid;
>>>  
>>>  		ext4_lock_group(sb, block_group);
>>> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>>  		ext4_mb_free_metadata(handle, &e4b, new_entry);
>>>  	} else {
>>> -		/* need to update group_info->bb_free and bitmap
>>> -		 * with group lock held. generate_buddy look at
>>> -		 * them with group lock_held
>>> -		 */
>>>  		if (test_opt(sb, DISCARD)) {
>>>  			err = ext4_issue_discard(sb, block_group, bit,
>>>  						 count_clusters, NULL);
>>> @@ -6461,23 +6441,11 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>  			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
>>>  
>>>  		ext4_lock_group(sb, block_group);
>>> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>>  		mb_free_blocks(inode, &e4b, bit, count_clusters);
>>>  	}
>>>  
>>> -	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
>>> -	ext4_free_group_clusters_set(sb, gdp, ret);
>>> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>>> -	ext4_group_desc_csum_set(sb, block_group, gdp);
>>>  	ext4_unlock_group(sb, block_group);
>>>  
>>> -	if (sbi->s_log_groups_per_flex) {
>>> -		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
>>> -		atomic64_add(count_clusters,
>>> -			     &sbi_array_rcu_deref(sbi, s_flex_groups,
>>> -						  flex_group)->free_clusters);
>>> -	}
>>> -
>>>  	/*
>>>  	 * on a bigalloc file system, defer the s_freeclusters_counter
>>>  	 * update to the caller (ext4_remove_space and friends) so they
>>> @@ -6492,26 +6460,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>  
>>>  	ext4_mb_unload_buddy(&e4b);
>>>  
>>> -	/* We dirtied the bitmap block */
>>> -	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
>>> -	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
>>> -
>>> -	/* And the group descriptor block */
>>> -	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
>>> -	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
>>> -	if (!err)
>>> -		err = ret;
>>> -
>>>  	if (overflow && !err) {
>>>  		block += count;
>>>  		count = overflow;
>>> -		put_bh(bitmap_bh);
>>>  		/* The range changed so it's no longer validated */
>>>  		flags &= ~EXT4_FREE_BLOCKS_VALIDATED;
>>>  		goto do_more;
>>>  	}
>>>  error_return:
>>> -	brelse(bitmap_bh);
>>>  	ext4_std_error(sb, err);
>>>  	return;
>>>  }
>>> -- 
>>> 2.30.0
> 


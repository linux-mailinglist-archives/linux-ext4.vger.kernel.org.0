Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB31275DFFE
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jul 2023 07:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGWFhP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jul 2023 01:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWFhN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Jul 2023 01:37:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8121BD0;
        Sat, 22 Jul 2023 22:37:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666eec46206so3113081b3a.3;
        Sat, 22 Jul 2023 22:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690090631; x=1690695431;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=67iV377mlrZw0t0KHI20eTHUfEv5Ir/34Yk/0iNGuEw=;
        b=A3q5FBZaG1Ll/l/HvHElCKpkS+c+MaizDAwcBs8wrmZ+7BGVNcJjDzz0YEDBaiBZo3
         2iBoQPuYUX3gy4nZuKWhVCHJqY4tvviJl7Wn+QbZCC8upKgrZUjRx+gqiSqxe7bAglH9
         eD6MMt507ptEmyvT9WmXoaHrvLQONlFJ/7MozDiIqJjKoliwyR9eJ8Uncpdpsd0hpWl+
         jvXTBefd/6Ub/XeP4WBtrZS/sfcSgsb3XUYf4lzUwDYCXZTfXTzpLZehZIOLq1XRLkEm
         X9vXHLQNLBPVuTvAUvgADgL5r36b5iCczjgnX1uQs28RAM5cb5puR0+Rw93kERzC/YoP
         /2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690090631; x=1690695431;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67iV377mlrZw0t0KHI20eTHUfEv5Ir/34Yk/0iNGuEw=;
        b=MhoXZzSRSou7Nz0gHzXxsfvFnjSM6RQkmsAd0PZ2p8unE+AqWnYu2mSvFkw7SZ4pa5
         /CY8cxjz1ivwAnJuC0cIAbI3QpR4Tq7A/8+dc4b8JJk335g7fQCh0DO/t/Bhh49np5Xb
         Ilydeb1PNXoZnTKoesdedm7t2E/h7l2IFOOGIrT5g1TLEWM++sIZ1G4nCU2Gy6Ep5ADX
         NwMha9/GKd72o+2mj6Gb5prQ3gqPnPph0edVTYA+oe56esBX7LDCstb/XmaAl+s/Y94K
         VYkos2LmTmiCyjRhF3VPR1nEThJZswYy5L+g76tpBX+EppINdHCD3rWHKLZ/FeQiU7px
         yg7w==
X-Gm-Message-State: ABy/qLY26pA1YGtgrW1iZDlAnbZDo5PBwyASORO5PNiwxG3X2AoP6RQr
        vZg7ZpC5MuCLGeIUJRqMKOE=
X-Google-Smtp-Source: APBJJlHbtOOYOI2+R6FnPYL9mwGMzMivPV2Soz8ZIM0ASEPAudBC8OfaW50E8151F2Z26JeDT6ijGA==
X-Received: by 2002:a05:6a00:812:b0:668:81c5:2f8d with SMTP id m18-20020a056a00081200b0066881c52f8dmr6788882pfk.3.1690090631424;
        Sat, 22 Jul 2023 22:37:11 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id s9-20020a63af49000000b0055ff89c5453sm5837384pgo.6.2023.07.22.22.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 22:37:10 -0700 (PDT)
Date:   Sun, 23 Jul 2023 11:07:06 +0530
Message-Id: <87edkzjiil.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH v5 5/8] ext4: call ext4_mb_mark_group_bb in ext4_mb_clear_bb
In-Reply-To: <87h6pwj8c4.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>
>> call ext4_mb_mark_group_bb in ext4_mb_clear_bb to remove repeat code
>> to update block bitmap and group descriptor on disk.
>>
>> Note: ext4_mb_clear_bb will update buddy and bitmap in two critical
>> sections instead of update in the same critical section.
>>
>> Original lock behavior introduced in commit 7a2fcbf7f8573 ("ext4: don't
>> use blocks freed but not yet committed in buddy cache init") to avoid
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
>
> More information will definitely help.
>
> In ext4_mb_init_cache(), within a lock_group(), we first initialize
> a incore bitmap from on disk block bitmap, pa and from
> ext4_mb_generate_from_freelist() (this function basically requires
> ext4_mb_free_metadata() to be called)
> Then we go and initialize incore buddy within a page which utilize bitmap
> block data (from previous step) for generating buddy info.
> So this clearly means we need incore bitmap and mb_free_metadata() to be updated
> together within the same group lock.

Here I meant on-disk bitmap in bitmap_bh. Anyhow I don't think this is really
required though.


>
> Now you said that ext4_mb_init_cache() can't be called together between
> ext4_mb_load_buddy_gfp() and unload_buddy() because buddy page is uptodate?? 
> Can you give more details please? 

Ok. So even if the page is uptodate, ext4_mb_init_cache() can still get
called when you have a resize and the extended group belongs to the same
page (for bs < ps). But we don't touch the bitmap and buddy info for the
groups which are already initialized.
And as you said we can't be working on bitmap or buddy info unless we
have called ext4_mb_load_buddy_gfp() which takes care of the bitmap and
buddy initialization for this group and it will clear the
EXT4_GROUP_INFO_NEED_INIT_BIT in grp->bb_state so that
ext4_mb_init_cache() called due to resize doesn't re-initialize it.


But one concern that I still have is - till now we update the bitmap and
buddy info atomically within the same group lock. This patch is changing
this behavior. So you might wanna explain that this race will never happen
and why?


ext4_mb_clear_bb()              xxxxxxxx()

    ext4_mb_load_buddy_gfp()    ext4_mb_load_buddy_gfp() // this can happen in parallel for initialized groups
    ext4_lock_group()           ext4_lock_group()   // will wait
    update block bitmap
    ext4_unlock_group()
                                ext4_lock_group() // succeed. 
                                looks into bitmap and buddy info and found discripancy.
                                mark group corrupt or something?
                                ext4_unlock_group()    

    ext4_lock_group()
    update buddy info
    ext4_unlock_group()
    ext4_mb_unlock_buddy()      ext4_mb_unlock_buddy()


...On more reading, I don't find a dependency between the two. 
I see mb_free_blocks (poor naming I know...) which is responsible for
freeing buddy info does not have any return value. So it won't return an
error ever. Other thing to note is, ext4_mb_release_inode_pa() does
check for bits set in bitmap and based on that call mb_free_blocks(),
but I think we don't have a problem there since we take a group lock and
we first update the bitmap. 

So I haven't found any dependency due to which we need to update bitmap
and buddy info atomically. Hence IMO, we can separate it out from a common
lock.
Feel free to add/update more details if you thnk anything is missed.
I didn't put why journal commit cannot run between the two, because I
think we are still in the middle of a txn.
(i.e. we still haven't call ext4_journal_stop())

I am putting above information here.. so that if someone else reviews
the code, then can find this discussion for reference.

However please note that the subject of the commit is not very
informative. I think this patch should have been split into two - 

1. ext4: Separate block bitmap and buddy bitmap freeing in ext4_mb_clear_bb() 
... In this commit message you should explain why this can be seperated.
This way a reviewer would know that this requires a closer review to
make sure that locking is handled correctly and/or there is no race.

2. ext4: Make use of ext4_mb_mark_group_bb() in ext4_mb_clear_bb()
This commit message then just becomes make use of the new function that
you created.

-ritesh

>
> What about if the resize gets called on the last group which is within the
> same page on which we are operating. Also consider blocksize < pagesize.
> That means we can have even more blocks within the same page.
> So ext4_mb_init_cache() can still get called right while between load_buddy and unload_buddy?
>
> Maybe I need to take a closer look at it.
>
> -ritesh
>
>
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 90 ++++++++++++-----------------------------------
>>  1 file changed, 23 insertions(+), 67 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 34fd12aeaf8d..57cc304b724e 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6325,19 +6325,21 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
>> @@ -6369,18 +6371,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
>> @@ -6390,28 +6380,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
>> @@ -6420,6 +6389,22 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
>> @@ -6442,13 +6427,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
>> @@ -6461,23 +6441,11 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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
>> @@ -6492,26 +6460,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
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

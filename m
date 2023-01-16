Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D878166BDC1
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jan 2023 13:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjAPMXs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Jan 2023 07:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjAPMXk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Jan 2023 07:23:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72501C31D;
        Mon, 16 Jan 2023 04:23:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 716563744C;
        Mon, 16 Jan 2023 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673871815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gEX952hAKjhcwPQg9jeL8IylSfDc7S8JwhQc86bq5YM=;
        b=FjfKqqJEphjcunzkJ6JkbCNapevg9q2JadJIwXIfOeawG469Ysx2zxtC1V2sBIFuWCQHvr
        lYEs7BDdmSpzVSe8lONfP+vMxWc1glPHx+2LqUoPexpiOuuIAJ/73cT2MMy/LKA2qlwQ34
        fxqYRMlVhxfyTHNwtft/t3W/VVcjtxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673871815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gEX952hAKjhcwPQg9jeL8IylSfDc7S8JwhQc86bq5YM=;
        b=J4bLABqsW81JM2RYAiubfrLWgN1FRVVLc8viqd790UMqkVAcwN9COWh1C0rQNaF+xQqbaT
        ytDw9ltt/TSip+Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59889138FE;
        Mon, 16 Jan 2023 12:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fpvTFcdBxWPXGQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 16 Jan 2023 12:23:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DBD23A06AD; Mon, 16 Jan 2023 13:23:34 +0100 (CET)
Date:   Mon, 16 Jan 2023 13:23:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <20230116122334.k2hlom22o2hlek3m@quack3>
References: <20230116080216.249195-1-ojaswin@linux.ibm.com>
 <20230116080216.249195-8-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116080216.249195-8-ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 16-01-23 13:32:15, Ojaswin Mujoo wrote:
> Currently, the kernel uses i_prealloc_list to hold all the inode
> preallocations. This is known to cause degradation in performance in
> workloads which perform large number of sparse writes on a single file.
> This is mainly because functions like ext4_mb_normalize_request() and
> ext4_mb_use_preallocated() iterate over this complete list, resulting in
> slowdowns when large number of PAs are present.
> 
> Patch 27bc446e2 partially fixed this by enforcing a limit of 512 for
> the inode preallocation list and adding logic to continually trim the
> list if it grows above the threshold, however our testing revealed that
> a hardcoded value is not suitable for all kinds of workloads.
> 
> To optimize this, add an rbtree to the inode and hold the inode
> preallocations in this rbtree. This will make iterating over inode PAs
> faster and scale much better than a linked list. Additionally, we also
> had to remove the LRU logic that was added during trimming of the list
> (in ext4_mb_release_context()) as it will add extra overhead in rbtree.
> The discards now happen in the lowest-logical-offset-first order.
> 
> ** Locking notes **
> 
> With the introduction of rbtree to maintain inode PAs, we can't use RCU
> to walk the tree for searching since it can result in partial traversals
> which might miss some nodes(or entire subtrees) while discards happen
> in parallel (which happens under a lock).  Hence this patch converts the
> ei->i_prealloc_lock spin_lock to rw_lock.
> 
> Almost all the codepaths that read/modify the PA rbtrees are protected
> by the higher level inode->i_data_sem (except
> ext4_mb_discard_group_preallocations() and ext4_clear_inode()) IIUC, the
> only place we need lock protection is when one thread is reading
> "searching" the PA rbtree (earlier protected under rcu_read_lock()) and
> another is "deleting" the PAs in ext4_mb_discard_group_preallocations()
> function (which iterates all the PAs using the grp->bb_prealloc_list and
> deletes PAs from the tree without taking any inode lock (i_data_sem)).
> 
> So, this patch converts all rcu_read_lock/unlock() paths for inode list
> PA to use read_lock() and all places where we were using
> ei->i_prealloc_lock spinlock will now be using write_lock().
> 
> Note that this makes the fast path (searching of the right PA e.g.
> ext4_mb_use_preallocated() or ext4_mb_normalize_request()), now use
> read_lock() instead of rcu_read_lock/unlock().  Ths also will now block
> due to slow discard path (ext4_mb_discard_group_preallocations()) which
> uses write_lock().
> 
> But this is not as bad as it looks. This is because -
> 
> 1. The slow path only occurs when the normal allocation failed and we
>    can say that we are low on disk space.  One can argue this scenario
>    won't be much frequent.
> 
> 2. ext4_mb_discard_group_preallocations(), locks and unlocks the rwlock
>    for deleting every individual PA.  This gives enough opportunity for
>    the fast path to acquire the read_lock for searching the PA inode
>    list.
> 
> ** Design changes around deleted PAs **
> 
> In ext4_mb_adjust_overlap(), it is possible for an allocating thread to
> come across a PA that is marked deleted via
> ext4_mb_discard_group_preallocations() but not yet removed from the
> inode PA rbtree. In such a case, we ignore any overlaps with this PA
> node and simply move forward in the rbtree by comparing logical start of
> to-be-inserted PA and the deleted PA node.
> 
> Although this usually doesn't cause an issue and we can move forward in
> the tree, in one speacial case, i.e if range of deleted PA lies
> completely inside the normalized range, we might require to travese both
> the sub-trees under such a deleted PA.
> 
> To simplify this special scenario and also as an optimization, undelete
> the PA If the allocating thread determines that this PA might be needed
> in the near future. This results in the following changes:
> 
> - ext4_mb_use_preallocated(): Use a deleted PA if original request lies in it.
> - ext4_mb_pa_adjust_overlap(): Undelete a PA if it is deleted but there
> 		is an overlap with the normalized range.
> - ext4_mb_discard_group_preallocations(): Rollback delete operation if
> 		allocation path undeletes a PA before it is erased from inode PA
> 		list.
> 
> Since this covers the special case we discussed above, we will always
> un-delete the PA when we encounter the special case and we can then
> adjust for overlap and traverse the PA rbtree without any issues.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

So I find this putting back of already deleted inode PA very fragile. For
example in current code I suspect you've missed a case in ext4_mb_put_pa()
which can mark inode PA (so it can then be spotted by
ext4_mb_pa_adjust_overlap() and marked as in use again) but
ext4_mb_put_pa() still goes on and destroys the PA.

So I'd really love to stay with the invariant that once PA is marked as
deleted, it can never go alive again. Since finding such deleted PA that is
overlapping our new range should be really rare, cannot we just make
ext4_mb_pa_adjust_overlap() rb_erase() this deleted PA and restart the
adjustment search? Since rb_erase() is not safe to be called twice, we'd
have to record somewhere in the PA that the erasure has already happened
(probably we could have two flags in 'deleted' field - deleted from group
list, deleted from object (lg_list/inode_node)) but that is still much more
robust...

								Honza

> ---
>  fs/ext4/ext4.h    |   4 +-
>  fs/ext4/mballoc.c | 239 ++++++++++++++++++++++++++++++++++------------
>  fs/ext4/mballoc.h |   6 +-
>  fs/ext4/super.c   |   4 +-
>  4 files changed, 183 insertions(+), 70 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 140e1eb300d1..fad5f087e4c6 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1120,8 +1120,8 @@ struct ext4_inode_info {
>  
>  	/* mballoc */
>  	atomic_t i_prealloc_active;
> -	struct list_head i_prealloc_list;
> -	spinlock_t i_prealloc_lock;
> +	struct rb_root i_prealloc_node;
> +	rwlock_t i_prealloc_lock;
>  
>  	/* extents status tree */
>  	struct ext4_es_tree i_es_tree;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 53c4efd34d1c..85598079b7ce 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3984,6 +3984,44 @@ static void ext4_mb_normalize_group_request(struct ext4_allocation_context *ac)
>  	mb_debug(sb, "goal %u blocks for locality group\n", ac->ac_g_ex.fe_len);
>  }
>  
> +static void ext4_mb_mark_pa_inuse(struct super_block *sb,
> +				    struct ext4_prealloc_space *pa)
> +{
> +	struct ext4_inode_info *ei;
> +
> +	if (pa->pa_deleted == 0) {
> +		ext4_warning(
> +			sb, "pa already inuse, type:%d, pblk:%llu, lblk:%u, len:%d\n",
> +			pa->pa_type, pa->pa_pstart, pa->pa_lstart, pa->pa_len);
> +		return;
> +	}
> +
> +	pa->pa_deleted = 0;
> +
> +	if (pa->pa_type == MB_INODE_PA) {
> +		ei = EXT4_I(pa->pa_inode);
> +		atomic_inc(&ei->i_prealloc_active);
> +	}
> +}
> +
> +/*
> + * This function returns the next element to look at during inode
> + * PA rbtree walk. We assume that we have held the inode PA rbtree lock
> + * (ei->i_prealloc_lock)
> + *
> + * new_start	The start of the range we want to compare
> + * cur_start	The existing start that we are comparing against
> + * node	The node of the rb_tree
> + */
> +static inline struct rb_node*
> +ext4_mb_pa_rb_next_iter(ext4_lblk_t new_start, ext4_lblk_t cur_start, struct rb_node *node)
> +{
> +	if (new_start < cur_start)
> +		return node->rb_left;
> +	else
> +		return node->rb_right;
> +}
> +
>  static inline void
>  ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>  			  ext4_lblk_t start, ext4_lblk_t end)
> @@ -3992,27 +4030,31 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_prealloc_space *tmp_pa;
>  	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> +	struct rb_node *iter;
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> -		spin_lock(&tmp_pa->pa_lock);
> -		if (tmp_pa->pa_deleted == 0) {
> -			tmp_pa_start = tmp_pa->pa_lstart;
> -			tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +	read_lock(&ei->i_prealloc_lock);
> +	iter = ei->i_prealloc_node.rb_node;
> +	while (iter) {
> +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
> +				  pa_node.inode_node);
> +		tmp_pa_start = tmp_pa->pa_lstart;
> +		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
>  
> +		spin_lock(&tmp_pa->pa_lock);
> +		if (tmp_pa->pa_deleted == 0)
>  			BUG_ON(!(start >= tmp_pa_end || end <= tmp_pa_start));
> -		}
>  		spin_unlock(&tmp_pa->pa_lock);
> +
> +		iter = ext4_mb_pa_rb_next_iter(start, tmp_pa_start, iter);
>  	}
> -	rcu_read_unlock();
> +	read_unlock(&ei->i_prealloc_lock);
>  }
> -
>  /*
>   * Given an allocation context "ac" and a range "start", "end", check
>   * and adjust boundaries if the range overlaps with any of the existing
>   * preallocatoins stored in the corresponding inode of the allocation context.
>   *
> - *Parameters:
> + * Parameters:
>   *	ac			allocation context
>   *	start			start of the new range
>   *	end			end of the new range
> @@ -4024,6 +4066,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_prealloc_space *tmp_pa;
> +	struct rb_node *iter;
>  	ext4_lblk_t new_start, new_end;
>  	ext4_lblk_t tmp_pa_start, tmp_pa_end;
>  
> @@ -4031,25 +4074,40 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  	new_end = *end;
>  
>  	/* check we don't cross already preallocated blocks */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> -		if (tmp_pa->pa_deleted)
> -			continue;
> -		spin_lock(&tmp_pa->pa_lock);
> -		if (tmp_pa->pa_deleted) {
> -			spin_unlock(&tmp_pa->pa_lock);
> -			continue;
> -		}
> +	read_lock(&ei->i_prealloc_lock);
> +	for (iter = ei->i_prealloc_node.rb_node; iter;
> +	     iter = ext4_mb_pa_rb_next_iter(new_start, tmp_pa_start, iter)) {
> +		int is_overlap;
>  
> +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
> +				  pa_node.inode_node);
>  		tmp_pa_start = tmp_pa->pa_lstart;
>  		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
> +		is_overlap = !(tmp_pa_start >= new_end || tmp_pa_end <= new_start);
> +
> +		spin_lock(&tmp_pa->pa_lock);
> +		if (tmp_pa->pa_deleted) {
> +			if (is_overlap) {
> +				/*
> +				 * Normalized range overlaps with range of this
> +				 * deleted PA, that means we might need it in
> +				 * near future. Since the PA is yet to be
> +				 * removed from inode PA tree and freed, lets
> +				 * just undelete it.
> +				 */
> +				ext4_mb_mark_pa_inuse(ac->ac_sb, tmp_pa);
> +			} else {
> +				spin_unlock(&tmp_pa->pa_lock);
> +				continue;
> +			}
> +		}
>  
>  		/* PA must not overlap original request */
>  		BUG_ON(!(ac->ac_o_ex.fe_logical >= tmp_pa_end ||
>  			ac->ac_o_ex.fe_logical < tmp_pa_start));
>  
>  		/* skip PAs this normalized request doesn't overlap with */
> -		if (tmp_pa_start >= new_end || tmp_pa_end <= new_start) {
> +		if (!is_overlap) {
>  			spin_unlock(&tmp_pa->pa_lock);
>  			continue;
>  		}
> @@ -4065,7 +4123,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
>  		}
>  		spin_unlock(&tmp_pa->pa_lock);
>  	}
> -	rcu_read_unlock();
> +	read_unlock(&ei->i_prealloc_lock);
>  
>  	/* XXX: extra loop to check we really don't overlap preallocations */
>  	ext4_mb_pa_assert_overlap(ac, new_start, new_end);
> @@ -4192,7 +4250,6 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	ext4_mb_pa_adjust_overlap(ac, &start, &end);
>  
>  	size = end - start;
> -
>  	/*
>  	 * In this function "start" and "size" are normalized for better
>  	 * alignment and length such that we could preallocate more blocks.
> @@ -4401,6 +4458,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	struct ext4_locality_group *lg;
>  	struct ext4_prealloc_space *tmp_pa, *cpa = NULL;
>  	ext4_lblk_t tmp_pa_start, tmp_pa_end;
> +	struct rb_node *iter;
>  	ext4_fsblk_t goal_block;
>  
>  	/* only data can be preallocated */
> @@ -4408,14 +4466,17 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  		return false;
>  
>  	/* first, try per-file preallocation */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(tmp_pa, &ei->i_prealloc_list, pa_node.inode_list) {
> +	read_lock(&ei->i_prealloc_lock);
> +	for (iter = ei->i_prealloc_node.rb_node; iter;
> +	     iter = ext4_mb_pa_rb_next_iter(ac->ac_o_ex.fe_logical, tmp_pa_start, iter)) {
> +		tmp_pa = rb_entry(iter, struct ext4_prealloc_space, pa_node.inode_node);
>  
>  		/* all fields in this condition don't change,
>  		 * so we can skip locking for them */
>  		tmp_pa_start = tmp_pa->pa_lstart;
>  		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
>  
> +		/* original request start doesn't lie in this PA */
>  		if (ac->ac_o_ex.fe_logical < tmp_pa_start ||
>  		    ac->ac_o_ex.fe_logical >= tmp_pa_end)
>  			continue;
> @@ -4433,17 +4494,25 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  
>  		/* found preallocated blocks, use them */
>  		spin_lock(&tmp_pa->pa_lock);
> -		if (tmp_pa->pa_deleted == 0 && tmp_pa->pa_free) {
> +		if (tmp_pa->pa_free) {
> +			if (tmp_pa->pa_deleted == 1) {
> +				/*
> +				 * Since PA is yet to be deleted from inode PA
> +				 * rbtree, just undelete it and use it.
> +				 */
> +				ext4_mb_mark_pa_inuse(ac->ac_sb, tmp_pa);
> +			}
> +
>  			atomic_inc(&tmp_pa->pa_count);
>  			ext4_mb_use_inode_pa(ac, tmp_pa);
>  			spin_unlock(&tmp_pa->pa_lock);
>  			ac->ac_criteria = 10;
> -			rcu_read_unlock();
> +			read_unlock(&ei->i_prealloc_lock);
>  			return true;
>  		}
>  		spin_unlock(&tmp_pa->pa_lock);
>  	}
> -	rcu_read_unlock();
> +	read_unlock(&ei->i_prealloc_lock);
>  
>  	/* can we use group allocation? */
>  	if (!(ac->ac_flags & EXT4_MB_HINT_GROUP_ALLOC))
> @@ -4596,6 +4665,7 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
>  {
>  	ext4_group_t grp;
>  	ext4_fsblk_t grp_blk;
> +	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>  
>  	/* in this short window concurrent discard can set pa_deleted */
>  	spin_lock(&pa->pa_lock);
> @@ -4641,16 +4711,41 @@ static void ext4_mb_put_pa(struct ext4_allocation_context *ac,
>  	ext4_unlock_group(sb, grp);
>  
>  	if (pa->pa_type == MB_INODE_PA) {
> -		spin_lock(pa->pa_node_lock.inode_lock);
> -		list_del_rcu(&pa->pa_node.inode_list);
> -		spin_unlock(pa->pa_node_lock.inode_lock);
> +		write_lock(pa->pa_node_lock.inode_lock);
> +		rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
> +		write_unlock(pa->pa_node_lock.inode_lock);
> +		ext4_mb_pa_free(pa);
>  	} else {
>  		spin_lock(pa->pa_node_lock.lg_lock);
>  		list_del_rcu(&pa->pa_node.lg_list);
>  		spin_unlock(pa->pa_node_lock.lg_lock);
> +		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
>  	}
> +}
>  
> -	call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
> +static void ext4_mb_pa_rb_insert(struct rb_root *root, struct rb_node *new)
> +{
> +	struct rb_node **iter = &root->rb_node, *parent = NULL;
> +	struct ext4_prealloc_space *iter_pa, *new_pa;
> +	ext4_lblk_t iter_start, new_start;
> +
> +	while (*iter) {
> +		iter_pa = rb_entry(*iter, struct ext4_prealloc_space,
> +				   pa_node.inode_node);
> +		new_pa = rb_entry(new, struct ext4_prealloc_space,
> +				   pa_node.inode_node);
> +		iter_start = iter_pa->pa_lstart;
> +		new_start = new_pa->pa_lstart;
> +
> +		parent = *iter;
> +		if (new_start < iter_start)
> +			iter = &((*iter)->rb_left);
> +		else
> +			iter = &((*iter)->rb_right);
> +	}
> +
> +	rb_link_node(new, parent, iter);
> +	rb_insert_color(new, root);
>  }
>  
>  /*
> @@ -4716,7 +4811,6 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  	pa->pa_len = ac->ac_b_ex.fe_len;
>  	pa->pa_free = pa->pa_len;
>  	spin_lock_init(&pa->pa_lock);
> -	INIT_LIST_HEAD(&pa->pa_node.inode_list);
>  	INIT_LIST_HEAD(&pa->pa_group_list);
>  	pa->pa_deleted = 0;
>  	pa->pa_type = MB_INODE_PA;
> @@ -4736,9 +4830,9 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  
>  	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
>  
> -	spin_lock(pa->pa_node_lock.inode_lock);
> -	list_add_rcu(&pa->pa_node.inode_list, &ei->i_prealloc_list);
> -	spin_unlock(pa->pa_node_lock.inode_lock);
> +	write_lock(pa->pa_node_lock.inode_lock);
> +	ext4_mb_pa_rb_insert(&ei->i_prealloc_node, &pa->pa_node.inode_node);
> +	write_unlock(pa->pa_node_lock.inode_lock);
>  	atomic_inc(&ei->i_prealloc_active);
>  }
>  
> @@ -4904,6 +4998,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  	struct ext4_prealloc_space *pa, *tmp;
>  	struct list_head list;
>  	struct ext4_buddy e4b;
> +	struct ext4_inode_info *ei;
>  	int err;
>  	int free = 0;
>  
> @@ -4967,18 +5062,45 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  			list_del_rcu(&pa->pa_node.lg_list);
>  			spin_unlock(pa->pa_node_lock.lg_lock);
>  		} else {
> -			spin_lock(pa->pa_node_lock.inode_lock);
> -			list_del_rcu(&pa->pa_node.inode_list);
> -			spin_unlock(pa->pa_node_lock.inode_lock);
> +			/*
> +			 * The allocation path might undelete a PA
> +			 * incase it expects it to be used again in near
> +			 * future. In that case, rollback the ongoing delete
> +			 * operation and don't remove the PA from inode PA
> +			 * tree.
> +			 *
> +			 * TODO: See if we need pa_lock since there might no
> +			 * path that contends with it once the rbtree writelock
> +			 * is taken.
> +			 */
> +			write_lock(pa->pa_node_lock.inode_lock);
> +			spin_lock(&pa->pa_lock);
> +			if (pa->pa_deleted == 0) {
> +				free -= pa->pa_free;
> +				list_add(&pa->pa_group_list,
> +					 &grp->bb_prealloc_list);
> +				list_del(&pa->u.pa_tmp_list);
> +
> +				spin_unlock(&pa->pa_lock);
> +				write_unlock(pa->pa_node_lock.inode_lock);
> +				continue;
> +			}
> +			spin_unlock(&pa->pa_lock);
> +
> +			ei = EXT4_I(pa->pa_inode);
> +			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
> +			write_unlock(pa->pa_node_lock.inode_lock);
>  		}
>  
> -		if (pa->pa_type == MB_GROUP_PA)
> +		list_del(&pa->u.pa_tmp_list);
> +
> +		if (pa->pa_type == MB_GROUP_PA) {
>  			ext4_mb_release_group_pa(&e4b, pa);
> -		else
> +			call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
> +		} else {
>  			ext4_mb_release_inode_pa(&e4b, bitmap_bh, pa);
> -
> -		list_del(&pa->u.pa_tmp_list);
> -		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
> +			ext4_mb_pa_free(pa);
> +		}
>  	}
>  
>  	ext4_unlock_group(sb, group);
> @@ -5008,6 +5130,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  	ext4_group_t group = 0;
>  	struct list_head list;
>  	struct ext4_buddy e4b;
> +	struct rb_node *iter;
>  	int err;
>  
>  	if (!S_ISREG(inode->i_mode)) {
> @@ -5030,17 +5153,18 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  
>  repeat:
>  	/* first, collect all pa's in the inode */
> -	spin_lock(&ei->i_prealloc_lock);
> -	while (!list_empty(&ei->i_prealloc_list) && needed) {
> -		pa = list_entry(ei->i_prealloc_list.prev,
> -				struct ext4_prealloc_space, pa_node.inode_list);
> +	write_lock(&ei->i_prealloc_lock);
> +	for (iter = rb_first(&ei->i_prealloc_node); iter && needed; iter = rb_next(iter)) {
> +		pa = rb_entry(iter, struct ext4_prealloc_space,
> +				pa_node.inode_node);
>  		BUG_ON(pa->pa_node_lock.inode_lock != &ei->i_prealloc_lock);
> +
>  		spin_lock(&pa->pa_lock);
>  		if (atomic_read(&pa->pa_count)) {
>  			/* this shouldn't happen often - nobody should
>  			 * use preallocation while we're discarding it */
>  			spin_unlock(&pa->pa_lock);
> -			spin_unlock(&ei->i_prealloc_lock);
> +			write_unlock(&ei->i_prealloc_lock);
>  			ext4_msg(sb, KERN_ERR,
>  				 "uh-oh! used pa while discarding");
>  			WARN_ON(1);
> @@ -5051,7 +5175,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  		if (pa->pa_deleted == 0) {
>  			ext4_mb_mark_pa_deleted(sb, pa);
>  			spin_unlock(&pa->pa_lock);
> -			list_del_rcu(&pa->pa_node.inode_list);
> +			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
>  			list_add(&pa->u.pa_tmp_list, &list);
>  			needed--;
>  			continue;
> @@ -5059,7 +5183,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  
>  		/* someone is deleting pa right now */
>  		spin_unlock(&pa->pa_lock);
> -		spin_unlock(&ei->i_prealloc_lock);
> +		write_unlock(&ei->i_prealloc_lock);
>  
>  		/* we have to wait here because pa_deleted
>  		 * doesn't mean pa is already unlinked from
> @@ -5076,7 +5200,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  		schedule_timeout_uninterruptible(HZ);
>  		goto repeat;
>  	}
> -	spin_unlock(&ei->i_prealloc_lock);
> +	write_unlock(&ei->i_prealloc_lock);
>  
>  	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
>  		BUG_ON(pa->pa_type != MB_INODE_PA);
> @@ -5108,7 +5232,7 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  		put_bh(bitmap_bh);
>  
>  		list_del(&pa->u.pa_tmp_list);
> -		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
> +		ext4_mb_pa_free(pa);
>  	}
>  }
>  
> @@ -5482,7 +5606,6 @@ static void ext4_mb_trim_inode_pa(struct inode *inode)
>  static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>  {
>  	struct inode *inode = ac->ac_inode;
> -	struct ext4_inode_info *ei = EXT4_I(inode);
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>  	struct ext4_prealloc_space *pa = ac->ac_pa;
>  	if (pa) {
> @@ -5509,16 +5632,6 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
>  			}
>  		}
>  
> -		if (pa->pa_type == MB_INODE_PA) {
> -			/*
> -			 * treat per-inode prealloc list as a lru list, then try
> -			 * to trim the least recently used PA.
> -			 */
> -			spin_lock(pa->pa_node_lock.inode_lock);
> -			list_move(&pa->pa_node.inode_list, &ei->i_prealloc_list);
> -			spin_unlock(pa->pa_node_lock.inode_lock);
> -		}
> -
>  		ext4_mb_put_pa(ac, ac->ac_sb, pa);
>  	}
>  	if (ac->ac_bitmap_page)
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 398a6688c341..f8e8ee493867 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -115,7 +115,7 @@ struct ext4_free_data {
>  
>  struct ext4_prealloc_space {
>  	union {
> -		struct list_head	inode_list; /* for inode PAs */
> +		struct rb_node	inode_node;		/* for inode PA rbtree */
>  		struct list_head	lg_list;	/* for lg PAs */
>  	} pa_node;
>  	struct list_head	pa_group_list;
> @@ -132,10 +132,10 @@ struct ext4_prealloc_space {
>  	ext4_grpblk_t		pa_free;	/* how many blocks are free */
>  	unsigned short		pa_type;	/* pa type. inode or group */
>  	union {
> -		spinlock_t		*inode_lock;	/* locks the inode list holding this PA */
> +		rwlock_t		*inode_lock;	/* locks the rbtree holding this PA */
>  		spinlock_t		*lg_lock;	/* locks the lg list holding this PA */
>  	} pa_node_lock;
> -	struct inode		*pa_inode;	/* hack, for history only */
> +	struct inode		*pa_inode;	/* used to get the inode during group discard */
>  };
>  
>  enum {
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 72ead3b56706..5fb3e401de6b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1325,9 +1325,9 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>  	inode_set_iversion(&ei->vfs_inode, 1);
>  	ei->i_flags = 0;
>  	spin_lock_init(&ei->i_raw_lock);
> -	INIT_LIST_HEAD(&ei->i_prealloc_list);
> +	ei->i_prealloc_node = RB_ROOT;
>  	atomic_set(&ei->i_prealloc_active, 0);
> -	spin_lock_init(&ei->i_prealloc_lock);
> +	rwlock_init(&ei->i_prealloc_lock);
>  	ext4_es_init_tree(&ei->i_es_tree);
>  	rwlock_init(&ei->i_es_lock);
>  	INIT_LIST_HEAD(&ei->i_es_list);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FA54A839E
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Feb 2022 13:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346392AbiBCMOM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Feb 2022 07:14:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37908 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiBCMOL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Feb 2022 07:14:11 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F91F21135;
        Thu,  3 Feb 2022 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643890450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=By3IobQMS9IJ6uTZBKicE8Rr6bSuk+u6LHiKh8A+7fE=;
        b=jaeK6Bal59ctmc1KDXhvK8ee3smz1y18HHCcU8rTKgFeC/TVfDSgF+OMF3/rcybJcmRT/m
        is7nJQbzIgmqGuFCE6aNMn9Cpq1AeO71Ia303RueRDMSyCLXXrc3OEAjDWZW8cIoFES+7F
        xDEVXbDQcDed00c5d93H1hhUZtOJoco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643890450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=By3IobQMS9IJ6uTZBKicE8Rr6bSuk+u6LHiKh8A+7fE=;
        b=FJTm1hVk5DPp0CcvGRvw7pampokBTG4ysyr1RYTsb8va/W48B3aqPK1I7sdriZ5YY3/Bp1
        tV39huOkZ5HTMMAg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5DE74A3B81;
        Thu,  3 Feb 2022 12:14:10 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 20E6EA05B6; Thu,  3 Feb 2022 13:14:07 +0100 (CET)
Date:   Thu, 3 Feb 2022 13:14:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] ext4: remove journal barrier during fast commit
Message-ID: <20220203121407.q5htlemd6fljaptf@quack3.lan>
References: <20220203064659.1438701-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203064659.1438701-1-harshads@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 02-02-22 22:46:59, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> In commit 2729cfdcfa1cc49bef5a90d046fa4a187fdfcc69 ("ext4: use

Just first 12 digits from the commit sha is enough :)

> ext4_journal_start/stop for fast commit transactions"), journal
> barrier was introduced in fast commit path as an intermediate step for
> fast commit API migration. This patch removes the journal barrier to
> improve the fast commit performance. Instead of blocking the entire
> journal before starting the fast commit, this patch only blocks the
> inode that is being committed during a fast commit.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
...
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 3477a16d08ae..16321f89934c 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -106,6 +106,61 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
>  				   GFP_NOFS, type, line);
>  }
>  
> +handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
> +				  int type, int blocks, int rsv_blocks,
> +				  int revoke_creds)
> +{
> +	handle_t *handle;
> +	journal_t *journal;
> +	int err;
> +
> +	trace_ext4_journal_start(inode->i_sb, blocks, rsv_blocks, revoke_creds,
> +				 _RET_IP_);
> +	err = ext4_journal_check_start(inode->i_sb);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	journal = EXT4_SB(inode->i_sb)->s_journal;
> +	if (!journal || (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> +		return ext4_get_nojournal();
> +
> +	handle = jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
> +				     GFP_NOFS, type, line);
> +

Perhaps you could reuse __ext4_journal_start_sb() in the above?

> +	if (test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT)
> +	    && !IS_ERR(handle)
> +	    && !ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE)) {
> +		if (handle->h_ref == 1) {
> +			WARN_ON(handle->h_priv != NULL);
> +			ext4_fc_start_update(handle, inode);
> +			handle->h_priv = inode;
> +			return handle;
> +		}
> +		/*
> +		 * Check if this is a nested transaction that modifies multiple
> +		 * inodes. Such a transaction is fast commit ineligible.
> +		 */
> +		if (handle->h_priv != inode)
> +			ext4_fc_mark_ineligible(inode->i_sb,
> +						EXT4_FC_REASON_TOO_MANY_INODES,
> +						handle);
> +	}

Hum, here you seem to assume that if inode will be modified, we will call
__ext4_journal_start() with that inode. But that is not true. It is
perfectly valid to start a transaction with ext4_journal_start_sb() and
then add inodes to it. ext4_journal_start() is just a convenience helper to
save some boilerplate code you can but don't have to use when starting a
transaction. In particular we can have handles modifying more inodes
without calling ext4_journal_start() for all of them. We also have places
(most notably inode allocation) that definitely modify inodes but start
transaction with ext4_journal_start_sb(). A lot of auditing would be
required to make this approach work and even more to make sure it does not
break in the future.

If I'm reading the code right, what you need to achieve is that buffer
backing raw inode or inode's logical->physical block mapping is not
modified while the fastcommit including that inode is running because it
would corrupt the information being committed. So would not it be enough to
call ext4_fc_start_update() in ext4_map_blocks() once we know that we need
to modify block mapping and similarly in ext4_reserve_inode_write() (which
would need a bit of work to get used universally - fs/ext4/inline.c does
not seem to use it)? In ext4_journal_stop() we can then call
ext4_fc_stop_update() (we could either keep going with the
one-inode-per-handle limitation you have or introduce a list of inodes
attached to a handle). So essentially attaching inode to fastcommit would
rather be similar to jbd2_journal_get_write_access() than a transaction
start. I guess in principle that would work we just have to be careful not
to introduce deadlocks with running fastcommit (so that fastcommit does not
wait for some inode update to finish, owner of the handle with that inode
update waits for some lock, and the lock is held by someone waiting for
fastcommit to finish). So to do that we would need to block all new handle
starts, wait for all inode updates to finish (which essentially means wait
for all handles that modify inodes involved in fastcommit), set
EXT4_STATE_FC_COMMITTING for all involved inodes, unblock handle starts and
then we can go on with the fastcommit and EXT4_STATE_FC_COMMITTING flags
will protect us from inode modifications. This is better than
journal_lock_updates() we have now but I'm not sure this is the improvement
you were looking for ;).

> +
> +	return handle;
> +}
> +
> +/* Stop fast commit update on the inode in this handle, if any. */
> +static void ext4_fc_journal_stop(handle_t *handle)
> +{
> +	if (!handle->h_priv || handle->h_ref > 1)
> +		return;
> +	/*
> +	 * We have an inode and this is the top level __ext4_journal_stop call.
> +	 */
> +	ext4_fc_stop_update(handle);
> +	handle->h_priv = NULL;
> +}
> +
>  int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
>  {
>  	struct super_block *sb;
> @@ -119,11 +174,13 @@ int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
>  
>  	err = handle->h_err;
>  	if (!handle->h_transaction) {
> +		ext4_fc_journal_stop(handle);
>  		rc = jbd2_journal_stop(handle);
>  		return err ? err : rc;
>  	}
>  
>  	sb = handle->h_transaction->t_journal->j_private;
> +	ext4_fc_journal_stop(handle);
>  	rc = jbd2_journal_stop(handle);
>  
>  	if (!err)

Why don't you call ext4_fc_journal_stop() a bit earlier and thus avoid the
two callsites?

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d2a29fc93742..5edac6f6f7d3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5658,7 +5658,6 @@ int ext4_mark_iloc_dirty(handle_t *handle,
>  		put_bh(iloc->bh);
>  		return -EIO;
>  	}
> -	ext4_fc_track_inode(handle, inode);

I'm confused why it is safe to remove this. I mean if a transaction is
modifying multiple inodes you will not track them in fast commit?

>  
>  	if (IS_I_VERSION(inode))
>  		inode_inc_iversion(inode);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d1c4b04e72ab..7cbe0084bb39 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1428,7 +1428,6 @@ static void destroy_inodecache(void)
>  
>  void ext4_clear_inode(struct inode *inode)
>  {
> -	ext4_fc_del(inode);
>  	invalidate_inode_buffers(inode);
>  	clear_inode(inode);
>  	ext4_discard_preallocations(inode, 0);

Is this really safe? What prevents inode reclaim from reclaiming inode
while it is still part of fastcommit?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

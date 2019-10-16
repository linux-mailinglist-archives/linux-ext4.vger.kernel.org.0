Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4097D9BC6
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2019 22:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437153AbfJPU0y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Oct 2019 16:26:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53895 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437132AbfJPU0y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Oct 2019 16:26:54 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9GKQmOQ014347
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 16:26:49 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B003B420458; Wed, 16 Oct 2019 16:26:48 -0400 (EDT)
Date:   Wed, 16 Oct 2019 16:26:48 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 07/13] ext4: track changed files for fast commit
Message-ID: <20191016202648.GG11103@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-8-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001074101.256523-8-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 01, 2019 at 12:40:56AM -0700, Harshad Shirwadkar wrote:
> +void ext4_fc_enqueue_inode(handle_t *handle, struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	tid_t running_txn_tid = get_running_txn_tid(inode->i_sb);

BTW, we don't actually have to call get_running_txn_tid() here.  We
have a handle, which means we know there is a running transaction, so
we can also just do:

	tid_t running_txn_tid = handle->h_transaction->t_id;

> +
> +	if (!ext4_should_fast_commit(inode->i_sb))
> +		return;
> +
> +	spin_lock(&sbi->s_fc_lock);

This is going to be a major lock contention bottleneck.  So we should
move the the write_lock of &ei->i_fc.fc_lock and comparison of
ei->i_fc.fc_tid against running_txn_tid before we try to take the file
system-level s_fc_lock.

> +	if (!sbi->s_fc_eligible) {
> +		spin_unlock(&sbi->s_fc_lock);
> +		return;
> +	}

I'm really not fond the file system level s_fc_eligible; again, I
really think we should have a transaction-level "this transaction is
not eligible for fast commit" flag.  We don't have to be super careful
about locking for this flag anyway, since it only transitions from set
to unset, and here in ext4_fc_enqueue_inode(), it's only an
optimization to avoid doing extra unnecessary work.

> +static inline void
> +ext4_fc_mark_ineligible(struct inode *inode)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	write_lock(&ei->i_fc.fc_lock);
> +	if (sbi->s_journal)
> +		ei->i_fc.fc_tid = sbi->s_journal->j_commit_sequence + 1;

Use get_running_txn_tid() instead?

> +	ei->i_fc.fc_eligible = false;
> +	write_unlock(&ei->i_fc.fc_lock);
> +	spin_lock(&sbi->s_fc_lock);
> +	sbi->s_fc_eligible = false;
> +	spin_unlock(&sbi->s_fc_lock);
> +}
> +

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f230a888eddd..6d2efbd9aba9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -279,6 +280,8 @@ void ext4_evict_inode(struct inode *inode)
>  	if (ext4_inode_is_fast_symlink(inode))
>  		memset(EXT4_I(inode)->i_data, 0, sizeof(EXT4_I(inode)->i_data));
>  	inode->i_size = 0;
> +	ext4_fc_del(inode);
> +	ext4_fc_mark_ineligible(inode);

Why is ext4_fc_mark_ineligible() needed here?

> @@ -326,6 +330,8 @@ void ext4_evict_inode(struct inode *inode)
>  	 * having errors), but we can't free the inode if the mark_dirty
>  	 * fails.
>  	 */
> +	ext4_fc_del(inode);
> +	ext4_fc_mark_ineligible(inode);

Same question here....

> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 442f7ef873fc..a8e23acb5c03 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -987,6 +987,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		err = mnt_want_write_file(filp);
>  		if (err)
>  			return err;
> +		ext4_fc_mark_sb_ineligible(sb);
>  		err = swap_inode_boot_loader(sb, inode);
>  		mnt_drop_write_file(filp);
>  		return err;

I don't think we need to mark the whole file system (transaction) as
ineligible.  We just have to mark the two inodes being marked as
ineligible, no?

> @@ -997,6 +998,8 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		int err = 0, err2 = 0;
>  		ext4_group_t o_group = EXT4_SB(sb)->s_groups_count;
>  
> +		ext4_fc_mark_sb_ineligible(sb);
> +
>  		if (copy_from_user(&n_blocks_count, (__u64 __user *)arg,
>  				   sizeof(__u64))) {
>  			return -EFAULT;

This is the resize ioctl, and this is the one place where we need to
mark the whole transaction as fc ineligible, since some other
subsequent handle might try to allocate blocks or inodes that were
created as the result of EXT4_IOC_RESIZE_FS.

But we shouldn't actually do it here; we should do it whenever we
start a handle that tries to resize the file system, since it is
*that* transaction that we need to make sure is made ineligible.
Otherwise there can be races where we set the flag in sbi, but before
we have a chance to start the handle which does (part of) the resize
operation, it gets cleared because another transaction committed
first.

We similarly need to mark the transaction is ineligible for any
handles created as the result of EXT4_IOC_GROUP_ADD and
EXT4_IOC_GROUP_EXTEND.  (Which are the old/legacy resize ioctl.)

> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index b1e4d359f73b..b995690d73ce 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -513,6 +513,7 @@ int ext4_ext_migrate(struct inode *inode)
>  		 * work to orphan_list_cleanup()
>  		 */
>  		ext4_orphan_del(NULL, tmp_inode);
> +		ext4_fc_del(inode);

This should be tmp_inode, not inode; and I don't think it's needed,
since the tmp inode will never have been fast commit enqueued.

> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 491f9ee4040e..19bc4046658c 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1406,6 +1406,7 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
>  	inode_unlock(ea_inode);
>  
>  	ext4_mark_inode_dirty(handle, ea_inode);
> +	ext4_fc_enqueue_inode(handle, ea_inode);

If we modify an external xattr block, or if we need to create (or
modify the ref count) on an EA inode, we need to disable fast commit
on the inode whose xattrs we are manipulating.  Could you add that
logic, please?

We could add support for writing out the external xattr block to the
fast commit log if it has been modified, but that's a fast commit
change in its journal format.

					- Ted

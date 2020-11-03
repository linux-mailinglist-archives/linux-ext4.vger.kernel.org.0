Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3AD2A4881
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 15:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgKCOqw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 09:46:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:33962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgKCOqs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 09:46:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C30F5ACAE;
        Tue,  3 Nov 2020 14:46:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7FEA31E12FB; Tue,  3 Nov 2020 15:46:46 +0100 (CET)
Date:   Tue, 3 Nov 2020 15:46:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH 03/10] ext4: pass handle to ext4_fc_track_* functions
Message-ID: <20201103144646.GG3440@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-4-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-4-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 31-10-20 13:05:11, Harshad Shirwadkar wrote:
> Use transaction id found in handle->h_transaction->h_tid for tracking
> fast commit updates. This patch also restructures ext4_unlink to make
> handle available inside ext4_unlink for fast commit tracking.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks for the patch. Couple of comments below:

> @@ -4651,8 +4652,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
>  		     FALLOC_FL_INSERT_RANGE))
>  		return -EOPNOTSUPP;
> -	ext4_fc_track_range(inode, offset >> blkbits,
> -			(offset + len - 1) >> blkbits);

Why do you delete the ext4_fc_track_range() call here?

> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 354f81ff819d..5c3af472287a 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -323,15 +323,18 @@ static inline int ext4_fc_is_ineligible(struct super_block *sb)
>   * If enqueue is set, this function enqueues the inode in fast commit list.
>   */
>  static int ext4_fc_track_template(
> -	struct inode *inode, int (*__fc_track_fn)(struct inode *, void *, bool),
> +	handle_t *handle, struct inode *inode,
> +	int (*__fc_track_fn)(struct inode *, void *, bool),
>  	void *args, int enqueue)
>  {
> -	tid_t running_txn_tid;
>  	bool update = false;
>  	struct ext4_inode_info *ei = EXT4_I(inode);
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	tid_t tid = 0;
>  	int ret;
>  
> +	if (ext4_handle_valid(handle) && handle->h_transaction)
> +		tid = handle->h_transaction->t_tid;

The handle->h_transaction check is pointless here. It is always true. And
if you move the tid fetching after the JOURNAL_FAST_COMMIT check below, you
don't need the ext4_handle_valid() check either as fastcommit cannot be
enabled without a journal.

>  	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
>  	    (sbi->s_mount_state & EXT4_FC_REPLAY))
>  		return -EOPNOTSUPP;


> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 5159830dacb8..f3f8bf61072e 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2631,7 +2631,7 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>  		inode_save = inode;
>  		ihold(inode_save);
>  		err = ext4_add_nondir(handle, dentry, &inode);
> -		ext4_fc_track_create(inode_save, dentry);
> +		ext4_fc_track_create(handle, inode_save, dentry);
>  		iput(inode_save);
>  	}
>  	if (handle)
> @@ -2668,7 +2668,7 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
>  		ihold(inode_save);
>  		err = ext4_add_nondir(handle, dentry, &inode);
>  		if (!err)
> -			ext4_fc_track_create(inode_save, dentry);
> +			ext4_fc_track_create(handle, inode_save, dentry);
>  		iput(inode_save);
>  	}

Not directly related to this patch but why do you bother with 'inode_save'
in the above cases? I guess you're afraid by the comment that "inode
reference is consumed by the dentry" but since you have a dentry reference
as well, you can be sure that the inode stays around...

>  	if (handle)
> @@ -2833,7 +2833,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>  		iput(inode);
>  		goto out_retry;
>  	}
> -	ext4_fc_track_create(inode, dentry);
> +	ext4_fc_track_create(handle, inode, dentry);
>  	ext4_inc_count(dir);

And I was also wondering why all the directory tracking functions take both
dentry and the inode. You can fetch inode from a dentry with d_inode()
helper so I don't see a reason for passing it separately. That is, in a
couple of places you call ext4_fc_track_*() before d_instantiate[_new]() so
dentry isn't fully setup yet but there's nothing which prevents you from
calling it after d_instantiate().

The only possible exception to this is the ext4_rename() code. There you
don't have suitable dentry for the link tracking so this would need to
explicitely pass the inode & dentry. But that place can just call a low
level wrapper allowing that. All the other places can use a higher level
function which just takes the dentry.

>  static int ext4_unlink(struct inode *dir, struct dentry *dentry)
>  {
> +	handle_t *handle;
>  	int retval;
>  
>  	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
> @@ -3282,9 +3273,16 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
>  	if (retval)
>  		goto out_trace;
>  
> -	retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry));
> +	handle = ext4_journal_start(dir, EXT4_HT_DIR,
> +				    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
> +	if (IS_ERR(handle)) {
> +		retval = PTR_ERR(handle);
> +		goto out_trace;
> +	}
> +
> +	retval = __ext4_unlink(handle, dir, &dentry->d_name, d_inode(dentry));
>  	if (!retval)
> -		ext4_fc_track_unlink(d_inode(dentry), dentry);
> +		ext4_fc_track_unlink(handle, d_inode(dentry), dentry);
>  #ifdef CONFIG_UNICODE
>  	/* VFS negative dentries are incompatible with Encoding and
>  	 * Case-insensitiveness. Eventually we'll want avoid
> @@ -3295,6 +3293,8 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
>  	if (IS_CASEFOLDED(dir))
>  		d_invalidate(dentry);
>  #endif
> +	if (handle)
> +		ext4_journal_stop(handle);

How could 'handle' be NULL here?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

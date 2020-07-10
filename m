Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8821B045
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jul 2020 09:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgGJHfs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Jul 2020 03:35:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37201 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725966AbgGJHfs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Jul 2020 03:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594366545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqKVAf5oqs3AahdDkoitfNmfzBRovKJWEydRM2ANvXM=;
        b=afYqLVC5oUJa0StWdAfupzzq4v69dpn4LMU3iOz+K1Xa3c/+Y7iCTHC5EwGty+x/FH66Bc
        3SWbg1z57itBFBwcOKVkmZQ10KzUj3oyK/gSCtCVCUEQSt8lOrE8tSNVHqRsoCjtfX4j2I
        sdLMMlYt5oXq3V35JVA/PCFGaJ7TonY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-wnlL8ggiOLWCtMZ-P62X4g-1; Fri, 10 Jul 2020 03:35:41 -0400
X-MC-Unique: wnlL8ggiOLWCtMZ-P62X4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0F85802806;
        Fri, 10 Jul 2020 07:35:40 +0000 (UTC)
Received: from work (unknown [10.40.192.254])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 923BB920EF;
        Fri, 10 Jul 2020 07:35:39 +0000 (UTC)
Date:   Fri, 10 Jul 2020 09:35:36 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: don't BUG on inconsistent journal feature
Message-ID: <20200710073536.gn2c6pcevsa434sb@work>
References: <20200709154104.25917-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709154104.25917-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 09, 2020 at 05:41:04PM +0200, Jan Kara wrote:
> A customer has reported a BUG_ON in ext4_clear_journal_err() hitting
> during an LTP testing. Either this has been caused by a test setup
> issue where the filesystem was being overwritten while LTP was mounting
> it or the journal replay has overwritten the superblock with invalid
> data. In either case it is preferable we don't take the machine down
> with a BUG_ON. So handle the situation of unexpectedly missing
> has_journal feature more gracefully. We issue warning and fail the mount
> in the cases where the race window is narrow and the failed check is
> most likely a programming error. In cases where fs corruption is more
> likely, we do full ext4_error() handling before failing mount / remount.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 66 ++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957ed1f05..2c8f74f741f4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -66,10 +66,10 @@ static int ext4_load_journal(struct super_block *, struct ext4_super_block *,
>  			     unsigned long journal_devnum);
>  static int ext4_show_options(struct seq_file *seq, struct dentry *root);
>  static int ext4_commit_super(struct super_block *sb, int sync);
> -static void ext4_mark_recovery_complete(struct super_block *sb,
> +static int ext4_mark_recovery_complete(struct super_block *sb,
>  					struct ext4_super_block *es);
> -static void ext4_clear_journal_err(struct super_block *sb,
> -				   struct ext4_super_block *es);
> +static int ext4_clear_journal_err(struct super_block *sb,
> +				  struct ext4_super_block *es);
>  static int ext4_sync_fs(struct super_block *sb, int wait);
>  static int ext4_remount(struct super_block *sb, int *flags, char *data);
>  static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
> @@ -4770,7 +4770,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
>  	if (needs_recovery) {
>  		ext4_msg(sb, KERN_INFO, "recovery complete");
> -		ext4_mark_recovery_complete(sb, es);
> +		err = ext4_mark_recovery_complete(sb, es);
> +		if (err)
> +			goto failed_mount8;

failed_mount8 is in #ifdef CONFIG_QUOTA so it probably needs to be moved
out of the ifdef block.

Other than that it looks good to me, so with that change you can add

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks!
-Lukas

>  	}
>  	if (EXT4_SB(sb)->s_journal) {
>  		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
> @@ -4956,7 +4958,8 @@ static journal_t *ext4_get_journal(struct super_block *sb,
>  	struct inode *journal_inode;
>  	journal_t *journal;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> +		return NULL;
>  
>  	journal_inode = ext4_get_journal_inode(sb, journal_inum);
>  	if (!journal_inode)
> @@ -4986,7 +4989,8 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
>  	struct ext4_super_block *es;
>  	struct block_device *bdev;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> +		return NULL;
>  
>  	bdev = ext4_blkdev_get(j_dev, sb);
>  	if (bdev == NULL)
> @@ -5078,7 +5082,8 @@ static int ext4_load_journal(struct super_block *sb,
>  	int err = 0;
>  	int really_read_only;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> +		return -EFSCORRUPTED;
>  
>  	if (journal_devnum &&
>  	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
> @@ -5148,7 +5153,12 @@ static int ext4_load_journal(struct super_block *sb,
>  	}
>  
>  	EXT4_SB(sb)->s_journal = journal;
> -	ext4_clear_journal_err(sb, es);
> +	err = ext4_clear_journal_err(sb, es);
> +	if (err) {
> +		EXT4_SB(sb)->s_journal = NULL;
> +		jbd2_journal_destroy(journal);
> +		return err;
> +	}
>  
>  	if (!really_read_only && journal_devnum &&
>  	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
> @@ -5244,26 +5254,32 @@ static int ext4_commit_super(struct super_block *sb, int sync)
>   * remounting) the filesystem readonly, then we will end up with a
>   * consistent fs on disk.  Record that fact.
>   */
> -static void ext4_mark_recovery_complete(struct super_block *sb,
> -					struct ext4_super_block *es)
> +static int ext4_mark_recovery_complete(struct super_block *sb,
> +				       struct ext4_super_block *es)
>  {
> +	int err;
>  	journal_t *journal = EXT4_SB(sb)->s_journal;
>  
>  	if (!ext4_has_feature_journal(sb)) {
> -		BUG_ON(journal != NULL);
> -		return;
> +		if (journal != NULL) {
> +			ext4_error(sb, "Journal got removed while the fs was "
> +				   "mounted!");
> +			return -EFSCORRUPTED;
> +		}
> +		return 0;
>  	}
>  	jbd2_journal_lock_updates(journal);
> -	if (jbd2_journal_flush(journal) < 0)
> +	err = jbd2_journal_flush(journal);
> +	if (err < 0)
>  		goto out;
>  
>  	if (ext4_has_feature_journal_needs_recovery(sb) && sb_rdonly(sb)) {
>  		ext4_clear_feature_journal_needs_recovery(sb);
>  		ext4_commit_super(sb, 1);
>  	}
> -
>  out:
>  	jbd2_journal_unlock_updates(journal);
> +	return err;
>  }
>  
>  /*
> @@ -5271,14 +5287,17 @@ static void ext4_mark_recovery_complete(struct super_block *sb,
>   * has recorded an error from a previous lifetime, move that error to the
>   * main filesystem now.
>   */
> -static void ext4_clear_journal_err(struct super_block *sb,
> +static int ext4_clear_journal_err(struct super_block *sb,
>  				   struct ext4_super_block *es)
>  {
>  	journal_t *journal;
>  	int j_errno;
>  	const char *errstr;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (!ext4_has_feature_journal(sb)) {
> +		ext4_error(sb, "Journal got removed while the fs was mounted!");
> +		return -EFSCORRUPTED;
> +	}
>  
>  	journal = EXT4_SB(sb)->s_journal;
>  
> @@ -5303,6 +5322,7 @@ static void ext4_clear_journal_err(struct super_block *sb,
>  		jbd2_journal_clear_err(journal);
>  		jbd2_journal_update_sb_errno(journal);
>  	}
> +	return 0;
>  }
>  
>  /*
> @@ -5573,8 +5593,13 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  			    (sbi->s_mount_state & EXT4_VALID_FS))
>  				es->s_state = cpu_to_le16(sbi->s_mount_state);
>  
> -			if (sbi->s_journal)
> +			if (sbi->s_journal) {
> +				/*
> +				 * We let remount-ro finish even if marking fs
> +				 * as clean failed...
> +				 */
>  				ext4_mark_recovery_complete(sb, es);
> +			}
>  			if (sbi->s_mmp_tsk)
>  				kthread_stop(sbi->s_mmp_tsk);
>  		} else {
> @@ -5622,8 +5647,11 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  			 * been changed by e2fsck since we originally mounted
>  			 * the partition.)
>  			 */
> -			if (sbi->s_journal)
> -				ext4_clear_journal_err(sb, es);
> +			if (sbi->s_journal) {
> +				err = ext4_clear_journal_err(sb, es);
> +				if (err)
> +					goto restore_opts;
> +			}
>  			sbi->s_mount_state = le16_to_cpu(es->s_state);
>  
>  			err = ext4_setup_super(sb, es, 0);
> -- 
> 2.16.4
> 


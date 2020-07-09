Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C33121A025
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jul 2020 14:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgGIMhF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jul 2020 08:37:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48344 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbgGIMhD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Jul 2020 08:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594298221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=chflHkeu9/+34UfQSK8HKBjbRjDjN1sXIPcAXIQZ+zo=;
        b=CBfb2U+0kZIw1zCFmC/dFIBwAxmoMOP4EVre8O2sl+6QuTPDJKOPtgOQtwh44CdGN27gOf
        +NVs9Zl6vMdSRlqA8RKODpPiFVpuyWLZtvWu7tN8oEz1Sr/O62Ble/1Xu0jE4Ln1qktkQo
        KgCU2Zj7w5SBveVvNEkKAC2Y2KiQ1rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-Rtkt7ZjhMXecWdlmNsPc2w-1; Thu, 09 Jul 2020 08:36:59 -0400
X-MC-Unique: Rtkt7ZjhMXecWdlmNsPc2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D98688015FB;
        Thu,  9 Jul 2020 12:36:58 +0000 (UTC)
Received: from work (unknown [10.40.192.254])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E67E72DE69;
        Thu,  9 Jul 2020 12:36:57 +0000 (UTC)
Date:   Thu, 9 Jul 2020 14:36:55 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: don't BUG on inconsistent journal feature
Message-ID: <20200709123655.y7p7idrqukdi2he5@work>
References: <20200709095854.3651-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709095854.3651-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 09, 2020 at 11:58:54AM +0200, Jan Kara wrote:
> A customer has reported a BUG_ON in ext4_clear_journal_err() hitting
> during an LTP testing. Either this has been caused by a test setup
> issue where the filesystem was being overwritten while LTP was mounting
> it or the journal replay has overwritten the superblock with invalid
> data. In either case it is preferable we don't take the machine down
> with a BUG_ON. So handle the situation of unexpectedly missing
> has_journal feature more gracefully by a WARN_ON_ONCE and bailing out
> with error.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957ed1f05..d8b7222cb86c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -68,8 +68,8 @@ static int ext4_show_options(struct seq_file *seq, struct dentry *root);
>  static int ext4_commit_super(struct super_block *sb, int sync);
>  static void ext4_mark_recovery_complete(struct super_block *sb,
>  					struct ext4_super_block *es);
> -static void ext4_clear_journal_err(struct super_block *sb,
> -				   struct ext4_super_block *es);
> +static int ext4_clear_journal_err(struct super_block *sb,
> +				  struct ext4_super_block *es);
>  static int ext4_sync_fs(struct super_block *sb, int wait);
>  static int ext4_remount(struct super_block *sb, int *flags, char *data);
>  static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
> @@ -4956,7 +4956,8 @@ static journal_t *ext4_get_journal(struct super_block *sb,
>  	struct inode *journal_inode;
>  	journal_t *journal;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> +		return NULL;
>  
>  	journal_inode = ext4_get_journal_inode(sb, journal_inum);
>  	if (!journal_inode)
> @@ -4986,7 +4987,8 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
>  	struct ext4_super_block *es;
>  	struct block_device *bdev;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> +		return NULL;
>  
>  	bdev = ext4_blkdev_get(j_dev, sb);
>  	if (bdev == NULL)
> @@ -5078,7 +5080,8 @@ static int ext4_load_journal(struct super_block *sb,
>  	int err = 0;
>  	int really_read_only;
>  
> -	BUG_ON(!ext4_has_feature_journal(sb));
> +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> +		return -EFSCORRUPTED;
>  
>  	if (journal_devnum &&
>  	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
> @@ -5148,7 +5151,12 @@ static int ext4_load_journal(struct super_block *sb,
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
> @@ -5250,7 +5258,7 @@ static void ext4_mark_recovery_complete(struct super_block *sb,
>  	journal_t *journal = EXT4_SB(sb)->s_journal;
>  
>  	if (!ext4_has_feature_journal(sb)) {
> -		BUG_ON(journal != NULL);
> +		WARN_ON_ONCE(journal != NULL);

Hi Jan,

If this ever happens we will hapily continue with fs operation after
mount, or remount (remount is ro, so that is probably ok ?) without
journal feature, but with s_journal set ? I am not quite sure what the
consequences might be, are you sure this is ok ?

-Lukas

>  		return;
>  	}
>  	jbd2_journal_lock_updates(journal);
> @@ -5271,14 +5279,15 @@ static void ext4_mark_recovery_complete(struct super_block *sb,
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
> +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> +		return -EFSCORRUPTED;
>  
>  	journal = EXT4_SB(sb)->s_journal;
>  
> @@ -5303,6 +5312,7 @@ static void ext4_clear_journal_err(struct super_block *sb,
>  		jbd2_journal_clear_err(journal);
>  		jbd2_journal_update_sb_errno(journal);
>  	}
> +	return 0;
>  }
>  
>  /*
> @@ -5622,8 +5632,11 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
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


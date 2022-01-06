Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348294866E5
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 16:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbiAFPpq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jan 2022 10:45:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47142 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiAFPpp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jan 2022 10:45:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E4FDC1F397;
        Thu,  6 Jan 2022 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641483944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0D8k15AC2kJCmh5/5LxYORIwcshmjlIwNOGY6Usb7qg=;
        b=u/AhkTT+TFkoFbh+H9Hek0uY0UkEyQP+Tvl8EWe2qetVhnVCE3r78qhS9icjmWG2BGOl18
        a+oyb47ekYq3dVeixbzTGE2FfJ4w/3rlyDruS43TxBXPEBcdMYtnXlGbbUoZgvbnGEbG4i
        Ow8bRFloI6AGTvYxAxsxMVCH8mNYNnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641483944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0D8k15AC2kJCmh5/5LxYORIwcshmjlIwNOGY6Usb7qg=;
        b=/rXl3cBETdEc98uNS9XEYrQ0IneAovlBdi4VuG+qxOeEE47VYDmythV+6ISD9+ZyvyobpZ
        UwlC0iMXBdKlWACw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D8088A3B84;
        Thu,  6 Jan 2022 15:45:44 +0000 (UTC)
Received: by localhost (Postfix, from userid 1000)
        id 95DBDA0856; Thu,  6 Jan 2022 11:57:49 +0100 (CET)
Date:   Thu, 6 Jan 2022 11:57:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lczerner@redhat.com, jack@suse.cz
Subject: Re: [PATCH] ext4: don't use the orphan list when migrating an inode
Message-ID: <20220106105749.xldggivlpey3itlz@quack3.lan>
References: <20220106050505.474719-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106050505.474719-1-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 06-01-22 00:05:05, Theodore Ts'o wrote:
> We probably want to remove the indirect block to extents migration
> feature after a deprecation window, but until then, let's fix a
> potential data loss problem caused by the fact that we put the
> tmp_inode on the orphan list.  In the unlikely case where we crash and
> do a journal recovery, the data blocks belonging to the inode inode
> being migrated are also represented in the tmp_inode on the orphan
> list --- and so its data blocks will get marked unallocated, and
> available for reuse.
> 
> Instead, we stop putting the tmp_inode on the oprhan list.  So in the
> case where we crash while migrating the inode, we'll leak an inode,
> which is not a disaster.  It will be easily fixed the next time we run
> fsck, and it's better than potentially having blocks getting claimed
> by two different files, and losing data as a result.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/migrate.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index 36dfc88ce05b..ff8916e1d38e 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -437,12 +437,12 @@ int ext4_ext_migrate(struct inode *inode)
>  	percpu_down_write(&sbi->s_writepages_rwsem);
>  
>  	/*
> -	 * Worst case we can touch the allocation bitmaps, a bgd
> -	 * block, and a block to link in the orphan list.  We do need
> -	 * need to worry about credits for modifying the quota inode.
> +	 * Worst case we can touch the allocation bitmaps and a block
> +	 * group descriptor block.  We do need need to worry about
> +	 * credits for modifying the quota inode.
>  	 */
>  	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE,
> -		4 + EXT4_MAXQUOTAS_TRANS_BLOCKS(inode->i_sb));
> +		3 + EXT4_MAXQUOTAS_TRANS_BLOCKS(inode->i_sb));
>  
>  	if (IS_ERR(handle)) {
>  		retval = PTR_ERR(handle);
> @@ -463,10 +463,6 @@ int ext4_ext_migrate(struct inode *inode)
>  	 * Use the correct seed for checksum (i.e. the seed from 'inode').  This
>  	 * is so that the metadata blocks will have the correct checksum after
>  	 * the migration.
> -	 *
> -	 * Note however that, if a crash occurs during the migration process,
> -	 * the recovery process is broken because the tmp_inode checksums will
> -	 * be wrong and the orphans cleanup will fail.
>  	 */
>  	ei = EXT4_I(inode);
>  	EXT4_I(tmp_inode)->i_csum_seed = ei->i_csum_seed;
> @@ -478,7 +474,6 @@ int ext4_ext_migrate(struct inode *inode)
>  	clear_nlink(tmp_inode);
>  
>  	ext4_ext_tree_init(handle, tmp_inode);
> -	ext4_orphan_add(handle, tmp_inode);
>  	ext4_journal_stop(handle);
>  
>  	/*
> @@ -503,12 +498,6 @@ int ext4_ext_migrate(struct inode *inode)
>  
>  	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE, 1);
>  	if (IS_ERR(handle)) {
> -		/*
> -		 * It is impossible to update on-disk structures without
> -		 * a handle, so just rollback in-core changes and live other
> -		 * work to orphan_list_cleanup()
> -		 */
> -		ext4_orphan_del(NULL, tmp_inode);
>  		retval = PTR_ERR(handle);
>  		goto out_tmp_inode;
>  	}
> -- 
> 2.31.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

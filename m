Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7324848651B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 14:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiAFNT6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jan 2022 08:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbiAFNT6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jan 2022 08:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641475197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1VC3NszYeeyQ6yGxye/bZ9Wi+jchr9+jRHTDBUck7iI=;
        b=GT9u0SZeh9ys4whWuME4iZ5NR2hgpruZP1iy0LeDAqsD2ut7DsqrNeNGq0M8ZMGGL2aC9B
        YgUvkDCRjjBT1590hflgd3hhBeGKAYmS48eHF7tWAT7q/Ek7dS4yTyM6YGz40riGCrUQa8
        iX0mqoCuGPesGp+sxAgBVT3DeAQOxCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-gZnLDsG7MdGgCRIRwIxnYA-1; Thu, 06 Jan 2022 08:19:54 -0500
X-MC-Unique: gZnLDsG7MdGgCRIRwIxnYA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25FB21006AA4;
        Thu,  6 Jan 2022 13:19:53 +0000 (UTC)
Received: from work (unknown [10.40.194.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE2BC7E668;
        Thu,  6 Jan 2022 13:19:51 +0000 (UTC)
Date:   Thu, 6 Jan 2022 14:19:48 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>, jack@suse.cz
Subject: Re: [PATCH] ext4: don't use the orphan list when migrating an inode
Message-ID: <20220106131948.xlwfs73lfyhe6454@work>
References: <20220106050505.474719-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106050505.474719-1-tytso@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 06, 2022 at 12:05:05AM -0500, Theodore Ts'o wrote:
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

Looks good to me. Thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>


> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
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


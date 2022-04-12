Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A404FDE6A
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Apr 2022 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbiDLLqs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Apr 2022 07:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbiDLLqB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Apr 2022 07:46:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988AE55BC6
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 03:27:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 435E4210E3;
        Tue, 12 Apr 2022 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649759240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rN1MBS9ANLexepDD1aNL9pxt6QGwlejyeQ8C0wWLRLE=;
        b=FrbF3dOLT68XEAT1cOUWr1qFSMjylIgQ06eE0QnfXgPZ3JjzGr5ZjzOhrxpDVc8SLcyZy+
        w2lU8ZIC6mYIVTY7EakthQ26gQRMhQvjJ8i7nS7X4QjcvcLeA+IdqSlcvFFSgiGdlV8CFX
        8vxhcnkPKLN4pIDhCrkpbjl+5csBIM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649759240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rN1MBS9ANLexepDD1aNL9pxt6QGwlejyeQ8C0wWLRLE=;
        b=74tU1CPhHk1R0BZLmDzjzZnZIzhd5C2i5Il9wnARKtmrFQ0wcEPCjodiCYCDX91UCutPdj
        UYBBTJAlWv9GnFDQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2E4C5A3B83;
        Tue, 12 Apr 2022 10:27:20 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AE3F7A0615; Tue, 12 Apr 2022 12:27:16 +0200 (CEST)
Date:   Tue, 12 Apr 2022 12:27:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com,
        yebin10@huawei.com
Subject: Re: [RFC PATCH v2] ext4: convert symlink external data block mapping
 to bdev
Message-ID: <20220412102716.wmsfzbznkmdf3jqi@quack3.lan>
References: <20220412083941.2242143-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412083941.2242143-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hello,

On Tue 12-04-22 16:39:41, Zhang Yi wrote:
> Symlink's external data block is one kind of metadata block, and now
> that almost all ext4 metadata block's page cache (e.g. directory blocks,
> quota blocks...) belongs to bdev backing inode except the symlink. It
> is essentially worked in data=journal mode like other regular file's
> data block because probably in order to make it simple for generic VFS
> code handling symlinks or some other historical reasons, but the logic
> of creating external data block in ext4_symlink() is complicated. and it
> also make things confused if user do not want to let the filesystem
> worked in data=journal mode. This patch convert the final exceptional
> case and make things clean, move the mapping of the symlink's external
> data block to bdev like any other metadata block does.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

I had a closer look into some of the details. See my comments below:

> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index e37da8d5cd0c..fa8002aae829 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3249,6 +3249,32 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
>  	return retval;
>  }
>  
> +static int ext4_init_symlink_block(handle_t *handle, struct inode *inode,
> +				   struct fscrypt_str *disk_link)
> +{
> +	struct buffer_head *bh;
> +	char *kaddr;
> +	int err = 0;
> +
> +	bh = ext4_bread(handle, inode, 0, EXT4_GET_BLOCKS_CREATE);
> +	if (IS_ERR(bh))
> +		return PTR_ERR(bh);

This is now more likely to fail in close-to-ENOSPC conditions because we
don't do the force transaction commit to free blocks & retry dance here
(like we do in ext4_write_begin()). I guess we'd need to implement retry
in the ext4_symlink() to fix this.

> +	BUFFER_TRACE(bh, "get_write_access");
> +	err = ext4_journal_get_write_access(handle, inode->i_sb, bh, EXT4_JTR_NONE);
> +	if (err)
> +		goto out;
> +
> +	kaddr = (char *)bh->b_data;
> +	memcpy(kaddr, disk_link->name, disk_link->len);
> +	inode->i_size = disk_link->len - 1;
> +	EXT4_I(inode)->i_disksize = inode->i_size;
> +	err = ext4_handle_dirty_metadata(handle, inode, bh);
> +out:
> +	brelse(bh);
> +	return err;
> +}
> +
>  static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>  			struct dentry *dentry, const char *symname)
>  {
> @@ -3270,26 +3296,14 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>  	if (err)
>  		return err;
>  
> -	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
> -		/*
> -		 * For non-fast symlinks, we just allocate inode and put it on
> -		 * orphan list in the first transaction => we need bitmap,
> -		 * group descriptor, sb, inode block, quota blocks, and
> -		 * possibly selinux xattr blocks.
> -		 */
> -		credits = 4 + EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
> -			  EXT4_XATTR_TRANS_BLOCKS;
> -	} else {
> -		/*
> -		 * Fast symlink. We have to add entry to directory
> -		 * (EXT4_DATA_TRANS_BLOCKS + EXT4_INDEX_EXTRA_TRANS_BLOCKS),
> -		 * allocate new inode (bitmap, group descriptor, inode block,
> -		 * quota blocks, sb is already counted in previous macros).
> -		 */
> -		credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
> -			  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
> -	}
> -
> +	/*
> +	 * EXT4_INDEX_EXTRA_TRANS_BLOCKS for addition of entry into the
> +	 * directory. +3 for inode, inode bitmap, group descriptor allocation.
> +	 * EXT4_DATA_TRANS_BLOCKS for the data block allocation and
> +	 * modification.
> +	 */
> +	credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
> +		  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
>  	inode = ext4_new_inode_start_handle(mnt_userns, dir, S_IFLNK|S_IRWXUGO,
>  					    &dentry->d_name, 0, NULL,
>  					    EXT4_HT_DIR, credits);
> @@ -3305,73 +3319,52 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>  		if (err)
>  			goto err_drop_inode;
>  		inode->i_op = &ext4_encrypted_symlink_inode_operations;
> +	} else {
> +		if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
> +			inode->i_op = &ext4_symlink_inode_operations;
> +		} else {
> +			inode->i_op = &ext4_fast_symlink_inode_operations;
> +			inode->i_link = (char *)&EXT4_I(inode)->i_data;
> +		}
>  	}
>  
>  	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
> -		if (!IS_ENCRYPTED(inode))
> -			inode->i_op = &ext4_symlink_inode_operations;
> -		inode_nohighmem(inode);
> -		ext4_set_aops(inode);
> -		/*
> -		 * We cannot call page_symlink() with transaction started
> -		 * because it calls into ext4_write_begin() which can wait
> -		 * for transaction commit if we are running out of space
> -		 * and thus we deadlock. So we have to stop transaction now
> -		 * and restart it when symlink contents is written.
> -		 *
> -		 * To keep fs consistent in case of crash, we have to put inode
> -		 * to orphan list in the mean time.
> -		 */
> -		drop_nlink(inode);
> -		err = ext4_orphan_add(handle, inode);
> -		if (handle)
> -			ext4_journal_stop(handle);
> -		handle = NULL;
> +		/* alloc symlink block and fill it */
> +		err = ext4_init_symlink_block(handle, inode, &disk_link);
>  		if (err)
>  			goto err_drop_inode;
> -		err = __page_symlink(inode, disk_link.name, disk_link.len, 1);
> -		if (err)
> -			goto err_drop_inode;
> -		/*
> -		 * Now inode is being linked into dir (EXT4_DATA_TRANS_BLOCKS
> -		 * + EXT4_INDEX_EXTRA_TRANS_BLOCKS), inode is also modified
> -		 */
> -		handle = ext4_journal_start(dir, EXT4_HT_DIR,
> -				EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
> -				EXT4_INDEX_EXTRA_TRANS_BLOCKS + 1);
> -		if (IS_ERR(handle)) {
> -			err = PTR_ERR(handle);
> -			handle = NULL;
> -			goto err_drop_inode;
> -		}
> -		set_nlink(inode, 1);
> -		err = ext4_orphan_del(handle, inode);
> +		err = ext4_mark_inode_dirty(handle, inode);
> +		if (!err)
> +			err = ext4_add_entry(handle, dentry, inode);
>  		if (err)
>  			goto err_drop_inode;
> +
> +		d_instantiate_new(dentry, inode);
> +		if (IS_DIRSYNC(dir))
> +			ext4_handle_sync(handle);
> +		if (handle)
> +			ext4_journal_stop(handle);

Why don't you use ext4_add_nondir() here like in the fastsymlink case? It
would allow sharing more code between the two code paths...

>  	} else {
>  		/* clear the extent format for fast symlink */
>  		ext4_clear_inode_flag(inode, EXT4_INODE_EXTENTS);
> -		if (!IS_ENCRYPTED(inode)) {
> -			inode->i_op = &ext4_fast_symlink_inode_operations;
> -			inode->i_link = (char *)&EXT4_I(inode)->i_data;
> -		}
>  		memcpy((char *)&EXT4_I(inode)->i_data, disk_link.name,
>  		       disk_link.len);
>  		inode->i_size = disk_link.len - 1;
> +		EXT4_I(inode)->i_disksize = inode->i_size;
> +		err = ext4_add_nondir(handle, dentry, &inode);
> +		if (handle)
> +			ext4_journal_stop(handle);
> +		if (inode)
> +			iput(inode);
>  	}
> -	EXT4_I(inode)->i_disksize = inode->i_size;
> -	err = ext4_add_nondir(handle, dentry, &inode);
> -	if (handle)
> -		ext4_journal_stop(handle);
> -	if (inode)
> -		iput(inode);
>  	goto out_free_encrypted_link;
>  
>  err_drop_inode:
> -	if (handle)
> -		ext4_journal_stop(handle);
>  	clear_nlink(inode);
> +	ext4_orphan_add(handle, inode);
>  	unlock_new_inode(inode);
> +	if (handle)
> +		ext4_journal_stop(handle);
>  	iput(inode);
>  out_free_encrypted_link:
>  	if (disk_link.name != (unsigned char *)symname)

...

> @@ -62,6 +65,31 @@ static int ext4_encrypted_symlink_getattr(struct user_namespace *mnt_userns,
>  	return fscrypt_symlink_getattr(path, stat);
>  }
>  
> +static void ext4_free_link(void *bh)
> +{
> +	brelse(bh);
> +}
> +
> +static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
> +				 struct delayed_call *callback)
> +{
> +	struct buffer_head *bh;
> +
> +	if (!dentry)
> +		return ERR_PTR(-ECHILD);

So this essentially means you have disabled RCU walking for symlinks. I
think that needs to be fixed (i.e., in !dentry case you need to check whether
we have the buffer in the cache and provide it if yes).

> +
> +	bh = ext4_bread(NULL, inode, 0, 0);
> +	if (IS_ERR(bh))
> +		return ERR_CAST(bh);
> +	if (!bh) {
> +		EXT4_ERROR_INODE(inode, "bad symlink.");
> +		return ERR_PTR(-EFSCORRUPTED);
> +	}
> +

page_get_link() has here the nd_terminate_link() call so the link is
properly nul-terminated. I don't see anything assuring that in your code
(even for cases where fs gets corrupted or so).

> +	set_delayed_call(callback, ext4_free_link, bh);
> +	return bh->b_data;
> +}
> +
>  const struct inode_operations ext4_encrypted_symlink_inode_operations = {
>  	.get_link	= ext4_encrypted_get_link,
>  	.setattr	= ext4_setattr,

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

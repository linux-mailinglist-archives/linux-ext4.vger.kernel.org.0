Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9E1867EF
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Mar 2020 10:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgCPJcH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Mar 2020 05:32:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:35464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgCPJcH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Mar 2020 05:32:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5E923AD2A;
        Mon, 16 Mar 2020 09:32:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3A6711E10DA; Mon, 16 Mar 2020 10:32:05 +0100 (CET)
Date:   Mon, 16 Mar 2020 10:32:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/7] ext2fs: Update allocation info earlier in
 ext2fs_mkdir() and ext2fs_symlink()
Message-ID: <20200316093205.GE12783@quack2.suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-4-jack@suse.cz>
 <20200308000220.GF99899@mit.edu>
 <20200308022024.GG99899@mit.edu>
 <20200315161509.GQ225435@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315161509.GQ225435@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 15-03-20 12:15:09, Theodore Y. Ts'o wrote:
> Ah, I see now why this patch is needed.  If we don't update the block
> allocation bitmap to indicate block has been taken, and there is a
> need to allocate an htree index block, we will end up allocating the
> same block twice.

Exactly.

> Thanks, I've applied this patch with the following added.

Thanks, that's even better!

								Honza

> 
>      	     	  	     	 	   - Ted
> 
> diff --git a/lib/ext2fs/mkdir.c b/lib/ext2fs/mkdir.c
> index 947003eb..437c8ffc 100644
> --- a/lib/ext2fs/mkdir.c
> +++ b/lib/ext2fs/mkdir.c
> @@ -43,6 +43,7 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
>  	blk64_t			blk;
>  	char			*block = 0;
>  	int			inline_data = 0;
> +	int			drop_refcount = 0;
>  
>  	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
>  
> @@ -149,6 +150,7 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
>  	if (!inline_data)
>  		ext2fs_block_alloc_stats2(fs, blk, +1);
>  	ext2fs_inode_alloc_stats2(fs, ino, +1, 1);
> +	drop_refcount = 1;
>  
>  	/*
>  	 * Link the directory into the filesystem hierarchy
> @@ -181,10 +183,16 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t inum,
>  		if (retval)
>  			goto cleanup;
>  	}
> +	drop_refcount = 0;
>  
>  cleanup:
>  	if (block)
>  		ext2fs_free_mem(&block);
> +	if (drop_refcount) {
> +		if (!inline_data)
> +			ext2fs_block_alloc_stats2(fs, blk, -1);
> +		ext2fs_inode_alloc_stats2(fs, ino, -1, 1);
> +	}
>  	return retval;
>  
>  }
> diff --git a/lib/ext2fs/symlink.c b/lib/ext2fs/symlink.c
> index 3e07a539..a66fb7ec 100644
> --- a/lib/ext2fs/symlink.c
> +++ b/lib/ext2fs/symlink.c
> @@ -54,6 +54,7 @@ errcode_t ext2fs_symlink(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t ino,
>  	int			fastlink, inlinelink;
>  	unsigned int		target_len;
>  	char			*block_buf = 0;
> +	int			drop_refcount = 0;
>  
>  	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
>  
> @@ -168,6 +169,7 @@ need_block:
>  	if (!fastlink && !inlinelink)
>  		ext2fs_block_alloc_stats2(fs, blk, +1);
>  	ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
> +	drop_refcount = 1;
>  
>  	/*
>  	 * Link the symlink into the filesystem hierarchy
> @@ -185,10 +187,16 @@ need_block:
>  		if (retval)
>  			goto cleanup;
>  	}
> +	drop_refcount = 0;
>  
>  cleanup:
>  	if (block_buf)
>  		ext2fs_free_mem(&block_buf);
> +	if (drop_refcount) {
> +		if (!fastlink && !inlinelink)
> +			ext2fs_block_alloc_stats2(fs, blk, -1);
> +		ext2fs_inode_alloc_stats2(fs, ino, -1, 0);
> +	}
>  	return retval;
>  }
>  
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

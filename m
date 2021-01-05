Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0D82EAD5B
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 15:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbhAEO2R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 09:28:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:35602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbhAEO2Q (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Jan 2021 09:28:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6257ACC6;
        Tue,  5 Jan 2021 14:27:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 33B6F1E07FD; Tue,  5 Jan 2021 15:27:34 +0100 (CET)
Date:   Tue, 5 Jan 2021 15:27:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        lihaotian9@huawei.com, lutianxiong@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH v3] ext4: fix bug for rename with RENAME_WHITEOUT
Message-ID: <20210105142734.GC15080@quack2.suse.cz>
References: <20210105062857.3566-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105062857.3566-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 05-01-21 14:28:57, yangerkun wrote:
> We got a "deleted inode referenced" warning cross our fsstress test. The
> bug can be reproduced easily with following steps:
> 
>   cd /dev/shm
>   mkdir test/
>   fallocate -l 128M img
>   mkfs.ext4 -b 1024 img
>   mount img test/
>   dd if=/dev/zero of=test/foo bs=1M count=128
>   mkdir test/dir/ && cd test/dir/
>   for ((i=0;i<1000;i++)); do touch file$i; done # consume all block
>   cd ~ && renameat2(AT_FDCWD, /dev/shm/test/dir/file1, AT_FDCWD,
>     /dev/shm/test/dir/dst_file, RENAME_WHITEOUT) # ext4_add_entry in
>     ext4_rename will return ENOSPC!!
>   cd /dev/shm/ && umount test/ && mount img test/ && ls -li test/dir/file1
>   We will get the output:
>   "ls: cannot access 'test/dir/file1': Structure needs cleaning"
>   and the dmesg show:
>   "EXT4-fs error (device loop0): ext4_lookup:1626: inode #2049: comm ls:
>   deleted inode referenced: 139"
> 
> ext4_rename will create a special inode for whiteout and use this 'ino'
> to replace the source file's dir entry 'ino'. Once error happens
> latter(the error above was the ENOSPC return from ext4_add_entry in
> ext4_rename since all space has been consumed), the cleanup do drop the
> nlink for whiteout, but forget to restore 'ino' with source file. This
> will trigger the bug describle as above.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Thanks! The patch looks good to me now. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index b17a082b7db1..90f7ebeb69c8 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3593,9 +3593,6 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
>  			return retval2;
>  		}
>  	}
> -	brelse(ent->bh);
> -	ent->bh = NULL;
> -
>  	return retval;
>  }
>  
> @@ -3794,6 +3791,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		}
>  	}
>  
> +	old_file_type = old.de->file_type;
>  	if (IS_DIRSYNC(old.dir) || IS_DIRSYNC(new.dir))
>  		ext4_handle_sync(handle);
>  
> @@ -3821,7 +3819,6 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	force_reread = (new.dir->i_ino == old.dir->i_ino &&
>  			ext4_test_inode_flag(new.dir, EXT4_INODE_INLINE_DATA));
>  
> -	old_file_type = old.de->file_type;
>  	if (whiteout) {
>  		/*
>  		 * Do this before adding a new entry, so the old entry is sure
> @@ -3919,15 +3916,19 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	retval = 0;
>  
>  end_rename:
> -	brelse(old.dir_bh);
> -	brelse(old.bh);
> -	brelse(new.bh);
>  	if (whiteout) {
> -		if (retval)
> +		if (retval) {
> +			ext4_setent(handle, &old,
> +				old.inode->i_ino, old_file_type);
>  			drop_nlink(whiteout);
> +		}
>  		unlock_new_inode(whiteout);
>  		iput(whiteout);
> +
>  	}
> +	brelse(old.dir_bh);
> +	brelse(old.bh);
> +	brelse(new.bh);
>  	if (handle)
>  		ext4_journal_stop(handle);
>  	return retval;
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECBC2E6F34
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Dec 2020 09:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgL2I6g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Dec 2020 03:58:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10372 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgL2I6g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Dec 2020 03:58:36 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D4pFY1sfWz7Lyf;
        Tue, 29 Dec 2020 16:57:05 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 16:57:46 +0800
Subject: Re: [PATCH] ext4: fix bug for rename with RENAME_WHITEOUT
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>
CC:     <yi.zhang@huawei.com>, <lihaotian9@huawei.com>,
        <lutianxiong@huawei.com>, <linfeilong@huawei.com>
References: <20201229085609.1109598-1-yangerkun@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <24f6a6ff-bfa9-f0e6-1ab0-cf56222d0d40@huawei.com>
Date:   Tue, 29 Dec 2020 16:57:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201229085609.1109598-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



ÔÚ 2020/12/29 16:56, yangerkun Ð´µÀ:
> ext4_rename will create a special inode for whiteout and use this 'ino'
> to replace the source file's dir entry 'ino'. Once error happens
> latter(small ext4 img, and consume all space, so the rename with dst
> path not exist will fail due to the ENOSPC return from ext4_add_entry in
> ext4_rename), the cleanup do drop the nlink for whiteout, but forget to
> restore 'ino' with source file. This will lead to "deleted inode
> referenced".
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   fs/ext4/namei.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index b17a082b7db1..0e89e5a0c758 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3593,9 +3593,6 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
>   			return retval2;
>   		}
>   	}
> -	brelse(ent->bh);
> -	ent->bh = NULL;
> -
>   	return retval;
>   }
>   
> @@ -3794,6 +3791,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
>   		}
>   	}
>   
> +	old_file_type = old.de->file_type;
>   	if (IS_DIRSYNC(old.dir) || IS_DIRSYNC(new.dir))
>   		ext4_handle_sync(handle);
>   
> @@ -3821,7 +3819,6 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
>   	force_reread = (new.dir->i_ino == old.dir->i_ino &&
>   			ext4_test_inode_flag(new.dir, EXT4_INODE_INLINE_DATA));
>   
> -	old_file_type = old.de->file_type;
>   	if (whiteout) {
>   		/*
>   		 * Do this before adding a new entry, so the old entry is sure
> @@ -3919,15 +3916,18 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
>   	retval = 0;
>   
>   end_rename:
> -	brelse(old.dir_bh);
> -	brelse(old.bh);
> -	brelse(new.bh);
>   	if (whiteout) {
> +		ext4_setent(handle, &old,
> +			    old.inode->i_ino, old_file_type);
>   		if (retval)
>   			drop_nlink(whiteout);
>   		unlock_new_inode(whiteout);
>   		iput(whiteout);
> +

This is a mistake... Will send v2.

>   	}
> +	brelse(old.dir_bh);
> +	brelse(old.bh);
> +	brelse(new.bh);
>   	if (handle)
>   		ext4_journal_stop(handle);
>   	return retval;
> 

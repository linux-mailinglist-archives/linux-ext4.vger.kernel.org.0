Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDBF3F8827
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbhHZMzp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Aug 2021 08:55:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18974 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241651AbhHZMzp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Aug 2021 08:55:45 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GwN4p2JkZzbbZj;
        Thu, 26 Aug 2021 20:51:06 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 26 Aug 2021 20:54:56 +0800
Subject: Re: [PATCH v3 4/4] ext4: prevent getting empty inode buffer
To:     <jack@suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>,
        <linux-ext4@vger.kernel.org>
References: <20210821065450.1397451-1-yi.zhang@huawei.com>
 <20210821065450.1397451-5-yi.zhang@huawei.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <d06b266d-4acf-c679-d629-b8503e461ef1@huawei.com>
Date:   Thu, 26 Aug 2021 20:54:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210821065450.1397451-5-yi.zhang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/8/21 14:54, Zhang Yi wrote:
> In ext4_get_inode_loc(), we may skip IO and get an zero && uptodate
> inode buffer when the inode monopolize an inode block for performance
> reason. For most cases, ext4_mark_iloc_dirty() will fill the inode
> buffer to make it fine, but we could miss this call if something bad
> happened. Finally, __ext4_get_inode_loc_noinmem() may probably get an
> empty inode buffer and trigger ext4 error.
> 
> For example, if we remove a nonexistent xattr on inode A,
> ext4_xattr_set_handle() will return ENODATA before invoking
> ext4_mark_iloc_dirty(), it will left an uptodate but zero buffer. We
> will get checksum error message in ext4_iget() when getting inode again.
> 
>   EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid
> 
> Even worse, if we allocate another inode B at the same inode block, it
> will corrupt the inode A on disk when write back inode B.
> 
> So this patch postpone the initialization and mark buffer uptodate logic
> until shortly before we fill correct inode data in ext4_do_update_inode()
> if skip read I/O, ensure the buffer is really uptodate.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 8323d3e8f393..000abb5696b0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4367,9 +4367,12 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  		}
>  		brelse(bitmap_bh);
>  		if (i == start + inodes_per_block) {
> -			/* all other inodes are free, so skip I/O */
> -			memset(bh->b_data, 0, bh->b_size);
> -			set_buffer_uptodate(bh);
> +			/*
> +			 * All other inodes are free, skip I/O. Return
> +			 * uninitialized buffer immediately, initialization
> +			 * is postponed until shortly before we fill inode
> +			 * contents.
> +			 */
>  			unlock_buffer(bh);
>  			goto has_buffer;
>  		}
> @@ -5028,6 +5031,24 @@ static int ext4_do_update_inode(handle_t *handle,
>  	gid_t i_gid;
>  	projid_t i_projid;
>  
> +	/*
> +	 * If the buffer is not uptodate, it means all information of the
> +	 * inode is in memory and we got this buffer without reading the
> +	 * block. We must be cautious that once we mark the buffer as
> +	 * uptodate, we rely on filling in the correct inode data later
> +	 * in this function. Otherwise if we left uptodate buffer without
> +	 * copying proper inode contents, we could corrupt the inode on
> +	 * disk after allocating another inode in the same block.
> +	 */
> +	if (!buffer_uptodate(bh)) {
> +		lock_buffer(bh);
> +		if (!buffer_uptodate(bh)) {
> +			memset(bh->b_data, 0, bh->b_size);
> +			set_buffer_uptodate(bh);
> +		}
> +		unlock_buffer(bh);
> +	}

Hi, Jan.

I notice that above solution is not correct. The problem is still in
ext4_xattr_set_handle(), if we set a new xattr entry in a pure inode,
the above hunk may zero out the ibody xattr entry we just set up in
ext4_xattr_ibody_set().

I guess we could not 'zero out buffer && mark buffer uptodate' here,
maybe __ext4_get_inode_loc() should return a really initialized buffer,
or else it's still fragile and hard to guarantee that the 'zero out'
and 'postponed set_buffer_uptodate()' will not zero out something we
just set or overwrite something we updated concurrently.

How about factor out the filling inode contents from ext4_do_update_inode()
into maybe ext4_fill_raw_inode(), and call it in __ext4_get_inode_loc() ?
Please see my v4 patchset.

Thanks,
Yi.

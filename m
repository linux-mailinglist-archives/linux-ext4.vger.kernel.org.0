Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE5927739D
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 16:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgIXOJN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 10:09:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:53628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbgIXOJN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 10:09:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05F96AD03;
        Thu, 24 Sep 2020 14:09:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A8FA41E1318; Thu, 24 Sep 2020 11:44:47 +0200 (CEST)
Date:   Thu, 24 Sep 2020 11:44:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Haotian Li <lihaotian9@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com, linux-ext4@vger.kernel.org,
        hqjagain@gmail.com
Subject: Re: [PATCH] ext4: fix data-races problem at inode->i_disksize
Message-ID: <20200924094447.GG27019@quack2.suse.cz>
References: <b5032209-a132-fed4-e26e-1e02bc54c640@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5032209-a132-fed4-e26e-1e02bc54c640@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 19-09-20 20:39:52, Haotian Li wrote:
> 
> We find some data-race problems at inode->i_disksize by
> using KSCAN in kernel 4.18. The same problem can also be
> found at commit dce8e237100f ("ext4: fix a data race at
> inode->i_disksize").
> 
> BUG: KCSAN: data-race in ext4_da_write_end / ext4_writepages
> write to 0xffff8ee8ed62cea8 of 8 bytes by task 3908 on cpu 0:
> mpage_map_and_submit_extent  [inline]
> ext4_writepages+0x170c/0x1b90
> do_writepages+0x70/0x170
> __filemap_fdatawrite_range+0x199/0x1f0
> file_write_and_wait_range+0x80/0xc0
> ext4_sync_file+0x26f/0x860
> vfs_fsync_range+0x7a/0x130
> vfs_fsync  [inline]
> do_fsync+0x4c/0x80
> __do_sys_fsync  [inline]
> __se_sys_fsync  [inline]
> __x64_sys_fsync+0x2c/0x40
> do_syscall_64+0xb5/0x340
> entry_SYSCALL_64_after_hwframe+0x65/0xca
> 0xffffffffffffffff
> 
> read to 0xffff8ee8ed62cea8 of 8 bytes by task 3907 on cpu 3:
> ext4_da_write_end+0xd3/0x7d0
> generic_perform_write+0x1c6/0x2c0
> __generic_file_write_iter+0x2aa/0x2f0
> ext4_file_write_iter+0x197/0x820
> call_write_iter   [inline]
> new_sync_write+0x2ae/0x350
> __vfs_write+0xa5/0xc0
> vfs_write+0x119/0x2e0
> ksys_write+0x83/0x120
> __do_sys_write  [inline]
> __se_sys_write  [inline]
> __x64_sys_write+0x4d/0x60
> do_syscall_64+0xb5/0x340
> entry_SYSCALL_64_after_hwframe+0x65/0xca
> 0xffffffffffffffff
> 
> We find two solutions to solve this problem.
> 1) Just the same as commit dce8e237100f ("ext4: fix a data
> race at inode->i_disksize"), Add READ_ONCE or WRITE_ONCE
> on inode->i_disksize directly.
> 
> It is helpful to avoid current KCSAN problem. However,
> some other code using inode->i_disksize without READ_ONCE
> or WRITE_ONCE may also have KCSAN problem. So, we try to
> use the second solution.
> 
> 2) Add 'volatile' keyword at inode->i_disksize.
> 
> We think this solution may be helpful to deal with the
> date-race problem on inode->i_disksize.
> 
> Reported-by: Wenhao Zhang <zhangwenhao8@huawei.com>
> Signed-off-by: Haotian Li <lihaotian9@huawei.com>

So I don't think using volatile is really good here because if does a poor
job documenting what's going on. Also it makes compiler optimizations
impossible for i_disksize (not that it would matter that much in this
particular case). In the kernel we prefer to use explicit calls (such as
READ_ONCE) to mark something special is going on in that place.

But looking at i_disksize in particular, even using READ_ONCE / WRITE_ONCE
is problematic for it because i_disksize is loff_t which is long long. So
on 32-bit architectures storing value to i_disksize is not actually atomic
and using WRITE_ONCE / READ_ONCE does not fix that and we can still see
invalid values. So we might need similar trick as is used in i_size_read()
/ i_size_write() to make unlocked reads of i_disksize work... Not sure if
such a big hammer solution is really worth it for those few unlocked
i_disksize readers we have.

								Honza

> ---
>  fs/ext4/ext4.h  | 4 ++--
>  fs/ext4/inode.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 523e00d7b392..354a9d1371af 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1036,7 +1036,7 @@ struct ext4_inode_info {
>  	 * a truncate is in progress.  The only things which change i_disksize
>  	 * are ext4_get_block (growth) and ext4_truncate (shrinkth).
>  	 */
> -	loff_t	i_disksize;
> +	volatile loff_t	i_disksize;
> 
>  	/*
>  	 * i_data_sem is for serialising ext4_truncate() against
> @@ -3128,7 +3128,7 @@ static inline void ext4_update_i_disksize(struct inode *inode, loff_t newsize)
>  		     !inode_is_locked(inode));
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  	if (newsize > EXT4_I(inode)->i_disksize)
> -		WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize);
> +		EXT4_I(inode)->i_disksize = newsize;
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  }
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bf596467c234..7c89d07dead3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2476,7 +2476,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  	 * truncate are avoided by checking i_size under i_data_sem.
>  	 */
>  	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
> -	if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
> +	if (disksize > EXT4_I(inode)->i_disksize) {
>  		int err2;
>  		loff_t i_size;
> 
> @@ -5015,7 +5015,7 @@ static int ext4_do_update_inode(handle_t *handle,
>  		raw_inode->i_file_acl_high =
>  			cpu_to_le16(ei->i_file_acl >> 32);
>  	raw_inode->i_file_acl_lo = cpu_to_le32(ei->i_file_acl);
> -	if (READ_ONCE(ei->i_disksize) != ext4_isize(inode->i_sb, raw_inode)) {
> +	if (ei->i_disksize != ext4_isize(inode->i_sb, raw_inode)) {
>  		ext4_isize_set(raw_inode, ei->i_disksize);
>  		need_datasync = 1;
>  	}
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0911DC15
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2019 03:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfLMC2F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Dec 2019 21:28:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731330AbfLMC2F (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Dec 2019 21:28:05 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 319C9A4CF5683E5283DA;
        Fri, 13 Dec 2019 10:28:03 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 10:27:52 +0800
Subject: Re: [PATCH] ext4: reserve revoke credits in __ext4_new_inode
To:     <tytso@mit.edu>, <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <houtao1@huawei.com>
References: <20191213014900.47228-1-yangerkun@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <44ca8b47-816f-db44-33e4-2f7d12cc462f@huawei.com>
Date:   Fri, 13 Dec 2019 10:27:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191213014900.47228-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2019/12/13 9:49, yangerkun wrote:
> It's possible that __ext4_new_inode will release the xattr block, so
> it will trigger a warning since there is revoke credits will be 0 if
> the handle == NULL. The below scripts can reproduce it easily.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3861 at fs/jbd2/revoke.c:374 jbd2_journal_revoke+0x30e/0x540 fs/jbd2/revoke.c:374
> ...
> __ext4_forget+0x1d7/0x800 fs/ext4/ext4_jbd2.c:248
> ext4_free_blocks+0x213/0x1d60 fs/ext4/mballoc.c:4743
> ext4_xattr_release_block+0x55b/0x780 fs/ext4/xattr.c:1254
> ext4_xattr_block_set+0x1c2c/0x2c40 fs/ext4/xattr.c:2112
> ext4_xattr_set_handle+0xa7e/0x1090 fs/ext4/xattr.c:2384
> __ext4_set_acl+0x54d/0x6c0 fs/ext4/acl.c:214
> ext4_init_acl+0x218/0x2e0 fs/ext4/acl.c:293
> __ext4_new_inode+0x352a/0x42b0 fs/ext4/ialloc.c:1151
> ext4_mkdir+0x2e9/0xbd0 fs/ext4/namei.c:2774
> vfs_mkdir+0x386/0x5f0 fs/namei.c:3811
> do_mkdirat+0x11c/0x210 fs/namei.c:3834
> do_syscall_64+0xa1/0x530 arch/x86/entry/common.c:294
> ...
> -------------------------------------
> 
> scripts:
> mkfs.ext4 /dev/vdb
> mount /dev/vdb /mnt
> cd /mnt && mkdir dir && for i in {1..8}; do setfacl -dm "u:user_"$i":rx" dir; done
> mkdir dir/dir1 && mv dir/dir1 ./
> sh repro.sh && add some user
> 
> [root@localhost ~]# cat repro.sh
> while [ 1 -eq 1 ]; do
>      rm -rf dir
>      rm -rf dir1/dir1
>      mkdir dir
>      for i in {1..8}; do  setfacl -dm "u:test"$i":rx" dir; done
                                            ^^^^should be user_
>      setfacl -m "u:user_9:rx" dir &
>      mkdir dir1/dir1 &
> done
> 
> Before exec repro.sh, dir1 has inherit the default acl from dir, and
> xattr block of dir1 dir is not the same, so the h_refcount of these
> two dir's xattr block will be 1. Then repro.sh can trigger the warning
> with the situation show as below. The last h_refcount can be clear
> with mkdir, and __ext4_new_inode has not reserved revoke credits, so
> the warning will happened, fix it by reserve revoke credits in
> __ext4_new_inode.
> 
> Thread 1                        Thread 2
> mkdir dir
> set default acl(will create
> a xattr block blk1 and the
> refcount of ext4_xattr_header
> will be 1)
> 				...
>                                  mkdir dir1/dir1
> 				->....->ext4_init_acl
> 				->__ext4_set_acl(set default acl,
> 			          will reuse blk1, and h_refcount
> 				  will be 2)
> 
> setfacl->ext4_set_acl->...
> ->ext4_xattr_block_set(will create
> new block blk2 to store xattr)
> 
> 				->__ext4_set_acl(set access acl, since
> 				  h_refcount of blk1 is 2, will create
> 				  blk3 to store xattr)
> 
>    ->ext4_xattr_release_block(dec
>    h_refcount of blk1 to 1)
> 				  ->ext4_xattr_release_block(dec
> 				    h_refcount and since it is 0,
> 				    will release the block and trigger
> 				    the warning)
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>   fs/ext4/ialloc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index dc333e8e51e8..8ca4a23129aa 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -921,8 +921,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
>   		if (!handle) {
>   			BUG_ON(nblocks <= 0);
>   			handle = __ext4_journal_start_sb(dir->i_sb, line_no,
> -							 handle_type, nblocks,
> -							 0, 0);
> +				 handle_type, nblocks, 0,
> +				 ext4_trans_default_revoke_credits(sb));
>   			if (IS_ERR(handle)) {
>   				err = PTR_ERR(handle);
>   				ext4_std_error(sb, err);
> 


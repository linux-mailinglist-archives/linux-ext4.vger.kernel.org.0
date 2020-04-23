Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF2F1B55E8
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Apr 2020 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDWHiI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 03:38:08 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:35353 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgDWHiH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Apr 2020 03:38:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TwPIesv_1587627483;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TwPIesv_1587627483)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Apr 2020 15:38:04 +0800
Subject: Re: [PATCH] ext4: fix error pointer dereference
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     tytso@mit.edu, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <1587626854-73470-1-git-send-email-jefflexu@linux.alibaba.com>
Message-ID: <5718b1f1-d52e-5932-c632-06d185f7ff45@linux.alibaba.com>
Date:   Thu, 23 Apr 2020 15:38:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587626854-73470-1-git-send-email-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Please ignore this patch since there's a bug in this patch. Sorry for that.

On 4/23/20 3:27 PM, Jeffle Xu wrote:
> Don't pass error pointers to brelse().
>
> commit 7159a986b420 ("ext4: fix some error pointer dereferences") has fixed
> some cases, fix the remaining one case.
>
> Once ext4_xattr_block_find()->ext4_sb_bread() failed, error pointer is
> stored in @bs->bh, which will be passed to brelse() in the cleanup
> routine of ext4_xattr_set_handle(). This will then cause a NULL panic
> crash in __brelse().
>
> BUG: unable to handle kernel NULL pointer dereference at 000000000000005b
> RIP: 0010:__brelse+0x1b/0x50
> Call Trace:
>   ext4_xattr_set_handle+0x163/0x5d0
>   ext4_xattr_set+0x95/0x110
>   __vfs_setxattr+0x6b/0x80
>   __vfs_setxattr_noperm+0x68/0x1b0
>   vfs_setxattr+0xa0/0xb0
>   setxattr+0x12c/0x1a0
>   path_setxattr+0x8d/0xc0
>   __x64_sys_setxattr+0x27/0x30
>   do_syscall_64+0x60/0x250
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> In this case, @bs->bh stores '-EIO' actually.
>
> Fixes: fb265c9cb49e ("ext4: add ext4_sb_bread() to disambiguate ENOMEM cases")
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: stable@kernel.org # 2.6.19
> ---
>   fs/ext4/xattr.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 21df43a..c0ebd0f 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1800,8 +1800,10 @@ struct ext4_xattr_block_find {
>   	if (EXT4_I(inode)->i_file_acl) {
>   		/* The inode already has an extended attribute block. */
>   		bs->bh = ext4_sb_bread(sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
> -		if (IS_ERR(bs->bh))
> +		if (IS_ERR(bs->bh)) {
> +			bs->bh = NULL;
>   			return PTR_ERR(bs->bh);
> +		}
>   		ea_bdebug(bs->bh, "b_count=%d, refcount=%d",
>   			atomic_read(&(bs->bh->b_count)),
>   			le32_to_cpu(BHDR(bs->bh)->h_refcount));

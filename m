Return-Path: <linux-ext4+bounces-4526-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EAB99410D
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 10:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4991F29A96
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED61E1714B6;
	Tue,  8 Oct 2024 07:40:47 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DC7DA76;
	Tue,  8 Oct 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373247; cv=none; b=Oju54G3z//sqnWXKfB7h9u/J5WrAGpD2e4OZnz04h82BSFg456w2+5SPNjFb5b1kiDDIcbpsClUWxuWmSd8GcP4mbnwb3sz5uwDJNMgFmT8G9N52vggNXP59UCCsAEVrWmQ44cmu01yFrXJmy73BvINAKWjbdf84sQRYPh2Cuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373247; c=relaxed/simple;
	bh=Db/vKG35fxUql68zLBwIA3yZPDKUlp1kplZpcn1DRBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kY2i9CQjQGoTMOh4DZIdXG9H05qJFp1IqQaJ8Tzyp4iwvLwTi0BzYhbo8pgAi34jxGdmtTWnvOiDJWOH3CpVWL9qanWDNq+uwWyiYv9EADcHx+TO1kk+sYVDsvXE24jmsiCPRi2YzK5KwfjRaXFkJ1avm3b95Zh8gfmS+UIIfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XN7Fh6CyPz1j9FL;
	Tue,  8 Oct 2024 15:39:36 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F75714013B;
	Tue,  8 Oct 2024 15:40:40 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 15:40:39 +0800
Message-ID: <d62a25e9-04de-4309-98d1-22a4f9b5bb49@huawei.com>
Date: Tue, 8 Oct 2024 15:40:39 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix out-of-bounds issue in ext4_xattr_set_entry
To: Qianqiang Liu <qianqiang.liu@163.com>, <tytso@mit.edu>, Jan Kara
	<jack@suse.cz>
CC: <adilger.kernel@dilger.ca>, syzbot
	<syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>,
	<linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, Yang Erkun <yangerkun@huawei.com>
References: <Zu+vI3EipxSsPOMe@thinkpad.lan>
 <66efba95.050a0220.3195df.008c.GAE@google.com>
 <Zu+8aQBJgMn7xVws@thinkpad.lan>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Zu+8aQBJgMn7xVws@thinkpad.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/9/22 14:42, Qianqiang Liu wrote:
> syzbot has found an out-of-bounds issue in ext4_xattr_set_entry:
>
> ==================================================================
> BUG: KASAN: out-of-bounds in ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
> Read of size 18446744073709551572 at addr ffff888036426850 by task syz-executor264/5095
>
> CPU: 0 UID: 0 PID: 5095 Comm: syz-executor264 Not tainted 6.11.0-syzkaller-03917-ga940d9a43e62 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:93 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>   __asan_memmove+0x29/0x70 mm/kasan/shadow.c:94
>   ext4_xattr_set_entry+0x8ce/0x1f60 fs/ext4/xattr.c:1781
> [...]
> ==================================================================
>
> This issue is caused by a negative size in memmove.
> We need to check for this.
>
> Fixes: dec214d00e0d ("ext4: xattr inode deduplication")
> Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
> Tested-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>   fs/ext4/xattr.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 46ce2f21fef9..336badb46246 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1776,7 +1776,14 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
>   	} else if (s->not_found) {
>   		/* Insert new name. */
>   		size_t size = EXT4_XATTR_LEN(name_len);
> -		size_t rest = (void *)last - (void *)here + sizeof(__u32);
> +		size_t rest;
> +
> +		if (last < here) {
> +			ret = -ENOSPC;
> +			goto out;
> +		} else {
> +			rest = (void *)last - (void *)here + sizeof(__u32);
> +		}
>   
>   		memmove((void *)here + size, here, rest);
>   		memset(here, 0, size);
This change just passes syzbot's test cases without fixing the real
problem.

The root cause of the problem is that the inode's xattr block is marked as
free in the block bitmap, so that block is allocated to the ea inode
resulting in the data in the xattr block being overwritten, and the last of
the second lookups changing resulting in out-of-bounds access.

The stack that triggers the problem is as follows:

// An inode with an xattr block of 33.
__ext4_mark_inode_dirty
  __ext4_expand_extra_isize
   ext4_expand_extra_isize_ea
    ext4_xattr_make_inode_space
     // Move xattr from inode to block
     ext4_xattr_move_to_block
      // Find out if the xattr exists in the block
      ext4_xattr_block_find
       // If xattr does not exist, here == last
       xattr_find_entry
      // Add a new xattr to the block
      ext4_xattr_block_set
       |// xattr is too long, needs an ea inode
       |ext4_xattr_inode_lookup_create
       | ext4_xattr_inode_create
       | ext4_xattr_inode_write
       |  ext4_map_blocks
       |   // xattr block 33 is assigned to the new ea inode
       |  memcpy(bh->b_data, buf, csize)
       |   // The value of xattr overwrites the data in the xattr block.
       |ext4_xattr_set_entry
        // Since the contents of the xattr block have changed,
        // now here == last does not hold, so it is possible to
        // have last < here and trigger an out-of-bounds access.

So I think we should probably add a helper function ext4_mb_block_inuse()
that checks if xattr block is free with the block bitmap in check_xattrs().

Or go one step further and add a mechanism like xfs Reverse-Mapping, which
makes sure that allocated blocks do point to the target inode, which could
replace the current block_validity, and could also be used in future online
fscks.

Ted, Honza, do you have any thoughts?

Regards,
Baokun


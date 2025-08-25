Return-Path: <linux-ext4+bounces-9595-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F41B33565
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 06:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A8717CF02
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 04:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E70272E43;
	Mon, 25 Aug 2025 04:40:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D2F23B63C;
	Mon, 25 Aug 2025 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096800; cv=none; b=qbXAPvvGuE3XGY2iOclaZvzKQ6uFR8V4BMgBS0BDNHBetL2DPQzcRLq+IQQRMOBuKBWExVLlI/GaMLVYXyyIRHG7y8+BiKj9MALAxujWpaPiNyjhHTDogB7xhsqlLuzXD1ZRzH93Uzs5YnPtzF/BccY3AhSpBMnrtdnQedpz8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096800; c=relaxed/simple;
	bh=sRi0BdywOkFVtpyesp1SmdY4RAR58yVQ7CfD8V/yBMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btLWw0PEz+Vcj127IFSU6Hc4/AcaVhJDYTQFxPlBLjyo92Zk0rY8nkrQJpG8V9WhKMPCAOiKT1AlnynnUdN8gFTHzQZuADA+/jGr2KXWa4pUC6Y5kPkAm5R/R/02MIKWth7Pk87tn/hBAZYB6HZBlxRl8aGFUtZsyxl0axACyS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9J4B6HfZzYQvLt;
	Mon, 25 Aug 2025 12:39:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6A0531A0CC5;
	Mon, 25 Aug 2025 12:39:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAncY0W6atoqvLYAA--.56226S3;
	Mon, 25 Aug 2025 12:39:52 +0800 (CST)
Message-ID: <ad0e8cea-64fb-44f7-abf2-30ad5fc07a4c@huaweicloud.com>
Date: Mon, 25 Aug 2025 12:39:50 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix potential null deref in ext4_mb_init()
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, libaokun1@huawei.com,
 syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com
References: <20250825033830.2230202-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250825033830.2230202-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAncY0W6atoqvLYAA--.56226S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw48WryxurWfWFyrtw4Dtwb_yoW5WF4fp3
	ZrAFyxKr4UGFyDCa1xW3WYqw4Fga18WF1UJ34fWF1rXF1Utryvka92gr1UCFyUKrWDA3Z7
	JF9Fqr45tw48CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 8/25/2025 11:38 AM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_mb_init(), ext4_mb_avg_fragment_size_destroy() may be called
> when sbi->s_mb_avg_fragment_size remains uninitialized (e.g., if groupinfo
> slab cache allocation fails). Since ext4_mb_avg_fragment_size_destroy()
> lacks null pointer checking, this leads to a null pointer dereference.
> 
> ==================================================================
> EXT4-fs: no memory for groupinfo slab cache
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: Oops: 0002 [#1] SMP PTI
> CPU:2 UID: 0 PID: 87 Comm:mount Not tainted 6.17.0-rc2 #1134 PREEMPT(none)
> RIP: 0010:_raw_spin_lock_irqsave+0x1b/0x40
> Call Trace:
>  <TASK>
>  xa_destroy+0x61/0x130
>  ext4_mb_init+0x483/0x540
>  __ext4_fill_super+0x116d/0x17b0
>  ext4_fill_super+0xd3/0x280
>  get_tree_bdev_flags+0x132/0x1d0
>  vfs_get_tree+0x29/0xd0
>  do_new_mount+0x197/0x300
>  __x64_sys_mount+0x116/0x150
>  do_syscall_64+0x50/0x1c0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ==================================================================
> 
> Therefore, add necessary null check to ext4_mb_avg_fragment_size_destroy()
> to prevent this issue. The same fix is also applied to
> ext4_mb_largest_free_orders_destroy().
> 
> Reported-by: syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1713b1aa266195b916c2
> Fixes: f7eaacbb4e54 ("ext4: convert free groups order lists to xarrays")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/mballoc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5898d92ba19f..6070d3c86678 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3655,16 +3655,26 @@ static void ext4_discard_work(struct work_struct *work)
>  
>  static inline void ext4_mb_avg_fragment_size_destroy(struct ext4_sb_info *sbi)
>  {
> +	if (!sbi->s_mb_avg_fragment_size)
> +		return;
> +
>  	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
>  		xa_destroy(&sbi->s_mb_avg_fragment_size[i]);
> +
>  	kfree(sbi->s_mb_avg_fragment_size);
> +	sbi->s_mb_avg_fragment_size = NULL;
>  }
>  
>  static inline void ext4_mb_largest_free_orders_destroy(struct ext4_sb_info *sbi)
>  {
> +	if (!sbi->s_mb_largest_free_orders)
> +		return;
> +
>  	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
>  		xa_destroy(&sbi->s_mb_largest_free_orders[i]);
> +
>  	kfree(sbi->s_mb_largest_free_orders);
> +	sbi->s_mb_largest_free_orders = NULL;
>  }
>  
>  int ext4_mb_init(struct super_block *sb)



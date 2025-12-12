Return-Path: <linux-ext4+bounces-12311-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462ACB78CA
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 02:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 503AE30274D5
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 01:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F8283159;
	Fri, 12 Dec 2025 01:37:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A124DD09;
	Fri, 12 Dec 2025 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765503435; cv=none; b=AEjQvQblcf0W9y0isfcO9+2hvxRnNYsNIieHpMPlYMuvZdmyO8c6AZiY6oZ4X9q5TA6c9Oea4oFZ+bbM91ygjZuTqiQyqfLyjGpefLja0Jjrp5szI8t0+krUwYuboPbWBQMwjnsur9cgzs6UduUYZxi9OotQ9QeNAAWxgqUU77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765503435; c=relaxed/simple;
	bh=oZhR3kDM10Y5sB6ilS346jfuCidu4iRvnyQphD3O9Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eko2Xlar8ZG3teiMHysBcwaucT/wGp0kwEtz3s7A39Kc84gP6lgxPsxg8cCs2BYpYo8ejNKMWOJge0qZdcsUo6IF4rxKzfXhzfHHox1PNPBTAFL7eMotp/Ozf01U7BtOC8ry0m2UDSVb+rrqK9lo/S9+NTFe5kUNRVGNRahtu+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dSBrp053HzKHMR3;
	Fri, 12 Dec 2025 09:36:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C23131A07BB;
	Fri, 12 Dec 2025 09:36:58 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgCXxE65cTtpyePBBQ--.44153S3;
	Fri, 12 Dec 2025 09:36:58 +0800 (CST)
Message-ID: <552bf485-c297-4c8e-b38b-f97b982e2295@huaweicloud.com>
Date: Fri, 12 Dec 2025 09:36:57 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: move ext4_percpu_param_init() before ext4_mb_init()
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, libaokun1@huawei.com
References: <20251209133116.731350-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251209133116.731350-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCXxE65cTtpyePBBQ--.44153S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1kZw18ZFyDWw1DuF1rZwb_yoWrAr47pr
	yDAa4xtry8CryDCw43JF1FqF18X3W0kF45Jryfur1UA3srtFn3WF97tF45JFW2gr4kZFnY
	qF1rWr17Gr17u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUFBT5DUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 12/9/2025 9:31 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> When running `kvm-xfstests -c ext4/1k -C 1 generic/383` with the
> `DOUBLE_CHECK` macro defined, the following panic is triggered:
> 
> ==================================================================
> EXT4-fs error (device vdc): ext4_validate_block_bitmap:423:
>                         comm mount: bg 0: bad block bitmap checksum
> BUG: unable to handle page fault for address: ff110000fa2cc000
> PGD 3e01067 P4D 3e02067 PUD 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 2386 Comm: mount Tainted: G W
>                         6.18.0-gba65a4e7120a-dirty #1152 PREEMPT(none)
> RIP: 0010:percpu_counter_add_batch+0x13/0xa0
> Call Trace:
>  <TASK>
>  ext4_mark_group_bitmap_corrupted+0xcb/0xe0
>  ext4_validate_block_bitmap+0x2a1/0x2f0
>  ext4_read_block_bitmap+0x33/0x50
>  mb_group_bb_bitmap_alloc+0x33/0x80
>  ext4_mb_add_groupinfo+0x190/0x250
>  ext4_mb_init_backend+0x87/0x290
>  ext4_mb_init+0x456/0x640
>  __ext4_fill_super+0x1072/0x1680
>  ext4_fill_super+0xd3/0x280
>  get_tree_bdev_flags+0x132/0x1d0
>  vfs_get_tree+0x29/0xd0
>  vfs_cmd_create+0x59/0xe0
>  __do_sys_fsconfig+0x4f6/0x6b0
>  do_syscall_64+0x50/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ==================================================================
> 
> This issue can be reproduced using the following commands:
>         mkfs.ext4 -F -q -b 1024 /dev/sda 5G
>         tune2fs -O quota,project /dev/sda
>         mount /dev/sda /tmp/test
> 
> With DOUBLE_CHECK defined, mb_group_bb_bitmap_alloc() reads
> and validates the block bitmap. When the validation fails,
> ext4_mark_group_bitmap_corrupted() attempts to update
> sbi->s_freeclusters_counter. However, this percpu_counter has not been
> initialized yet at this point, which leads to the panic described above.
> 
> Fix this by moving the execution of ext4_percpu_param_init() to occur
> before ext4_mb_init(), ensuring the per-CPU counters are initialized
> before they are used.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/super.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 87205660c5d0..5c2e931d8a53 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5599,35 +5599,35 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	 */
>  	if (!(ctx->spec & EXT4_SPEC_mb_optimize_scan)) {
>  		if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
>  			set_opt2(sb, MB_OPTIMIZE_SCAN);
>  		else
>  			clear_opt2(sb, MB_OPTIMIZE_SCAN);
>  	}
>  
> +	err = ext4_percpu_param_init(sbi);
> +	if (err)
> +		goto failed_mount5;
> +
>  	err = ext4_mb_init(sb);
>  	if (err) {
>  		ext4_msg(sb, KERN_ERR, "failed to initialize mballoc (%d)",
>  			 err);
>  		goto failed_mount5;
>  	}
>  
>  	/*
>  	 * We can only set up the journal commit callback once
>  	 * mballoc is initialized
>  	 */
>  	if (sbi->s_journal)
>  		sbi->s_journal->j_commit_callback =
>  			ext4_journal_commit_callback;
>  
> -	err = ext4_percpu_param_init(sbi);
> -	if (err)
> -		goto failed_mount6;
> -
>  	if (ext4_has_feature_flex_bg(sb))
>  		if (!ext4_fill_flex_info(sb)) {
>  			ext4_msg(sb, KERN_ERR,
>  			       "unable to initialize "
>  			       "flex_bg meta info!");
>  			err = -ENOMEM;
>  			goto failed_mount6;
>  		}
> @@ -5699,18 +5699,18 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
>  failed_mount8: __maybe_unused
>  	ext4_release_orphan_info(sb);
>  failed_mount7:
>  	ext4_unregister_li_request(sb);
>  failed_mount6:
>  	ext4_mb_release(sb);
>  	ext4_flex_groups_free(sbi);
> -	ext4_percpu_param_destroy(sbi);
>  failed_mount5:
> +	ext4_percpu_param_destroy(sbi);
>  	ext4_ext_release(sb);
>  	ext4_release_system_zone(sb);
>  failed_mount4a:
>  	dput(sb->s_root);
>  	sb->s_root = NULL;
>  failed_mount4:
>  	ext4_msg(sb, KERN_ERR, "mount failed");
>  	if (EXT4_SB(sb)->rsv_conversion_wq)



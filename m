Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB91159E7D7
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Aug 2022 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbiHWQsz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Aug 2022 12:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244761AbiHWQsc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Aug 2022 12:48:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9EF915F6;
        Tue, 23 Aug 2022 07:22:12 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MBrv56kbDzlWKf;
        Tue, 23 Aug 2022 22:18:57 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 22:22:10 +0800
Message-ID: <c1389b6c-9952-0206-d5a7-eb2332dbba5f@huawei.com>
Date:   Tue, 23 Aug 2022 22:22:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4] ext4: fix bug in extents parsing when eh_entries == 0
 and eh_depth > 0
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
CC:     <wenqingliu0120@gmail.com>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "yukuai (C)" <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220822094235.2690-1-lhenriques@suse.de>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20220822094235.2690-1-lhenriques@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/8/22 17:42, Luís Henriques wrote:
> When walking through an inode extents, the ext4_ext_binsearch_idx() function
> assumes that the extent header has been previously validated.  However, there
> are no checks that verify that the number of entries (eh->eh_entries) is
> non-zero when depth is > 0.  And this will lead to problems because the
> EXT_FIRST_INDEX() and EXT_LAST_INDEX() will return garbage and result in this:
>
> [  135.245946] ------------[ cut here ]------------
> [  135.247579] kernel BUG at fs/ext4/extents.c:2258!
> [  135.249045] invalid opcode: 0000 [#1] PREEMPT SMP
> [  135.250320] CPU: 2 PID: 238 Comm: tmp118 Not tainted 5.19.0-rc8+ #4
> [  135.252067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> [  135.255065] RIP: 0010:ext4_ext_map_blocks+0xc20/0xcb0
> [  135.256475] Code:
> [  135.261433] RSP: 0018:ffffc900005939f8 EFLAGS: 00010246
> [  135.262847] RAX: 0000000000000024 RBX: ffffc90000593b70 RCX: 0000000000000023
> [  135.264765] RDX: ffff8880038e5f10 RSI: 0000000000000003 RDI: ffff8880046e922c
> [  135.266670] RBP: ffff8880046e9348 R08: 0000000000000001 R09: ffff888002ca580c
> [  135.268576] R10: 0000000000002602 R11: 0000000000000000 R12: 0000000000000024
> [  135.270477] R13: 0000000000000000 R14: 0000000000000024 R15: 0000000000000000
> [  135.272394] FS:  00007fdabdc56740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> [  135.274510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  135.276075] CR2: 00007ffc26bd4f00 CR3: 0000000006261004 CR4: 0000000000170ea0
> [  135.277952] Call Trace:
> [  135.278635]  <TASK>
> [  135.279247]  ? preempt_count_add+0x6d/0xa0
> [  135.280358]  ? percpu_counter_add_batch+0x55/0xb0
> [  135.281612]  ? _raw_read_unlock+0x18/0x30
> [  135.282704]  ext4_map_blocks+0x294/0x5a0
> [  135.283745]  ? xa_load+0x6f/0xa0
> [  135.284562]  ext4_mpage_readpages+0x3d6/0x770
> [  135.285646]  read_pages+0x67/0x1d0
> [  135.286492]  ? folio_add_lru+0x51/0x80
> [  135.287441]  page_cache_ra_unbounded+0x124/0x170
> [  135.288510]  filemap_get_pages+0x23d/0x5a0
> [  135.289457]  ? path_openat+0xa72/0xdd0
> [  135.290332]  filemap_read+0xbf/0x300
> [  135.291158]  ? _raw_spin_lock_irqsave+0x17/0x40
> [  135.292192]  new_sync_read+0x103/0x170
> [  135.293014]  vfs_read+0x15d/0x180
> [  135.293745]  ksys_read+0xa1/0xe0
> [  135.294461]  do_syscall_64+0x3c/0x80
> [  135.295284]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> This patch simply adds an extra check in __ext4_ext_check(), verifying that
> eh_entries is not 0 when eh_depth is > 0.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215941
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216283
> Cc: Baokun Li <libaokun1@huawei.com>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>

The value of eh_entries for a non-leaf node cannot be 0.

Looks good to me.

Reviewed-by:  Baokun Li <libaokun1@huawei.com>

> ---
>   fs/ext4/extents.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> Changes since v3:
> - Fixed typo (I had 'eh_depth' instead of 'depth')
>
> Changes since v2:
> - Dropped usage of le16_to_cpu() because we're comparing values against 0
> - Use 'depth' instead of 'eh->eh_depth' because we've checked earlier that
>    both have the same value.
>
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c148bb97b527..5235974126bd 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -460,6 +460,10 @@ static int __ext4_ext_check(const char *function, unsigned int line,
>   		error_msg = "invalid eh_entries";
>   		goto corrupted;
>   	}
> +	if (unlikely((eh->eh_entries == 0) && (depth > 0))) {
> +		error_msg = "eh_entries is 0 but eh_depth is > 0";
> +		goto corrupted;
> +	}
>   	if (!ext4_valid_extent_entries(inode, eh, lblk, &pblk, depth)) {
>   		error_msg = "invalid extent entries";
>   		goto corrupted;

-- 
With Best Regards,
Baokun Li


Return-Path: <linux-ext4+bounces-1585-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FCA877B55
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Mar 2024 08:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B99E1C20D58
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Mar 2024 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D71107A6;
	Mon, 11 Mar 2024 07:31:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C59F9D3;
	Mon, 11 Mar 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710142300; cv=none; b=B5VTk+bjGW+BQXt7JbB9O7LnawEALAP8XPM2c/NXwxije+9dIYDCtA097dw3af54YWblpSTs7pAV6/OWi1GnF/ys+gol2wGo9ngK5QXmFcMF89489aBeovN+Xds4bIfambQ82SWWArxFRCfv9kE3iUqhJNBRNpLLhbPpSXbiT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710142300; c=relaxed/simple;
	bh=4vkHIMU5sLhEQ25bNI/O3AvT4oBOKoIMinDU+cLJS8Y=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T/CdEizTt6tR6R16PKFgDZcTzq/al6I8vloUo6a5n6rGeYDBB2Xcu2Vf8oFCKPkeRazwnOkBUsM0zzENx9Ith4H3TPnfiFj7pBoH75bv+NXaOzjHhC3srq6ek/ceq9nWgKYlFn9/QD/vQ92I2DqTm3J3EXzOKV1MP3dy0WlOeZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TtT103btZz2Bfqg;
	Mon, 11 Mar 2024 15:29:08 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id DB6641A0178;
	Mon, 11 Mar 2024 15:31:33 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 15:31:33 +0800
Subject: Re: [PATCH RFC] ext4: Validate inode pa before using preallocation
 blocks
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>
References: <20240311063843.2431708-1-chengzhihao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <24740a61-d379-b9b5-2e08-07f7a4597fa2@huawei.com>
Date: Mon, 11 Mar 2024 15:31:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240311063843.2431708-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/11 14:38, Zhihao Cheng Ð´µÀ:
> In ext4 continue & no-journal mode, physical blocks could be allocated
> more than once (caused by writing extent entries failed & reclaiming
> extent cache) in preallocation process, which could trigger a BUG_ON
> (pa->pa_free < len) in ext4_mb_use_inode_pa().
> 
>   kernel BUG at fs/ext4/mballoc.c:4681!
>   invalid opcode: 0000 [#1] PREEMPT SMP
>   CPU: 3 PID: 97 Comm: kworker/u8:3 Not tainted 6.8.0-rc7
>   RIP: 0010:ext4_mb_use_inode_pa+0x1b6/0x1e0
>   Call Trace:
>    ext4_mb_use_preallocated.constprop.0+0x19e/0x540
>    ext4_mb_new_blocks+0x220/0x1f30
>    ext4_ext_map_blocks+0xf3c/0x2900
>    ext4_map_blocks+0x264/0xa40
>    ext4_do_writepages+0xb15/0x1400
>    do_writepages+0x8c/0x260
>    writeback_sb_inodes+0x224/0x720
>    wb_writeback+0xd8/0x580
>    wb_workfn+0x148/0x820
> 
> Details are shown as following:
> 
> 0. Given a file with i_size=4096 with one mapped block
> 1. Write block no 1, blocks 1~3 are preallocated.
>     ext4_ext_map_blocks
>      ext4_mb_normalize_request
>       size = 16 * 1024
>       size = end - start // Allocate 3 blocks (bs = 4096)
>      ext4_mb_regular_allocator
>       ext4_mb_regular_allocator
>       ext4_mb_regular_allocator
>       ext4_mb_use_inode_pa
>        pa->pa_free -= len // 3 - 1 = 2
> 2. Extent buffer head is written failed, es cache and buffer head are
>     reclaimed.
> 3. Write blocks 1~3
>     ext4_ext_map_blocks
>      newex.ee_len = 3
>      ext4_ext_check_overlap // Find nothing, there should have been block 1
>      allocated = map->m_len  // 3
>      ext4_mb_new_blocks
>       ext4_mb_use_preallocated
>        ext4_mb_use_inode_pa
>         BUG_ON(pa->pa_free < len) // 2 < 3!
> 
> Fix it by adding validation checking for inode pa. If invalid pa is
> detected, stop using inode preallocation, drop invalid pa to avoid it
> being used again, mark group block bitmap as corrupted to avoid allocating
> from the erroneous group.

After marking group block bitmap corrupted, mpage_map_and_submit_extent 
returns -EFSCORRUPTED from ext4_map_blocks -> ext4_ext_map_blocks -> 
ext4_mb_new_blocks -> ext4_mb_regular_allocator -> ext4_mb_find_by_goal 
-> ext4_mb_load_buddy -> ext4_mb_init_cache -> ext4_wait_block_bitmap -> 
  ext4_validate_block_bitmap-> EXT4_MB_GRP_BBITMAP_CORRUPT(grp).
I think the checking 'EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)' is not 
needed in ext4_mb_load_buddy, because all callers have checked it before 
using e4b. In this case(ext4_mb_regular_allocator), goal group could be 
skipped if it is corrupted, so ext4_mb_find_by_goal should load 
buddy(ext4_mb_load_buddy) without checking corrupted and then check 
corrupted with returning 0. But we can't delete the 
checking(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)) directly from 
ext4_validate_block_bitmap, because some ext4_wait_block_bitmap callers 
may still need it. IOW, there are some logic pathes need the checking, 
but some don't need.

Above problem is independent with the problem solved by this patch, so I 
send out the patch.
> 
> Fetch a reproducer in Link.
> 
> Cc: stable@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218576
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>   fs/ext4/mballoc.c | 128 +++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 98 insertions(+), 30 deletions(-)
> 


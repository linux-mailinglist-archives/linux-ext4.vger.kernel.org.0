Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68E4403947
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Sep 2021 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344680AbhIHMAI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Sep 2021 08:00:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15308 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348327AbhIHMAH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Sep 2021 08:00:07 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H4LJ43S1Rz8srZ;
        Wed,  8 Sep 2021 19:58:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 8 Sep
 2021 19:58:57 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [RFC PATCH 0/3] ext4: enhance extent consistency check
Date:   Wed, 8 Sep 2021 20:08:47 +0800
Message-ID: <20210908120850.4012324-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now that in the error patch of extent updating procedure cannot handle
error and roll-back partial updates properly, so we could access the
left inconsistent extent buffer later and lead to BUGON in
errors=continue mode. For example, we could get below BUGON if we
update leaf extent but failed to update index extent in
ext4_ext_insert_extent() and try to alloc block again.

  kernel BUG at fs/ext4/mballoc.c:4085!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 30 PID: 1177 Comm: xfs_io Not tainted 5.14.0-00006-g555c93b65a81 #543
  RIP: 0010:ext4_mb_normalize_request.constprop.0+0x72c/0x8a0
  RSP: 0018:ffffb398c0abb8d8 EFLAGS: 00010202
  RAX: 0000000000000000 RBX: ffff8d79d3125000 RCX: 0000000000001500
  RDX: 0000000000001500 RSI: 0000000000000000 RDI: ffffb398c0abba50
  RBP: 0000000000001500 R08: 0000000000000001 R09: 00000000000015c0
  R10: 0000000000660000 R11: ffff8d79e21212d8 R12: ffff8d79e21215b8
  R13: 0000000000001500 R14: ffffb398c0abba50 R15: ffff8d79e21215b8
  FS:  00007f1bf519f800(0000) GS:ffff8d80e5d80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000560c5b96d000 CR3: 000000010f170000 CR4: 00000000000006e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   ext4_mb_new_blocks+0x8f3/0x1c90
   ? __read_extent_tree_block+0x20a/0x260
   ext4_ext_map_blocks+0xb7c/0x1d30
   ext4_map_blocks+0x15d/0xa30
   ? __cond_resched+0x1d/0x50
   ? kmem_cache_alloc+0x206/0x400
   _ext4_get_block+0xa8/0x170
   ext4_get_block+0x1a/0x30
   ext4_block_write_begin+0x179/0x8c0
   ? ext4_get_block_unwritten+0x20/0x20
   ? __ext4_journal_start_sb+0x179/0x1d0
   ext4_write_begin+0x42d/0x910
   ext4_da_write_begin+0x2eb/0x750
   generic_perform_write+0xcb/0x280
   ext4_buffered_write_iter+0xc3/0x1e0
   ext4_file_write_iter+0x70/0xac0
   ? _raw_spin_unlock+0x12/0x30
   ? __handle_mm_fault+0x13e1/0x2520
   new_sync_write+0x166/0x220
   vfs_write+0x1d7/0x3b0
   ksys_pwrite64+0x85/0xf0
   __x64_sys_pwrite64+0x22/0x30
   do_syscall_64+0x3b/0x90
   entry_SYSCALL_64_after_hwframe+0x44/0xae
  RIP: 0033:0x7f1bf5760378

This patch set address to enhance extent check in __ext4_ext_check() and
force check buffer again through clear buffer's verified bit if we
breaks off extent updating.

Thanks,
Yi.


Zhang Yi (3):
  ext4: check for out-of-order index extents in
    ext4_valid_extent_entries()
  ext4: check for inconsistent extents between index and leaf block
  ext4: prevent partial update of the extent blocks

 fs/ext4/extents.c | 95 +++++++++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 31 deletions(-)

-- 
2.31.1


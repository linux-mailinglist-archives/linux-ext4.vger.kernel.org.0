Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C25E3A74E9
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jun 2021 05:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFODUW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 23:20:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4907 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFODUW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Jun 2021 23:20:22 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G3tjS0sRsz6yjd;
        Tue, 15 Jun 2021 11:15:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 11:18:16 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH RFC] ext4:fix warning in mark_buffer_dirty as IO error when mount with errors=continue
Date:   Tue, 15 Jun 2021 11:27:17 +0800
Message-ID: <20210615032717.2902675-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We test with following step:
1. dmsetup  create dust1 --table  '0 2097152 dust /dev/sdc 0 4096'
2. mount  /dev/mapper/dust1  /home/test
3. dmsetup message dust1 0 addbadblock 0 10
4. cd /home/test
5. echo "XXXXXXX" > t
6. wait a moment we got following warning:
[   80.654487] end_buffer_async_write: bh=0xffff88842f18bdd0
[   80.656134] Buffer I/O error on dev dm-0, logical block 0, lost async page write
[   85.774450] EXT4-fs error (device dm-0): ext4_check_bdev_write_error:193: comm kworker/u16:8: Error while async write back metadata
[   91.415513] mark_buffer_dirty: bh=0xffff88842f18bdd0
[   91.417038] ------------[ cut here ]------------
[   91.418450] WARNING: CPU: 1 PID: 1944 at fs/buffer.c:1092 mark_buffer_dirty.cold+0x1c/0x5e

[   91.440322] Call Trace:
[   91.440652]  __jbd2_journal_temp_unlink_buffer+0x135/0x220
[   91.441354]  __jbd2_journal_unfile_buffer+0x24/0x90
[   91.441981]  __jbd2_journal_refile_buffer+0x134/0x1d0
[   91.442628]  jbd2_journal_commit_transaction+0x249a/0x3240
[   91.443336]  ? put_prev_entity+0x2a/0x200
[   91.443856]  ? kjournald2+0x12e/0x510
[   91.444324]  kjournald2+0x12e/0x510
[   91.444773]  ? woken_wake_function+0x30/0x30
[   91.445326]  kthread+0x150/0x1b0
[   91.445739]  ? commit_timeout+0x20/0x20
[   91.446258]  ? kthread_flush_worker+0xb0/0xb0
[   91.446818]  ret_from_fork+0x1f/0x30
[   91.447293] ---[ end trace 66f0b6bf3d1abade ]---

If super block write back with IO error, then will call clear_buffer_uptodate
clear uptodate flag. But there is no chance to set buffer uptodate again.
So call set_buffer_uptodate before call jbd2_journal_dirty_metadata to make sure
that buffer is uptodate when buffer is jbddirty.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/ext4_jbd2.c | 2 +-
 fs/ext4/super.c     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index be799040a415..b96ecba91899 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -327,6 +327,7 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 
 	set_buffer_meta(bh);
 	set_buffer_prio(bh);
+	set_buffer_uptodate(bh);
 	if (ext4_handle_valid(handle)) {
 		err = jbd2_journal_dirty_metadata(handle, bh);
 		/* Errors can only happen due to aborted journal or a nasty bug */
@@ -355,7 +356,6 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 					 err);
 		}
 	} else {
-		set_buffer_uptodate(bh);
 		if (inode)
 			mark_buffer_dirty_inode(bh, inode);
 		else
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d29f6aa7d96e..1bd50d3d6a47 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5584,6 +5584,7 @@ static void ext4_update_super(struct super_block *sb)
 	spin_unlock(&sbi->s_error_lock);
 
 	ext4_superblock_csum_set(sb);
+	set_buffer_uptodate(sbh);
 	unlock_buffer(sbh);
 }
 
-- 
2.31.1


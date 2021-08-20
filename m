Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CB63F25E2
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 06:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhHTEc4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 00:32:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17991 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhHTEcy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 00:32:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GrTCd2Pcqzbg1S;
        Fri, 20 Aug 2021 12:28:29 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 20 Aug 2021 12:32:15 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 20 Aug
 2021 12:32:14 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <harshadshirwadkar@gmail.com>
CC:     <houtao1@huawei.com>, <linux-ext4@vger.kernel.org>
Subject: [PATCH] ext4: limit the number of blocks in one ADD_RANGE TLV
Date:   Fri, 20 Aug 2021 12:45:05 +0800
Message-ID: <20210820044505.474318-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now EXT4_FC_TAG_ADD_RANGE uses ext4_extent to track the
newly-added blocks, but the limit on the max value of
ee_len field is ignored, and it can lead to BUG_ON as
shown below when running command "fallocate -l 128M file"
on a fast_commit-enabled fs:

  kernel BUG at fs/ext4/ext4_extents.h:199!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 3 PID: 624 Comm: fallocate Not tainted 5.14.0-rc6+ #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  RIP: 0010:ext4_fc_write_inode_data+0x1f3/0x200
  Call Trace:
   ? ext4_fc_write_inode+0xf2/0x150
   ext4_fc_commit+0x93b/0xa00
   ? ext4_fallocate+0x1ad/0x10d0
   ext4_sync_file+0x157/0x340
   ? ext4_sync_file+0x157/0x340
   vfs_fsync_range+0x49/0x80
   do_fsync+0x3d/0x70
   __x64_sys_fsync+0x14/0x20
   do_syscall_64+0x3b/0xc0
   entry_SYSCALL_64_after_hwframe+0x44/0xae

Simply fixing it by limiting the number of blocks
in one EXT4_FC_TAG_ADD_RANGE TLV.

Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/ext4/fast_commit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index e8195229c252..782d05a3f97a 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -893,6 +893,12 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 					    sizeof(lrange), (u8 *)&lrange, crc))
 				return -ENOSPC;
 		} else {
+			unsigned int max = (map.m_flags & EXT4_MAP_UNWRITTEN) ?
+				EXT_UNWRITTEN_MAX_LEN : EXT_INIT_MAX_LEN;
+
+			/* Limit the number of blocks in one extent */
+			map.m_len = min(max, map.m_len);
+
 			fc_ext.fc_ino = cpu_to_le32(inode->i_ino);
 			ex = (struct ext4_extent *)&fc_ext.fc_ex;
 			ex->ee_block = cpu_to_le32(map.m_lblk);
-- 
2.29.2


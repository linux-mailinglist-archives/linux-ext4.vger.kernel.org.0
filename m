Return-Path: <linux-ext4+bounces-6238-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C2A1C6FB
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 09:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A2A16518C
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2025 08:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31014B075;
	Sun, 26 Jan 2025 08:27:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E413B280
	for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2025 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737880058; cv=none; b=eY4MQrtbhRaSSOSTxh14JfZb9tgyVMGNuxU/7edFo/773yphIUpV7l1B2sYukPsvXsRJLkpvFzSR+vo+DqFlZGQ8M5qR1ylHdsHYIm6r3ypzahsNFIJuDJ3UwuQxm36Hp5HwhttjB8d7xxtUlU9L5/kNhd2y9vOOXWAuy1HDBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737880058; c=relaxed/simple;
	bh=olUgsS/nE5AUKArHmQYY1nvlJcrhh62yhGHZ/bQ/ZXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3nd386AFVOFFyrd/U82ydZoaPJBJU8C4dP4AwpOH2hKeFZbvGRtxzSUbD6KNevT8+X90fUMYFke11EgCdhqOSrN/NXWyOHWmILrvKpTskExlfd+/7gGAmAVdLih1OAKsyrrSpDNc4B8apOd774Opcw/2OHKYsLOsLzFnHUepcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ygl3H3yJxz22lJJ;
	Sun, 26 Jan 2025 16:24:59 +0800 (CST)
Received: from kwepemd200022.china.huawei.com (unknown [7.221.188.232])
	by mail.maildlp.com (Postfix) with ESMTPS id E97D718001B;
	Sun, 26 Jan 2025 16:27:33 +0800 (CST)
Received: from huawei.com (10.175.101.107) by kwepemd200022.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 26 Jan
 2025 16:27:33 +0800
From: Ye Bin <yebin10@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <jack@suse.cz>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 2/2] ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
Date: Sun, 26 Jan 2025 16:27:31 +0800
Message-ID: <20250126082731.2037385-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126082731.2037385-1-yebin10@huawei.com>
References: <20250126082731.2037385-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200022.china.huawei.com (7.221.188.232)

There's issue as follows:
BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172

CPU: 3 PID: 15172 Comm: syz-executor.0
Call Trace:
 __dump_stack lib/dump_stack.c:82 [inline]
 dump_stack+0xbe/0xfd lib/dump_stack.c:123
 print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
 __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
 kasan_report+0x3a/0x50 mm/kasan/report.c:585
 ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
 ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
 ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
 evict+0x39f/0x880 fs/inode.c:622
 iput_final fs/inode.c:1746 [inline]
 iput fs/inode.c:1772 [inline]
 iput+0x525/0x6c0 fs/inode.c:1758
 ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
 ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
 mount_bdev+0x355/0x410 fs/super.c:1446
 legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
 do_new_mount fs/namespace.c:2983 [inline]
 path_mount+0x119a/0x1ad0 fs/namespace.c:3316
 do_mount+0xfc/0x110 fs/namespace.c:3329
 __do_sys_mount fs/namespace.c:3540 [inline]
 __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

Memory state around the buggy address:
 ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Above issue happens as ext4_xattr_delete_inode() isn't check xattr
is valid if xattr is in inode.
To solve above issue call xattr_check_inode() check if xattr if valid
in inode.

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/xattr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 0e4494863d15..cb724477f8da 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2922,7 +2922,6 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 			    int extra_credits)
 {
 	struct buffer_head *bh = NULL;
-	struct ext4_xattr_ibody_header *header;
 	struct ext4_iloc iloc = { .bh = NULL };
 	struct ext4_xattr_entry *entry;
 	struct inode *ea_inode;
@@ -2937,6 +2936,9 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 
 	if (ext4_has_feature_ea_inode(inode->i_sb) &&
 	    ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
+		struct ext4_xattr_ibody_header *header;
+		struct ext4_inode *raw_inode;
+		void *end;
 
 		error = ext4_get_inode_loc(inode, &iloc);
 		if (error) {
@@ -2952,14 +2954,20 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 			goto cleanup;
 		}
 
-		header = IHDR(inode, ext4_raw_inode(&iloc));
-		if (header->h_magic == cpu_to_le32(EXT4_XATTR_MAGIC))
+		raw_inode = ext4_raw_inode(&iloc);
+		header = IHDR(inode, raw_inode);
+		end = ITAIL(inode, raw_inode);
+		if (header->h_magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
+			error = xattr_check_inode(inode, header, end);
+			if (error)
+				goto cleanup;
 			ext4_xattr_inode_dec_ref_all(handle, inode, iloc.bh,
 						     IFIRST(header),
 						     false /* block_csum */,
 						     ea_inode_array,
 						     extra_credits,
 						     false /* skip_quota */);
+		}
 	}
 
 	if (EXT4_I(inode)->i_file_acl) {
-- 
2.34.1



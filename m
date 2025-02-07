Return-Path: <linux-ext4+bounces-6369-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE2A2B9B8
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 04:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AFE1889DCF
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 03:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C800F183CCA;
	Fri,  7 Feb 2025 03:28:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E96917BB16
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738898882; cv=none; b=BmJLaUoKnwgsn8D/cGjZOLkHvxeyRdtNahP9mwP8rIU6/iXPhwl5bk+Bu63UKc7fVVGWqFMr9FtlC3J0srTM5b0ryrgnKTwf7pECysK/rDux9Af3dgBVs8Drd2VLLYK6xMODKvripuAqw72VxL56jp0r+WFPAoGg+KvUchFvf38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738898882; c=relaxed/simple;
	bh=fBERXcPx7lXgA3SLKxiEMX4xWDIrRgYnHyZOu5T4fCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCSH5JuvWKjoUD1y2SoKNwKrzDlytcVVCIjAtkwU0uocf0Rd8Bawr2ETBykDtC6QO5Y07iv2jaF1i3VmeNPd+uC3A1zPVRciyn8D4kEdfKxgaYI2kw34aMp3afqNmfrFTA4pxEKIslRn/lf+XwKLYkGjcPCyRuBrLRnuqcN09aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YpztS1zdSz4f3kvp
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 11:27:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C9D221A13DD
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 11:27:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2CvfaVn3VOJDA--.47160S6;
	Fri, 07 Feb 2025 11:27:50 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz
Subject: [RESEND PATCH 2/2] ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
Date: Fri,  7 Feb 2025 11:27:43 +0800
Message-Id: <20250207032743.882949-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207032743.882949-1-yebin@huaweicloud.com>
References: <20250207032743.882949-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHK2CvfaVn3VOJDA--.47160S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4xCFyDCFy7Cw4DGr1UAwb_yoWrJFWDp3
	43J348Cr48Xryq9r4xtr45Xw1jg3W7CayUXFWxGryUCFy7Ww1xtFyrKrn8CF4DZrW8Xr9F
	qF1DAr4jg3WrC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07URpBfUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

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



Return-Path: <linux-ext4+bounces-6392-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC4A2D444
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Feb 2025 07:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BD4188F0F2
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Feb 2025 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86114188904;
	Sat,  8 Feb 2025 06:31:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AC155316
	for <linux-ext4@vger.kernel.org>; Sat,  8 Feb 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738996315; cv=none; b=FSkXqrZOhuiPaVAMtSEP8Ng5Uq5wPAyuXiqMZluxQXkocz48RZlE0Jej2H7WCAM80BogY5NllinXPWPKjW+ilUGrql+fH/ZxpOnOd9/QkCOFJhPkXwOtaf8wks72NtUNIZGLLAHT6YnAFZ24fEo9u9RPhM5V+++7fzIzPTdGCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738996315; c=relaxed/simple;
	bh=NyQjkdjXQ04xdBDTPqNOxsv+TLsrRX3E/ReeuecVxA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L6BIJddTxTTF8lbxApTHDhUAk1Ag/BfDUaAIMEqqZ4khCyCk/z+Maj7HsDCpf97vDeCSDaWCoOHQlIgQ892fo/N70+s42WOC8IYafOaAGMhxj72WnC9E93wERdrs7q+jwI14N3FI4Cy0vth6Z2JJ9WN2cJtEC8ih5tE+LT0IeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YqgwB6l0vz4f3jdF
	for <linux-ext4@vger.kernel.org>; Sat,  8 Feb 2025 14:31:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 29DD41A111F
	for <linux-ext4@vger.kernel.org>; Sat,  8 Feb 2025 14:31:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGBN+qZnQ2X1DA--.63634S6;
	Sat, 08 Feb 2025 14:31:44 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz
Subject: [PATCH v2 2/2] ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
Date: Sat,  8 Feb 2025 14:31:41 +0800
Message-Id: <20250208063141.1539283-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208063141.1539283-1-yebin@huaweicloud.com>
References: <20250208063141.1539283-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGBN+qZnQ2X1DA--.63634S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr48Jry5uF4rJw17XFyfCrg_yoW3Jryfp3
	W3t34UCr48XryUWrWIyr13Zw1ag3W7CayUZayxGry8AFy5Wwn7tFyFkF15CF1DArW8G3W2
	qFs8Jr4j93WfC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
in inode. In fact, we can directly verify in ext4_iget_extra_inode(),
so that there is no divergent verification.

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/inode.c |  5 +++++
 fs/ext4/xattr.c | 26 +-------------------------
 fs/ext4/xattr.h |  7 +++++++
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7c54ae5fcbd4..af735386aa44 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4674,6 +4674,11 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		int err;
 
+		err = xattr_check_inode(inode, IHDR(inode, raw_inode),
+					ITAIL(inode, raw_inode));
+		if (err)
+			return err;
+
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
 		err = ext4_find_inline_data_nolock(inode);
 		if (!err && ext4_has_inline_data(inode))
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 0e4494863d15..a10fb8a9d02d 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -308,7 +308,7 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
 
 
-static inline int
+int
 __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			 void *end, const char *function, unsigned int line)
 {
@@ -316,9 +316,6 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			    function, line);
 }
 
-#define xattr_check_inode(inode, header, end) \
-	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
-
 static int
 xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
 		 void *end, int name_index, const char *name, int sorted)
@@ -650,9 +647,6 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
 	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	entry = IFIRST(header);
 	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
 	if (error)
@@ -783,7 +777,6 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_inode *raw_inode;
 	struct ext4_iloc iloc;
-	void *end;
 	int error;
 
 	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
@@ -793,14 +786,9 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	error = ext4_xattr_list_entries(dentry, IFIRST(header),
 					buffer, buffer_size);
 
-cleanup:
 	brelse(iloc.bh);
 	return error;
 }
@@ -868,7 +856,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	qsize_t ea_inode_refs = 0;
-	void *end;
 	int ret;
 
 	lockdep_assert_held_read(&EXT4_I(inode)->xattr_sem);
@@ -879,10 +866,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = ITAIL(inode, raw_inode);
-		ret = xattr_check_inode(inode, header, end);
-		if (ret)
-			goto out;
 
 		for (entry = IFIRST(header); !IS_LAST_ENTRY(entry);
 		     entry = EXT4_XATTR_NEXT(entry))
@@ -2237,9 +2220,6 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	is->s.here = is->s.first;
 	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
-		error = xattr_check_inode(inode, header, is->s.end);
-		if (error)
-			return error;
 		/* Find the named attribute. */
 		error = xattr_find_entry(inode, &is->s.here, is->s.end,
 					 i->name_index, i->name, 0);
@@ -2790,10 +2770,6 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
-
 	ifree = ext4_xattr_free_space(base, &min_offs, base, &total_ino);
 	if (ifree >= isize_diff)
 		goto shift;
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 5197f17ffd9a..1fedf44d4fb6 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -209,6 +209,13 @@ extern int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 extern struct mb_cache *ext4_xattr_create_cache(void);
 extern void ext4_xattr_destroy_cache(struct mb_cache *);
 
+extern int
+__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
+		    void *end, const char *function, unsigned int line);
+
+#define xattr_check_inode(inode, header, end) \
+	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
+
 #ifdef CONFIG_EXT4_FS_SECURITY
 extern int ext4_init_security(handle_t *handle, struct inode *inode,
 			      struct inode *dir, const struct qstr *qstr);
-- 
2.34.1



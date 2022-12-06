Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7587A643AD8
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 02:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiLFBhX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 20:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiLFBhQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 20:37:16 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B472019E;
        Mon,  5 Dec 2022 17:37:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NR31d6zLhz4f3v5K;
        Tue,  6 Dec 2022 09:37:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgDH69jFnI5jZpTsBg--.65169S9;
        Tue, 06 Dec 2022 09:37:13 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 5/6] ext4: rename xattr_find_entry() and __xattr_check_inode()
Date:   Tue,  6 Dec 2022 09:58:05 +0800
Message-Id: <20221206015806.3420321-6-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221206015806.3420321-1-yebin@huaweicloud.com>
References: <20221206015806.3420321-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDH69jFnI5jZpTsBg--.65169S9
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyfJFy3GrWfGFyDCw18Grg_yoWrKFyUpF
        yUJa4DJw48JryUur40yr17Zw1ag3W7Gay7ZayxC3WSyF1kXwn7tFyFkFn8CFyUWr4kWw4a
        qF43K348u3WSk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

xattr_find_entry() and __xattr_check_inode() is in EXT4 xattr module. so
add 'ext4' prefix to unify name style.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/xattr.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index efa623658c12..003fe1f2d6a8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -290,7 +290,7 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 
 
 static int
-__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
+__ext4_xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			 void *end, const char *function, unsigned int line)
 {
 	int error = -EFSCORRUPTED;
@@ -307,11 +307,11 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 	return error;
 }
 
-#define xattr_check_inode(inode, header, end) \
-	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
+#define ext4_xattr_check_inode(inode, header, end) \
+	__ext4_xattr_check_inode((inode), (header), (end), __func__, __LINE__)
 
 static int
-xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
+ext4_xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
 		 void *end, int name_index, const char *name, int sorted)
 {
 	struct ext4_xattr_entry *entry, *next;
@@ -577,7 +577,7 @@ ext4_xattr_block_get(struct inode *inode, int name_index, const char *name,
 	ext4_xattr_block_cache_insert(ea_block_cache, bh);
 	entry = BFIRST(bh);
 	end = bh->b_data + bh->b_size;
-	error = xattr_find_entry(inode, &entry, end, name_index, name, 1);
+	error = ext4_xattr_find_entry(inode, &entry, end, name_index, name, 1);
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
@@ -628,11 +628,11 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
 	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
-	error = xattr_check_inode(inode, header, end);
+	error = ext4_xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
 	entry = IFIRST(header);
-	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
+	error = ext4_xattr_find_entry(inode, &entry, end, name_index, name, 0);
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
@@ -773,7 +773,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
 	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
-	error = xattr_check_inode(inode, header, end);
+	error = ext4_xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
 	error = ext4_xattr_list_entries(dentry, IFIRST(header),
@@ -859,7 +859,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
 		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
-		ret = xattr_check_inode(inode, header, end);
+		ret = ext4_xattr_check_inode(inode, header, end);
 		if (ret)
 			goto out;
 
@@ -1862,7 +1862,7 @@ ext4_xattr_block_find(struct inode *inode, struct ext4_xattr_info *i,
 		bs->s.first = BFIRST(bs->bh);
 		bs->s.end = bs->bh->b_data + bs->bh->b_size;
 		bs->s.here = bs->s.first;
-		error = xattr_find_entry(inode, &bs->s.here, bs->s.end,
+		error = ext4_xattr_find_entry(inode, &bs->s.here, bs->s.end,
 					 i->name_index, i->name, 1);
 		if (error && error != -ENODATA)
 			return error;
@@ -2222,11 +2222,11 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	is->s.here = is->s.first;
 	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
-		error = xattr_check_inode(inode, header, is->s.end);
+		error = ext4_xattr_check_inode(inode, header, is->s.end);
 		if (error)
 			return error;
 		/* Find the named attribute. */
-		error = xattr_find_entry(inode, &is->s.here, is->s.end,
+		error = ext4_xattr_find_entry(inode, &is->s.here, is->s.end,
 					 i->name_index, i->name, 0);
 		if (error && error != -ENODATA)
 			return error;
@@ -2742,7 +2742,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
-	error = xattr_check_inode(inode, header, end);
+	error = ext4_xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
 
-- 
2.31.1


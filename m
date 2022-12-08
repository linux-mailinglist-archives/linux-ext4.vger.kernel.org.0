Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE866466C8
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 03:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLHCLu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 21:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiLHCLp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 21:11:45 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3411192FD0;
        Wed,  7 Dec 2022 18:11:44 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NSHhV5GS9z4f3jLy;
        Thu,  8 Dec 2022 10:11:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgB3m9jbR5Fjj5BiBw--.22193S7;
        Thu, 08 Dec 2022 10:11:41 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v3 3/4] ext4: rename xattr_find_entry() and __xattr_check_inode()
Date:   Thu,  8 Dec 2022 10:32:32 +0800
Message-Id: <20221208023233.1231330-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221208023233.1231330-1-yebin@huaweicloud.com>
References: <20221208023233.1231330-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3m9jbR5Fjj5BiBw--.22193S7
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW8KF1kArW8Wr18uF4fAFb_yoW7XF15pF
        yUta4DJr48JryUur40yr17Zw1ag3W7Ga17ZayxC3WftF1kX3s7tFyFkFn5CFyUWr4kWw42
        qF43K348u3WSk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU2PEfUUUUU
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

Prepend ext4 prefix to function names of xattr_find_entry() and
__xattr_check_inode() for consistency with other functions in ext4
xattr module.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/xattr.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 23cfefc6d262..99dacb0393fa 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -260,8 +260,9 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 
 
 static int
-__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
-			 void *end, const char *function, unsigned int line)
+__ext4_xattr_check_inode(struct inode *inode,
+			 struct ext4_xattr_ibody_header *header, void *end,
+			 const char *function, unsigned int line)
 {
 	int error = -EFSCORRUPTED;
 
@@ -276,12 +277,12 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 	return error;
 }
 
-#define xattr_check_inode(inode, header, end) \
-	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
+#define ext4_xattr_check_inode(inode, header, end) \
+	__ext4_xattr_check_inode((inode), (header), (end), __func__, __LINE__)
 
 static int
-xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
-		 void *end, int name_index, const char *name, int sorted)
+ext4_xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
+		      void *end, int name_index, const char *name, int sorted)
 {
 	struct ext4_xattr_entry *entry, *next;
 	size_t name_len;
@@ -554,7 +555,7 @@ ext4_xattr_block_get(struct inode *inode, int name_index, const char *name,
 	ext4_xattr_block_cache_insert(ea_block_cache, bh);
 	entry = BFIRST(bh);
 	end = bh->b_data + bh->b_size;
-	error = xattr_find_entry(inode, &entry, end, name_index, name, 1);
+	error = ext4_xattr_find_entry(inode, &entry, end, name_index, name, 1);
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
@@ -605,11 +606,11 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
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
@@ -750,7 +751,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
 	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
-	error = xattr_check_inode(inode, header, end);
+	error = ext4_xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
 	error = ext4_xattr_list_entries(dentry, IFIRST(header),
@@ -836,7 +837,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
 		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
-		ret = xattr_check_inode(inode, header, end);
+		ret = ext4_xattr_check_inode(inode, header, end);
 		if (ret)
 			goto out;
 
@@ -1839,8 +1840,8 @@ ext4_xattr_block_find(struct inode *inode, struct ext4_xattr_info *i,
 		bs->s.first = BFIRST(bs->bh);
 		bs->s.end = bs->bh->b_data + bs->bh->b_size;
 		bs->s.here = bs->s.first;
-		error = xattr_find_entry(inode, &bs->s.here, bs->s.end,
-					 i->name_index, i->name, 1);
+		error = ext4_xattr_find_entry(inode, &bs->s.here, bs->s.end,
+					      i->name_index, i->name, 1);
 		if (error && error != -ENODATA)
 			return error;
 		bs->s.not_found = error;
@@ -2199,12 +2200,12 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	is->s.here = is->s.first;
 	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
-		error = xattr_check_inode(inode, header, is->s.end);
+		error = ext4_xattr_check_inode(inode, header, is->s.end);
 		if (error)
 			return error;
 		/* Find the named attribute. */
-		error = xattr_find_entry(inode, &is->s.here, is->s.end,
-					 i->name_index, i->name, 0);
+		error = ext4_xattr_find_entry(inode, &is->s.here, is->s.end,
+					      i->name_index, i->name, 0);
 		if (error && error != -ENODATA)
 			return error;
 		is->s.not_found = error;
@@ -2719,7 +2720,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
-	error = xattr_check_inode(inode, header, end);
+	error = ext4_xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
 
-- 
2.31.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F40C645477
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 08:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLGHUD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 02:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiLGHT4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 02:19:56 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6869631FA9;
        Tue,  6 Dec 2022 23:19:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NRpZY60v8z4f3mSd;
        Wed,  7 Dec 2022 15:19:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBniteWPpBj6qE0Bw--.52253S6;
        Wed, 07 Dec 2022 15:19:52 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 2/6] ext4: add primary check extended attribute inode in ext4_xattr_check_entries()
Date:   Wed,  7 Dec 2022 15:40:39 +0800
Message-Id: <20221207074043.1286731-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221207074043.1286731-1-yebin@huaweicloud.com>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBniteWPpBj6qE0Bw--.52253S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGF13CFykKry7Cw45ur1kGrg_yoW5ZF4rpa
        13Jr98Gr4UJFyDWrySyw1UZwnIga1xGFWjvFyxKw1FyF17Xrn7tFyFqF90kF1jyrWkGw1j
        qa98tr1Uua13u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxU2_MaUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Add primary check for extended attribute inode, only do hash check when read
ea_inode's data in ext4_xattr_inode_get().

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/xattr.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 718ef3987f94..eed001eee3ec 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -83,6 +83,9 @@ static __le32 ext4_xattr_hash_entry(char *name, size_t name_len, __le32 *value,
 				    size_t value_count);
 static void ext4_xattr_rehash(struct ext4_xattr_header *);
 
+static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
+				 u32 ea_inode_hash, struct inode **ea_inode);
+
 static const struct xattr_handler * const ext4_xattr_handler_map[] = {
 	[EXT4_XATTR_INDEX_USER]		     = &ext4_xattr_user_handler,
 #ifdef CONFIG_EXT4_FS_POSIX_ACL
@@ -181,9 +184,32 @@ ext4_xattr_handler(int name_index)
 	return handler;
 }
 
+static inline int ext4_xattr_check_extra_inode(struct inode *inode,
+					       struct ext4_xattr_entry *entry)
+{
+	int err;
+	struct inode *ea_inode;
+
+	err = ext4_xattr_inode_iget(inode, le32_to_cpu(entry->e_value_inum),
+				    le32_to_cpu(entry->e_hash), &ea_inode);
+	if (err)
+		return err;
+
+	if (i_size_read(ea_inode) != le32_to_cpu(entry->e_value_size)) {
+		ext4_warning_inode(ea_inode,
+                           "ea_inode file size=%llu entry size=%u",
+                           i_size_read(ea_inode),
+			   le32_to_cpu(entry->e_value_size));
+		err = -EFSCORRUPTED;
+	}
+	iput(ea_inode);
+
+	return err;
+}
+
 static int
-ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
-			 void *value_start)
+ext4_xattr_check_entries(struct inode *inode, struct ext4_xattr_entry *entry,
+			 void *end, void *value_start)
 {
 	struct ext4_xattr_entry *e = entry;
 
@@ -221,6 +247,10 @@ ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
 			    size > end - value ||
 			    EXT4_XATTR_SIZE(size) > end - value)
 				return -EFSCORRUPTED;
+		} else if (entry->e_value_inum) {
+			int err = ext4_xattr_check_extra_inode(inode, entry);
+			if (err)
+				return err;
 		}
 		entry = EXT4_XATTR_NEXT(entry);
 	}
@@ -243,8 +273,8 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 	error = -EFSBADCRC;
 	if (!ext4_xattr_block_csum_verify(inode, bh))
 		goto errout;
-	error = ext4_xattr_check_entries(BFIRST(bh), bh->b_data + bh->b_size,
-					 bh->b_data);
+	error = ext4_xattr_check_entries(inode, BFIRST(bh),
+					 bh->b_data + bh->b_size, bh->b_data);
 errout:
 	if (error)
 		__ext4_error_inode(inode, function, line, 0, -error,
@@ -268,7 +298,8 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 	if (end - (void *)header < sizeof(*header) + sizeof(u32) ||
 	    (header->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC)))
 		goto errout;
-	error = ext4_xattr_check_entries(IFIRST(header), end, IFIRST(header));
+	error = ext4_xattr_check_entries(inode, IFIRST(header), end,
+					 IFIRST(header));
 errout:
 	if (error)
 		__ext4_error_inode(inode, function, line, 0, -error,
-- 
2.31.1


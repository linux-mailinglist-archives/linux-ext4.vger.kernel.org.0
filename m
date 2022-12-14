Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1483264D105
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 21:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiLNUUo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 15:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiLNUUG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 15:20:06 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2474013DDD
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 12:08:30 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BEK8MIJ011925
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 15:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1671048503; bh=XAbUvKJFKr2cIVu8GmeMPEKwXRkezsxq3RJBoWK4yYk=;
        h=From:To:Cc:Subject:Date;
        b=OE4kIFnLjcHFGA+Vlehi7U5wzf1S6LuUxlCOkSpSwNrhBFPPYEMop9/4yIp6sUOS1
         keBGtPUdl+LoiaPvysrjrrhQsw7aYxP4nXbrqUxC7kpJJaZ4h0ZXOz/TdDX/qln9u1
         ZTSsGe/0sCjAqImlR14Xyb4VVouoMrR8Qwu6FdYV9iaAgUaoR6JTSZXi1eADg3jxrY
         DfYgb82U0KEXxZCPHf8i7jFnl+92LrJPgCz265bbeTGUhNYDZOkjTpIuOMc2N3pQE9
         88wd3zN6Gf4D1TBsG/gWppnosEn1YYp4HWU8ROVk7pTZhouduG6gHCcnWmGVyrDPPV
         HLVhlmmkjnzRA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 001F515C40A2; Wed, 14 Dec 2022 15:08:21 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     yebin@huaweicloud.com, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: improve xattr consistency checking and error reporting
Date:   Wed, 14 Dec 2022 15:08:18 -0500
Message-Id: <20221214200818.870087-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Refactor the in-inode and xattr block consistency checking, and report
more fine-grained reports of the consistency problems.  Also add more
consistency checks for ea_inode number.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/xattr.c | 126 ++++++++++++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 46 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7decaaf27e82..247560cb8016 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -182,27 +182,73 @@ ext4_xattr_handler(int name_index)
 }
 
 static int
-ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
-			 void *value_start)
+check_xattrs(struct inode *inode, struct buffer_head *bh,
+	     struct ext4_xattr_entry *entry, void *end, void *value_start,
+	     const char *function, unsigned int line)
 {
 	struct ext4_xattr_entry *e = entry;
+	int err = -EFSCORRUPTED;
+	char *err_str;
+
+	if (bh) {
+		if (BHDR(bh)->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC) ||
+		    BHDR(bh)->h_blocks != cpu_to_le32(1)) {
+			err_str = "invalid header";
+			goto errout;
+		}
+		if (buffer_verified(bh))
+			return 0;
+		if (!ext4_xattr_block_csum_verify(inode, bh)) {
+			err = -EFSBADCRC;
+			err_str = "invalid checksum";
+			goto errout;
+		}
+	} else {
+		struct ext4_xattr_ibody_header *header = value_start;
+
+		header -= 1;
+		if (end - (void *)header < sizeof(*header) + sizeof(u32)) {
+			err_str = "in-inode xattr block too small";
+			goto errout;
+		}
+		if (header->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC)) {
+			err_str = "bad magic number in in-inode xattr";
+			goto errout;
+		}
+	}
 
 	/* Find the end of the names list */
 	while (!IS_LAST_ENTRY(e)) {
 		struct ext4_xattr_entry *next = EXT4_XATTR_NEXT(e);
-		if ((void *)next >= end)
-			return -EFSCORRUPTED;
-		if (strnlen(e->e_name, e->e_name_len) != e->e_name_len)
-			return -EFSCORRUPTED;
+		if ((void *)next >= end) {
+			err_str = "e_name out of bounds";
+			goto errout;
+		}
+		if (strnlen(e->e_name, e->e_name_len) != e->e_name_len) {
+			err_str = "bad e_name length";
+			goto errout;
+		}
 		e = next;
 	}
 
 	/* Check the values */
 	while (!IS_LAST_ENTRY(entry)) {
 		u32 size = le32_to_cpu(entry->e_value_size);
+		unsigned long ea_ino = le32_to_cpu(entry->e_value_inum);
 
-		if (size > EXT4_XATTR_SIZE_MAX)
-			return -EFSCORRUPTED;
+		if (!ext4_has_feature_ea_inode(inode->i_sb) && ea_ino) {
+			err_str = "ea_inode specified without ea_inode feature enabled";
+			goto errout;
+		}
+		if (ea_ino && ((ea_ino == EXT4_ROOT_INO) ||
+			       !ext4_valid_inum(inode->i_sb, ea_ino))) {
+			err_str = "invalid ea_ino";
+			goto errout;
+		}
+		if (size > EXT4_XATTR_SIZE_MAX) {
+			err_str = "e_value size too large";
+			goto errout;
+		}
 
 		if (size != 0 && entry->e_value_inum == 0) {
 			u16 offs = le16_to_cpu(entry->e_value_offs);
@@ -214,66 +260,54 @@ ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
 			 * the padded and unpadded sizes, since the size may
 			 * overflow to 0 when adding padding.
 			 */
-			if (offs > end - value_start)
-				return -EFSCORRUPTED;
+			if (offs > end - value_start) {
+				err_str = "e_value out of bounds";
+				goto errout;
+			}
 			value = value_start + offs;
 			if (value < (void *)e + sizeof(u32) ||
 			    size > end - value ||
-			    EXT4_XATTR_SIZE(size) > end - value)
-				return -EFSCORRUPTED;
+			    EXT4_XATTR_SIZE(size) > end - value) {
+				err_str = "overlapping e_value ";
+				goto errout;
+			}
 		}
 		entry = EXT4_XATTR_NEXT(entry);
 	}
-
+	if (bh)
+		set_buffer_verified(bh);
 	return 0;
+
+errout:
+	if (bh)
+		__ext4_error_inode(inode, function, line, 0, -err,
+				   "corrupted xattr block %llu: %s",
+				   (unsigned long long) bh->b_blocknr,
+				   err_str);
+	else
+		__ext4_error_inode(inode, function, line, 0, -err,
+				   "corrupted in-inode xattr: %s", err_str);
+	return err;
 }
 
 static inline int
 __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 			 const char *function, unsigned int line)
 {
-	int error = -EFSCORRUPTED;
-
-	if (BHDR(bh)->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC) ||
-	    BHDR(bh)->h_blocks != cpu_to_le32(1))
-		goto errout;
-	if (buffer_verified(bh))
-		return 0;
-
-	error = -EFSBADCRC;
-	if (!ext4_xattr_block_csum_verify(inode, bh))
-		goto errout;
-	error = ext4_xattr_check_entries(BFIRST(bh), bh->b_data + bh->b_size,
-					 bh->b_data);
-errout:
-	if (error)
-		__ext4_error_inode(inode, function, line, 0, -error,
-				   "corrupted xattr block %llu",
-				   (unsigned long long) bh->b_blocknr);
-	else
-		set_buffer_verified(bh);
-	return error;
+	return check_xattrs(inode, bh, BFIRST(bh), bh->b_data + bh->b_size,
+			    bh->b_data, function, line);
 }
 
 #define ext4_xattr_check_block(inode, bh) \
 	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
 
 
-static int
+static inline int
 __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			 void *end, const char *function, unsigned int line)
 {
-	int error = -EFSCORRUPTED;
-
-	if (end - (void *)header < sizeof(*header) + sizeof(u32) ||
-	    (header->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC)))
-		goto errout;
-	error = ext4_xattr_check_entries(IFIRST(header), end, IFIRST(header));
-errout:
-	if (error)
-		__ext4_error_inode(inode, function, line, 0, -error,
-				   "corrupted in-inode xattr");
-	return error;
+	return check_xattrs(inode, NULL, IFIRST(header), end, IFIRST(header),
+			    function, line);
 }
 
 #define xattr_check_inode(inode, header, end) \
-- 
2.31.0


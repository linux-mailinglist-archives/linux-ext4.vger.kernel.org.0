Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7765512DACD
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 19:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfLaSGC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Dec 2019 13:06:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfLaSGC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 31 Dec 2019 13:06:02 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB6A206E6
        for <linux-ext4@vger.kernel.org>; Tue, 31 Dec 2019 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577815561;
        bh=/9+gRCOFN6Z43S0kuOiNIYDvorZPATF0syR1h/cXBqc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AOd2A19go+uDmSMQXkpG+flgkfxLp/XVYJ+jW7bBH7lsCedvzbWJlC1+73WMQbcjm
         thSdatveid5EKRO5NIigyzppolGt/VRTCl+c3fV2QXEVOdkdtintmvb0VVR+C2giUp
         10yp3YZ3QoZakEyIU67AX7/QGF4lCb13ZKOzFc+8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/8] ext4: clean up len and offset checks in ext4_fallocate()
Date:   Tue, 31 Dec 2019 12:04:38 -0600
Message-Id: <20191231180444.46586-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191231180444.46586-1-ebiggers@kernel.org>
References: <20191231180444.46586-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

- Fix some comments.

- Consistently access i_size directly rather than using i_size_read(),
  since in all relevant cases we're under inode_lock().

- Simplify the alignment checks by using the IS_ALIGNED() macro.

- In ext4_insert_range(), do the check against s_maxbytes in a way
  that is safe against signed overflow.  (This doesn't currently matter
  for ext4 due to ext4's limited max file size, but this is something
  other filesystems have gotten wrong.  We might as well do it safely.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/extents.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c6c89e38f43a..21d39758d522 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4715,7 +4715,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	    (offset + len > i_size_read(inode) ||
+	    (offset + len > inode->i_size ||
 	     offset + len > EXT4_I(inode)->i_disksize)) {
 		new_size = offset + len;
 		ret = inode_newsize_ok(inode, new_size);
@@ -4799,7 +4799,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		* Mark that we allocate beyond EOF so the subsequent truncate
 		* can proceed even if the new size is the same as i_size.
 		*/
-		if ((offset + len) > i_size_read(inode))
+		if (offset + len > inode->i_size)
 			ext4_set_inode_flag(inode, EXT4_INODE_EOFBLOCKS);
 	}
 	ext4_mark_inode_dirty(handle, inode);
@@ -4886,7 +4886,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	}
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	    (offset + len > i_size_read(inode) ||
+	    (offset + len > inode->i_size ||
 	     offset + len > EXT4_I(inode)->i_disksize)) {
 		new_size = offset + len;
 		ret = inode_newsize_ok(inode, new_size);
@@ -5434,9 +5434,8 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		return -EOPNOTSUPP;
 
-	/* Collapse range works only on fs block size aligned offsets. */
-	if (offset & (EXT4_CLUSTER_SIZE(sb) - 1) ||
-	    len & (EXT4_CLUSTER_SIZE(sb) - 1))
+	/* Collapse range works only on fs cluster size aligned regions. */
+	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
 		return -EINVAL;
 
 	if (!S_ISREG(inode->i_mode))
@@ -5459,7 +5458,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	 * There is no need to overlap collapse range with EOF, in which case
 	 * it is effectively a truncate operation
 	 */
-	if (offset + len >= i_size_read(inode)) {
+	if (offset + len >= inode->i_size) {
 		ret = -EINVAL;
 		goto out_mutex;
 	}
@@ -5537,7 +5536,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		goto out_stop;
 	}
 
-	new_size = i_size_read(inode) - len;
+	new_size = inode->i_size - len;
 	i_size_write(inode, new_size);
 	EXT4_I(inode)->i_disksize = new_size;
 
@@ -5584,9 +5583,8 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		return -EOPNOTSUPP;
 
-	/* Insert range works only on fs block size aligned offsets. */
-	if (offset & (EXT4_CLUSTER_SIZE(sb) - 1) ||
-			len & (EXT4_CLUSTER_SIZE(sb) - 1))
+	/* Insert range works only on fs cluster size aligned regions. */
+	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
 		return -EINVAL;
 
 	if (!S_ISREG(inode->i_mode))
@@ -5611,14 +5609,14 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		goto out_mutex;
 	}
 
-	/* Check for wrap through zero */
-	if (inode->i_size + len > inode->i_sb->s_maxbytes) {
+	/* Check whether the maximum file size would be exceeded */
+	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
 		ret = -EFBIG;
 		goto out_mutex;
 	}
 
-	/* Offset should be less than i_size */
-	if (offset >= i_size_read(inode)) {
+	/* Offset must be less than i_size */
+	if (offset >= inode->i_size) {
 		ret = -EINVAL;
 		goto out_mutex;
 	}
-- 
2.24.1


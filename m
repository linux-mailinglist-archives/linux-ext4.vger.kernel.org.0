Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C3F12DACB
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 19:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLaSGC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Dec 2019 13:06:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfLaSGC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 31 Dec 2019 13:06:02 -0500
Received: from zzz.tds (h75-100-12-111.burkwi.broadband.dynamic.tds.net [75.100.12.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE28C206D9
        for <linux-ext4@vger.kernel.org>; Tue, 31 Dec 2019 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577815561;
        bh=nsbsUds6zZItgcM2DWFyT9cJRtpjoSnHLMRJNTuwByw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=V3qezYn9yRBic0m4lj1I+rijUoLD9rxkKvMhhbB7HgMbyu0Mbn1CFdrvUvnHukHPV
         LX5JLA04AObW+NswFFzNLtn1v2DCyfYM2G2XvkKatg0OIJwqO8D94tM0BTpAjL+Ecr
         GefzsJXo+U+KNRwaZ3QJ+RBKkQkWw31k1OGa6kO0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 3/8] ext4: remove redundant S_ISREG() checks from ext4_fallocate()
Date:   Tue, 31 Dec 2019 12:04:39 -0600
Message-Id: <20191231180444.46586-4-ebiggers@kernel.org>
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

ext4_fallocate() is only used in the file_operations for regular files.
Also, the VFS only allows fallocate() on regular files and block
devices, but block devices always use blkdev_fallocate().  For both of
these reasons, S_ISREG() is always true in ext4_fallocate().

Therefore the S_ISREG() checks in ext4_zero_range(),
ext4_collapse_range(), ext4_insert_range(), and ext4_punch_hole() are
redundant.  Remove them.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/extents.c | 9 ---------
 fs/ext4/inode.c   | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 21d39758d522..296ad7fcc302 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4673,9 +4673,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 	trace_ext4_zero_range(inode, offset, len, mode);
 
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
-
 	/* Call ext4_force_commit to flush all data in case of data=journal. */
 	if (ext4_should_journal_data(inode)) {
 		ret = ext4_force_commit(inode->i_sb);
@@ -5438,9 +5435,6 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
 		return -EINVAL;
 
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
-
 	trace_ext4_collapse_range(inode, offset, len);
 
 	punch_start = offset >> EXT4_BLOCK_SIZE_BITS(sb);
@@ -5587,9 +5581,6 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
 		return -EINVAL;
 
-	if (!S_ISREG(inode->i_mode))
-		return -EOPNOTSUPP;
-
 	trace_ext4_insert_range(inode, offset, len);
 
 	offset_lblk = offset >> EXT4_BLOCK_SIZE_BITS(sb);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6586b29e9f2f..32ab4d4074be 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3916,9 +3916,6 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 	unsigned int credits;
 	int ret = 0;
 
-	if (!S_ISREG(inode->i_mode))
-		return -EOPNOTSUPP;
-
 	trace_ext4_punch_hole(inode, offset, length, 0);
 
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
-- 
2.24.1


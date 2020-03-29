Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348AA196FDF
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 22:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgC2UVz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Mar 2020 16:21:55 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53763 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgC2UVz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Mar 2020 16:21:55 -0400
X-Originating-IP: 50.39.173.182
Received: from localhost (50-39-173-182.bvtn.or.frontiernet.net [50.39.173.182])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6362E1C0003;
        Sun, 29 Mar 2020 20:21:50 +0000 (UTC)
Date:   Sun, 29 Mar 2020 13:21:41 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Fix return-value types in several function
 documentation comments
Message-ID: <60a3f4996f4932c45515aaa6b75ca42f2a78ec9b.1585512514.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The documentation comments for ext4_read_block_bitmap_nowait and
ext4_read_inode_bitmap describe them as returning NULL on error, but
they return an ERR_PTR on error; update the documentation to match.

The documentation comment for ext4_wait_block_bitmap describes it as
returning 1 on error, but it returns -errno on error; update the
documentation to match.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 fs/ext4/balloc.c | 4 ++--
 fs/ext4/ialloc.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8fd0b3cdab4c..9a296008cf90 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -410,7 +410,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
  * Read the bitmap for a given block_group,and validate the
  * bits for block/inode/inode tables are set in the bitmaps
  *
- * Return buffer_head on success or NULL in case of failure.
+ * Return buffer_head on success or an ERR_PTR in case of failure.
  */
 struct buffer_head *
 ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
@@ -502,7 +502,7 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group)
 	return ERR_PTR(err);
 }
 
-/* Returns 0 on success, 1 on error */
+/* Returns 0 on success, -errno on error */
 int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
 			   struct buffer_head *bh)
 {
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index f95ee99091e4..86a96dca9ebf 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -113,7 +113,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
  * Read the inode allocation bitmap for a given block_group, reading
  * into the specified slot in the superblock's bitmap cache.
  *
- * Return buffer_head of bitmap on success or NULL.
+ * Return buffer_head of bitmap on success, or an ERR_PTR on error.
  */
 static struct buffer_head *
 ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
-- 
2.26.0


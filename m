Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635E4F1602
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 13:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfKFMZN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 07:25:13 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:56330 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727391AbfKFMZN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 07:25:13 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 155792E1536;
        Wed,  6 Nov 2019 15:25:10 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id B7r0ZSOaEi-P9jqPFrZ;
        Wed, 06 Nov 2019 15:25:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573043110; bh=VNHTVJgiBUzRXMvTsn/63vksAZQWaIt9D9leamx225k=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=a/qh8MSzvdoEc4YjBPAezu1hAKoFKFK93V3G1EVLp+mXgsAknaQR1048WyF6uXw8B
         7lGUqot/1NIcGJard1vVrq/k03BwfeAKKeXswhpcRXXBWQqtBfqj0Ec+iF/tuVzL9I
         uWg7biEO6R7DMh2bhKEoTqAoACOd8YNj7XaqL+9s=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by vla5-2bf13a090f43.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id cXS3Q0ownK-P9XWnhYl;
        Wed, 06 Nov 2019 15:25:09 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Dmitry Monakhov <dmonakhov@gmail.com>
Subject: [PATCH] ext4: fix extent_status fragmentation for plain files
Date:   Wed,  6 Nov 2019 12:25:02 +0000
Message-Id: <20191106122502.19986-1-dmonakhov@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It is appeared that extent are not cached for inodes with depth == 0
which result in suboptimal extent status populating inside ext4_map_blocks()
by map's result where size requested is usually smaller than extent size so
cache becomes fragmented

# Example: I have plain file:
File size of /mnt/test is 33554432 (8192 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..    8191:      40960..     49151:   8192:             last,eof

$ perf record -e 'ext4:ext4_es_*' /root/bin/fio --name=t --direct=0 --rw=randread --bs=4k --filesize=32M --size=32M --filename=/mnt/test
$ perf script | grep ext4_es_insert_extent | head -n 10
             fio   131 [000]    13.975421:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [494/1) mapped 41454 status W
             fio   131 [000]    13.975939:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [6064/1) mapped 47024 status W
             fio   131 [000]    13.976467:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [6907/1) mapped 47867 status W
             fio   131 [000]    13.976937:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [3850/1) mapped 44810 status W
             fio   131 [000]    13.977440:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [3292/1) mapped 44252 status W
             fio   131 [000]    13.977931:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [6882/1) mapped 47842 status W
             fio   131 [000]    13.978376:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [3117/1) mapped 44077 status W
             fio   131 [000]    13.978957:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [2896/1) mapped 43856 status W
             fio   131 [000]    13.979474:           ext4:ext4_es_insert_extent: dev 253,0 ino 12 es [7479/1) mapped 48439 status W

This is wrong, we should cache extents inside ext4_find_extent() as we already do for inodes with depth > 0

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
---
 fs/ext4/extents.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index fb0f99d..24d6bfd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -498,6 +498,30 @@ int ext4_ext_check_inode(struct inode *inode)
 	return ext4_ext_check(inode, ext_inode_hdr(inode), ext_depth(inode), 0);
 }
 
+static void  ext4_es_cache_extents(struct inode *inode,
+				   struct ext4_extent_header *eh)
+{
+	struct ext4_extent *ex = EXT_FIRST_EXTENT(eh);
+	ext4_lblk_t prev = 0;
+	int i;
+
+	for (i = le16_to_cpu(eh->eh_entries); i > 0; i--, ex++) {
+		unsigned int status = EXTENT_STATUS_WRITTEN;
+		ext4_lblk_t lblk = le32_to_cpu(ex->ee_block);
+		int len = ext4_ext_get_actual_len(ex);
+
+		if (prev && (prev != lblk))
+			ext4_es_cache_extent(inode, prev, lblk - prev, ~0,
+					     EXTENT_STATUS_HOLE);
+
+		if (ext4_ext_is_unwritten(ex))
+			status = EXTENT_STATUS_UNWRITTEN;
+		ext4_es_cache_extent(inode, lblk, len,
+				     ext4_ext_pblock(ex), status);
+		prev = lblk + len;
+	}
+}
+
 static struct buffer_head *
 __read_extent_tree_block(const char *function, unsigned int line,
 			 struct inode *inode, ext4_fsblk_t pblk, int depth,
@@ -532,26 +556,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
 	 */
 	if (!(flags & EXT4_EX_NOCACHE) && depth == 0) {
 		struct ext4_extent_header *eh = ext_block_hdr(bh);
-		struct ext4_extent *ex = EXT_FIRST_EXTENT(eh);
-		ext4_lblk_t prev = 0;
-		int i;
-
-		for (i = le16_to_cpu(eh->eh_entries); i > 0; i--, ex++) {
-			unsigned int status = EXTENT_STATUS_WRITTEN;
-			ext4_lblk_t lblk = le32_to_cpu(ex->ee_block);
-			int len = ext4_ext_get_actual_len(ex);
-
-			if (prev && (prev != lblk))
-				ext4_es_cache_extent(inode, prev,
-						     lblk - prev, ~0,
-						     EXTENT_STATUS_HOLE);
-
-			if (ext4_ext_is_unwritten(ex))
-				status = EXTENT_STATUS_UNWRITTEN;
-			ext4_es_cache_extent(inode, lblk, len,
-					     ext4_ext_pblock(ex), status);
-			prev = lblk + len;
-		}
+		ext4_es_cache_extents(inode, eh);
 	}
 	return bh;
 errout:
@@ -899,6 +904,8 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	path[0].p_bh = NULL;
 
 	i = depth;
+	if (!(flags & EXT4_EX_NOCACHE) && depth == 0)
+		ext4_es_cache_extents(inode, eh);
 	/* walk through the tree */
 	while (i) {
 		ext_debug("depth %d: num %d, max %d\n",
-- 
2.7.4


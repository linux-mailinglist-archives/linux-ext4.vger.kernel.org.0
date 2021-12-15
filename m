Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358A647591C
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 13:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbhLOMwd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 07:52:33 -0500
Received: from esa3.hc324-48.eu.iphmx.com ([207.54.68.121]:52615 "EHLO
        esa3.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232543AbhLOMwc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Dec 2021 07:52:32 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 07:52:32 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1639572752; x=1671108752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nGPGiTmIUZ9HE3Q8A9pcQ/5tz5gDV2sT/wDfdLgNWM8=;
  b=FgF8fwsMFBmqeh9mtkSpff5UshxnvA8KztuLOQkTZyopFpWk9QpBoZsg
   aFoOu9GBJwVA+ZahWEfLwi1ZwKZs1ajNCPKdi0DIY4QxiMDVa2KG7njen
   xWbMvynPYFloUGqQb34KdN4qLDGVL+NwIv12L2H7FlR71w4RGyX4lOBiP
   4=;
IronPort-SDR: USP+bp1qT2C9EZARP8IEIkvGGFlFyZ16WGt0MKv00opFTUnztzNNAZpnhV4LKLwpAcg/3lYXCL
 ulwctZUO97NqEYcXaVw7Wez/nB9582672oKEzxPFC9BQH9VRZ5R1x+aj4GQ+7qSN52xjY9MwtN
 vYhHUVcIOsOfWPiA+QeQl2WAAPob6qJy8wMbHBkd//uJ12arIq81k9DD0O2M7gmcr9pSJX5eI3
 GxSm54r2D3MLQoqNA2X1QLDhBBEARfbJETviIamxubqTaxSp28U+JUSPeMHV8KtNDjS25m7bCl
 e72C94Fsit/iQCwYKhKZWC3X
Received: from esagw5.bmwgroup.com (HELO esagw5.muc) ([160.46.252.46]) by
 esa3.hc324-48.eu.iphmx.com with ESMTP/TLS; 15 Dec 2021 13:45:23 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw5.muc with ESMTP/TLS;
 15 Dec 2021 13:45:19 +0100
Received: from smucm13k.bmwgroup.net (HELO smucm13k.europe.bmw.corp) ([160.48.96.59])
 by esabb2.muc with ESMTP/TLS; 15 Dec 2021 13:45:19 +0100
Received: from beeblebrox.bmw-carit.intra (192.168.221.33) by smucm13k.europe.bmw.corp
 (160.48.96.59) with Microsoft SMTP Server (TLS;
 Wed, 15 Dec 2021 13:45:17 +0100
From:   Clemens Lang <clemens.lang@bmw.de>
To:     <linux-ext4@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>
CC:     Mikko Rapeli <mikko.rapeli@bmw.de>,
        Clemens Lang <clemens.lang@bmw.de>
Subject: [PATCH] ext2simg: Fix off-by-one errors causing corruption
Date:   Wed, 15 Dec 2021 13:44:52 +0100
Message-ID: <20211215124452.2934059-1-clemens.lang@bmw.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucm09m.europe.bmw.corp (160.48.96.45) To
 smucm13k.europe.bmw.corp (160.48.96.59)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If your filesystem is contiguously used from block 0 to block 524286
with a 4096 byte block size, block 524286 did not end up in the sparse
image and was thus restored as zeros when unsparsing.

Additionally, if the last block of the image is used, this block also
ended up being 0:

$> dd if=/dev/zero of=test.ext4 bs=4096 count=10240
$> mkfs.ext4 test.ext4
$> mkdir test
$> sudo mount -t ext4 -o loop test.ext4 test
$> sudo dd if=/dev/urandom of=test/contents
$> sudo umount test
$> ext2simg test.ext4 test.ext4.simg
$> simg2img test.ext4.simg test.ext4.restored
$> vimdiff <(debugfs -R 'bd 10239' test.ext4) <(debugfs -R 'bd 10239' test.ext4.restored)

This seems to have happened because it was not clear that add_chunk()
treats the given end block as exclusive, since the different invocations
of add_chunk() seem to make different assumptions on whether the end
block is included in the sparse image or not. Add documentation to both
the add_chunk function as well as the invocations to clarify this.

This may or may not be the same issue that was reported a few years ago
in https://www.spinics.net/lists/linux-ext4/msg58483.html.

Signed-off-by: Clemens Lang <clemens.lang@bmw.de>
---
 contrib/android/ext2simg.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/contrib/android/ext2simg.c b/contrib/android/ext2simg.c
index 017e16ff..daebb8a8 100644
--- a/contrib/android/ext2simg.c
+++ b/contrib/android/ext2simg.c
@@ -63,6 +63,9 @@ static struct buf_item {
 	void		    *buf[0];
 } *buf_list;
 
+/* Add the blocks [chunk_start, chunk_end) in the filesystem specificed by fs
+ * to the sparse file s. Note that the block at chunk_end is NOT included in
+ * the output. */
 static void add_chunk(ext2_filsys fs, struct sparse_file *s, blk_t chunk_start, blk_t chunk_end)
 {
 	int retval;
@@ -146,16 +149,24 @@ static struct sparse_file *ext_to_sparse(const char *in_file)
 			if (chunk_start == -1) {
 				chunk_start = cur_blk;
 			} else if (cur_blk - chunk_start + 1 == max_blk_per_chunk) {
-				add_chunk(fs, s, chunk_start, cur_blk);
+				/* cur_blk is used, so we must add [chunk_start, cur_blk], i.e.
+				 * pass cur_blk + 1 here. */
+				add_chunk(fs, s, chunk_start, cur_blk + 1);
 				chunk_start = -1;
 			}
 		} else if (chunk_start != -1) {
+			/* cur_blk is unused, so add [chunk_start, cur_blk) */
 			add_chunk(fs, s, chunk_start, cur_blk);
 			chunk_start = -1;
 		}
 	}
-	if (chunk_start != -1)
-		add_chunk(fs, s, chunk_start, cur_blk - 1);
+	if (chunk_start != -1) {
+		/* (cur_blk - 1) must be used, otherwise the code for unused blocks
+		 * above would have processed this. We must include the block, but the
+		 * upper boundary for add_chunk is exclusive, so to add [chunk_start,
+		 * cur_blk - 1] to the sparse image, pass cur_blk. */
+		add_chunk(fs, s, chunk_start, cur_blk);
+	}
 
 	ext2fs_free(fs);
 	return s;
-- 
2.25.1


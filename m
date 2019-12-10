Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0F118E5C
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2019 17:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfLJQ5F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Dec 2019 11:57:05 -0500
Received: from relay.sw.ru ([185.231.240.75]:36462 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfLJQ5F (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Dec 2019 11:57:05 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ieio7-0006yx-JX; Tue, 10 Dec 2019 19:56:19 +0300
Subject: [PATCH RFC 3/3] ext4: Notify block device about fallocate(0)-assigned
 blocks
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Cc:     axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        ktkhai@virtuozzo.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, ajay.joshi@wdc.com, sagi@grimberg.me,
        dsterba@suse.com, chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com
Date:   Tue, 10 Dec 2019 19:56:19 +0300
Message-ID: <157599697948.12112.3846364542350011691.stgit@localhost.localdomain>
In-Reply-To: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Call sb_issue_assign_range() after extent range was allocated
on user request. Hopeful, this helps block device to maintain
its internals in the best way, if this is appliable.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/ext4/ext4.h    |    1 +
 fs/ext4/extents.c |   11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f8578caba40d..fe2263c00c0e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -622,6 +622,7 @@ enum {
 	 * allows jbd2 to avoid submitting data before commit. */
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
 
+#define EXT4_GET_BLOCKS_SUBMIT_ALLOC		0x0800
 /*
  * The bit position of these flags must not overlap with any of the
  * EXT4_GET_BLOCKS_*.  They are used by ext4_find_extent(),
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0e8708b77da6..5f4fc660cbb1 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4490,6 +4490,13 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		ar.len = allocated;
 
 got_allocated_blocks:
+	if ((flags & EXT4_GET_BLOCKS_SUBMIT_ALLOC) && sbi->fallocate) {
+		err = sb_issue_assign_range(inode->i_sb, newblock,
+			EXT4_C2B(sbi, allocated_clusters), GFP_NOFS);
+		if (err)
+			goto free_on_err;
+	}
+
 	/* try to insert new extent into found leaf and return */
 	ext4_ext_store_pblock(&newex, newblock + offset);
 	newex.ee_len = cpu_to_le16(ar.len);
@@ -4506,7 +4513,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	if (!err)
 		err = ext4_ext_insert_extent(handle, inode, &path,
 					     &newex, flags);
-
+free_on_err:
 	if (err && free_on_err) {
 		int fb_flags = flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE ?
 			EXT4_FREE_BLOCKS_NO_QUOT_UPDATE : 0;
@@ -4926,7 +4933,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	lblk = offset >> blkbits;
 
 	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
-	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
+	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT | EXT4_GET_BLOCKS_SUBMIT_ALLOC;
 	if (mode & FALLOC_FL_KEEP_SIZE)
 		flags |= EXT4_GET_BLOCKS_KEEP_SIZE;
 



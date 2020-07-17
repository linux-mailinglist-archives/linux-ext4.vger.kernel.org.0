Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B936223FF7
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGQPyF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 11:54:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54478 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726675AbgGQPyD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 11:54:03 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06HFrx8K029545
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 11:53:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D114E420C55; Fri, 17 Jul 2020 11:53:58 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Alex Zhuravlev <bzzz@whamcloud.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/4] ext4: indicate via a block bitmap read is prefetched via a tracepoint
Date:   Fri, 17 Jul 2020 11:53:51 -0400
Message-Id: <20200717155352.1053040-4-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200717155352.1053040-1-tytso@mit.edu>
References: <20200717155352.1053040-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Modify the ext4_read_block_bitmap_load tracepoint so that it tells us
whether a block bitmap is being prefetched.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/balloc.c            |  2 +-
 include/trace/events/ext4.h | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index aaa9ec5212c8..5a2f8837200c 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -494,7 +494,7 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 	 * submit the buffer_head for reading
 	 */
 	set_buffer_new(bh);
-	trace_ext4_read_block_bitmap_load(sb, block_group);
+	trace_ext4_read_block_bitmap_load(sb, block_group, ignore_locked);
 	bh->b_end_io = ext4_end_bitmap_read;
 	get_bh(bh);
 	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO |
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index cc41d692ae8e..cbcd2e1a608d 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1312,18 +1312,34 @@ DEFINE_EVENT(ext4__bitmap_load, ext4_mb_buddy_bitmap_load,
 	TP_ARGS(sb, group)
 );
 
-DEFINE_EVENT(ext4__bitmap_load, ext4_read_block_bitmap_load,
+DEFINE_EVENT(ext4__bitmap_load, ext4_load_inode_bitmap,
 
 	TP_PROTO(struct super_block *sb, unsigned long group),
 
 	TP_ARGS(sb, group)
 );
 
-DEFINE_EVENT(ext4__bitmap_load, ext4_load_inode_bitmap,
+TRACE_EVENT(ext4_read_block_bitmap_load,
+	TP_PROTO(struct super_block *sb, unsigned long group, bool prefetch),
 
-	TP_PROTO(struct super_block *sb, unsigned long group),
+	TP_ARGS(sb, group, prefetch),
 
-	TP_ARGS(sb, group)
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	__u32,	group			)
+		__field(	bool,	prefetch		)
+
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->group	= group;
+		__entry->prefetch = prefetch;
+	),
+
+	TP_printk("dev %d,%d group %u prefetch %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->group, __entry->prefetch)
 );
 
 TRACE_EVENT(ext4_direct_IO_enter,
-- 
2.24.1


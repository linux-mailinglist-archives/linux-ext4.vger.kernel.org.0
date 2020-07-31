Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94A1234B73
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jul 2020 21:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgGaTId (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Jul 2020 15:08:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59745 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726726AbgGaTIc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Jul 2020 15:08:32 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06VJ8S8O009103
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 15:08:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 60C04420C55; Fri, 31 Jul 2020 15:08:28 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [PATCH 3/4] ext4: indicate via a block bitmap read is prefetched via a tracepoint
Date:   Fri, 31 Jul 2020 15:08:04 -0400
Message-Id: <20200731190805.181253-4-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200731190805.181253-1-tytso@mit.edu>
References: <20200731190805.181253-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Modify the ext4_read_block_bitmap_load tracepoint so that it tells us
whether a block bitmap is being prefetched.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 fs/ext4/balloc.c            |  2 +-
 include/trace/events/ext4.h | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 1e2b1b4093aa..48c3df47748d 100644
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


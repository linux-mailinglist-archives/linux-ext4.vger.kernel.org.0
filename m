Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4DFC072
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 08:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfKNHDm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 02:03:42 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:56370 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbfKNHDm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Nov 2019 02:03:42 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 5C4762E1434;
        Thu, 14 Nov 2019 10:03:39 +0300 (MSK)
Received: from sas2-2e05890d47f7.qloud-c.yandex.net (sas2-2e05890d47f7.qloud-c.yandex.net [2a02:6b8:c08:bd8e:0:640:2e05:890d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id m4gTrxi4AI-3dpaWMZ6;
        Thu, 14 Nov 2019 10:03:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573715019; bh=ZquIgbcaOsP/D1v88E6EEHCAsiNBykH0vtfHs5vfC9s=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=gYcyeXUl5k7aX/L/GOFtH76JkRJO7ph4WLVsmWSO2J1a1doIZCxSFCLwUUFDM4DnO
         VhHCv1kQ2Pw3rfZh5d7qTQeoHgkQw+fQeDl+hs+V87XXcQFLyPxBH+ahDxRLHVbhFr
         Wd2VriL2Nq3pmHyVUWqh2gW8ngAbgxJxgTEv5tnA=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas2-2e05890d47f7.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id MuwuNopcmR-3dWK20Iu;
        Thu, 14 Nov 2019 10:03:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Dmitry Monakhov <dmonakhov@gmail.com>
Subject: [PATCH 2/2] ext4: Fix extent_status trace events
Date:   Thu, 14 Nov 2019 07:03:30 +0000
Message-Id: <20191114070330.14115-3-dmonakhov@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191114070330.14115-1-dmonakhov@gmail.com>
References: <20191114070330.14115-1-dmonakhov@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

 - show pblock only if it has meaningful value
 - Add missed EXTENT_STATUS_REFERENCED decoder
 - Define status flags as explicit numbers instead of implicit enum ones

# before
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [1/4294967294) 576460752303423487 0x8
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [2/4294967293) 576460752303423487 0x18
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [3/4294967292) 576460752303423487 0x18
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [4/4294967291) 576460752303423487 0x18
# after
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [1/4294967294) 0 H
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [2/4294967293) 0 HR
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [3/4294967292) 0 HR
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [4/4294967291) 0 HR

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
---
 fs/ext4/extents_status.h    | 21 +++++++++++++--------
 include/trace/events/ext4.h | 11 ++++++-----
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 131a8b7..64b8fd1 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -30,14 +30,13 @@
 /*
  * These flags live in the high bits of extent_status.es_pblk
  */
-enum {
-	ES_WRITTEN_B,
-	ES_UNWRITTEN_B,
-	ES_DELAYED_B,
-	ES_HOLE_B,
-	ES_REFERENCED_B,
-	ES_FLAGS
-};
+
+#define ES_WRITTEN_B     0
+#define ES_UNWRITTEN_B   1
+#define ES_DELAYED_B     2
+#define ES_HOLE_B        3
+#define ES_REFERENCED_B  4
+#define ES_FLAGS         5
 
 #define ES_SHIFT (sizeof(ext4_fsblk_t)*8 - ES_FLAGS)
 #define ES_MASK (~((ext4_fsblk_t)0) << ES_SHIFT)
@@ -208,6 +207,12 @@ static inline ext4_fsblk_t ext4_es_pblock(struct extent_status *es)
 	return es->es_pblk & ~ES_MASK;
 }
 
+static inline ext4_fsblk_t ext4_es_show_pblock(struct extent_status *es)
+{
+	ext4_fsblk_t pblock = ext4_es_pblock(es);
+	return pblock == ~ES_MASK ? 0 : pblock;
+}
+
 static inline void ext4_es_store_pblock(struct extent_status *es,
 					ext4_fsblk_t pb)
 {
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index d68e9e5..bdb5fc4 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -66,7 +66,8 @@ struct partial_cluster;
 	{ EXTENT_STATUS_WRITTEN,	"W" },			\
 	{ EXTENT_STATUS_UNWRITTEN,	"U" },			\
 	{ EXTENT_STATUS_DELAYED,	"D" },			\
-	{ EXTENT_STATUS_HOLE,		"H" })
+	{ EXTENT_STATUS_HOLE,		"H" },			\
+	{ EXTENT_STATUS_REFERENCED,	"R" })
 
 #define show_falloc_mode(mode) __print_flags(mode, "|",		\
 	{ FALLOC_FL_KEEP_SIZE,		"KEEP_SIZE"},		\
@@ -2262,7 +2263,7 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
-		__entry->pblk	= ext4_es_pblock(es);
+		__entry->pblk	= ext4_es_show_pblock(es);
 		__entry->status	= ext4_es_status(es);
 	),
 
@@ -2351,7 +2352,7 @@ TRACE_EVENT(ext4_es_find_extent_range_exit,
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
-		__entry->pblk	= ext4_es_pblock(es);
+		__entry->pblk	= ext4_es_show_pblock(es);
 		__entry->status	= ext4_es_status(es);
 	),
 
@@ -2405,7 +2406,7 @@ TRACE_EVENT(ext4_es_lookup_extent_exit,
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
-		__entry->pblk	= ext4_es_pblock(es);
+		__entry->pblk	= ext4_es_show_pblock(es);
 		__entry->status	= ext4_es_status(es);
 		__entry->found	= found;
 	),
@@ -2573,7 +2574,7 @@ TRACE_EVENT(ext4_es_insert_delayed_block,
 		__entry->ino		= inode->i_ino;
 		__entry->lblk		= es->es_lblk;
 		__entry->len		= es->es_len;
-		__entry->pblk		= ext4_es_pblock(es);
+		__entry->pblk		= ext4_es_show_pblock(es);
 		__entry->status		= ext4_es_status(es);
 		__entry->allocated	= allocated;
 	),
-- 
2.7.4


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22FDAFCF09
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 21:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKNUCJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 15:02:09 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:39892 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726557AbfKNUCJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Nov 2019 15:02:09 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id DA7512E1527;
        Thu, 14 Nov 2019 23:02:06 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id H5yq8WjJCQ-26I8IdAc;
        Thu, 14 Nov 2019 23:02:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573761726; bh=4mIMnRFLTV9Wv97TCaZQLfjHqdrqLsZHtLSW4c2W8rQ=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=0IAYbc0tw8re7KeDtCskmBdXg9tG17fsM0fiV2xEPuXltItM667IRutwdQdnpWAzZ
         4MLczuVlNDAlcCawiip8wR3PDplCmvIe8xAbf8ptIm7uEN6BG0Tfwzotm3zo1POBIj
         2xyxvp1sfmVEmNkEb25avQW9GLeJZ4xRgaDZ+ue4=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by vla5-2bf13a090f43.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id oLMREPc4p1-26X01xLg;
        Thu, 14 Nov 2019 23:02:06 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     darrick.wong@oracle.com, tytso@mit.edu,
        Dmitry Monakhov <dmonakhov@gmail.com>
Subject: [PATCH 2/2] ext4: fix extent_status trace points
Date:   Thu, 14 Nov 2019 20:01:47 +0000
Message-Id: <20191114200147.1073-2-dmonakhov@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191114200147.1073-1-dmonakhov@gmail.com>
References: <20191114200147.1073-1-dmonakhov@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Show pblock only if it has meaningful value.

# before
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [1/4294967294) 576460752303423487 H
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [2/4294967293) 576460752303423487 HR
# after
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [1/4294967294) 0 H
   ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [2/4294967293) 0 HR

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
---
 fs/ext4/extents_status.h    | 6 ++++++
 include/trace/events/ext4.h | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 825313c..4ec30a7 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -209,6 +209,12 @@ static inline ext4_fsblk_t ext4_es_pblock(struct extent_status *es)
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
index 3bf7128..19c8766 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2282,7 +2282,7 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
-		__entry->pblk	= ext4_es_pblock(es);
+		__entry->pblk	= ext4_es_show_pblock(es);
 		__entry->status	= ext4_es_status(es);
 	),
 
@@ -2371,7 +2371,7 @@ TRACE_EVENT(ext4_es_find_extent_range_exit,
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
-		__entry->pblk	= ext4_es_pblock(es);
+		__entry->pblk	= ext4_es_show_pblock(es);
 		__entry->status	= ext4_es_status(es);
 	),
 
@@ -2425,7 +2425,7 @@ TRACE_EVENT(ext4_es_lookup_extent_exit,
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
-		__entry->pblk	= ext4_es_pblock(es);
+		__entry->pblk	= ext4_es_show_pblock(es);
 		__entry->status	= ext4_es_status(es);
 		__entry->found	= found;
 	),
@@ -2593,7 +2593,7 @@ TRACE_EVENT(ext4_es_insert_delayed_block,
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


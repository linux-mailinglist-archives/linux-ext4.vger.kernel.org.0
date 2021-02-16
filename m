Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB10C31D0CE
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Feb 2021 20:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhBPTRd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Feb 2021 14:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhBPTRX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Feb 2021 14:17:23 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A54C061574
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 11:16:42 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id g3so5180285qvl.2
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 11:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6+vAO3u8KNBhRR19KuJslmRh13LTzGbB8WRZcIyBJ4=;
        b=aFzdTFLue2k2HBd+JMET9jqEMoAu05A2SMHu7UTDA+LpVIJ3F2oB3FJXYWSMKLLuFl
         gXzH32DbDU3e47GgZiKDSoqqkBjdZqcuHZrzVtSB04Oh2zIAOZG4SfYGd1vxOfiW5aOm
         ARneNB+gU98FoTHAo03RgXBPCfp5f4NEDShqEGvHhOZYvuaxfbKhf+pe6J60Tr6CnBKl
         C45tr/ivVRVkvWR/Eu28XkbNRB2vQpCZFmhyQTL6TY9cgDSBKojEReXKbMbiAEOb1T07
         xkqsz0eXZBe6w1z3gaDy1pHpim9gRJ6y++UULz3IkJOcAJmGZAb22uSDja5EpB+Nsz5M
         g09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6+vAO3u8KNBhRR19KuJslmRh13LTzGbB8WRZcIyBJ4=;
        b=PG0HspCfLXwnAol77rS5LFP8VqxqMKUv8O024UM4ApuOS/+p5VQ0LhRKMOpTBbZdwn
         7en9SxD0Ng7rrWaTF/1JSvswnrLQIAyQbeSd/eo5DgNiwBbCcqwXATuNUSPhSs1H6QRJ
         GUFfr1xRbS8g07XaMJRoUBRj4UPkPm/GXK7iugJeirpaIYhjNMMoad/m4Nn7rXZTKBTA
         Eghd2X0+ik4AfuVSn5cpkse8nedagReEf4jRT85du4b7/AHXG/PD9GkuIzOz9cieV0cj
         bFQAo1nlYeaSlG1wb4osFlHM+QesZsLQ5OE4Bp+z+UHTxGx6DnsAhdcTxYYxb6YQPTor
         iCNA==
X-Gm-Message-State: AOAM530HhwiRlMurSbAz2TjfVN8HFcQQFLjxlqbq2J51ly2CFFr5qEnV
        b4mbbiU6SyA3Fxzbr4iVThuA63p+ES0=
X-Google-Smtp-Source: ABdhPJwJeGwJkHI2NZvAWJuwBKpNX4fYuY8MF8Fb7cxdGCD82W/Mc5Bp1h/PvvOAe9/ZnVQK/+AVdQ==
X-Received: by 2002:a05:6214:574:: with SMTP id cj20mr21302998qvb.37.1613503001899;
        Tue, 16 Feb 2021 11:16:41 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id t128sm15097800qka.46.2021.02.16.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 11:16:41 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH v2] ext4: delete some unused tracepoint definitions
Date:   Tue, 16 Feb 2021 14:16:34 -0500
Message-Id: <20210216191634.20957-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A number of tracepoint instances have been removed from ext4 by past
patches but the definitions of those tracepoints have not.

All instances of ext4_ext_in_cache and ext4_ext_put_in_cache were
removed by "ext4: remove single extent cache" (69eb33dc24dc).
ext4_get_reserved_cluster_alloc was removed by
"ext4: reduce reserved cluster count by number of allocated clusters"
(b6bf9171ef5c).
ext4_find_delalloc_range was removed by
"ext4: reimplement ext4_find_delay_alloc_range on extent status tree"
(7d1b1fbc95eb).

v2:  After a full review, delete two more tracepoint definitions.
All instances of ext4_direct_IO_enter and ext4_direct_IO_exit were
removed by "ext4: introduce direct I/O write using iomap infrastructure"
(378f32bab371).

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 include/trace/events/ext4.h | 176 ------------------------------------
 1 file changed, 176 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 70ae5497b73a..0ea36b2b0662 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1358,64 +1358,6 @@ TRACE_EVENT(ext4_read_block_bitmap_load,
 		  __entry->group, __entry->prefetch)
 );
 
-TRACE_EVENT(ext4_direct_IO_enter,
-	TP_PROTO(struct inode *inode, loff_t offset, unsigned long len, int rw),
-
-	TP_ARGS(inode, offset, len, rw),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
-		__field(	loff_t,	pos			)
-		__field(	unsigned long,	len		)
-		__field(	int,	rw			)
-	),
-
-	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->ino	= inode->i_ino;
-		__entry->pos	= offset;
-		__entry->len	= len;
-		__entry->rw	= rw;
-	),
-
-	TP_printk("dev %d,%d ino %lu pos %lld len %lu rw %d",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
-		  __entry->pos, __entry->len, __entry->rw)
-);
-
-TRACE_EVENT(ext4_direct_IO_exit,
-	TP_PROTO(struct inode *inode, loff_t offset, unsigned long len,
-		 int rw, int ret),
-
-	TP_ARGS(inode, offset, len, rw, ret),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
-		__field(	loff_t,	pos			)
-		__field(	unsigned long,	len		)
-		__field(	int,	rw			)
-		__field(	int,	ret			)
-	),
-
-	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->ino	= inode->i_ino;
-		__entry->pos	= offset;
-		__entry->len	= len;
-		__entry->rw	= rw;
-		__entry->ret	= ret;
-	),
-
-	TP_printk("dev %d,%d ino %lu pos %lld len %lu rw %d ret %d",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
-		  __entry->pos, __entry->len,
-		  __entry->rw, __entry->ret)
-);
-
 DECLARE_EVENT_CLASS(ext4__fallocate_mode,
 	TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int mode),
 
@@ -1962,124 +1904,6 @@ TRACE_EVENT(ext4_get_implied_cluster_alloc_exit,
 		  __entry->len, show_mflags(__entry->flags), __entry->ret)
 );
 
-TRACE_EVENT(ext4_ext_put_in_cache,
-	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, unsigned int len,
-		 ext4_fsblk_t start),
-
-	TP_ARGS(inode, lblk, len, start),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
-		__field(	ext4_lblk_t,	lblk	)
-		__field(	unsigned int,	len	)
-		__field(	ext4_fsblk_t,	start	)
-	),
-
-	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->ino	= inode->i_ino;
-		__entry->lblk	= lblk;
-		__entry->len	= len;
-		__entry->start	= start;
-	),
-
-	TP_printk("dev %d,%d ino %lu lblk %u len %u start %llu",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
-		  (unsigned) __entry->lblk,
-		  __entry->len,
-		  (unsigned long long) __entry->start)
-);
-
-TRACE_EVENT(ext4_ext_in_cache,
-	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, int ret),
-
-	TP_ARGS(inode, lblk, ret),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
-		__field(	ext4_lblk_t,	lblk	)
-		__field(	int,		ret	)
-	),
-
-	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->ino	= inode->i_ino;
-		__entry->lblk	= lblk;
-		__entry->ret	= ret;
-	),
-
-	TP_printk("dev %d,%d ino %lu lblk %u ret %d",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
-		  (unsigned) __entry->lblk,
-		  __entry->ret)
-
-);
-
-TRACE_EVENT(ext4_find_delalloc_range,
-	TP_PROTO(struct inode *inode, ext4_lblk_t from, ext4_lblk_t to,
-		int reverse, int found, ext4_lblk_t found_blk),
-
-	TP_ARGS(inode, from, to, reverse, found, found_blk),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
-		__field(	ext4_lblk_t,	from		)
-		__field(	ext4_lblk_t,	to		)
-		__field(	int,		reverse		)
-		__field(	int,		found		)
-		__field(	ext4_lblk_t,	found_blk	)
-	),
-
-	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
-		__entry->ino		= inode->i_ino;
-		__entry->from		= from;
-		__entry->to		= to;
-		__entry->reverse	= reverse;
-		__entry->found		= found;
-		__entry->found_blk	= found_blk;
-	),
-
-	TP_printk("dev %d,%d ino %lu from %u to %u reverse %d found %d "
-		  "(blk = %u)",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
-		  (unsigned) __entry->from, (unsigned) __entry->to,
-		  __entry->reverse, __entry->found,
-		  (unsigned) __entry->found_blk)
-);
-
-TRACE_EVENT(ext4_get_reserved_cluster_alloc,
-	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, unsigned int len),
-
-	TP_ARGS(inode, lblk, len),
-
-	TP_STRUCT__entry(
-		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
-		__field(	ext4_lblk_t,	lblk	)
-		__field(	unsigned int,	len	)
-	),
-
-	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->ino	= inode->i_ino;
-		__entry->lblk	= lblk;
-		__entry->len	= len;
-	),
-
-	TP_printk("dev %d,%d ino %lu lblk %u len %u",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino,
-		  (unsigned) __entry->lblk,
-		  __entry->len)
-);
-
 TRACE_EVENT(ext4_ext_show_extent,
 	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 		 unsigned short len),
-- 
2.20.1


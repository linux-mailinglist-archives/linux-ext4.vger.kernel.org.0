Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD83F3159A1
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Feb 2021 23:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhBIWoO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Feb 2021 17:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbhBIWUs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Feb 2021 17:20:48 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2742C061574
        for <linux-ext4@vger.kernel.org>; Tue,  9 Feb 2021 14:20:07 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id f18so3364419qvm.9
        for <linux-ext4@vger.kernel.org>; Tue, 09 Feb 2021 14:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2wjZ025jMXQjTQUaIFmQzpMIC7Tqoi0P3qcPOlyyow=;
        b=GejO3QRP4uR3xuBgfsaiyvbA/swtHfLHbEGyVRMcHW+mEYGTB+GEaKnjyVm9kVksj/
         IMzT9bapchTJ4EjEs/fPIOve0BOWB5/V6NQor2VJU7ZzIa2dOxABprDsPgNsJQTSpgUA
         B15D18SpNcy9r5lFkZerkCbWjsrOI5xA//VhCYRsjQr5E3A2ux5/xJyxFfo+0z1roc1k
         gMpsg3iBPY59bbIgQeYWykF67nUh1OZjRVlX2uSpWdgWPgAcBzrV92U8e8q7PmliZPu6
         0ApLdcmGM49ENzbM/MWDLeh8a5wAeIsx58TXVwnQdOLK6fPYPiOt3HAJyPuBGEfMYiA+
         GJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2wjZ025jMXQjTQUaIFmQzpMIC7Tqoi0P3qcPOlyyow=;
        b=eN/8gZD13zUKfHBmJpfMYJg+qZh0OsjdC+BU24V4mRleWD9K6WOkqmAFBXl2nEx+sp
         lySPsR6wCYZAtYpZ1bI7rt+K1yJNDgC8h8XVGHiVPCuleJ1nR9OaVMpVPPYK2gw4Lf+x
         OOzZaVL2Ae9p9CCkD6TeD606Auc4fRy3riIZxUKUhTgkGQSKHMRiAhGrWEZNXzM0s60n
         Z4Xx9D4I5bwBLcWAODj+3rlyfPhpk5TXtop7M2ifvg5kqq1z2L+EMwhQkWr7WlHK8Obr
         4nwiaV92EVflQOZYEAXa9wyMv15MljIs0Fn/I8DwChgbUFTE7vuJ1yABpRiY5HTB3K+o
         XoSA==
X-Gm-Message-State: AOAM532QmrA6H6WtVhVHn6SFi2BBeiMmO9f3FlYb7X2SowDSNFAENl90
        FeBxu3nDmp7BGLJGSE8cu9QOUjru6t4=
X-Google-Smtp-Source: ABdhPJzD/39QmJmUnxcAdW2zlzgeR6dztJ/FbEqZfblOrDHhseH9nOUzKhq5ndAwc1xLfgv7fwroVQ==
X-Received: by 2002:ad4:5bae:: with SMTP id 14mr14325934qvq.24.1612909206864;
        Tue, 09 Feb 2021 14:20:06 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id 199sm94859qkj.9.2021.02.09.14.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:20:06 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: delete some unused tracepoint definitions
Date:   Tue,  9 Feb 2021 17:19:59 -0500
Message-Id: <20210209221959.23883-1-enwlinux@gmail.com>
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

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 include/trace/events/ext4.h | 118 ------------------------------------
 1 file changed, 118 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 70ae5497b73a..3c3f40605391 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1962,124 +1962,6 @@ TRACE_EVENT(ext4_get_implied_cluster_alloc_exit,
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


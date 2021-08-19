Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158DD3F1BE6
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 16:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhHSOuT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 10:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbhHSOuR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Aug 2021 10:50:17 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8A2C061575
        for <linux-ext4@vger.kernel.org>; Thu, 19 Aug 2021 07:49:40 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cu12so2128397qvb.10
        for <linux-ext4@vger.kernel.org>; Thu, 19 Aug 2021 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=304Ej8iokqbiYyAzlMvCH4vurNA8Qu6uG3/CblPnzts=;
        b=OWbKqXTlO5ShFPEHOHH9+5QNz3uUQe6UictEZ/g81+95pVqByvY8Hjc7QJgbJrgNez
         N9/1zDzrdZE42qYDy8Es9tjNXdQVJp8ODrBzfoG4wyd4/X1uTO2xsAxzAiH9B0Fu4lB7
         Tqa1aIfR5ImJTj0VTYYeDzpDnDfKEjAdGyn+TdkNtUMtUJkMX+G0GBbtCqMPBKM6uVOA
         WWlYWkuSqjHQGJtXQN4L4IQgIsncfdajRz8Mun/lswKC8BJlsPNpQqeM4elC6Efc89jV
         eJLnIctBgIjuNZMwOY8JPbh0mbSphkZyiglA3iK6frqX0I6LhrciEaygcYoH02/wiHrh
         RL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=304Ej8iokqbiYyAzlMvCH4vurNA8Qu6uG3/CblPnzts=;
        b=cJfh4ZQA0YZX49mtttAlgV1CGlJLmAXXt0az8VudlTJO7pSQjcNpUBWWOZqwf2iriw
         zfy8a9+IIwQ9sSw4jgHuQAkNY/o5p0s0ZKUtjvTq3sYh7NifuHg4d094tCRtoRV/A9vd
         /mQvnA1TfVpzwj7g7jS3EFc0k7x8kCHnLz17djZmN5LwH3Sf7HTvcXeW7T3a1PgB4nSU
         Xdv/+yJ8RsNAy2crcTN0Xw8yHeiy2s4cHiIMAjpISUeVAy3cfVYrIynzwPunYsLMFZfb
         Ez8CMlHsJyvsUdr8K2s1TlgegPhgxGZUJsGPdDVOptHM/k9kj4S3ex3Civ4OGLTwyOTq
         XasA==
X-Gm-Message-State: AOAM533FMWl5+P1gm1Feao+AYDe2KwYLvuw/7e9aFGrC42b6YRmrGo/P
        LwHVnfm3gFR6b01f60MlqiTjU5pMg3A=
X-Google-Smtp-Source: ABdhPJysE5XoMCDJTEMGFGNjHO49QnqAZYjkkTav6s8/tCN60w55E+xpVk0pcLOihOil5a6HQeCrtQ==
X-Received: by 2002:a05:6214:54a:: with SMTP id ci10mr14824044qvb.19.1629384580002;
        Thu, 19 Aug 2021 07:49:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id x21sm1684292qkf.76.2021.08.19.07.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 07:49:39 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 1/2] ext4: remove extent cache entries when truncating inline data
Date:   Thu, 19 Aug 2021 10:49:26 -0400
Message-Id: <20210819144927.25163-2-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210819144927.25163-1-enwlinux@gmail.com>
References: <20210819144927.25163-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Conditionally remove all cached extents belonging to an inode
when truncating its inline data.  It's only necessary to attempt to
remove cached extents when a conversion from inline to extent storage
has been initiated (!EXT4_STATE_MAY_INLINE_DATA).  This avoids
unnecessary es lock overhead in the more common inline case.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/inline.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 70cb64db33f7..49b0b4fcea6d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -7,6 +7,7 @@
 #include <linux/iomap.h>
 #include <linux/fiemap.h>
 #include <linux/iversion.h>
+#include <linux/backing-dev.h>
 
 #include "ext4_jbd2.h"
 #include "ext4.h"
@@ -1903,6 +1904,24 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 	EXT4_I(inode)->i_disksize = i_size;
 
 	if (i_size < inline_size) {
+		/*
+		 * if there's inline data to truncate and this file was
+		 * converted to extents after that inline data was written,
+		 * the extent status cache must be cleared to avoid leaving
+		 * behind stale delayed allocated extent entries
+		 */
+		if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
+retry:
+			err = ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
+			if (err == -ENOMEM) {
+				cond_resched();
+				congestion_wait(BLK_RW_ASYNC, HZ/50);
+				goto retry;
+			}
+			if (err)
+				goto out_error;
+		}
+
 		/* Clear the content in the xattr space. */
 		if (inline_size > EXT4_MIN_INLINE_DATA_SIZE) {
 			if ((err = ext4_xattr_ibody_find(inode, &i, &is)) != 0)
-- 
2.20.1


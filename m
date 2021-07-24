Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAC93D4614
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jul 2021 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhGXHCj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Jul 2021 03:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbhGXHCd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Jul 2021 03:02:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB75C061764;
        Sat, 24 Jul 2021 00:43:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i10so2643634pla.3;
        Sat, 24 Jul 2021 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XRdthhqasfVWQIIgMf6zw1yKQwtnDg2xDy8hqBSk2WY=;
        b=Qhs84xn1AryzgCtyc0laLVnOLrP0NX/W7BeSN6ku791qDYALskql4PVftLEjIhDt75
         +gTupGOW3pYTVnXgrT5ZQrTkTTg5wjmnsobma4ISybVy6VKxZTqLp1TmCzw3X7ZEzVCp
         muZmwJPUyrTGX5JBbBGDFAynns0uo/9zNeohaICpJtkPjwL6dyODglifSPKDSTdNK/jT
         F1AsmWBkDWTyF8rrh0hdEnZroIRkTNm89alOzWa9MUUGylq2A/TNJKfT8BpVDKykvVAm
         hqPGMvhgSJ2QM7seaAGFucyzJ7mILjp/wpbjXm7Ez1RHtMnt4P1ClNknoNDeL2c011bd
         FjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XRdthhqasfVWQIIgMf6zw1yKQwtnDg2xDy8hqBSk2WY=;
        b=d2EnH3/lmjRbOJvPPkDaxi2mCtRPoANbSe15FOFjHK2U3X9t02Wn+HbWhgrXzsFjly
         PX4Ovxck7RXLo7RC55gx0hZxDOfZJFLeGAe+uFGUTkhJTgZ3Jh3cAU4ak2hKLc5z86wj
         7dcwlmNsxrmFgW0rhZdaX9yDWQyCeehNEEN/vTb4WkAeIlZS6s8LtIhC4V6Jqqy//GDq
         8QivZh2NLd45rEcxEm9i7rL14/7JNhBcZlxzzw3d85LRegnl1uH2PiyzI+hJxddBPA9m
         peOzt7iX9gYW6OcFG6yM3QO0RMhpVB0ysYcw60yohxNuT2Iu1aEUBDC5bHzxQtjpMz8c
         fFiw==
X-Gm-Message-State: AOAM532kaTOtD7P6HlkqzYGn0Wexn55pMxG2FT2VnOYQl3//DigTvn+m
        T1XbPIVR/UjiomJyrpSKbgNPgbwRJW9Qjw==
X-Google-Smtp-Source: ABdhPJw+I4hijXgWv2TVgv5259+sW3LemPdH6NWQePmTpaJ0RO5c226e5MDyYzzGVzBpe7ve+I9CVA==
X-Received: by 2002:a17:90b:3ecb:: with SMTP id rm11mr7862397pjb.147.1627112584551;
        Sat, 24 Jul 2021 00:43:04 -0700 (PDT)
Received: from localhost.localdomain ([154.86.159.244])
        by smtp.gmail.com with ESMTPSA id v31sm33002342pgl.49.2021.07.24.00.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:43:04 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
Subject: [PATCH V3 5/5] ext4: make fallocate retry when err is ENOSPC
Date:   Sat, 24 Jul 2021 15:41:24 +0800
Message-Id: <20210724074124.25731-6-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210724074124.25731-1-jianchao.wan9@gmail.com>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

The blocks may be waiting for journal commit to be freed back to
mb buddy. Let fallocate wait and retry in that case.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/extents.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92ad64b89d9b..ad0b874d3448 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4635,7 +4635,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	struct inode *inode = file_inode(file);
 	loff_t new_size = 0;
 	unsigned int max_blocks;
-	int ret = 0;
+	int ret = 0, retries = 0;
 	int flags;
 	ext4_lblk_t lblk;
 	unsigned int blkbits = inode->i_blkbits;
@@ -4656,6 +4656,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		     FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
+retry:
 	ext4_fc_start_update(inode);
 
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
@@ -4722,6 +4723,9 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
 exit:
 	ext4_fc_stop_update(inode);
+	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+		goto retry;
+
 	return ret;
 }
 
-- 
2.17.1


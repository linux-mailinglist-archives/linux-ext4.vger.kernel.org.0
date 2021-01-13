Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A032F57F0
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jan 2021 04:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbhANCLj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 21:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbhAMWO5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jan 2021 17:14:57 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23209C061575
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 14:14:17 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 186so4412511qkj.3
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 14:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f44459R0W1AGwcc9BWILd7jja1t8A+AdL8/2x0Rd+pc=;
        b=pseKpRNRPbD5k9pfBGNJb1S01KhurYi+vqr4EQfW6fV1qQ8Vs1Q8N9IqRU7p2NO220
         6/a9lsBT3V9ZNv3+k+lrYnAaiIgVv+b+SSmamC+Qs7HTl4FhpweJ9XHIK28rBzx4ZUeX
         FtFAguSa+uwBRyYL9Co7FGyH4rYO2PfmGRU/pXdr9b2fm1fa3BFQ214DZWCSXNdP7BZP
         tNw1d8u30aKWQSXx099YrI2BpmXkvKuNcazIE4IPo4JChwrb3npU+VrebHoDIH+b2QP+
         wcGILaHHdtitESK/C2O5UAxbLiQGcLDOn7ZVZRgNl2S2tGxEfVH5d3QYckvYmgL4XkOd
         nM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f44459R0W1AGwcc9BWILd7jja1t8A+AdL8/2x0Rd+pc=;
        b=pz1CYwZ7iTK020Xsj8nvoMB0ydowGj6RTCexPGdaG3bR5Cb9UEc55mKa+dfzFHUlnH
         90091zoxlxLPYz2rD+u/JwhzvFacA2QO4dYbnKzduAmM6y0hbgefr+0BpV/z8FppGTOf
         uwc/OxV8fm6yAOtzBb/6fdYctN4QqAq5ig4cHL29Scwr2lBPgelDzDcOc2p8VcZ8ihwr
         +fb52977+WB7nI7VMM+C8n3f9EdM4eTssCYo3hBrEBJTERBAzziaNC/oSB99JJq4cJAs
         5mkF1PjgdPQKpUkjtoH0rZ1qNDy716rKLBl5ULNazKGz/ymBg5HEgP0SuBvGHhNiUtkp
         awYg==
X-Gm-Message-State: AOAM5333Fpno50mHnC+RDxMbGS+0FFD8Wo6OaDZwgv2EonxBjpzH75QG
        ljUtGHoyJ9v19VN0n7FQNDb9L0ocWKQ=
X-Google-Smtp-Source: ABdhPJzTOKzEA1ZQr+Nu2TgOOSJ+o5OAiD1xkOLEspw64O/QCG15Adbiqz9DMGjNWQr+jMIR8wKIiA==
X-Received: by 2002:a37:d2c7:: with SMTP id f190mr4336166qkj.95.1610576054602;
        Wed, 13 Jan 2021 14:14:14 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id f134sm1906641qke.23.2021.01.13.14.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:14:14 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: reset retry counter when ext4_alloc_file_blocks() makes progress
Date:   Wed, 13 Jan 2021 17:14:03 -0500
Message-Id: <20210113221403.18258-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Change the retry policy in ext4_alloc_file_blocks() to allow for a full
retry cycle whenever a portion of an allocation request has been
fulfilled.  A large allocation request often results in multiple calls
to ext4_map_blocks(), each of which is potentially subject to a
temporary ENOSPC condition and retry cycle.  The current code only
allows for a single retry cycle.

This patch does not address a known bug or reported complaint.
However, it should make block allocation for fallocate and zero range
more robust.

In addition, simplify the conditional controlling the allocation while
loop, where testing len alone is sufficient.  Remove the assignment to
ret2 in the error path after the call to ext4_map_blocks() since its
value isn't subsequently used.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3960b7ec3ab7..77c7c8a54da7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4382,8 +4382,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 {
 	struct inode *inode = file_inode(file);
 	handle_t *handle;
-	int ret = 0;
-	int ret2 = 0, ret3 = 0;
+	int ret, ret2 = 0, ret3 = 0;
 	int retries = 0;
 	int depth = 0;
 	struct ext4_map_blocks map;
@@ -4408,7 +4407,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	depth = ext_depth(inode);
 
 retry:
-	while (ret >= 0 && len) {
+	while (len) {
 		/*
 		 * Recalculate credits when extent tree depth changes.
 		 */
@@ -4430,9 +4429,13 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 				   inode->i_ino, map.m_lblk,
 				   map.m_len, ret);
 			ext4_mark_inode_dirty(handle, inode);
-			ret2 = ext4_journal_stop(handle);
+			ext4_journal_stop(handle);
 			break;
 		}
+		/*
+		 * allow a full retry cycle for any remaining allocations
+		 */
+		retries = 0;
 		map.m_lblk += ret;
 		map.m_len = len = len - ret;
 		epos = (loff_t)map.m_lblk << inode->i_blkbits;
@@ -4450,11 +4453,8 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 		if (unlikely(ret2))
 			break;
 	}
-	if (ret == -ENOSPC &&
-			ext4_should_retry_alloc(inode->i_sb, &retries)) {
-		ret = 0;
+	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
-	}
 
 	return ret > 0 ? ret2 : ret;
 }
-- 
2.20.1


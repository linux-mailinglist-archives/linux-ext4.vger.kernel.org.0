Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B531FDD4
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Feb 2021 18:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhBSR0Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Feb 2021 12:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSR0O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Feb 2021 12:26:14 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51E6C061574
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 09:25:33 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id z128so1717873qkc.12
        for <linux-ext4@vger.kernel.org>; Fri, 19 Feb 2021 09:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDKETMydywcQL4ctKlwVof4NCJywbgisj5fRM6SbWbY=;
        b=iMYnnTsclMWJITOnQot+9zlxmfVUn7GNvVNCYK31H5qglJURKQMFT6RUtgLFpdutLP
         2immiNFbO4z9m0jfgqbzR+5+91qwOSeZbZYVu4VD+B6OJFTEa4qLtFVEmC5BX+pQbfhT
         l8tO1CVTyT+2eP06ZSFfk3v6SjoPvODqq34HFbyrX2ivogv/8k4/vLcpr3qey2flpL0X
         BFkemfd/L9y/OQ6TzeBMBseWtooluUgZ1l4INsnbZRtrRb1VmvoC4gtnT5h5JlFRz7wd
         0PorNd3nRZ6ifQly3VwV3PLsk28oF2DAOPAT99Yqexu9pnm0WyBNsnD2suIf2sdm5SEU
         Hjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UDKETMydywcQL4ctKlwVof4NCJywbgisj5fRM6SbWbY=;
        b=ucCjCPbwitxvfbPsllMBjRXHjLko2WAHIHgxDyVIzsHst10hynkjNBHiVV7rJrXYA0
         InTP4hKBfr3+tZoMS2S5Fo3Kg74oGeVBwzxZTqX2e46uCnaNV5bxRe4v+jER26fKR+iN
         nZ0SQqMCwv3BgyFDf3bvUeTIpvmn4xvJipP714q/UdwUMUV27vOOOJiQnc6LoIGA3kaY
         SX8QHuKlzTNH2FDtcx6oGG5WMAdAtH+V5SkexonnQrnq/g1GJxS49746HFn0sSwPZShA
         fxtX9gf86dBPGkDuK1RdZgJRhfTn8FknNVnGZIjAgPYZVU8Sy3kG5JfI6CFLc5j7EynD
         LkaQ==
X-Gm-Message-State: AOAM5330GMvL3rlPpGNzayueLY1iRaIFA3ktrHz+R1BxSX9JbqEoL00I
        al9oyF/qcfZ2iHibXdShp+4D1sTyFzc=
X-Google-Smtp-Source: ABdhPJzeG//x4bcZTI1KlX3+I2hqLcUKuThAUoqmo8yRTS+x02fm2nxynAXdZ+epNJKWYKoBqsRV7A==
X-Received: by 2002:a05:620a:10b9:: with SMTP id h25mr10020340qkk.154.1613755532813;
        Fri, 19 Feb 2021 09:25:32 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id l128sm6600876qkf.68.2021.02.19.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 09:25:32 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] ext4: reset retry counter when ext4_alloc_file_blocks() makes progress
Date:   Fri, 19 Feb 2021 12:25:19 -0500
Message-Id: <20210219172519.2117-1-enwlinux@gmail.com>
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

v2: Silence smatch warning by initializing ret.

For smatch warning:
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3960b7ec3ab7..77c84d6f1af6 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4382,8 +4382,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 {
 	struct inode *inode = file_inode(file);
 	handle_t *handle;
-	int ret = 0;
-	int ret2 = 0, ret3 = 0;
+	int ret = 0, ret2 = 0, ret3 = 0;
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


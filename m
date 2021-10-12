Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007F742AA9E
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhJLRVS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 13:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhJLRVP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Oct 2021 13:21:15 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4844FC061570
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 10:19:13 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id r15so11890664qkp.8
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fCRzp1RgT4JqmbH2IXSQy9EiMJO+5AFpK34h77OLMek=;
        b=O8dZSfcClMDMMenpJ6SmYrDjKzxdppWK2qW9woh4IxjrGYtsfZjrflwEbSypQB0jRQ
         WpDCVSNoT/zwUqStxG77XK3TkBdtQBz+kXYz+Yz4M2gIxJekR2tt23g/RxdUayGnVtJm
         v2t3kbU3ERJvH9frDQZeiEyoSv1ZFsESpr6STOlqhv2g8IHx/eepbwjhUHb9yYVT266n
         kAqPPujAV5xZX4qHKJ8UV8nhYfOH4b1UEjLsAKXhKd0mHzb2MYnGBEVFMFGXfaVeGpO3
         zyntWR5Ya0bWbb9E0pZOLuzBZbcQQ/1cGF2hEhjxCJKxSq7FASj8lN32xmUwWDmP+h4D
         P7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fCRzp1RgT4JqmbH2IXSQy9EiMJO+5AFpK34h77OLMek=;
        b=117Wagy0DFuZyqzwW7MPHwwybbKApFV3oszqFTJY8PrWx6ETPxTt/B/AhQ5+wh3QoZ
         2l7nTLHmhHvt5YZH2CQcoWCleIkTwSz7W5vq+atGdYT2T18Z2ZZ8xXaUYrnSnLlT2b6/
         OQPPgPGPrjm4BgzVYQj1RJQKuG60WpB6KlAy9pkHEO4UjbV4I8Fk1VXLbBedeUI+FJd7
         Ygnz1N84WUmj7sWzPuGTONYq37Zx6xP6oAFaHBxdQvFCY1/+Yw84WYo2i6ijj0OKeGzy
         T23TCeQyMdvyPvlx6s5camYPbvHKlZ05DwfD1+kdMMCIu3ijNyADmknQdHO1bCbCCSRd
         8TGA==
X-Gm-Message-State: AOAM53277mRSuYNFtK4Eltg4pIskO1B9jpglfHT6znFcMgxNNeER8b78
        U688kKbodzYxFPfGaY0IybG4olAtr7U=
X-Google-Smtp-Source: ABdhPJyh5LH7UMyzqOfD9yZuaBl/8zLYgagt3e6qiMd9M5suq5c7tm5kJLJtXvI6zkZz7Y2hT7w4tg==
X-Received: by 2002:a37:9d04:: with SMTP id g4mr20699482qke.212.1634059152209;
        Tue, 12 Oct 2021 10:19:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id f15sm7037135qtf.66.2021.10.12.10.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 10:19:11 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] Revert "ext4: enforce buffer head state assertion in ext4_da_map_blocks"
Date:   Tue, 12 Oct 2021 13:19:01 -0400
Message-Id: <20211012171901.5352-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This reverts commit 948ca5f30e1df0c11eb5b0f410b9ceb97fa77ad9.

Two crash reports from users running variations on 5.15-rc4 kernels
suggest that it is premature to enforce the state assertion in the
original commit.  Both crashes were triggered by BUG calls in that
code, indicating that under some rare circumstance the buffer head
state did not match a delayed allocated block at the time the
block was written out.  No reproducer is available.  Resolving this
problem will require more time than remains in the current release
cycle, so reverting the original patch for the time being is necessary
to avoid any instability it may cause.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/inode.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0f06305167d5..9097fccdc688 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1711,16 +1711,13 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		}
 
 		/*
-		 * the buffer head associated with a delayed and not unwritten
-		 * block found in the extent status cache must contain an
-		 * invalid block number and have its BH_New and BH_Delay bits
-		 * set, reflecting the state assigned when the block was
-		 * initially delayed allocated
+		 * Delayed extent could be allocated by fallocate.
+		 * So we need to check it.
 		 */
-		if (ext4_es_is_delonly(&es)) {
-			BUG_ON(bh->b_blocknr != invalid_block);
-			BUG_ON(!buffer_new(bh));
-			BUG_ON(!buffer_delay(bh));
+		if (ext4_es_is_delayed(&es) && !ext4_es_is_unwritten(&es)) {
+			map_bh(bh, inode->i_sb, invalid_block);
+			set_buffer_new(bh);
+			set_buffer_delay(bh);
 			return 0;
 		}
 
-- 
2.20.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414336F5C20
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjECQfq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 12:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjECQfo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 12:35:44 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789163ABC;
        Wed,  3 May 2023 09:35:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaea3909d1so41701155ad.2;
        Wed, 03 May 2023 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683131743; x=1685723743;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FphQhP/ndgfx40/adXwhnzLVwSTKceCysdZmKATytIQ=;
        b=ZlDO7Ma6lmFGQEdnNmDPoGFZakr9vc1qNDciVPQFuKnHgp5r5GUeOr0ID4Qho6fwzT
         1TpntnObhKrJud2u6IKwqQCMw1dBjO8hkX/DzVI4c5vHeacjABFBJmLQvkPFE9MTRf8n
         dsXc6ZlhNmBpQQ71sQE4nbekL05WB53OGhb9yLbyRd39iPyEVPqWhCCsjwLmouphFsnA
         1qqadDhki+L3BTecEA8/awCPLQWuHXnL9q7MwXpd1TQr0zTeJ5RCTGk9umJKmDdIY93u
         ybpsWK9TgoP34EgWVRLB7/wbRRt1KtjZKANw1PdG8WfFWkpBcAU/w79O1+bZtgy28Sm2
         njxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131743; x=1685723743;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FphQhP/ndgfx40/adXwhnzLVwSTKceCysdZmKATytIQ=;
        b=kXAoWSPs+mxhHOh0X+bYNPIryVyJxwoVOS/gD29xBg6kfQg+XvCaBnbf1SC1robDb1
         Lzd0IdV8vQ7NGud8g5kiLsecxiF21NleWtmjBC+7V3o88QOojEA8d3Zqd3/82tBSly7V
         9eN+jOcSO44vgUIHaY6SyjFK6Jx8K7SPCSYrpe1NlVujNV4T0jBd1uF4XzeMknXzAJxv
         QdCVpLV6Vd0RgqSpvC/NPskr55okLu1FyOm++/kVHXkhqBX3MwJuuecZ/9FUTEJn2F/p
         6EYhv41oAfsJlYJr1LmfuckNyCsyxWpLEPc9GzLFMnLvsrDeiFOcspJM7gDQbff9p2B4
         YioQ==
X-Gm-Message-State: AC+VfDx2qSRvPsgE+4OTQYlKAzCfHnv0RRD0Xd4xSrk1iQjwb6Mg9cPB
        v7MqCLhC3euWjAgrCRsoP6AtyYGFzJHyPyaJBNk=
X-Google-Smtp-Source: ACHHUZ6fidjCAUuXXlk3n8d7vuvS/g0YighVJB/wsK4FHb/HfmpJYCIJFUu1FBI9ujJb2V4uTFMy8Q==
X-Received: by 2002:a17:902:ea03:b0:19f:2dff:2199 with SMTP id s3-20020a170902ea0300b0019f2dff2199mr647532plg.68.1683131742629;
        Wed, 03 May 2023 09:35:42 -0700 (PDT)
Received: from MSI-FindNS.localdomain ([95.174.71.27])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902d2c400b001a5260a6e6csm8111509plc.206.2023.05.03.09.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 09:35:42 -0700 (PDT)
From:   Yue Zhao <findns94@gmail.com>
To:     stable@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH 1/1][For stable 5.4] mm: migrate: buffer_migrate_page_norefs() fallback migrate not uptodate pages
Date:   Thu,  4 May 2023 00:34:26 +0800
Message-Id: <20230503163426.5538-2-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230503163426.5538-1-findns94@gmail.com>
References: <20230503163426.5538-1-findns94@gmail.com>
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Recently we notice that ext4 filesystem occasionally fail to read
metadata from disk and report error message, but the disk and block
layer looks fine. After analyse, we lockon commit 88dbcbb3a484
("blkdev: avoid migration stalls for blkdev pages"). It provide a
migration method for the bdev, we could move page that has buffers
without extra users now, but it will lock the buffers on the page, which
breaks a lot of current filesystem's fragile metadata read operations,
like ll_rw_block() for common usage and ext4_read_bh_lock() for ext4,
these helpers just trylock the buffer and skip submit IO if it lock
failed, many callers just wait_on_buffer() and conclude IO error if the
buffer is not uptodate after buffer unlocked.

This issue could be easily reproduced by add some delay just after
buffer_migrate_lock_buffers() in __buffer_migrate_page() and do
fsstress on ext4 filesystem.

  EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #73193:
  comm fsstress: reading directory lblock 0
  EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #75334:
  comm fsstress: reading directory lblock 0

Something like ll_rw_block() should be used carefully and seems could
only be safely used for the readahead case. So the best way is to fix
the read operations in filesystem in the long run, but now let us avoid
this issue first. This patch avoid this issue by fallback to migrate
pages that are not uptodate like fallback_migrate_page(), those pages
that has buffers may probably do read operation soon.

Fixes: 88dbcbb3a484 ("blkdev: avoid migration stalls for blkdev pages")

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 mm/migrate.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 034b0662fd3b..1e908e997147 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -751,6 +751,39 @@ static int __buffer_migrate_page(struct address_space *mapping,
 		return -EAGAIN;
 
 	head = page_buffers(page);
+
+	/*
+	 * If the mapped buffers on the page are not uptodate and has refcount,
+	 * some others may propably try to lock the buffer and submit read IO
+	 * through ll_rw_block(), but it will not submit IO once it failed to
+	 * lock the buffer, so try to fallback to migrate_page() to prevent
+	 * false positive EIO.
+	 */
+	if (check_refs) {
+		bool uptodate = true;
+		bool invalidate = false;
+
+		bh = head;
+		do {
+			if (buffer_mapped(bh) && !buffer_uptodate(bh)) {
+				uptodate = false;
+				if (atomic_read(&bh->b_count)) {
+					invalidate = true;
+					break;
+				}
+			}
+			bh = bh->b_this_page;
+		} while (bh != head);
+
+		if (!uptodate) {
+			if (invalidate)
+				invalidate_bh_lrus();
+			if (try_to_release_page(page, GFP_KERNEL))
+				return migrate_page(mapping, newpage, page, mode);
+			return -EAGAIN;
+		}
+	}
+
 	if (!buffer_migrate_lock_buffers(head, mode))
 		return -EAGAIN;
 
-- 
2.17.1


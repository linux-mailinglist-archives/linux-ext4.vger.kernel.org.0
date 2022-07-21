Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A28E57C412
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 08:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiGUGDS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 02:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiGUGDO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 02:03:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA14D7AB35
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:03:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k16so858616pls.8
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RyJ/2ovef+Q1/jKxQ9/xhbRuIU47cSBso2MBQ15p+0w=;
        b=l49nNg/RxE+hO9L4OR1icl2zJRiDb4bdPpvAWun/lbU7AfZw62J02Y0/q7yRj0EPua
         3s+SNLH1/18ZLbHaC3v2KXV5IkBhsslfKX3miJhTk/jsuvB6Zelw6ISQ5u/5xgXQ81rG
         spWMr8P5aJesK1V3CrgVFIdNdxcB7PahnOUmyiatTgbfuENzkki3plhC4rfty2VRUIzr
         bph8AAqbEWGv2jE50KnIkWFJsk0hy3pjQDWyhGffMrExhXlb1lLwY/TTdAKEAS6699YQ
         VaJgKbtZnInS06LozxvbHTLJL9G6qLyHum7WuyhkuILomDzsgZtI/EU5v2GSlIJaHQpx
         rAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RyJ/2ovef+Q1/jKxQ9/xhbRuIU47cSBso2MBQ15p+0w=;
        b=Jha7JhRpgzkTovnPj0qsiaA8BvRzi2TaaWqMSlErWKSLidQA0Rj6b0CFor89SJsxBT
         nE0WCPY5V/1DLf+MBgktgUOMHHDMqi1WnDHGNOZ1b6LJ+gW997apIhBtWWI4FHQRKkU7
         bQRCoMxgOeE6Av2dPKI/OcQ2qaKUvuQgUL2tTp/iPGCPNp8oO8hcTmSNBKwr9l0AO2sn
         mlItSzUkLyxwrfUnyRuVwFOEUOJLTFZ1Nk0FGT1UVUCmLpQA85R+t7tmo9EfKrtEV2RG
         jTyQmY5FBgCvyp0wOqBE0d9D6/mqreSMXwGCo+cZc31tyOWpdGFaRYC3kdy45cSlHa+G
         HO7w==
X-Gm-Message-State: AJIora/LUExogSCYyi27oNfsbbJWSdxWmA+La6gTTd+x/MuvBqXnZknR
        p6SO9d6ikzb6tg3H3OYUNVzHW6+GkNPrWRjQ
X-Google-Smtp-Source: AGRyM1sBHDiKBI1dl8yBUUuCG22gijD+vRo3KaYHJzx66WMiwILq+GLi6Kh9Vye/v35BkAzdAyGEbw==
X-Received: by 2002:a17:90a:4e0f:b0:1f2:10b0:2f60 with SMTP id n15-20020a17090a4e0f00b001f210b02f60mr9567190pjh.161.1658383382577;
        Wed, 20 Jul 2022 23:03:02 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.googlemail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm9105377pjb.2.2022.07.20.23.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:03:01 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [RFC PATCH v4 8/8] ext4: update code documentation
Date:   Thu, 21 Jul 2022 06:02:46 +0000
Message-Id: <20220721060246.1696852-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
References: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch updates code documentation to reflect the commit path changes
made in this series.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 727a87073e6a..7a7bb540904f 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -49,14 +49,21 @@
  * that need to be committed during a fast commit in another in memory queue of
  * inodes. During the commit operation, we commit in the following order:
  *
- * [1] Lock inodes for any further data updates by setting COMMITTING state
- * [2] Submit data buffers of all the inodes
- * [3] Wait for [2] to complete
- * [4] Commit all the directory entry updates in the fast commit space
- * [5] Commit all the changed inode structures
- * [6] Write tail tag (this tag ensures the atomicity, please read the following
+ * [1] Lock the journal by calling jbd2_journal_lock_updates. This ensures that
+ *     all the exsiting handles finish and no new handles can start.
+ * [2] Mark all the fast commit eligible inodes as undergoing fast commit
+ *     by setting "EXT4_STATE_FC_COMMITTING" state.
+ * [3] Unlock the journal by calling jbd2_journal_unlock_updates. This allows
+ *     starting of new handles. If new handles try to start an update on
+ *     any of the inodes that are being committed, ext4_fc_track_inode()
+ *     will block until those inodes have finished the fast commit.
+ * [4] Submit data buffers of all the committing inodes.
+ * [5] Wait for [4] to complete.
+ * [6] Commit all the directory entry updates in the fast commit space.
+ * [7] Commit all the changed inodes in the fast commit space and clear
+ *     "EXT4_STATE_FC_COMMITTING" for these inodes.
+ * [8] Write tail tag (this tag ensures the atomicity, please read the following
  *     section for more details).
- * [7] Wait for [4], [5] and [6] to complete.
  *
  * All the inode updates must call ext4_fc_start_update() before starting an
  * update. If such an ongoing update is present, fast commit waits for it to
@@ -142,6 +149,13 @@
  * similarly. Thus, by converting a non-idempotent procedure into a series of
  * idempotent outcomes, fast commits ensured idempotence during the replay.
  *
+ * Locking
+ * -------
+ * sbi->s_fc_lock protects the fast commit inodes queue and the fast commit
+ * dentry queue. ei->i_fc_lock protects the fast commit related info in a given
+ * inode. Most of the code avoids acquiring both the locks, but if one must do
+ * that then sbi->s_fc_lock must be acquired before ei->i_fc_lock.
+ *
  * TODOs
  * -----
  *
@@ -156,13 +170,12 @@
  *    fast commit recovery even if that area is invalidated by later full
  *    commits.
  *
- * 1) Fast commit's commit path locks the entire file system during fast
- *    commit. This has significant performance penalty. Instead of that, we
- *    should use ext4_fc_start/stop_update functions to start inode level
- *    updates from ext4_journal_start/stop. Once we do that we can drop file
- *    system locking during commit path.
+ * 1) Handle more ineligible cases.
  *
- * 2) Handle more ineligible cases.
+ * 2) Change ext4_fc_commit() to lookup logical to physical mapping using extent
+ *    status tree. This would get rid of the need to call ext4_fc_track_inode()
+ *    before acquiring i_data_sem. To do that we would need to ensure that
+ *    modified extents from the extent status tree are not evicted from memory.
  */
 
 #include <trace/events/ext4.h>
-- 
2.37.0.170.g444d1eabd0-goog


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CB8731631
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjFOLML (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 07:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbjFOLMK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 07:12:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABBD119
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 04:12:09 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b515ec39feso1496795ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 04:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686827529; x=1689419529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNZjRU1r2naqquhIxKV1tMirHdIZNgUsol5hCBn099s=;
        b=LCDIBoVzZCzEFM0f6MbIUyfFtsS0EAWlz+URDNwjdugfIaQTtkyWsaY/53oi4W94Tz
         XL85crNUnbp1x94L5NLPUWoL4lEmHtlHCrqtPNVopu9nHXIhMqOmX/7fpFuLeWmrqACf
         7nGVaeYDytPkY1g6077J/P8N9r/i10nnfVNVs56cqpIMwLthSStBScUB6UIGGsMTntbi
         jpVm6DK2+92QOiLWwWdpAI5DKlq3x+fedEx1igHE2wNPPk1G7J0uXqt4gaMyb7DquEA6
         2ZwbK7WQmDW1tOq3RBAcaUt3STPRQCpykAiMcw+4GMAhW/XBVw9XkwYTMhd9EKYQhKA7
         cXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686827529; x=1689419529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNZjRU1r2naqquhIxKV1tMirHdIZNgUsol5hCBn099s=;
        b=L2capzY6ylakgV8eivivVpJz2+256oPxd709FLzTHaEFtoTvAOsjorUBNQlyrSBEUU
         9J77amrw2MF8BC53OS8Sps+vBK4e6763iKeEoGzJcGFu75aaUawHh6eUpWhBR5Q0zb3I
         +XhZtHXexSoA7rGacfvK68AYXExnXiIIgSRkgWyf1sR+qD0Ri+EEKNk5mfHkQN+Ds65u
         kTqCEOXZEsf4h2dtyZPyl6a/cH19gC4pS8C6dEQfbLy8b+DYbn+o/ZLEyqKIg7Kab1/J
         KELdqeUcNsKgt4Kxk1y3s3gXbFwAkPMzSxXX+ltColISb+4PajQ2B78Bg8bcPVSE5agk
         8lWw==
X-Gm-Message-State: AC+VfDwah9x0R/i6Bj0yEdfyhRs+cVXPJ+LZ4ithArylstZsM3DtiuZl
        UETeSJ1SzQBrbr719PaZwV4l9g==
X-Google-Smtp-Source: ACHHUZ53LjLU8zshBVZv4gGPxRap5naiMliawi7BucaqIETbihJMSAACl1cuW70jp+8C1D8xwPklmQ==
X-Received: by 2002:a17:902:f54e:b0:1a6:6bdb:b548 with SMTP id h14-20020a170902f54e00b001a66bdbb548mr20096337plf.1.1686827528759;
        Thu, 15 Jun 2023 04:12:08 -0700 (PDT)
Received: from HTW5T2C6VL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id z7-20020a170902708700b001ae3b51269dsm13783398plk.262.2023.06.15.04.12.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 04:12:08 -0700 (PDT)
From:   Fengnan Chang <changfengnan@bytedance.com>
To:     daeho.jeong@samsung.com, wangjianchao@kuaishou.com, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@bytedance.com>
Subject: [RFC PATCH] ext4: improve discard efficiency
Date:   Thu, 15 Jun 2023 19:12:00 +0800
Message-Id: <20230615111200.11949-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In commit a015434480dc("ext4: send parallel discards on commit
completions"), issue all discard commands in parallel make all
bios could merged into one request, so lowlevel drive can issue
multi segments in one time which is more efficiency, but commit
55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
seems broke this way, let's fix it.
In my test, the time of fstrim fs with multi big sparse file
reduce from 6.7s to 1.3s.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 fs/ext4/mballoc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a2475b8c9fb5..e5a27fd2e959 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6790,7 +6790,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
  * be called with under the group lock.
  */
 static int ext4_trim_extent(struct super_block *sb,
-		int start, int count, struct ext4_buddy *e4b)
+		int start, int count, struct ext4_buddy *e4b, struct bio **biop)
 __releases(bitlock)
 __acquires(bitlock)
 {
@@ -6812,7 +6812,7 @@ __acquires(bitlock)
 	 */
 	mb_mark_used(e4b, &ex);
 	ext4_unlock_group(sb, group);
-	ret = ext4_issue_discard(sb, group, start, count, NULL);
+	ret = ext4_issue_discard(sb, group, start, count, biop);
 	ext4_lock_group(sb, group);
 	mb_free_blocks(NULL, e4b, start, ex.fe_len);
 	return ret;
@@ -6826,12 +6826,15 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
 	ext4_grpblk_t next, count, free_count;
 	void *bitmap;
+	struct bio *discard_bio = NULL;
+	struct blk_plug plug;
 
 	bitmap = e4b->bd_bitmap;
 	start = (e4b->bd_info->bb_first_free > start) ?
 		e4b->bd_info->bb_first_free : start;
 	count = 0;
 	free_count = 0;
+	blk_start_plug(&plug);
 
 	while (start <= max) {
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
@@ -6840,7 +6843,7 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		next = mb_find_next_bit(bitmap, max + 1, start);
 
 		if ((next - start) >= minblocks) {
-			int ret = ext4_trim_extent(sb, start, next - start, e4b);
+			int ret = ext4_trim_extent(sb, start, next - start, e4b, &discard_bio);
 
 			if (ret && ret != -EOPNOTSUPP)
 				break;
@@ -6864,6 +6867,14 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 			break;
 	}
 
+	if (discard_bio) {
+		ext4_unlock_group(sb, e4b->bd_group);
+		submit_bio_wait(discard_bio);
+		bio_put(discard_bio);
+		ext4_lock_group(sb, e4b->bd_group);
+	}
+	blk_finish_plug(&plug);
+
 	return count;
 }
 
-- 
2.37.1 (Apple Git-137.1)


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3074C4F7F5F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Apr 2022 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiDGMpK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Apr 2022 08:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245371AbiDGMpI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Apr 2022 08:45:08 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B98AD13D;
        Thu,  7 Apr 2022 05:43:07 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id q12so1704447pla.9;
        Thu, 07 Apr 2022 05:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djDttX67eYTaV+Ltmm65GSmGkKnWz/VB8DEpNLaANO4=;
        b=Ya6tvFKwsIKPcEszlbAyvRiZMuZCAJgeEuKpY+BK0UIWW8vNRAALW6NI4Kw5TPzSlP
         nF0Z99LvAwC5EsB78hCebEYL+BBZWW7hVN0mixi6MbSb2ztZ2uXW7NL6Aj2j9hew4Kqz
         iCRbq0sJ/DT9HoOOt+ZV3THKOyzko/gMlK8aaEL4N/IV4TkFEwF1WOpL9uQPh+BqMOPi
         Ua00e/uD0Lv2hNC145b+aCur7j2f2TmeWavmO3cfw+JWTlDD7SgushZ5WpT7Cpg1HpFx
         u3IUkrujfaOMaEK8A8+kVTJQM2Rzbi4Om2KPkPfAhe0/WJZK946pNpv8CSDkv6IVTpYn
         J3AQ==
X-Gm-Message-State: AOAM533GNqtChafq7IqyS/WgddGfF7CCvLilAc06xHdc1LXuDpzlVRh5
        CmTq5Fb9wrIn8/mJh8ZvK1A=
X-Google-Smtp-Source: ABdhPJzu2hVm+E8WdgrMkf4gu1dT/NXXL5NpK9h7OQ7uwd3BcRp7NMDbPV4w3EmrimUPZwyH3vLQOg==
X-Received: by 2002:a17:902:ea11:b0:157:514:2239 with SMTP id s17-20020a170902ea1100b0015705142239mr3419961plg.95.1649335386608;
        Thu, 07 Apr 2022 05:43:06 -0700 (PDT)
Received: from lunar.aeonazure.com.www.tendawifi.com ([182.0.134.124])
        by smtp.gmail.com with ESMTPSA id bx22-20020a056a00429600b004fa936a64b0sm20938572pfb.196.2022.04.07.05.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 05:43:05 -0700 (PDT)
From:   Shaun Tancheff <shaun.tancheff@hpe.com>
To:     shaun@tancheff.com, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Shaun Tancheff <shaun.tancheff@hpe.com>
Subject: [PATCH] Shrink fast commit buffer when not used
Date:   Thu,  7 Apr 2022 19:42:44 +0700
Message-Id: <20220407124244.2014497-1-shaun.tancheff@hpe.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Shrink the fast-commit buffer when the feature is not
enabled. By default the fast-commit buffer will allocate 256
blocks if s_num_fc_blks is 0. Set s_num_fc_blks to a smaller
value (> 0) to avoid allocating a large unused buffer, this
also makes more journal credits available when fast commit
is not used.

Signed-off-by: Shaun Tancheff <shaun.tancheff@hpe.com>
---
 fs/ext4/super.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 81749eaddf4c..d2df10dc7cc3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4222,6 +4222,14 @@ static int count_overhead(struct super_block *sb, ext4_group_t grp,
 		ext4_count_free(buf, EXT4_CLUSTERS_PER_GROUP(sb) / 8);
 }
 
+static void strink_journal_fc_buffer(struct super_block *ext4_sb)
+{
+	journal_t *journal = EXT4_SB(ext4_sb)->s_journal;
+	journal_superblock_t *sb = journal->j_superblock;
+
+	sb->s_num_fc_blks = cpu_to_be32(8);
+}
+
 /*
  * Compute the overhead and stash it in sbi->s_overhead
  */
@@ -5189,6 +5197,13 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount_wq;
 	}
 
+	/* Since fast-commit is disabled, shrink it's dedicated memory
+	 * and it's share of the journal space so we can use the extra
+	 * credits
+	 */
+	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
+		strink_journal_fc_buffer(sb);
+
 	if (!set_journal_csum_feature_set(sb)) {
 		ext4_msg(sb, KERN_ERR, "Failed to set journal checksum "
 			 "feature set");
-- 
2.32.0


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623F3270991
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Sep 2020 02:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgISAzV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Sep 2020 20:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgISAzS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Sep 2020 20:55:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D7FC0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jw11so3882542pjb.0
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EpTAzNNxTgeih6RTSwewI0RLzYkyjUkYiBqcN/5bSh8=;
        b=lJp45zLqZuV6LVg0TbzUtaP77w8UV+2Rbb8b74ZarZ57atfxES0fPiJgIfJ8lHCTBM
         CmFM6KM0cDcrZXkMcoPsNza2sPzrxmiAF1gkberWFcsDX0R2RB26UiRO6i0CYDmZ8YV3
         3P8WVuv69mFyfxMa25ZhFT618BLvP2k2M/RI9G5PRnP5+j0uNQ/OQpqAWfeMcScwMJHi
         T8KF+Ne4yHcNJyGLdKI8q13F+UR7IQfq7yI3AKwIUUouufh/oz86umQPrLB3TEls1eOz
         Y1d0HFNvaHSwtGUvU8hW3tRQ2CcSu73eHDZCtCFsoNgE+U8Ir8ZBRwf0CixCMSiB2+v3
         eomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EpTAzNNxTgeih6RTSwewI0RLzYkyjUkYiBqcN/5bSh8=;
        b=MbxnXDLdldDrUpRnNYkjrl0hIKpGWLc6aNchiqJRvWjA+izYTBGum0AoisogHBdfAg
         MkStS4lunUiE/7/7KJF+kCLkStrI+RNSlYbrQ2vJXo2LUz/TwtXVaaU/CEWOInR/bMxp
         dt8oG9449VESqY32VJH1c+83emFT9KGxHLFejmRNHlk5/2Mq8QtNgYiub22SNOOY5sZb
         SVFwjyq8PbK2Wo8mrulJNWEypUObfgDfKelHgJnAZkCH+KAsN5Ul8wZTJx0Us7HBhRFL
         d1f2iPZuRHTVSOoskJkWgu30msnPIevmMe6keom5UwbgFNatsjV5x0o4NkgF204tb97p
         ZPhg==
X-Gm-Message-State: AOAM532Eo0Cw8yW66e4snCeOUr2JeDWPcvP7ggCS4nYx+0DRuv/r/cPF
        VeaWOl1lSDg83ls8w5OIKzZ/Oe0clqQ=
X-Google-Smtp-Source: ABdhPJypANmIEpM8xgaDJjVFb6WsFilt9zHL1c6as+F5Bz/LdFl/yMmSayKLy1nReaPTNj6nmz7W1A==
X-Received: by 2002:a17:902:a612:b029:d1:ece5:a1ce with SMTP id u18-20020a170902a612b02900d1ece5a1cemr14903894plq.66.1600476917825;
        Fri, 18 Sep 2020 17:55:17 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id f28sm4621953pfq.191.2020.09.18.17.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:55:17 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 8/9] ext4: add a mount opt to forcefully turn fast commits on
Date:   Fri, 18 Sep 2020 17:54:50 -0700
Message-Id: <20200919005451.3899779-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a debug only mount option that forcefully turns fast commits
on at mount time.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 967c4eac87d2..43ac8c19bf1d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1536,8 +1536,9 @@ enum {
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
 	Opt_prefetch_block_bitmaps, Opt_no_fc,
 #ifdef CONFIG_EXT4_DEBUG
-	Opt_fc_debug_max_replay
+	Opt_fc_debug_max_replay,
 #endif
+	Opt_fc_debug_force
 };
 
 static const match_table_t tokens = {
@@ -1625,6 +1626,7 @@ static const match_table_t tokens = {
 	{Opt_init_itable, "init_itable"},
 	{Opt_noinit_itable, "noinit_itable"},
 	{Opt_no_fc, "no_fc"},
+	{Opt_fc_debug_force, "fc_debug_force"},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_max_replay, "fc_debug_max_replay=%u"},
 #endif
@@ -1856,6 +1858,8 @@ static const struct mount_opts {
 	 MOPT_SET},
 	{Opt_no_fc, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
+	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
+	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_max_replay, 0, MOPT_GTE0},
 #endif
-- 
2.28.0.681.g6f77f65b4e-goog


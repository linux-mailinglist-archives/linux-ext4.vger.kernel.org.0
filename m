Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF42A8DEA
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgKFD7y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgKFD7x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:53 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4DCC0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:53 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so121434pfn.0
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d5H2NqAW25lXN2uLV8kMXgbJdyDSpRD8qIvszub5uYU=;
        b=EUMPvFWF9ZfON4HDn+g6LT0Pcc/d+dCnBRETQ+wmV344EdYPNccV9XpkzhWvlpdTVD
         iB5zFK0OmVBCC0nmLSdKK/L3bsSaO0jHTNvW74jp4AGxvRd3SZYdCcHLjZpyuAjgx7ZC
         oq1gcfOEhj3ZyLKj8b8s7SDse+MufZ2vrnEMjxkY0jhRbmaadhYDeF+uSvv63R7JJJ0U
         CGM9wMEo1SEaxPAX/QRgZOaudqukBviPiT5wMuSKHoOe6zQmRomnrjVqigX7pHUUjc2X
         +N4SZcETKalQV9WSgFJ3IHobmAubPYRnHeSwszsMZ1Mr4BTfZa5G9NYqWjJJbv2Xx+N3
         a6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d5H2NqAW25lXN2uLV8kMXgbJdyDSpRD8qIvszub5uYU=;
        b=EGuT1SRkcNmMs3c+XUlZDi3aqS8U5nDUINC7mDPnPWz/7oG1upksnSBg7dwCB/QN96
         +CPS/tVO9AVYK8vIej/Yn4vC06P6craG3BQ6pSN8xzOx0JDaIth1qgKu6EXZuEzgGn8N
         PWTLeVxmYdn6XWfY6LPnCcUNj8UvXW4XZ9Ee42mc+l7TmIyTn6PMd3BtomcJtXhehiIT
         UebdoueYOAtrIhtQj2g1ipgryWLupvFK+gQOyIZzhl2lGgO/RiSyh8MHZCUSyN8M0YkJ
         rZaUdvozcrNk4xu49RGiDiWfkVEYEoK/2YWnGplt/O6Zf6BibxiDGxC7MPHo46/kZtZH
         lnSg==
X-Gm-Message-State: AOAM531CuY06kpV9kiWexi1dJEYPyys6NTej8Yub4NIGFV41UpMilx4g
        /bZgVeSidwppB05UTjkixqpEvsIElqk=
X-Google-Smtp-Source: ABdhPJxa8bUsp+xQ0lTeORCRHHVG069jt0M9HOkZp9kkgvw8EQd8PKhb1rLUjIDSwS3uObxh8fMoKw==
X-Received: by 2002:a63:e241:: with SMTP id y1mr70029pgj.264.1604635192916;
        Thu, 05 Nov 2020 19:59:52 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:51 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 22/22] ext4: cleanup fast commit mount options
Date:   Thu,  5 Nov 2020 19:59:11 -0800
Message-Id: <20201106035911.1942128-23-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Drop no_fc mount option that disable fast commit even if it was
enabled at mkfs time. Move fc_debug_force mount option under ifdef
EXT4_DEBUG to annotate that this is strictly for debugging and testing
purposes and should not be used in production.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/super.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index edb36581f6cc..4679dbf14555 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1716,11 +1716,10 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_prefetch_block_bitmaps, Opt_no_fc,
+	Opt_prefetch_block_bitmaps,
 #ifdef CONFIG_EXT4_DEBUG
-	Opt_fc_debug_max_replay,
+	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
-	Opt_fc_debug_force
 };
 
 static const match_table_t tokens = {
@@ -1807,9 +1806,8 @@ static const match_table_t tokens = {
 	{Opt_init_itable, "init_itable=%u"},
 	{Opt_init_itable, "init_itable"},
 	{Opt_noinit_itable, "noinit_itable"},
-	{Opt_no_fc, "no_fc"},
-	{Opt_fc_debug_force, "fc_debug_force"},
 #ifdef CONFIG_EXT4_DEBUG
+	{Opt_fc_debug_force, "fc_debug_force"},
 	{Opt_fc_debug_max_replay, "fc_debug_max_replay=%u"},
 #endif
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
@@ -2039,11 +2037,9 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
-	{Opt_no_fc, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
-	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
+#ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
-#ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_max_replay, 0, MOPT_GTE0},
 #endif
 	{Opt_err, 0, 0}
-- 
2.29.1.341.ge80a0c044ae-goog


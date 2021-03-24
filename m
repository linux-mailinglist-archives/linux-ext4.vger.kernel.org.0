Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1073334852D
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Mar 2021 00:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbhCXXTg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Mar 2021 19:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239022AbhCXXTd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Mar 2021 19:19:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07474C06175F
        for <linux-ext4@vger.kernel.org>; Wed, 24 Mar 2021 16:19:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 11so49311pfn.9
        for <linux-ext4@vger.kernel.org>; Wed, 24 Mar 2021 16:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ElMJ7bjXqaQdzuOQnFsg0ZG+tTn3DsBAWPK7hzq2d+0=;
        b=bMXF6Q30GU7fZH8Wk7H1TfNIbhOWjwZZglIqlASYeLcu7KnLlxN3j3KcSdv05iGhhh
         vdc6q6X9Cd4ng0RGewSGyhuSpmSL2lrpHyDXclnsLC+zbmgSRpkG0lCCb1MeXXJT6LeK
         SIWHDD7uCVhW3T8zjoaZOrAZMB6pSbVoGN19R+88IkXnOtiAtT1OEnHdWS1fa2EaZ96z
         zY1pM2wVW2pz0J5tnuxNxYU03ttXDqZeludYHMrN2xceovd9ClzWeYPKvwrWMUibYDbu
         2Gl47fyZcJB8ynjI0HAAnEjGenYDCe20XMdec2QkOLM8mDDmSmADIboeSrNR6L9iL0QD
         nN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ElMJ7bjXqaQdzuOQnFsg0ZG+tTn3DsBAWPK7hzq2d+0=;
        b=iZygXRz1M07SZ+KOus7c9CGh2QLpHzJUvmyR71mAfKQkNjp8bp9lD+zjcdhvSOdDg0
         28wrXQIqlS2AB9Qd3u1q/POkP3evxA/nkgn1QPqiUgMiLizbqy79J0HSty04HqInwj/M
         szB+M8uy6TXpNSjasZbtmglifCLC866EZ+fouWCbxtc3cX7ihml/lvblxqL95+X0e37e
         4DIq2GJJShdNEwwTQAVQY/ObWiRttr6DWiQL+J/R0wHh7OfYkkGBcimEt/h6+SPDAi4g
         giUa+e+GxHfjE1DFUhP4NVMMQMlbGLn512oICqHJRuJmVDw+JGC/wI14NvFY55QN6cq+
         n3Vg==
X-Gm-Message-State: AOAM532oDuoBsxFn7a9fh3c9IrAMTXA7bDu6ofKoWAHQksyTHQT9Hll1
        E/EzQut0QfK7WH2aFM6XgJqdKbaYuTM=
X-Google-Smtp-Source: ABdhPJzl2sNY9D/P3SNZFbHGL6XRAqe9JvEhWGrSO+KRNE1llBItcwr9bdAJ/PSztIc8fIsFV6txWQ==
X-Received: by 2002:a63:3e06:: with SMTP id l6mr4892681pga.140.1616627972173;
        Wed, 24 Mar 2021 16:19:32 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:f8fe:8e5d:4c9f:edfd])
        by smtp.googlemail.com with ESMTPSA id z3sm3629928pff.40.2021.03.24.16.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 16:19:31 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v5 1/6] ext4: drop s_mb_bal_lock and convert protected fields to atomic
Date:   Wed, 24 Mar 2021 16:19:11 -0700
Message-Id: <20210324231916.2515824-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
References: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

s_mb_buddies_generated gets used later in this patch series to
determine if the cr 0 and cr 1 optimziations should be performed or
not. Currently, s_mb_buddies_generated is protected under a
spin_lock. In the allocation path, it is better if we don't depend on
the lock and instead read the value atomically. In order to do that,
we drop s_bal_lock altogether and we convert the only two protected
fields by it s_mb_buddies_generated and s_mb_generation_time to atomic
type.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/ext4/ext4.h    |  5 ++---
 fs/ext4/mballoc.c | 13 +++++--------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2866d249f3d2..cb0724b87d54 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1552,9 +1552,8 @@ struct ext4_sb_info {
 	atomic_t s_bal_goals;	/* goal hits */
 	atomic_t s_bal_breaks;	/* too long searches */
 	atomic_t s_bal_2orders;	/* 2^order hits */
-	spinlock_t s_bal_lock;
-	unsigned long s_mb_buddies_generated;
-	unsigned long long s_mb_generation_time;
+	atomic_t s_mb_buddies_generated;	/* number of buddies generated */
+	atomic64_t s_mb_generation_time;
 	atomic_t s_mb_lost_chunks;
 	atomic_t s_mb_preallocated;
 	atomic_t s_mb_discarded;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 99bf091fee10..07b78a3cc421 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -816,10 +816,8 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 	clear_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &(grp->bb_state));
 
 	period = get_cycles() - period;
-	spin_lock(&sbi->s_bal_lock);
-	sbi->s_mb_buddies_generated++;
-	sbi->s_mb_generation_time += period;
-	spin_unlock(&sbi->s_bal_lock);
+	atomic_inc(&sbi->s_mb_buddies_generated);
+	atomic64_add(period, &sbi->s_mb_generation_time);
 }
 
 /* The buddy information is attached the buddy cache inode
@@ -2843,7 +2841,6 @@ int ext4_mb_init(struct super_block *sb)
 	} while (i <= sb->s_blocksize_bits + 1);
 
 	spin_lock_init(&sbi->s_md_lock);
-	spin_lock_init(&sbi->s_bal_lock);
 	sbi->s_mb_free_pending = 0;
 	INIT_LIST_HEAD(&sbi->s_freed_data_list);
 
@@ -2979,9 +2976,9 @@ int ext4_mb_release(struct super_block *sb)
 				atomic_read(&sbi->s_bal_breaks),
 				atomic_read(&sbi->s_mb_lost_chunks));
 		ext4_msg(sb, KERN_INFO,
-		       "mballoc: %lu generated and it took %Lu",
-				sbi->s_mb_buddies_generated,
-				sbi->s_mb_generation_time);
+		       "mballoc: %u generated and it took %llu",
+				atomic_read(&sbi->s_mb_buddies_generated),
+				atomic64_read(&sbi->s_mb_generation_time));
 		ext4_msg(sb, KERN_INFO,
 		       "mballoc: %u preallocated, %u discarded",
 				atomic_read(&sbi->s_mb_preallocated),
-- 
2.31.0.291.g576ba9dcdaf-goog


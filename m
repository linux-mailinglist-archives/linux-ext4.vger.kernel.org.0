Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957EA326782
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 20:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBZThK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 14:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhBZThG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Feb 2021 14:37:06 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A05DC06174A
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:26 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 201so6939837pfw.5
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sIZGrpGooSBFOHOM1EUak1gYGHwH+zFPkE3v4htIJMM=;
        b=XGJIpPbgWq0aH9Fe9GnRe5Rk59o6PfNb+KQn+Jb8GBQg2WhoCeNPpcTn3Dwf3GqGAk
         MPDBl6crhizu01InfoM4pLVwnALSq9klaY9DSVR//8C64b0ASKHIumozgaJfHu6mM/iA
         3i8JF+zwGkDYUt1cpu8S5Y9BieutZjsCoUBAXnkNZ7aU/F1CaHGVRwiJX88MYdo/yLgs
         +Y/y7zU3nCIEVmU8sJoB2ACpWwQ8WAH3Z1n7TShOD3FB/Jie4sg/UANArSKkr67IuX5i
         eeWXoHiEeO8ulcr87hwzXWl5SZ0grX1YitgdQ5VBqxQVjSnuX6i8FkhCDSWfzDg+hd1w
         dw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sIZGrpGooSBFOHOM1EUak1gYGHwH+zFPkE3v4htIJMM=;
        b=WA3rqwSgnr+HT5Ywi9l89d39R+pIYyaw1gkRBGG+TjwJSHRwUmNVcEOLOnllDtz269
         GczHdy9+0dBNX9rVbX5FrWqM5dlDQsC14wMEbfSICMuF7eUiSae0vTnqQuTnkn9adKPK
         ztXt3V7QiFpjm8RoyCMORbgoV3x5bLrxEn1z5ew7vQzppNonTwqvhTBVCwvjFkleL+Ml
         JBdxdIH42VK2xtvs1X9uuqC4ir4zUJ4c6rHFiDhxHNiApWWeP0g/uhnHlwSpL359Qc1k
         /oW6dcoM2WABUWcOaX5vlxp79QEuQWEkmzsAb05ZO2Ov38VOze5HBym3S4iJGzhJbCJr
         2Erg==
X-Gm-Message-State: AOAM531PlbPjxXc3dJ+lI3OI5U97V3bf0MKWjO4xdWkfSShjlIQ3TwfD
        o6bflSwvBuFTJmJ4J5dwY7BbpR3kMjs=
X-Google-Smtp-Source: ABdhPJxqRxRtUiAIq2KM3NkaU+4ubagJrUexY9/iFkmHCE3jhzxUUek4T4kH4akb8q9f6Shz1WeGRg==
X-Received: by 2002:a63:30c5:: with SMTP id w188mr4205838pgw.375.1614368185221;
        Fri, 26 Feb 2021 11:36:25 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:e88c:d103:27dc:612d])
        by smtp.googlemail.com with ESMTPSA id x129sm2935041pfc.96.2021.02.26.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 11:36:24 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger@dilger.ca,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 1/5] ext4: drop s_mb_bal_lock and convert protected fields to atomic
Date:   Fri, 26 Feb 2021 11:36:08 -0800
Message-Id: <20210226193612.1199321-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
References: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
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
2.30.1.766.gb4fecdf3b7-goog


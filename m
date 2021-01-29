Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462B630901C
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Jan 2021 23:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhA2WbA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Jan 2021 17:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhA2Waw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Jan 2021 17:30:52 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CF2C06174A
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 14:30:10 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o7so7626363pgl.1
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 14:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xfOwVDspnIO1YFUaKbkqG+i39CROAQwGnLyL+vQ+YeI=;
        b=OSoHxmvlZLej5m0TBF0nKwPWwkpep8oZhVgnwtr2j7ASAikoBzQnP4a313jZG7pR8J
         sh4bUr/bDZxK4QRJ1lLmjqAhlupIQG5kbi7d0mQhDrLM4qco2txmmGFsjVuB9iPGS+67
         33G3QbE1zmYRXNp7TA3BZGy9dlaYoF0wpJK4JJdIYLoXasNAslY++D/wWELDf2Yrv6Ed
         9dgPcJpAx4BZypR+QjZorl8XvdIAyIAFOeee/rUcK8u+YddJ3gmOMEYudOCymYIjiULB
         lG2C/ESg1sqVXMSqdwdACU07BY/I7UKie10m++oMg6+F+RTtIYuEdIRlpMTUxULlbo0C
         eX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xfOwVDspnIO1YFUaKbkqG+i39CROAQwGnLyL+vQ+YeI=;
        b=M5sOSZSD3RT5O102SiQNAfbsF/NavPTizm9hXUQHw41qLkX71esjRZRXWjIu/Q4cgl
         euC1CFRz18UqEsPxWeUEgUH1jGlTP1/ixec2Vo/pMwX2IOjwo9q4fX8G+CKYYONdJ/sF
         hK57Misz5w7RyqYNvtJ7Bcy7GVIQtPclN68inGbXKmRM1qQheqIYa/K9BfD9gwmTJIZu
         doW/1GRG8I2K5JrvBk8vlHvMtaUlgDqygv5oEfpMIKZ9tAAk6aKMj0PEDRh0BYYxutqQ
         1j+ZgUWBSinLSthzPjrBej4A/CsUw6I71QJittrSbC2xrS5dDuc2WNKoxCB1MSEcFzL5
         PpzQ==
X-Gm-Message-State: AOAM532zMi5AmXyNAakQ2mRQioM7RbLHzmXlI2NIwc+Un7H2N/vXOJdB
        m3mdHLG9DtpXfcIL9Kc3GGz6p0M1Lfo=
X-Google-Smtp-Source: ABdhPJzPaZvQx6bybLw/3hRgaUxP2+n8y7v8N0NRhvE1pEZ9JSb33epq+5HW/q+xcHNx/0uL2r5QOA==
X-Received: by 2002:a63:f34f:: with SMTP id t15mr6571611pgj.239.1611959409755;
        Fri, 29 Jan 2021 14:30:09 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id d14sm9719358pfo.156.2021.01.29.14.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 14:30:08 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/4] ext4: drop s_mb_bal_lock and convert protected fields to atomic
Date:   Fri, 29 Jan 2021 14:29:29 -0800
Message-Id: <20210129222931.623008-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
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
---
 fs/ext4/ext4.h    |  5 ++---
 fs/ext4/mballoc.c | 13 +++++--------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 64f25ea2fa7a..6dd127942208 100644
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
index 625242e5c683..11c56b0e6f35 100644
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
@@ -2844,7 +2842,6 @@ int ext4_mb_init(struct super_block *sb)
 
 
 	spin_lock_init(&sbi->s_md_lock);
-	spin_lock_init(&sbi->s_bal_lock);
 	sbi->s_mb_free_pending = 0;
 	INIT_LIST_HEAD(&sbi->s_freed_data_list);
 
@@ -2980,9 +2977,9 @@ int ext4_mb_release(struct super_block *sb)
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
2.30.0.365.g02bc693789-goog


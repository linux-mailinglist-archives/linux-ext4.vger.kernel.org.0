Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033EF3157EA
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Feb 2021 21:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhBIUpM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Feb 2021 15:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbhBIUjr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Feb 2021 15:39:47 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B152C0698D4
        for <linux-ext4@vger.kernel.org>; Tue,  9 Feb 2021 12:29:06 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z6so3514202pfq.0
        for <linux-ext4@vger.kernel.org>; Tue, 09 Feb 2021 12:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6gXc36Fb7rev0oeIRbVuSomePZlN/Rh1wSk7zuJJl8=;
        b=i1unExR5mEXn0h9u/DX3vamDMNXG0KMzY1P5es/Z8TRFp43c4kJ7nLKE9oxo8UjEns
         uk+e3XS+fdwiLVQtEa39cbcjF5W2RXlgc9Bdchr3MDVD4c2vzAFU+Wo/xSn01NJrORS3
         3LiGTE/8/yvftMc3ZXzHMxTUMGpvMCTxcMkWxHSZFU7NvbdKHNFwTzFnPFIYTHWSyMSu
         A3jZaglHRxYlpP3Rfo+xeQfETXFNATVsKLXFBVfC7gMl4RFyf/EVq4c40uKUl4Vvyqmd
         vzw1lXQTop9nG3LqOdtpk86FTcdFT5mr3H4pHTDcbHdm/0dxJcg2kcv5oKk2lzyix8VM
         UwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6gXc36Fb7rev0oeIRbVuSomePZlN/Rh1wSk7zuJJl8=;
        b=nIyEIzlARLuUgdB4gRdYZfuROePWvWnwebBZgqfzZUeZulBueyQDTdaAJsjPzIFlFM
         o9y3Br5TTnZwrT0iAsPw3X0NkkPpmwjxsfJfRs/jYFAKefdS8J2+oNDoM9jdfK0z8zya
         h28I6K0D43Phdv4Uer4aAEd+/hW9/gMoDcz3FYEmhEBLOuEsXJNCSNhMODYNSgpWIRwE
         eOvHr8bW+9PZNvE7uMhsTRN2NYZWLdZdwpD+BIN9eynAJyOaYq9uOuretBkifjo5TS3+
         FYhdYtieemPl9SYE0QFNCN1gpFuJD/Y3wnyNscQCRvddHYLwOhUu3maz455y9j+1xHOB
         x57Q==
X-Gm-Message-State: AOAM5323MVHanUy2J0qNc44t3z23B9JLj7v0bBB+mibCJkokcDhtgaSd
        2WRtrZwxLlT8sTfbnSnWXQcVkIBnRk8=
X-Google-Smtp-Source: ABdhPJxmdpAuT5XD5z5Pat2zTGL+viZ/MBhLeMr8c8zcRTalYqfDHFR3MUUULXLPP8n8w3Xw7dsggw==
X-Received: by 2002:a63:4a49:: with SMTP id j9mr24270712pgl.197.1612902545937;
        Tue, 09 Feb 2021 12:29:05 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:1d7c:b2d9:c196:949c])
        by smtp.googlemail.com with ESMTPSA id p12sm3325827pju.35.2021.02.09.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:29:05 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, bzzz@whamcloud.com, artem.blagodarenko@gmail.com,
        sihara@ddn.com, adilger@dilger.ca,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 1/5] ext4: drop s_mb_bal_lock and convert protected fields to atomic
Date:   Tue,  9 Feb 2021 12:28:53 -0800
Message-Id: <20210209202857.4185846-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
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
2.30.0.478.g8a0d178c01-goog


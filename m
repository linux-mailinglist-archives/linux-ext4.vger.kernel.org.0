Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EBB35185C
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhDARpp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhDARkL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 13:40:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C224C0319CA
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 10:21:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g10so1344554plt.8
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 10:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1g9769Ltx4hInk6A249+gbIE5yVpVqL9UtxHOYXY3gg=;
        b=igp3opwY8EAMv+4eI3y0XudoeeA2JJpbuXA+XrlTyyqw1KxvX3L1yWkB+kgJWl4mzP
         EavHZCOxVz967NdvQ57qrLh/bus1dFapgjSJ3vhxpJ4gNXVUcQaz1ELhZzBvCf7i/7qa
         Cdg+dNpy349dv4pJ57bhLcg0E+q7OGKUJX6sMwrW+MsYrSL6zgj3CUaaSHmKbLfZRsur
         lebzoQ60C9XNJtQiHW1CLgdmY6I5mGUxg16hW7P+l3tLxOjq1QMpd/Fv67g9xuRGYZse
         qIDHQcF70OW128hmLkDLeW/SOOeeA/NoNig94Ev8isZQhyXeT/FlSHc4mOsXJ5ps0LKi
         siiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1g9769Ltx4hInk6A249+gbIE5yVpVqL9UtxHOYXY3gg=;
        b=YMjyaLuvASmPrWhsAEGiB5Z42NO3/nkgqg4ncGsTSUfZInGhZ0nv0oO4Ab72Zmjl/H
         e33gj8Vmxf1dMKBY9uSJV1KC5GxWrSsjXJA5UcvXLP4cOUX8eGRd7RlGA2d3RuwINJ3M
         QjsRr6BHFJ0RTjVEu2LZOF8ggwAmd5qg7ZizEHE+xmZOIDHv9TZKOio58+0s0seXRyK2
         K+6y6CJyJP/0KnUUJeHeQwdO7GnoSd2ANM9sVUnHSg7b4NHGkksE8STjfYWlraWJ8lCQ
         oCn8qWG8GitVZy+YQAa1HG4LLqUvP+yxWBEjUygl+jlUdSjPXctBsk9Wn/fIzr49VAN+
         gE7Q==
X-Gm-Message-State: AOAM533FFn6Q/e0WDrglj9nNrgEbbeH/yz0n6w2ZOT9nItXKwvbyfOpT
        APN8nizpREMIDrvEssPbZ3YjHDN5Zms=
X-Google-Smtp-Source: ABdhPJw3KpwVHtPndqww0bqqmLNrbwjGQof3I3oUXnBjXLL0H1D7WKRNbp90OsVmj8GiYFvCo3BL7g==
X-Received: by 2002:a17:902:8347:b029:e7:4a2d:6589 with SMTP id z7-20020a1709028347b02900e74a2d6589mr9122187pln.64.1617297699244;
        Thu, 01 Apr 2021 10:21:39 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:455f:9418:5b00:693])
        by smtp.googlemail.com with ESMTPSA id w26sm5751766pfn.33.2021.04.01.10.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:21:38 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v6 1/7] ext4: drop s_mb_bal_lock and convert protected fields to atomic
Date:   Thu,  1 Apr 2021 10:21:23 -0700
Message-Id: <20210401172129.189766-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
References: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
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
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
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


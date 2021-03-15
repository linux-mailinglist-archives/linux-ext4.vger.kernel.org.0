Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C861733C496
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 18:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhCORhq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbhCORha (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 13:37:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21049C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso15177797pjb.4
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rm6iff/Xns9Fjjp2zg4s4LGlY03vmdwWCtYKtxgtvxM=;
        b=DgPmnFejlSRyfj7gtuRUmmhGjSLPrRBlRfX8iOCirobfLSw4PsuxelDsiJ7HLWWjjo
         vlxgrITXntaJYeu0qtT/OgYBhdIQKx7mE6b5oCK3io87LPzYdWlX3RiJhl5kshnoQ5MI
         eaF6XPCkdUxDCH6f55icZF+DejK1wh+S81zJwEuI1uOCtWrWjb7fahqchY8bgozE0mbl
         giuZxsNknt1WndQqenSkec+dO+D6DC5n246bicd+W82oB6oPwnaVPlbe5Yga7fuBbvjI
         iMeVMw1U10Hnw3QYxrLQyhWKDyemwcr+swsIBMMxFxuAqLvFSOnXvA1p//6ODF4hf5hb
         G1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rm6iff/Xns9Fjjp2zg4s4LGlY03vmdwWCtYKtxgtvxM=;
        b=QwUJE5+vSyNn+ROQstydz92CZnPPL/PPgFn8VyyLB1j+FosyXQz/u2vdxzrugmREyB
         1q/CWzryAtvmxYUXEhVchk78pUXm2BLEM+6yFNkhiK4oV3nzE1T+DxDbRmPBdpKu7KgH
         ttEqnkLRclQAO6X1QqjKHyG7/BFtcB9DVuGwf8NoMw+Ju/+PR31MrroQf8gMNjQ57gIx
         Mxc+2FgGcwdKUGg5L+ZWTqrd2qs7/2vu06RTo/McbOHvAfDfV4y2ZPp7n/sbyA8hEha6
         cICU3/GWeYcAIj2Y2EpibbCE8Bi7zDwGFBPLPq3zIII7/V3DvJAb1CiASK7TSfy+9gV4
         Eh6g==
X-Gm-Message-State: AOAM5329HxSt7ho3VgZu01siu7nj642svtn3MIm9sGKQMKY6NDil+Vm8
        SLuYx1PDPipkTOVzNKxARolROURQjyI=
X-Google-Smtp-Source: ABdhPJwLL360RbuqTDoncMVJqPP9pP8JLjVW50pmRnQfjHpoJtjkq66CeJ7aU+SDW1macTYjimdpqQ==
X-Received: by 2002:a17:90b:ecc:: with SMTP id gz12mr174919pjb.79.1615829849335;
        Mon, 15 Mar 2021 10:37:29 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:1025:7e5a:33cc:4e9c])
        by smtp.googlemail.com with ESMTPSA id p190sm13520178pga.78.2021.03.15.10.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:37:28 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v4 1/6] ext4: drop s_mb_bal_lock and convert protected fields to atomic
Date:   Mon, 15 Mar 2021 10:37:11 -0700
Message-Id: <20210315173716.360726-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
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
2.31.0.rc2.261.g7f71774620-goog


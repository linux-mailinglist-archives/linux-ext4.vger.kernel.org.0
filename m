Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F45245038
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Aug 2020 02:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHOAKt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Aug 2020 20:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHOAKs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Aug 2020 20:10:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F314C061385
        for <linux-ext4@vger.kernel.org>; Fri, 14 Aug 2020 17:10:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ep8so5105925pjb.3
        for <linux-ext4@vger.kernel.org>; Fri, 14 Aug 2020 17:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dlnrH4FTjfd4ukaEgdwiA3Ep3chR13xQXWxmzzgGBRM=;
        b=cPJHq6HUItUx9LS2OdstRSl1Rxkvgei0HhviPKbiJwJwfzk044Ff4im/qYTITOGxuq
         XRg/PCSCwEmS94YJRgEgNap2yt34IvvfdzjWzgpCN+0AouTvnjEJgGR62NGwiI6STgJ5
         u39M7MTf63wQzoxT7yLOvBRJLv88Tn1r6aasjl2RtvHDtnuEAcuyF/DWULv7XHfiffhZ
         wKMgDNGCd3iw6K3QeOSVx8/NeSboGBjC90A9mzZk7OL9LOfDrfaLglgzI0bnHpViKIc8
         IgntcYpRA0NIcvt2mJjH7i/0jtBOCUnnRhN/XpJJZYlM/7tGNAFhnkdHV5GhYa+q3+Ua
         Rnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dlnrH4FTjfd4ukaEgdwiA3Ep3chR13xQXWxmzzgGBRM=;
        b=eiRNLyv2J1gHEnx6EJzNZWf63xFlNIKDLCT7ZKRjqOOtsGKFRi5gCTC3IcsdYYSH4A
         4cgJThbZ9KA8J4I77i0THnXCvMnh2/WHN+O+bXzC7TwQVZ/pvC8vUy3Un5NGPbS5sGBY
         z6nIuPlTto+xNxaIuR26FeQdYGHTeMhffmodF8ao/yW0SmOEz9J8quH8uf/UiVZHE4BB
         q7ftNd1R9wX8xtPNqEeyHr/oaNbK7tTCTnEY53vDhi65TYiDme9jRTZYXKoMppr5RjbC
         q4wPEcSvBLbvb5K0dKgyYxX74i4ibay679bK9xGzy9NtvTZFm1DnxH1uZjpWnoq1idG4
         Zm8g==
X-Gm-Message-State: AOAM533CE5T2Mx8dqYXXhJZqZmtehGvgCBQg68nyOjpjySH9Vkw5S6VZ
        W0N/TTILOTQhax2lWdTaMnEtDyLiB9g=
X-Google-Smtp-Source: ABdhPJxXl/mb+y5ZFvnAmUWXGSMbqVKUvEhkQ2abTzw7GjmRWZwmtDevtOFTLs3UR/wHk1UMIW25qQ==
X-Received: by 2002:a17:902:b194:: with SMTP id s20mr3801969plr.321.1597450247346;
        Fri, 14 Aug 2020 17:10:47 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id 196sm10725113pfc.178.2020.08.14.17.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 17:10:46 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v3] ext4: fix log printing of ext4_mb_regular_allocator()
To:     adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Message-ID: <0a165ac0-1912-aebd-8a0d-b42e7cd1aea1@gmail.com>
Date:   Sat, 15 Aug 2020 08:10:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix log printing of ext4_mb_regular_allocator()，it may be an
unintentional behavior.

V3:
It may be better to add a comma between start and len, which is
convenient for script processing.

V2:
Add more valuable information, such as group, start, len, lost.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c0a331e..70b110f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2218,6 +2218,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi;
 	struct super_block *sb;
 	struct ext4_buddy e4b;
+	unsigned int lost;
 
 	sb = ac->ac_sb;
 	sbi = EXT4_SB(sb);
@@ -2341,22 +2342,24 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		 * We've been searching too long. Let's try to allocate
 		 * the best chunk we've found so far
 		 */
-
 		ext4_mb_try_best_found(ac, &e4b);
 		if (ac->ac_status != AC_STATUS_FOUND) {
 			/*
 			 * Someone more lucky has already allocated it.
 			 * The only thing we can do is just take first
 			 * found block(s)
-			printk(KERN_DEBUG "EXT4-fs: someone won our chunk\n");
 			 */
+			lost = (unsigned int)atomic_inc_return(&sbi->s_mb_lost_chunks);
+			mb_debug(sb, "lost chunk, group: %u, start: %d, len: %d, lost: %u\n",
+				 ac->ac_b_ex.fe_group, ac->ac_b_ex.fe_start,
+				 ac->ac_b_ex.fe_len, lost);
+
 			ac->ac_b_ex.fe_group = 0;
 			ac->ac_b_ex.fe_start = 0;
 			ac->ac_b_ex.fe_len = 0;
 			ac->ac_status = AC_STATUS_CONTINUE;
 			ac->ac_flags |= EXT4_MB_HINT_FIRST;
 			cr = 3;
-			atomic_inc(&sbi->s_mb_lost_chunks);
 			goto repeat;
 		}
 	}
-- 
1.8.3.1



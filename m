Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285462443A4
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Aug 2020 04:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHNC53 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 22:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHNC53 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Aug 2020 22:57:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A544C061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 19:57:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so3862659pfh.3
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 19:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lIpSLAYTBc3n3tfErn3hiQO7fF4+UZXCHsNqgW0Lan0=;
        b=Ka+oUgG/VYeyllOVLy08WEVkDYvxVqpvo0mPkXmWlfFqtI3N5HaEIlAv+oo6iSkM4e
         5hiYtF08MkIc8QQQOAGNozMME7pRV23Kn8XwXvUxWPOiLUZPKSIV+DIhNhgPNIaGEpwn
         ZkEc4GYRp0yA2VSf7CbkDu2It+ZGoG+Oy4+7e8uYz6acCdI6hNM1Ndx6NT981MqWScQ8
         fT9LZjzcVLmQUOuUTW1Kly4U/pKaOUSlP1AgH+J9cnHR9OReun+FljYUyLXmj1Y8TNR5
         w4oDyG6qEwD7pfcB3GHpYsGJKjOQhc9x8eyzqPp+MF+2QN3Vo2HGTElst4dnMhbVWSiP
         e3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lIpSLAYTBc3n3tfErn3hiQO7fF4+UZXCHsNqgW0Lan0=;
        b=ojvs/F2HjVAPzN5V+GcTcUgHWH5VCYW0nKHAntghKSufspHZVGKdaeohL6SlgSWfcd
         zA9N3iUNvRypIRJTIys8xRKVgCl2b85yeNfeQ93Y3UdG63cYmwwrsGW2XOVMTUjy0shZ
         RB4aHSLe5e3cJWvdqzmVCLgOah6FF3c6zjDdHU76n/j5IwymLuKNIAJOrQy590ZD4ihY
         ReQjcZaopFqy7otsbnvfcIk+ZgdGx1ZOcPiFvYM1tZotR5kfXSPTQlmRfeoGlkXc5K1l
         uL29VEvbwcY5cue3RYTvna3D0m4rGG49jvOI58XLZqTizAgaVgb8Hje7pfuKPtzB1sqa
         0UXg==
X-Gm-Message-State: AOAM5306YQHNQ4Edw+2OMwi852DmJ3fMOTsUCbQDcmYbNv9bPWNrt3Lq
        NAkgIJfU7P0iHRoIf9sxn00=
X-Google-Smtp-Source: ABdhPJwf9rFV0qr4u+qmAVicvD+f7+2RjIok6v0XTs+2UA0mu4FInRUyXB9DNMv19Q4MFVXVRZVNDw==
X-Received: by 2002:aa7:9569:: with SMTP id x9mr335567pfq.16.1597373848909;
        Thu, 13 Aug 2020 19:57:28 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id nu14sm6690036pjb.19.2020.08.13.19.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 19:57:28 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH v2] ext4: fix log printing of ext4_mb_regular_allocator()
To:     adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Message-ID: <597ddf01-0c19-c951-6d98-0a011da975fc@gmail.com>
Date:   Fri, 14 Aug 2020 10:57:26 +0800
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

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c0a331e..6e59ca2 100644
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
+			mb_debug(sb, "lost chunk, group: %u, start: %d len: %d, lost: %u\n",
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



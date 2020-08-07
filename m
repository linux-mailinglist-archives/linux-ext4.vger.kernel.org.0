Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4885923EE9D
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHGOD7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 10:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgHGOCI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 10:02:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB5C06179E
        for <linux-ext4@vger.kernel.org>; Fri,  7 Aug 2020 07:01:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so923738pjb.4
        for <linux-ext4@vger.kernel.org>; Fri, 07 Aug 2020 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=LSJ5M8WtjTDp5Ug/zXqMJMc2NUuifOhMIP4KKsG1N0w=;
        b=cv/bJPhEnFchVhZ6kfWr8K30JsaLlNqXgqOiomwNMfHgTYy7DDEOZ9lQrG8IfGZbM2
         LnrqBMQCq7ZMhIP1cjYfAiDRPh5HuFsSHNTaGAP+CZMa0aaNU5lMhWG/2g5ja8QaBavu
         A0HVAWraDMZExUeFxbEMTl8GRS7zS/OOOlta+TdQVkei7XvPuDYRx35kEzsGSFA/q6Og
         sMe7mopbhsc53UCK19P5iNJXX8bQz/4Xdo6qFLObQdWEAeFKLcJdEousYABKURdA6rKv
         IHf4vUsZoFQb4Ox6FGR1Fk4a9g4V0/A4UyWmpY8pSEIqgIu18ub90ItRkZ79M/dD45R3
         qtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=LSJ5M8WtjTDp5Ug/zXqMJMc2NUuifOhMIP4KKsG1N0w=;
        b=f5mPSr8/6RwrM6UU8nAyJKDda8/wS0CIkXLmd49/npt2sCYF5invzaBnmjpHBlkoF+
         r/WaR5xlpgxf5o1QZURnPttrr76pwiNsGs7O4r64VuaQEgAjT1p4/fnWb8ZkZvYcR773
         bhH0bYif5OfCRxYCsTZgsTY/OirUBp1tRQVSuKXEg0WnbssYDHlTEpxDLQGLbYJkg9SB
         Xy1e5JLK2fMCZaoa2zPKrabYLnFVU+53xPQNdcUQ/fDJmah/bHijTd4kGqSyuc5RkAKe
         vKASiZ3oOIiKWge++viX6e6Llu0PQjAGrcu4KGPEw+oEjnDD/72SwwwcM9FMf80osr8O
         Y0bA==
X-Gm-Message-State: AOAM531TKlIzWw+XtGf7FhCqBK02L3nvctdUA2nPkyiKPxJ+yps0xvfs
        WBzMzc4PMFCunpw8ErnKEeSPOiFxz4U=
X-Google-Smtp-Source: ABdhPJzJibSNuqjZfJ7NnvP+VGUDfMqqgPs4ec9Y2q5Cq0mdAQChgzHHu2fcLh25ag58j4d2EfYQRg==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr13078568plr.211.1596808915962;
        Fri, 07 Aug 2020 07:01:55 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id e26sm11761567pgt.63.2020.08.07.07.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 07:01:55 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH] ext4: fix log printing of ext4_mb_regular_allocator()
To:     adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org
Message-ID: <131a608b-0c8a-1a2d-57ee-4263cfcdd5a2@gmail.com>
Date:   Fri, 7 Aug 2020 22:01:54 +0800
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
 fs/ext4/mballoc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5d4a1be..b0da525 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2324,15 +2324,14 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
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
+			mb_debug(sb, "EXT4-fs: someone won our chunk\n");
 			ac->ac_b_ex.fe_group = 0;
 			ac->ac_b_ex.fe_start = 0;
 			ac->ac_b_ex.fe_len = 0;
-- 
1.8.3.1

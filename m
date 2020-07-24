Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DD322BC38
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jul 2020 04:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGXC6Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jul 2020 22:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgGXC6O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Jul 2020 22:58:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ECFC0619D3;
        Thu, 23 Jul 2020 19:58:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 207so4267522pfu.3;
        Thu, 23 Jul 2020 19:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=4t0GZUqaSa6aUwCTaIwAXrly6p8Czif4LGn3BgFT6TE=;
        b=DPcpUPcNBFgbN7NAuBzuNO5Cgtw+MrsUmXPHfU+OWuGOduhQbZnz76vLQ/FUX7yz92
         XL04/XCDd2soVga9zJ7+8HSR8IQyL+R5wH7id1BAsFxQWMrq8oyMD7LLMYU/82GOpymv
         +GPYxG6e4Q8ueq3ddqAQXcD5e3xJRg2mjNTZbw593KHL6V9P/BIAs60cB7oQf/duObjP
         VPQJXMcu64DEEOI0Hoc9hjVolEUhJ5UXmMEY6ny9tPpGmLSNHyfEfRumXahdRSuZAuK1
         enInlhtA67QA9NqgdQ3LIj+y6mjEE2IlSXWYk/VjdoI+snUw4hBXOi053H2sLQNMbBhl
         8oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=4t0GZUqaSa6aUwCTaIwAXrly6p8Czif4LGn3BgFT6TE=;
        b=dSKfHU1MojYoezYfHGk/xKHllhMa1Cf8mLuU9iM9Q+tluyYKJkrx/NBY2Ua86QOL1X
         n88B5a2s9Jctxj+WvM4sp1sEfA+fz/B7njhEI4LDQvAnl5Y9lq+fPrkuoxb4vAoxH1Wx
         /1WGei9MabV6hJFpGMmPplTOXPRGq0E6o0zOIFoscTcSnReEmoORPMIflvzXzOSdmvJu
         OTVFFjt95idBU6Odj3w4UVG9S23xgQs1NgAwLeXlJxX/83YeK9FDy3RVlI7MDXWqpzqU
         TNY9wetGLQfXf3fe8Li1gWKdO4Ci8WCD3QZaFAHeed7uxnV98sD56b7Mlk30aEdZFdZW
         S8xw==
X-Gm-Message-State: AOAM531rm6cJUGBvl6g1GAFIEanWdCMCZ3waESOqpZU5k0+DEcn7RhmC
        YP6OZoDUmCE5BBCPWZABCdSEPTOs35k=
X-Google-Smtp-Source: ABdhPJxWhg6BPC7Zci2dfEdWTRJy2DPvvLgGvpP3lqtfKmZx74vens29zzaH67vEJKbpoq5BjWATEg==
X-Received: by 2002:a62:82ce:: with SMTP id w197mr6955833pfd.322.1595559494291;
        Thu, 23 Jul 2020 19:58:14 -0700 (PDT)
Received: from [10.8.0.10] ([203.205.141.54])
        by smtp.gmail.com with ESMTPSA id h15sm4405238pjc.14.2020.07.23.19.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 19:58:13 -0700 (PDT)
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH 1/3] ext4: reorganize if statement of,
 ext4_mb_release_context()
Message-ID: <4de96de5-c645-f25e-d2cf-f788d56f6f51@gmail.com>
Date:   Fri, 24 Jul 2020 10:58:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Reorganize the if statement of ext4_mb_release_context(), make it
easier to read.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c0a331e..4f21f34 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4564,20 +4564,19 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
             pa->pa_free -= ac->ac_b_ex.fe_len;
             pa->pa_len -= ac->ac_b_ex.fe_len;
             spin_unlock(&pa->pa_lock);
-        }
-    }
-    if (pa) {
-        /*
-         * We want to add the pa to the right bucket.
-         * Remove it from the list and while adding
-         * make sure the list to which we are adding
-         * doesn't grow big.
-         */
-        if ((pa->pa_type == MB_GROUP_PA) && likely(pa->pa_free)) {
-            spin_lock(pa->pa_obj_lock);
-            list_del_rcu(&pa->pa_inode_list);
-            spin_unlock(pa->pa_obj_lock);
-            ext4_mb_add_n_trim(ac);
+
+            /*
+             * We want to add the pa to the right bucket.
+             * Remove it from the list and while adding
+             * make sure the list to which we are adding
+             * doesn't grow big.
+             */
+            if (likely(pa->pa_free)) {
+                spin_lock(pa->pa_obj_lock);
+                list_del_rcu(&pa->pa_inode_list);
+                spin_unlock(pa->pa_obj_lock);
+                ext4_mb_add_n_trim(ac);
+            }
         }
         ext4_mb_put_pa(ac, ac->ac_sb, pa);
     }
-- 
1.8.3.1


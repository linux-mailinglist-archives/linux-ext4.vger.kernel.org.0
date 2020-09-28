Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0171A27ACF7
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Sep 2020 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgI1Lgj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Sep 2020 07:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1Lgj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Sep 2020 07:36:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C8C061755
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 04:36:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u24so629247pgi.1
        for <linux-ext4@vger.kernel.org>; Mon, 28 Sep 2020 04:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l2wzKyqwTHCPXrEdHtVdoWwhNHqjt4/+S8cb36uE/NY=;
        b=RKQ/jSmC73K5xYhJ2iAfXw2TmdCDyidlG7N7sPhXVhl0F8T0xF/4utD9Q6nKiesF58
         3r6KjPGcUR/BHuT83D40+Sv6142pdl/uCansXZ7oujD9OMn0+kRSY4AldbP0QJH9Hi6V
         2VK7xCsNvk+KHfc7xPySuoveLVpdw3Jb24JZzjAtJJCPivDEt1Pvv3Wzk6nvjVfA+vRZ
         t5H2AZvEMCVfHUQXWAJaB4m2quByL5nGuRZ7nRBlOrXHlARfjpcdxJMBg+djfG4JQvko
         pl9ae27lDxnrcItDMLjKjogszpBVM20jLsQLkxsESuaQlIbE/GXvwNg+TxTb53YQyyEi
         rgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l2wzKyqwTHCPXrEdHtVdoWwhNHqjt4/+S8cb36uE/NY=;
        b=pKwMLsvqx3FIZzO9Qp7cx8COqVll94Xt800xDmxtQ2peFhTnxsr0DfG5HMQPqJeoJD
         e8A949L9brqEZiWW9SnZ1dJLBsKxcptDsl6XmZhN334p252eyLioa7TWCcol1fRL4pL4
         Obml7i8Felz1z6ZRH69+zpSEmJjxbSQtqJIL+tT9eTItVtKOi8L7vcqWkdCfh7FP92NS
         9cJfLl9A+39T9xdPV4IAt16wOKMB5lYHlcGg8s1b6iGxdrvF9zOhW2j3LEvMVBwKXOEd
         CaXZHTPpO15rBJ57s8OCHzBv19Tb2BsvEThuqruJt3HnJeVjqQCoj7AJKkzUoUGA74xr
         6DXQ==
X-Gm-Message-State: AOAM530svHdc3UtqNDqsW3rZvpk0DamC44H+MSLbyR40RiwZLiqDNpq+
        Akkh51pwzyrlPHirsdkR9Xg=
X-Google-Smtp-Source: ABdhPJw4URWhogOO32v0bMn3YZUrzMuQG8RQ6RnGV6YGQ+sliGABLXN6taULbE+FDbKvfZBHJ6C5sg==
X-Received: by 2002:a05:6a00:1506:b029:142:2501:3971 with SMTP id q6-20020a056a001506b029014225013971mr1058206pfu.54.1601292998551;
        Mon, 28 Sep 2020 04:36:38 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t12sm1122820pgk.32.2020.09.28.04.36.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 04:36:38 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     adilger.kernel@dilger.ca, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: delete invalid comments near mb_buddy_adjust_border
Date:   Mon, 28 Sep 2020 19:36:34 +0800
Message-Id: <1601292995-32205-1-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

The comment near mb_buddy_adjust_border seems meaningless, just
clear it.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e5ce7dc..b89a106 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1397,9 +1397,6 @@ void ext4_set_bits(void *bm, int cur, int len)
 	}
 }
 
-/*
- * _________________________________________________________________ */
-
 static inline int mb_buddy_adjust_border(int* bit, void* bitmap, int side)
 {
 	if (mb_test_bit(*bit + side, bitmap)) {
-- 
1.8.3.1


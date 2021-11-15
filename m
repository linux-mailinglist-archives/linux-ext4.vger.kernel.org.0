Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB67450210
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Nov 2021 11:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhKOKNj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Nov 2021 05:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbhKOKNb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Nov 2021 05:13:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09152C06120A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Nov 2021 02:10:16 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so12603626pju.3
        for <linux-ext4@vger.kernel.org>; Mon, 15 Nov 2021 02:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQs9pm/aXxVAPgcSDwX1+7NsGMS9etDYwTyptaFJJ6E=;
        b=O4NkbgKXCLTnfYZHPFcJAgYBLLK4Q2LOBpTGeGeg1DLhw4ivG2tI18VG1acBSp0rA3
         onJeWPTT6hFkYJysxXl9rev18DPwL7Oz5XcKns0HsungOR0B7yKDmhHWfxlBfPN5AXL0
         xMnq8qDL5X826Inydmnjua08Z6tD6dX3bWD6ZrPhr5bTIAYNPQA6jFUTBSjAa74FAtVV
         dfvrRWZM7gABNryOWbOozgDHNfDbv/zrgR6OjbR+/9l7QnRpqWnBWGoi8UhlqwrbwmRM
         y9JN9svpLQV0G1wZWr5Y1VCx7aeKFGdGEEK++rLaI/mA9nFrB+pG6nY20OEMbex/QIvl
         1M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQs9pm/aXxVAPgcSDwX1+7NsGMS9etDYwTyptaFJJ6E=;
        b=v7rZqLscM3mziF8yedYj/PnS37pSqDXUp8H4KqnHzLGRxybVW7W8NVvJ5Kn2oPWoZd
         5rAymwfZD2bIqtsWVs7KZIx8YkcPzFYicSmDhuupdMmJBuYGFqI4Zdigj5rxd/l66gQc
         HljXzsol1n4wupj7oKjerqZMt95v/BGDJ8L6fvX00FWwwZdgL4xHi1zB4PIcGZ9711PS
         juG8dteAKvvpM0AncjPYRGIgAQfwWRhxWAYFWyXhTc+kctAF7Rs6+M8rF9WVSekV6Jm+
         AwnOdweRY1nI2xyWWvYScTEWYd4iWIdJVIRu023MbbXkCzYTPJlzAPJsllEiix3+Nzb2
         uJew==
X-Gm-Message-State: AOAM530QUFGF4SfZmoRqcmt1pkiOjIG8yqWA1jaE1pZzjt76CB0ax3bG
        CEbfPUi08NwhMWb3X3sM7Mgqa3rDsljseA==
X-Google-Smtp-Source: ABdhPJyaOvsJXCzyyniGRYQvmEq/qTr7NO/85BC0DU2HDujN3HoSHIhwrKp03ppni0xqVuvHOjqj4Q==
X-Received: by 2002:a17:90b:4d0c:: with SMTP id mw12mr45026625pjb.209.1636971015560;
        Mon, 15 Nov 2021 02:10:15 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id mi18sm13131500pjb.13.2021.11.15.02.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:10:15 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        harshadshirwadkar@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH] ext4:fix different behavior of fsync when use fast commit
Date:   Mon, 15 Nov 2021 18:09:50 +0800
Message-Id: <20211115100951.1972-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For the follow test example:
-mkdir test/
-create&write test/a.txt
-fsync test/a.txt
-crash (before a full commit)

If fast commit is used then "a.txt" will lost, while the normal
journaling can recover it.

We should keep behavior of fsync unchanged when use fast commit.

other report: https://www.spinics.net/lists/linux-ext4/msg80514.html

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/ext4/fast_commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8ea5a81e6554..2fc573575ebc 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -523,7 +523,7 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 	args.op = EXT4_FC_TAG_CREAT;
 
 	ret = ext4_fc_track_template(handle, inode, __track_dentry_update,
-					(void *)&args, 0);
+					(void *)&args, 1);
 	trace_ext4_fc_track_create(inode, dentry, ret);
 }
 
-- 
2.20.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8294C23EEB1
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 16:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgHGOIf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 10:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgHGOBs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 10:01:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86BC061575
        for <linux-ext4@vger.kernel.org>; Fri,  7 Aug 2020 07:01:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o5so947334pgb.2
        for <linux-ext4@vger.kernel.org>; Fri, 07 Aug 2020 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XIYvs1lVCvaz2DrUG7dC/2GRzmSKS+hhopwMOEdNcfA=;
        b=H9fGkHbUUVOdIxk5+JNUOG1YquZkA1XgiWRIkZ9VOXZiinM0kg6o3rUwLMQHqIfTqX
         kvshIoDCSXQvJjPBofSOmHgBPpw6Mtw3pmNAgBqt5F0RPQSbmJQeeAKfwa/93C/8cJqu
         ywsQ9VZz8xKq6Q4bXZC2MiJcnxfG0JDsZllbckH73H24ll+WUpXyL1TDBJDftCFD6a4H
         EuU1rpCTA684ow2w+8gTzJhT4uK1rwf5H114F4XQ2dchwk61cJSZKHOtzhvqrsanFEFI
         2B6+nPVUnl73Xgqg4yNHSDSWCuOHWCT5FvnGc8SMyU+TaVvjtdIwhsTHGulWB0Z8KPGJ
         I66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XIYvs1lVCvaz2DrUG7dC/2GRzmSKS+hhopwMOEdNcfA=;
        b=bx436BW+89OgxSeeS+xKu7cnrcunFzLSqyyefO1J8tFHm17vAdtJ+52ADXXtmS9DKC
         VMtlbq/cu0EwuQpBcmgkKIUVswn6XGIQ9uH/svLChULi6NNJqydnp3IIuT6NjE7BE60P
         ScuQlByu6bKBKpwCoLoUHpewpTRrCUu/GapQ1JxQVMzM+gT4zZlgCqjgawfeRUbZSK6z
         svFtdhxHLbA/3qSh30DMTv7AJpCqkfp2xzLEv4zcaptafJvfOwr+bZjJjyn+DxhlMgW7
         bazLFvbXuWW7IvAdYUvWlOz41Fbdm8UdGi3uw2F1pOarSsJvID5Z5Z6Jy8r+mygQfn/B
         R5yA==
X-Gm-Message-State: AOAM5301VrKjnqHU/QD7Wu6ojCPTH2OHclvc4BlJSaMaLoLtSApvb8Sd
        tA4sITlnc+LyzLb+adwywM5GKnvIpxM=
X-Google-Smtp-Source: ABdhPJzkO+dMVoVLa39Uc6nJvIIX51AMUNMqywMFGGcPySO7G5SdFachn/kR8KAt/NBZEMNX9tNT5A==
X-Received: by 2002:a63:705b:: with SMTP id a27mr10487593pgn.405.1596808895002;
        Fri, 07 Aug 2020 07:01:35 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id q10sm12798469pfs.75.2020.08.07.07.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 07:01:34 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH] ext4: delete invalid comments near ext4_mb_check_limits()
To:     adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org
Message-ID: <c49faf0c-d5d5-9c51-6911-9e0ff57c6bfa@gmail.com>
Date:   Fri, 7 Aug 2020 22:01:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These comments do not seem to be related to ext4_mb_check_limits(),
it may be invalid.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 577ce98..aaefeb4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1743,10 +1743,6 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 
 }
 
-/*
- * regular allocator, for general purposes allocation
- */
-
 static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
 					struct ext4_buddy *e4b,
 					int finish_group)
-- 
1.8.3.1

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E65823B605
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Aug 2020 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgHDHtZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Aug 2020 03:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHDHtY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Aug 2020 03:49:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7C4C06174A;
        Tue,  4 Aug 2020 00:49:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so14573169plk.13;
        Tue, 04 Aug 2020 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=4lUb1UDGtIibOehfsGOpj3d1F0eGCARLUemjRhAopo4=;
        b=ZiibNN8Sjxcp1HIHuEaLVJfUxGcJ7w6XHP+IdD5Zy5ctaJrRP2lsbQGyOybdf6qYcv
         4wfu/so9vVxhUtrHI24F/dkcYhD0/vD9qtG9yRlxV0JAPgWBJ4IuODgG0a5ZaCxCMXyz
         vdtU0yI40y3qbB1BheU1pWTOh3TkpDKcub1szRcGoYZUZRR8KiyRY3bHAldHVpR7SIT4
         PdecyM8LOF0GKlpy6qP3SSj8u3FOCin3I4FT3O+Ec3tEWk+XHGd6dmpIchFsgusnbxjC
         0hXqaPgHBLWXb7naGKLV5WirN7JdnRAQwLiybUOlm/8uxUwcLl8+btaqt1oLLpx/R2II
         p2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=4lUb1UDGtIibOehfsGOpj3d1F0eGCARLUemjRhAopo4=;
        b=pcFn8IuuSJdwPhM5175ojzT3sE0TmH3cCqqy/3r+kWyNl4zMc6WJEn/cFGYKpwRUou
         wj5x8Z+SUWAd9H9mPf17sZlT8aH6gr7nttWZSLYMFUuaLUGGTNbcfPF+eXfk9+IN24e2
         Oon3fvWtXn+sCvuqAq8YmDWNdT6I7bQmkA3kQKGqo4NLTBJrfa0+TJBoTYJDmPO7/Wg0
         XzP0fkX4LCD2288dm16cpdigzDbaXiLt0syY8lcXJcfsKK8/rzivBuKv4wjsaIU3BmKz
         7sAy1C+PNlMkYRp5XCDEl2klGIXcPeI5Jw2L/TDtyQ9MPnYa6GhMgg8KbGq2z4W6iiq7
         mh0g==
X-Gm-Message-State: AOAM531oHW84w/wrCVxqLOJfTifMX5uT00UJgiyC8fQJseIPacwg9Ap5
        MFrxgzLDhvGi9KipWga/PVgByxlx9/Q=
X-Google-Smtp-Source: ABdhPJxzAJE/ZkD3Su8IXKsD+lGk6tNMUV3r8nMIof4uJv+YxoUbAU8B6Cuv9P0Bj9rdEQe3WGdlUg==
X-Received: by 2002:a17:902:d303:: with SMTP id b3mr18596539plc.101.1596527364077;
        Tue, 04 Aug 2020 00:49:24 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.45])
        by smtp.gmail.com with ESMTPSA id q5sm2746455pfg.89.2020.08.04.00.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 00:49:23 -0700 (PDT)
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH] ext4: delete invalid ac_b_extent backup inside
 ext4_mb_use_best_found()
Message-ID: <ab2231e8-584a-c55b-38b3-5b5f6d02c9b8@gmail.com>
Date:   Tue, 4 Aug 2020 15:49:21 +0800
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

Delete invalid ac_b_extent backup inside ext4_mb_use_best_found(),
we have done this operation in ext4_mb_new_group_pa() and
ext4_mb_new_inode_pa().

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9b1c3ad..fb63e9f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1704,10 +1704,6 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
     ac->ac_b_ex.fe_logical = ac->ac_g_ex.fe_logical;
     ret = mb_mark_used(e4b, &ac->ac_b_ex);
 
-    /* preallocation can change ac_b_ex, thus we store actually
-     * allocated blocks for history */
-    ac->ac_f_ex = ac->ac_b_ex;
-
     ac->ac_status = AC_STATUS_FOUND;
     ac->ac_tail = ret & 0xffff;
     ac->ac_buddy = ret >> 16;
@@ -1726,8 +1722,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
     /* store last allocated for subsequent stream allocation */
     if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
         spin_lock(&sbi->s_md_lock);
-        sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
-        sbi->s_mb_last_start = ac->ac_f_ex.fe_start;
+        sbi->s_mb_last_group = ac->ac_b_ex.fe_group;
+        sbi->s_mb_last_start = ac->ac_b_ex.fe_start;
         spin_unlock(&sbi->s_md_lock);
     }
     /*
-- 
1.8.3.1


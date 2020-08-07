Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F331123EEAF
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHGOIT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 10:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHGOBv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 10:01:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3BC061757
        for <linux-ext4@vger.kernel.org>; Fri,  7 Aug 2020 07:01:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so919920pjx.5
        for <linux-ext4@vger.kernel.org>; Fri, 07 Aug 2020 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=1Oh71eiAJL4yMrDM2EFvenrukKcVABQSmk+AJxliWBU=;
        b=JFfNEMnGCHVyImhqpVmIiyDXslNM2R1S2kkBaq38wNTzZoXe+b3FOdIgrYCfoGfeJ0
         qPxnJv3ERBffuk6E+4507e2eM7A5OQUj7io4q7TsbeKLDnmvIa2a64L9DD7oyaSBf+4D
         ZPmMpTeE8UTEX+b0lJjeNhuQRM/62zqP72tWwnIEA+fHLpROSd3+I44lKcmQNFIuPLk/
         P7Q+zivJK3drHLC5pEs3cIGkGa9oE4JFXaT1ncZKzaKmAf2DS/dgQIlcpAjHDsvdteK6
         Cev5PFPOUxVx02Q2bis0p4r5jQ5lqO5mekquHjA2zi2qO4kSjGaEVWSoojEXGo6qSEiX
         u8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=1Oh71eiAJL4yMrDM2EFvenrukKcVABQSmk+AJxliWBU=;
        b=QLeR7AN/G0vTcrP8lBgkTbZJmTFhw3+/fRygd0S+B9WCOSMoO97v5h5HB48wbCflsd
         uxydtarTmVXI0H6jenY0LTxWwhP3V6crnmjNYTbNKWMHuphRF3whxO78vEQfTf9ZFNjM
         oAA+ZvaKlSPwZgkRpOywJquKUxrIGL8jO5v0D9yBvEIpGVmHf+Ua4kz/WpX1l6mi9HFF
         51bx7ISAA9TgjjCe4x52efG26r3Bn3DI/rz1Is9GqsJVj9XrVX4YIKhn4oFSI40v8qaQ
         LB0mkmPVeFyQL9goNZP3Bjw38GHn/0YEokpVXpXRvPh+nGDb7QLZLiuRjHrrHhqhwkSg
         muFQ==
X-Gm-Message-State: AOAM532H3enReUlXCXzZFThO1fQ3v5VNawjQfK0owtdzJ8uxPejVz7/J
        7BbLFj2pydInEEgvZktyDgILSmX9foU=
X-Google-Smtp-Source: ABdhPJxzm3rnMlnwz0la2ABmZqYmHSJNCuiU/G+5e2AkL03OW9qZ7C4COXqru8ehuK4SOGUTV4DM+w==
X-Received: by 2002:a17:90a:1749:: with SMTP id 9mr13842257pjm.127.1596808908745;
        Fri, 07 Aug 2020 07:01:48 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id w7sm12510071pfi.164.2020.08.07.07.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 07:01:48 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
Subject: [PATCH] ext4: put grp related checks into ext4_mb_good_group()
To:     adilger.kernel@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org
Message-ID: <a53fe585-2b31-3a2e-f3eb-edc6f80ad85f@gmail.com>
Date:   Fri, 7 Aug 2020 22:01:46 +0800
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

We will make these judgments in ext4_mb_good_group(), maybe there
is no need to repeat judgments here.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/mballoc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4304113..84871f7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2178,21 +2178,8 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
 	struct super_block *sb = ac->ac_sb;
 	bool should_lock = ac->ac_flags & EXT4_MB_STRICT_CHECK;
-	ext4_grpblk_t free;
 	int ret = 0;
 
-	if (should_lock)
-		ext4_lock_group(sb, group);
-	free = grp->bb_free;
-	if (free == 0)
-		goto out;
-	if (cr <= 2 && free < ac->ac_g_ex.fe_len)
-		goto out;
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
-		goto out;
-	if (should_lock)
-		ext4_unlock_group(sb, group);
-
 	/* We only do this if the grp has never been initialized */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
 		ret = ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
@@ -2202,8 +2189,9 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 
 	if (should_lock)
 		ext4_lock_group(sb, group);
+
 	ret = ext4_mb_good_group(ac, group, cr);
-out:
+
 	if (should_lock)
 		ext4_unlock_group(sb, group);
 	return ret;
-- 
1.8.3.1



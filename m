Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C0293A25
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Oct 2020 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393480AbgJTLlQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Oct 2020 07:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393477AbgJTLlP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Oct 2020 07:41:15 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465DCC061755
        for <linux-ext4@vger.kernel.org>; Tue, 20 Oct 2020 04:41:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o9so876658plx.10
        for <linux-ext4@vger.kernel.org>; Tue, 20 Oct 2020 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=udyyWxZNbd6kkxjrD/UKGnNiFzKdQdyMNAwmbyqgrsw=;
        b=Fpof4AMLWLej1FJVm4+qPRWtInQkDflTIZxoNdMlUwNwSXDgmNjdedpsTdOoZOsfh5
         jNQVug8Z14TVcZdB1uPjlwcqzHU3sMRaJmQOUPREOKmFtdaH3PXmO1iInGnmiHPn7Awp
         ENiUt5DGBPTI60YwZHtuPP2OvO2VaUSQkLzNFXmNllCD1jjPuhVOnn7uYByuaKuBVcgB
         TeS9DpPtOKKUu9TeXjmHc5oSMInVCl5kiSLOEQrGyU9gPvjocLY71jjngEwi03lUqeAY
         vJCcuaBzv5aEJWOZvaSq9BLAoduobx2CG6uLBRRI51nWgIQVBy8W9sQTNoGcf9NfGDQX
         0bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=udyyWxZNbd6kkxjrD/UKGnNiFzKdQdyMNAwmbyqgrsw=;
        b=FApnQ4oOTuud2vDshUVgum7bdxIutc5HvyZWkwkZCyNi30drIWEcdtKNycjgtojTCr
         Zkj3Nse3vkNcMwAgaexcPXCq+dlOgRXs9Q5p2FLN0dPI3EdI3T1VfHVqTP4AXF5jHUeg
         TYnKiTOQNUBsF6D8VFMS1fj86Qi862w4cZ2nhW1sFnThNP0mSoy/ARj7wtSNoe5Mqm4l
         flW1sjfOsjWWcsPYpHxJutjsu+jMBK1Aihe/5O+JlXNekAkeu/b8tbX70H7t1lFsAk1b
         9uo39CPtAl30D21qedV0/xTDiv0uZznocrE1fUE/Pf5pDBc5fNBrmO3E0w1LfjZqD2YW
         HIdA==
X-Gm-Message-State: AOAM531pfAn04jP8CzoWv+fI9BZ+vsQgKT+rGPa4LxP9bFRzvjbBmZ0v
        mXJxEcvHzzEhGtLG/4kL4Wqm1vRQ2hyS
X-Google-Smtp-Source: ABdhPJxeyJ9NvLBTLJ1RAxePftvTKyhsaT1vp5WVHuRliSv7qELWSEntZM8m4VZuYjS1aYyO+HOVjQ==
X-Received: by 2002:a17:90a:193:: with SMTP id 19mr2489679pjc.71.1603194074432;
        Tue, 20 Oct 2020 04:41:14 -0700 (PDT)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id 189sm2131410pfw.123.2020.10.20.04.41.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 04:41:13 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] ext4: remove redundant operation that set bh to NULL
Date:   Tue, 20 Oct 2020 19:41:09 +0800
Message-Id: <1603194069-17557-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The out_fail branch path don't release the bh and the second bh is
valid only in the for statement, so we don't need to set them to NULL.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/ext4/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5308f0d5fb5a..3ebfabc6061a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4093,7 +4093,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (IS_ERR(bh)) {
 		ext4_msg(sb, KERN_ERR, "unable to read superblock");
 		ret = PTR_ERR(bh);
-		bh = NULL;
 		goto out_fail;
 	}
 	/*
@@ -4721,7 +4720,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			       "can't read group descriptor %d", i);
 			db_count = i;
 			ret = PTR_ERR(bh);
-			bh = NULL;
 			goto failed_mount2;
 		}
 		rcu_read_lock();
-- 
2.20.0


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DA12AA67C
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 16:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgKGP6q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 10:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgKGP6q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 10:58:46 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F132C0613CF
        for <linux-ext4@vger.kernel.org>; Sat,  7 Nov 2020 07:58:46 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id f21so2398569plr.5
        for <linux-ext4@vger.kernel.org>; Sat, 07 Nov 2020 07:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AF8FR3F/ClJ6EJNVBH1gLQ9CWvyd1d97y/TI4TUHyk4=;
        b=Ugt5zqyglxr4wcVRzZRt/n9XmIHABJ69wyWavwqjmS8LAac2O7svUChjucGQ1ZzHAS
         itko9kRbTuTQIhm4w+ywH5eQ3BryREhrH5HPyAZ3Db6p47EQCUcYhJ8FM1hkLgQrgBBe
         O89uOhhBo87TFBN4TvbVJkMwawzBEcnene7kBv9U/ezZ1iU+qaroPc1xz3sNaTjtQ4RR
         P31ufmXaZhQDaM91IoiTZ7Vj4xE6CDnn6m/aHrjXGG4IHOuGFIzuPvbMbkMB37hzJpL+
         096nzPtTmcMC8KXnbpT8QQ9yLseiKHrCdDlJxSVrZYdSqrwv9z8Y56qLquoAaXcHXcVJ
         ptOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AF8FR3F/ClJ6EJNVBH1gLQ9CWvyd1d97y/TI4TUHyk4=;
        b=kPXaXhTNxN1DiQ+9aF+bQitGSHNP0k6dBarRAXl6MhLXH+51iDpvHj3SkA9Q3ucBJs
         JyMPBPrmox7UiJLWIBcd8/9SoDdWzVf3dYZ4W7SwOvQvU29zzLLxszTVeKNUFfXyLcpZ
         btSByLAaiFOAJhSXoEK9/rJ4piN03xfz2/5N90mrnspnfDT27GKGmO6AIxvFgPTb8+Zg
         q/vOY8Bj1uJjdnNPkuqwP0xkoGzeGoAUortkPAr5OOh0Fiij7FKG4b99MaKcVtiI+raP
         pzYtYi5p3w9nzAD5RtALRVvcg/Du8DTwNN/EAhoK9jhr4Xi8kfXP0+WlcjpguLcsBDds
         6SHA==
X-Gm-Message-State: AOAM533HCGzTzwSeSNIu2xQoKGAf/+tBoRAzUx+HcX8KjggDOkwikYbP
        7MVIq0jshi3kBDdII0xuoBs=
X-Google-Smtp-Source: ABdhPJxoOWiJID6Byf5QTFXomS07OQbRNiTEht7w22X+ZJvgP4J0woFy37UZ5070IM6puwX/XvOw5A==
X-Received: by 2002:a17:902:222:b029:d3:b4d2:105e with SMTP id 31-20020a1709020222b02900d3b4d2105emr6159076plc.32.1604764725712;
        Sat, 07 Nov 2020 07:58:45 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id e81sm6049956pfh.104.2020.11.07.07.58.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:58:45 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH RESEND 4/8] ext4: add the gdt block of meta_bg to system_zone
Date:   Sat,  7 Nov 2020 23:58:14 +0800
Message-Id: <1604764698-4269-4-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In order to avoid poor search efficiency of system_zone, the
system only adds metadata of some sparse group to system_zone.
In the meta_bg scenario, the non-sparse group may contain gdt
blocks. Perhaps we should add these blocks to system_zone to
improve fault tolerance without significantly reducing system
performance.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/block_validity.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 8e6ca23..37025e3 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -218,6 +218,7 @@ int ext4_setup_system_zone(struct super_block *sb)
 	struct ext4_group_desc *gdp;
 	ext4_group_t i;
 	int flex_size = ext4_flex_bg_size(sbi);
+	int gd_blks;
 	int ret;
 
 	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
@@ -226,13 +227,16 @@ int ext4_setup_system_zone(struct super_block *sb)
 
 	for (i=0; i < ngroups; i++) {
 		cond_resched();
-		if (ext4_bg_has_super(sb, i) &&
-		    ((i < 5) || ((i % flex_size) == 0))) {
-			ret = add_system_zone(system_blks,
-					ext4_group_first_block_no(sb, i),
-					ext4_bg_num_gdb(sb, i) + 1, 0);
-			if (ret)
-				goto err;
+		if ((i < 5) || ((i % flex_size) == 0)) {
+			gd_blks = ext4_bg_has_super(sb, i) +
+				ext4_bg_num_gdb(sb, i);
+			if (gd_blks) {
+				ret = add_system_zone(system_blks,
+						ext4_group_first_block_no(sb, i),
+						gd_blks, 0);
+				if (ret)
+					goto err;
+			}
 		}
 		gdp = ext4_get_group_desc(sb, i, NULL);
 		ret = add_system_zone(system_blks,
-- 
1.8.3.1


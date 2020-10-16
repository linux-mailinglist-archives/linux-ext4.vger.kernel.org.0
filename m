Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC74A28FD04
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Oct 2020 05:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394323AbgJPD4I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 23:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394321AbgJPD4H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 23:56:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2DC0613CF
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so678981pfp.13
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o05ngunXtcPuyrwafiNdLriw16flaP90iok/5JOcEBo=;
        b=qpTuotOFk6iFQjFxflRFxWxmPchr5pkQyXooHQbFwRDbiyb10Zmo9oH7Tcr472hzYn
         6TLjJwktHJupFkspQk+YAVDd2GbMdpczso/FwoqksU/AoIT2le5kInkkhnxMVrVvY5m4
         G+DF84f6TIoSB7mBmyda+sFkOHi0ObV2krqQXPLx+dPVwiByrH/qXnCC83s9GWiBJBie
         65ekdEpfJJeCU3iXlJ9XoBGDVgsfU8sx6Vs9x4JO7LB+d7Fk5V/BglqhQF2yQcCjk0Qh
         gf8sG8XBd83FvIFiDHyqp+tzA6QIdkqqZyBYxKPK8kIs3so6+wgGpOfwyCFjqtFmjBtE
         YelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o05ngunXtcPuyrwafiNdLriw16flaP90iok/5JOcEBo=;
        b=OIadUV1yKFI6EPpNQQYiQK0JE8mEzY7kvlw2bFf4QVJ7cOOMDuXJb9DXQMHI4C/VA9
         h1oguYCvEMxKmP57fPSMKDx2GG/RwwaZ6c9v2+4yM9olD7hYE9fQH7BHVX5uXb6ECbC+
         1UxGQhRkU1WdVrTeakYGJQii20k70DlOok9eqB9v/OotJ5Qq4T5ume+qly5i+pvOJUrx
         dP2ouig/1h3+ehgJvcLobBZs2Uw9gc5Gf7fEOonRyUs7JIWHzqe9QokQp47XMV5qnigj
         9tI8HFvexv3UK/VAjZJZFYWE2g0AY9XNlvTn0u5Nfh5wKou2NBtOSHTm64+jgYa0iyEG
         l+sA==
X-Gm-Message-State: AOAM531srIeUcgh5+UV0GtHR9SYPFeiwN4oGiM+qd4JqDtuK3MpH7UV5
        t7O1qW8jxNv0EiK3tzuxdYbmPYWKIDY=
X-Google-Smtp-Source: ABdhPJyArreI90Bp8wDOSN21shnlsHa1X+pzKB54grrIgBSfF/hb/NKPEq5iObfT+oYSW1up+5Kebg==
X-Received: by 2002:a62:ce08:0:b029:156:4427:4b29 with SMTP id y8-20020a62ce080000b029015644274b29mr1960149pfg.70.1602820566508;
        Thu, 15 Oct 2020 20:56:06 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id v12sm861555pgr.4.2020.10.15.20.56.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 20:56:05 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 5/8] ext4: add the gdt block of meta_bg to system_zone
Date:   Fri, 16 Oct 2020 11:55:49 +0800
Message-Id: <1602820552-4082-5-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
References: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
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
index c54ba52..5e98ca0 100644
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


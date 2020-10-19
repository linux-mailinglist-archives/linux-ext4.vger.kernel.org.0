Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0723292432
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgJSJCq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbgJSJCq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 05:02:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C0C0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so5606060pfa.10
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVogl0W51ro2Kw5mHE5fasRPtHB4GYwajX7vEboekgo=;
        b=C0iY+RlZBOz8ZhXCqOtH0pBaZSDcGsZsbd2MC9BcYlg2/HAtkUGie8nRGvYthM8nhW
         27UxQaSu6Iv0roZzbiUnRiFZK49lqRFahbQN8Go5zl3NnAvw1S3dTmHFSsA/9XJlhuyG
         1vn7Ol5IP8WofpCmM07lk76VH6qjDN517O18t3b2Es9O846PxkMlE36+nJHXM8tNLyLQ
         J0PyTDx0oTMutM8EYY72eYqPiuzjJ0p6rEg7mUaJyEunqJ+l/vDs7VLtbA6qFSXHxs07
         vbL0O6nWa5HFg2CZ/DFWqdQ0d3g7bvHKbWb/CY74yl9XURvXVlPZHn5pC7GWk9/Yydth
         pE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVogl0W51ro2Kw5mHE5fasRPtHB4GYwajX7vEboekgo=;
        b=hOzprMXDXQmNOSf16SaDvzaJfvA26mAzB15g7NrY93C4AyI26/HE0m9FklKdd43eVo
         udPRoFEWvPXaLmyCrP2Z0kdxo5hbAmz7UwbA1IevDq39LxdG94wQ2mUrm1qdgwoabfcm
         F/oeY7HCmrd57hq65xvhd6cP1Ll6S+8VPgIwmWUFtgNEFBvrsy5rLvfk+Zh3Ta8uqpjg
         /kap/97RVPTMpluwoZDU0cfcSqGRq/q+Y+2jR2qVDFcvkyQPmpGbir7oO6QZk1wFcE60
         6hV9BXspH35KODedwQo4pr3WgC6/xtOdUENu0X44iWSKxkVCQt/hdH0m38YsZQZH/H0U
         NeNg==
X-Gm-Message-State: AOAM531U/MdQ3r0VcR6idpA3jx8fIzob5FJcAq9k8T90OiUx4cCdf7q3
        TITULEgwB+ovOC6bLFIyNco=
X-Google-Smtp-Source: ABdhPJzevVbUCRIByNiO81/LZjndcQk69kmkKoGEP6V9iy5p+4M7AQ7gWbJreAIzg4XUAX/2jAeV4Q==
X-Received: by 2002:a65:5c86:: with SMTP id a6mr13452500pgt.227.1603098166145;
        Mon, 19 Oct 2020 02:02:46 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id 14sm11422880pjn.48.2020.10.19.02.02.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 02:02:45 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 4/8] ext4: add the gdt block of meta_bg to system_zone
Date:   Mon, 19 Oct 2020 17:02:34 +0800
Message-Id: <1603098158-30406-4-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
References: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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


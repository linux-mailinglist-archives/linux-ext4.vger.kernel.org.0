Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B553D460E
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jul 2021 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhGXHC1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Jul 2021 03:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhGXHC0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Jul 2021 03:02:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908AFC061575;
        Sat, 24 Jul 2021 00:42:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e10so5878864pls.2;
        Sat, 24 Jul 2021 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RZIPH6VlAgUsGXeoKGBeqe0kKjb46AfueIlM1fKks8c=;
        b=jh/FeK8TGzPgYftw+mf7IQDKFyFEuwWhkV66AQ85cObM3Gx91dfBGLm19o7wJxMlCH
         dVhSQbk1bXlpAiZEC7Pf3RiAVUVcldznmR0KyaeOcANKUVqnDG2eM2T4IKDcggARiH8R
         KKsrc5wDFh7jZG5iwusOGuZkmne9Z4dyTVeeMMyiyiPyWA2TKDcTDX3APNDY8oMMi4uo
         eBErLsEbHD/zOyFvEhRGCDy4iRnDZeHFyXDgtR1WN783PkOmNu45Q7sU/lUj7aikNUF5
         NEnyrhxv+IpdPYQTkoioKktO3WoiKjkPZd3c9+nrlOIKdlSIWXDgGLw3ldG3Fxz/eSpG
         t/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RZIPH6VlAgUsGXeoKGBeqe0kKjb46AfueIlM1fKks8c=;
        b=LZ36F6DEEIl44wgVeAuhpXKNXbatj5MvVc58MU8W7BQ63rHRmrOX/HLWu/U1/sV5yz
         xGHbrgzVNQ0ruEQf8FDFWLvdoqeIuTrJjl87MvU2xBIMy0Mi8aHxuJi7COs5OReiSW65
         NuNEmpovUjPcNR/62/J1R0SqNCL05kGZtvhtb7Sn46qae4n4HBhb0lLSVk1yMDaAiL6T
         6wGvdesIOuDbKsYwXrXOFNUaTP9LLAj+a4Vf6F/+xDHsQupGpzPI6wEgLpuZk1g8QQAH
         7rBTFD8juNZxK/GJCip9Aj6+ZpgfA0Z1DJc9wAHMuqLnG3vqMZZXZYiiSuKuVtVwg56Q
         dxSw==
X-Gm-Message-State: AOAM531GB+jCo/4fN3Bn5+/X+obtEBgfegZ7iMm99r7Gviw7hR0ln1Em
        zQI1laG79VGv3bORHh7D6BFIiYDIZUyblw==
X-Google-Smtp-Source: ABdhPJz2S0H1Clbkendy3fxjR5tyGuOpNpXr2GYUsWWuyOqo4pHuKeimaz8MKlDhW2aS6T+SDOsGPg==
X-Received: by 2002:a63:1266:: with SMTP id 38mr8535099pgs.154.1627112577179;
        Sat, 24 Jul 2021 00:42:57 -0700 (PDT)
Received: from localhost.localdomain ([154.86.159.244])
        by smtp.gmail.com with ESMTPSA id v31sm33002342pgl.49.2021.07.24.00.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:42:56 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
Subject: [PATCH V3 1/5] ext4: remove the 'group' parameter of ext4_trim_extent
Date:   Sat, 24 Jul 2021 15:41:20 +0800
Message-Id: <20210724074124.25731-2-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210724074124.25731-1-jianchao.wan9@gmail.com>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

Get rid of the 'group' parameter of ext4_trim_extent as we can get
it from the 'e4b'.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 089c958aa2c3..018d5d3c6eeb 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6183,19 +6183,19 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
  * @sb:		super block for the file system
  * @start:	starting block of the free extent in the alloc. group
  * @count:	number of blocks to TRIM
- * @group:	alloc. group we are working with
  * @e4b:	ext4 buddy for the group
  *
  * Trim "count" blocks starting at "start" in the "group". To assure that no
  * one will allocate those blocks, mark it as used in buddy bitmap. This must
  * be called with under the group lock.
  */
-static int ext4_trim_extent(struct super_block *sb, int start, int count,
-			     ext4_group_t group, struct ext4_buddy *e4b)
+static int ext4_trim_extent(struct super_block *sb,
+		int start, int count, struct ext4_buddy *e4b)
 __releases(bitlock)
 __acquires(bitlock)
 {
 	struct ext4_free_extent ex;
+	ext4_group_t group = e4b->bd_group;
 	int ret = 0;
 
 	trace_ext4_trim_extent(sb, group, start, count);
@@ -6271,8 +6271,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		next = mb_find_next_bit(bitmap, max + 1, start);
 
 		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start,
-					       next - start, group, &e4b);
+			ret = ext4_trim_extent(sb, start, next - start, &e4b);
 			if (ret && ret != -EOPNOTSUPP)
 				break;
 			ret = 0;
-- 
2.17.1


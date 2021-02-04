Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101853100CA
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Feb 2021 00:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhBDXgz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Feb 2021 18:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhBDXgy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Feb 2021 18:36:54 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54167C0613D6
        for <linux-ext4@vger.kernel.org>; Thu,  4 Feb 2021 15:36:14 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id s23so3213874pgh.11
        for <linux-ext4@vger.kernel.org>; Thu, 04 Feb 2021 15:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PnlMDYeUbYvPqGBr55A/KTQ5JKZla7+L5wiTNs3I1U=;
        b=uCX0kuk0hJX8WacPk8GcknlnKKqTGJ1mW2PCV5UcynRNvUFrh3flM6UrQHGY602F0W
         6ti/EKhJ2Vzpt2wi+QEMbaWqEGO3uKk4o+QiDDuzZGHosdDk//89EsV8Piyu4Gfb2Ghl
         vqXtqvs7KjGM0Etlhytsiu6c9Bt6htlHpwfYtPqEmrX5uYDOjSTnEMohzN2XW+fXwyoJ
         xNkd8G6ddJLox+wOqi+VhGPddw6JDb775Pk1XS9CRCZAa+4tlhYSELcbfAYZRBLnhI2Z
         VChR01c7zCT5aCRfoTz6I1LddbKNIub0muoutiOU2eZaCKS53PSVHzCdutberONTQUGw
         gybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PnlMDYeUbYvPqGBr55A/KTQ5JKZla7+L5wiTNs3I1U=;
        b=KbBcmjzcysaDg0BAOAkAOOl2NJ4j9n6Gy747c++3IRey4vSh+an7zMSzEc1tymiL3D
         iP5I+8dwGB+HJnwwWx0vs6yZ9Wlvvi51bVho3yK0Jn2wmeozR1emXr19gWZjMNOVg6R/
         I6hoOl+Lx0jwrXD20QziGdAtCd5M32ylBQV4SHWSbRgX8hjOeOJfqO4TZdvb8Chje3tz
         45ARiuOQPwJtprrEnUCYF6l7tx/oZ8Q88FI1vZCdkxfAn42Yt8pwjOpDyHI+cSxWKZnV
         qASQek7pJs80fKNxdyoKHJ2N35WwssISYEjlshOvHBYBwcYiYN5oH/2yvQTWKRz76Y8x
         5EEw==
X-Gm-Message-State: AOAM533tsJqMWGd8A4/NsaZYcgX9MSYRkp2FCooCpcCzQaBzY9d6/uXa
        oIqLIiq3zGC0yZ7xPi3vIOvtuIVJ0Ac=
X-Google-Smtp-Source: ABdhPJy42MOAlfVpX8KUtI0KFXP31DYmK68ctjaRPPvlO4ZIolFglSnJgQQe4yvMIQuWtexQzXmmLg==
X-Received: by 2002:a63:5642:: with SMTP id g2mr1364791pgm.434.1612481773374;
        Thu, 04 Feb 2021 15:36:13 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:5142:d9c7:4222:def5])
        by smtp.googlemail.com with ESMTPSA id mv14sm10236149pjb.0.2021.02.04.15.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 15:36:12 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 1/3] ext2fs: initialize handle to NULL in ext2fs_count_blks
Date:   Thu,  4 Feb 2021 15:35:59 -0800
Message-Id: <20210204233601.2369470-1-harshads@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Initialize the handle to NULL to ensure that in error cases,
ext2fs_free_mem can be called on it.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 lib/ext2fs/extent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index bde6b0f3..1a87e68b 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -1809,7 +1809,7 @@ errcode_t ext2fs_decode_extent(struct ext2fs_extent *to, void *addr, int len)
 errcode_t ext2fs_count_blocks(ext2_filsys fs, ext2_ino_t ino,
 			      struct ext2_inode *inode, blk64_t *ret_count)
 {
-	ext2_extent_handle_t	handle;
+	ext2_extent_handle_t	handle = NULL;
 	struct ext2fs_extent	extent;
 	errcode_t		errcode;
 	int			i;
-- 
2.30.0.365.g02bc693789-goog


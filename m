Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157A31F6068
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jun 2020 05:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFKDVG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Jun 2020 23:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgFKDVG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Jun 2020 23:21:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DFAC08C5C1;
        Wed, 10 Jun 2020 20:21:05 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n141so4360825qke.2;
        Wed, 10 Jun 2020 20:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KO+XPaOLwidNUxOVCzyGJ8t6s2FUjrDroQTVA4h6i4Y=;
        b=NpWp9oXKXV5x8F+uZlafDV3Wew/8hBai+ILzlyv70VCNvLaBYSh+5kyc0b2yJTTMMP
         DtqETKDRrL+CCqHRlkbQW+WQ5Td3QaoKHnwulJQ/K5zk/A6lGtm9UvAjGn6QAna4+Qge
         r+ZiNHYp8cFufxsZRZrIvn8waAfNEVlUUZeALxiCyBKkeGHND92iMpMcJm2dyI5Y+4rW
         R7XLVci3O/NXTvmGEvLzK81aRMPrOFKel3Pt5MwliVdNyoIWNFODwbiVjmNNw6f3qNbq
         HedCFSkNN/SsQK+Tkln+YATQKj50SkaEI4yEXvYsCgEZH9jlEqFrMyyjCxTRd0RdqoAN
         t6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KO+XPaOLwidNUxOVCzyGJ8t6s2FUjrDroQTVA4h6i4Y=;
        b=PFrYhmqcdE/MRZZcSD/LaMNZxJyk93FaC1ajWWJaWhx1ZnnQtPx4x+k2o2tYF7702i
         tefoWeum+AUQ1saEGSREv52svj91xDKD2YDLnXlew0ZFZbXYOpUk9l3FWc2zck41/8rK
         IaHKd/jYeP1zsRSKIytCOcGdbxeFiraVYb3Syvt4cjryrQ9n9rEAGCou+zrMudsjZWFM
         m303+1apI3HSuANlsriUGAoGax1V3P8lHv06g5wUby6yjHVgyQkFytOOdeFiOPE6OnTa
         MZSh2rgsmidPIUjZGXa+JtaL42/w3Jp9YCQ2h3VYoFTZfwUWj/80BrsOsDA+us5ItNQz
         YsLw==
X-Gm-Message-State: AOAM532H5Vqr3O8JtiC44csKAHUR7P5kIi9xVGvgy2UhrkV8iWccFiNT
        gqJgUXqlzShy1ZE9rhcYJw==
X-Google-Smtp-Source: ABdhPJwdoCPYrtPMNnQ4h9C6hrM9RAEUVtIaY9eMJIgimLWzZN2mU2PqkJXJ5WTp8ps22h6tJrABgw==
X-Received: by 2002:ae9:ebd2:: with SMTP id b201mr6266309qkg.409.1591845664321;
        Wed, 10 Jun 2020 20:21:04 -0700 (PDT)
Received: from localhost.localdomain ([142.119.96.191])
        by smtp.googlemail.com with ESMTPSA id r195sm1350279qka.12.2020.06.10.20.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 20:21:03 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Keyur Patel <iamkeyur96@gmail.com>
Subject: [PATCH] ext4: fix spelling mistakes in extents.c
Date:   Wed, 10 Jun 2020 23:19:46 -0400
Message-Id: <20200611031947.165079-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix spelling issues over the comments in the code.

requsted ==> requested
deterimined ==> determined
insde ==> inside
neet ==> need
somthing ==> something

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 fs/ext4/extents.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 7d088ff1e902..8028e1aae8de 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1915,7 +1915,7 @@ static unsigned int ext4_ext_check_overlap(struct ext4_sb_info *sbi,
 
 /*
  * ext4_ext_insert_extent:
- * tries to merge requsted extent into the existing extent or
+ * tries to merge requested extent into the existing extent or
  * inserts requested extent as new one into the tree,
  * creating new leaf in the no-space case.
  */
@@ -3125,7 +3125,7 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
  *
  *
  * Splits extent [a, b] into two extents [a, @split) and [@split, b], states
- * of which are deterimined by split_flag.
+ * of which are determined by split_flag.
  *
  * There are two cases:
  *  a> the extent are splitted into two extent.
@@ -3650,7 +3650,7 @@ static int ext4_split_convert_extents(handle_t *handle,
 		eof_block = map->m_lblk + map->m_len;
 	/*
 	 * It is safe to convert extent to initialized via explicit
-	 * zeroout only if extent is fully insde i_size or new_size.
+	 * zeroout only if extent is fully inside i_size or new_size.
 	 */
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -4495,7 +4495,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	}
 
 	/*
-	 * Round up offset. This is not fallocate, we neet to zero out
+	 * Round up offset. This is not fallocate, we need to zero out
 	 * blocks, so convert interior block aligned part of the range to
 	 * unwritten and possibly manually zero out unaligned parts of the
 	 * range.
@@ -5579,7 +5579,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
 		}
 		ex1 = path1[path1->p_depth].p_ext;
 		ex2 = path2[path2->p_depth].p_ext;
-		/* Do we have somthing to swap ? */
+		/* Do we have something to swap ? */
 		if (unlikely(!ex2 || !ex1))
 			goto finish;
 
-- 
2.26.2


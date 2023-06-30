Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DC674402D
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Jun 2023 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjF3QzI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Jun 2023 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjF3QzD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Jun 2023 12:55:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2672E3C01;
        Fri, 30 Jun 2023 09:55:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso12779325e9.0;
        Fri, 30 Jun 2023 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688144100; x=1690736100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rJgY0QGGp/jeN+32+rMb8429ffAnAZpXa/Aa5nGjjw=;
        b=NN+EDZhIb/QahO+GwDV+Bh3Ur/kDh7XL+jRw3POa/LTKwAFFIeRkmVicJBuIMOmo68
         /mtCSmvcnNdkJx5vdpcxnLKveyiBQdIQzZ/5ZfMWfPd7hk4eYJeffP3DFYl18egBQ8OH
         skXA2SNHTslB19UfVxGYdrW/HxeUc1nXhIy6jUD2MLdwae8nIo4XNMz4hnKn7vhx6PR0
         G4B+VqL0i7dnzudhWFVyi0Je+uVgpB5QEXFDWJQcWwWEaEGOc81eBShxd25hqeKJwf0G
         +3cLE4QfTUHo7X3J97ZFWrYEN8c9gxWWsalKjSsyAKIj1J5+Ve6T3h76lEZaNIInJ/Qh
         7NTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144100; x=1690736100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rJgY0QGGp/jeN+32+rMb8429ffAnAZpXa/Aa5nGjjw=;
        b=iSPvEb+d/MBONB95tN0fs9IDHdygrIP5p+0fOLMuKcF9m8Q8IB9X5AvFo/BgrC/bPH
         fDzVb7nMVoDvPnHVzTsUiyCMXyrtpD6AXUIwDzSjW4RPRXZVoDOg7lrDkHf5TNI71tj0
         BHIde9gJpDXsGWmxlxCCE5diKiHzQB361s85MNwMNnta2OPpafxaNOMYrU+fD1sKCPpR
         lRJQUhfc5vkrp0m3LCbZHP/2xKor5Cl7Iyht9eReZkvu5hU0qqf4rlpqqOr69hLwYilK
         cEeBe9tfl54HTbc696EBALkKiPLPDvjAfAE0Ruu6bfbcLYQK4CejQohMc3Qln4ysRSml
         hxtw==
X-Gm-Message-State: AC+VfDyXr/QMR4Oq1hhAOEK108qYcZKyXacwvCVagnQQZR0BaTqcORxb
        Kl4bYjYr3XW7UkpTPSehMNg=
X-Google-Smtp-Source: ACHHUZ7aIM94BF0G4f11uD0SLm5O59jr1gtTRZLm2Tgqeu4EipZ92uYR+88wxPIzJVPpa1VJyjvO+A==
X-Received: by 2002:a1c:f70a:0:b0:3fb:c060:8b3d with SMTP id v10-20020a1cf70a000000b003fbc0608b3dmr2482477wmh.40.1688144100416;
        Fri, 30 Jun 2023 09:55:00 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f8f8fc3c32sm19554577wmk.31.2023.06.30.09.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:54:59 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] ext2: remove redundant assignment to variable desc and variable best_desc
Date:   Fri, 30 Jun 2023 17:54:58 +0100
Message-Id: <20230630165458.166238-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Variable desc is being assigned a value that is never read, the exit
via label found immeditely returns with no access to desc. The
assignment is redundant and can be removed. Also remove variable best_desc
since this is not used. Cleans up clang scan muild warning:

fs/ext2/ialloc.c:297:4: warning: Value stored to 'desc' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: Also remove best_desc. Kudos to Dan Carpenter for spottin this extra
    janitorial cleanup.

---
 fs/ext2/ialloc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index a4e1d7a9c544..34cd5dc1da23 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -273,7 +273,6 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent)
 
 	if ((parent == d_inode(sb->s_root)) ||
 	    (EXT2_I(parent)->i_flags & EXT2_TOPDIR_FL)) {
-		struct ext2_group_desc *best_desc = NULL;
 		int best_ndir = inodes_per_group;
 		int best_group = -1;
 
@@ -291,10 +290,8 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent)
 				continue;
 			best_group = group;
 			best_ndir = le16_to_cpu(desc->bg_used_dirs_count);
-			best_desc = desc;
 		}
 		if (best_group >= 0) {
-			desc = best_desc;
 			group = best_group;
 			goto found;
 		}
-- 
2.39.2


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47A424C9B5
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 03:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHUBzr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Aug 2020 21:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgHUBzf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Aug 2020 21:55:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C012BC061385
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t6so144161pjr.0
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0aISXWgy4f0tPia037eRIOFaXF5QGy/8flcEPhgruI=;
        b=tkzHQDmwgTwKblSmOj+d25KOBN3gplAtQvaq9f3eUkxoy8ZUXpSpOE/e+NBT5apqOC
         fDgg9wWLDwk9rJdkaGVa3ZyeEAOMPxRxIkWv307KLS0Irn57uH9r6AafBVs0rB79sRKx
         yFVMugQW2lAH09/VO0kJgdNRaoPqjChTOz9lknOLnLdgVYlc/bNbXZtLu3KzwLyr2lA7
         t3JVPA4f/sqaHCjhbKI3Qw2W9gglYu77VWLF6vpAzRgWQf5coGTsdEg2ac60CrC7TjI7
         1R43kYEJaJtwIoj/oiMgQgfzRXghdaoJcszweC9WXm/WLuiwqGAgnHEt8GrG16iT60e6
         vyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0aISXWgy4f0tPia037eRIOFaXF5QGy/8flcEPhgruI=;
        b=AkcQDZ5P9dURM2urwrauYiq6RGoeN5Dy3pB2PDE/89cwPYiZbUf5g3vrw+ix8rtHLv
         6MTPptXlkfT1+xZeTbibHOEKjCjksT2WAP94jW38C0NzYf9t9jJZBiB1V4aiq92XS+za
         T+K2VycypHEtRIWLtOjsP5DGGN5sKTg3tJELcW1dxNqjOk0gN1CWTQU82QjZxaWxF6Lr
         QbFetN1DINBP6l8I+CgYOglCBnD1MR+ZUcwGG9ZZAlcVBhUi8S5A2DKCz9CMMJ1wtFFX
         Cc6+bwGtXcVHKt4Cp/GCc0PtOpsHgUX9ldK+blCV8+v5JWpuhS1flc5paqpd5/6QfnSn
         AIOg==
X-Gm-Message-State: AOAM532Wz1ezL7IoPpYEBS55MWUu2KblP2B8yZK8WXYlk75Sf6P/kfMt
        YrhHjmu9NqFl5ZwuqEdxF/Roxa1EonA=
X-Google-Smtp-Source: ABdhPJy7Of56wgOGFeAI7pJwg05DHhRTcDGtwrUauP1wFGKd0R3NMciAD6Yf+HELXhbFUoEEmktbjQ==
X-Received: by 2002:a17:902:c410:: with SMTP id k16mr519649plk.340.1597974933942;
        Thu, 20 Aug 2020 18:55:33 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o15sm370191pfu.167.2020.08.20.18.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:55:33 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v2 4/9] ext4: add prefetching support for freespace trees
Date:   Thu, 20 Aug 2020 18:55:18 -0700
Message-Id: <20200821015523.1698374-5-harshads@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821015523.1698374-1-harshads@google.com>
References: <20200821015523.1698374-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch supports creation of freespace trees for prefetched block
bitmaps.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/mballoc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 4b1c405543f0..168e9708257f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3137,6 +3137,9 @@ ext4_group_t ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
 void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 			   unsigned int nr)
 {
+	struct ext4_buddy e4b;
+	int ret;
+
 	while (nr-- > 0) {
 		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
 								  NULL);
@@ -3151,8 +3154,15 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 		    ext4_free_group_clusters(sb, gdp) > 0 &&
 		    !(ext4_has_group_desc_csum(sb) &&
 		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
-			if (ext4_mb_init_group(sb, group, GFP_NOFS))
+			if (ext4_mb_frsp_on(sb)) {
+				ret = ext4_mb_load_allocator(sb, group, &e4b,
+							     0);
+				if (ret)
+					break;
+				ext4_mb_unload_allocator(&e4b);
+			} else if (ext4_mb_init_group(sb, group, GFP_NOFS)) {
 				break;
+			}
 		}
 	}
 }
-- 
2.28.0.297.g1956fa8f8d-goog


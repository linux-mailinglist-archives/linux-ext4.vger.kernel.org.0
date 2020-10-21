Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B513D294A52
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 11:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437571AbgJUJQW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437537AbgJUJQV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 05:16:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7F0C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 1so916763ple.2
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f/RkicABsSjW7TwvRLZnei7YjJ26D6NVyW5bvWOhGCE=;
        b=EcZLK2Yk1hKd0i3vxhJbBTOABXjJYPoyqQgqEPZjHYZjFsabkUcTo2wnH4AYzCT9x8
         BQGvD4oMMsZlrHibj1nMyzdu4zvg+03BU8iQXzel+KUeTLIQ0kTYw2zizB1HyWIBxuIs
         TeQDEWctzVIpRvKMJbFMzhJbJAmmJqYvG69oo+v3IQZCevrOM8qHHBr2X2iLWpVejLQd
         RjUCpStt2fVOVmbbTMFVXQ5mxjLi0UtQJJY3EGg+uXRjATI258zIWwy4zATyE+kEEtlj
         IhpIIV1aRFHYPhpTHEtg9DyByS82+AArDVsMorr8bVTqU0sbDMM/WGroUPAnW7uyk+eX
         7shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f/RkicABsSjW7TwvRLZnei7YjJ26D6NVyW5bvWOhGCE=;
        b=q56QxXYzfJVVvjySueciSc/MbsaRDzjx5hV1lADUYVy9bUghEG4lTPi+arKvZpZa7+
         uHjqOTJkMxi7IMEt9c2rkZU6hx4Jpnxz+CxAXE98dTsPPRX//hv7P3ufsaW79lzOILTz
         0GqqrGoDUh+EiQ6DqPrwiESMWTraYTFvBAKLw+ok5oxpvm3oymWJN/4omkCEWxztiSFp
         wCYTZM8TR94kaWWOUkKanXOAzanMO67/Zr8xPRWoMiAG9SU+mZzvgkejBgE/BvAKoLQ8
         KRqpPtxHftGGhBXORGEvNjFOTPWZpNUs6iFl+rdOM2SQgwaPxEBS1j25IKwaohAgaBAb
         j6AA==
X-Gm-Message-State: AOAM533oJCBtmk6PPlaePcqrUI2MAuahMZUwem4PVeT0hBG43+u0vx7o
        wvtHrbVRrRujxWswWhlqXD9HIGEbdLE=
X-Google-Smtp-Source: ABdhPJztyd1Fee+I3AAJ/Mnnghy6wJtaF1AWQFw7VfZCu1JXdS88vAfct9DaD8deh7yKMD+FcMpkcQ==
X-Received: by 2002:a17:902:b211:b029:d5:e4b6:ebd9 with SMTP id t17-20020a170902b211b02900d5e4b6ebd9mr2779320plr.54.1603271779884;
        Wed, 21 Oct 2020 02:16:19 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x16sm1573002pff.14.2020.10.21.02.16.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 02:16:19 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 7/8] ext4: delete invalid code inside ext4_xattr_block_set()
Date:   Wed, 21 Oct 2020 17:15:27 +0800
Message-Id: <1603271728-7198-7-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Delete invalid code inside ext4_xattr_block_set().

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/xattr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 6127e94..4e3b1f8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1927,7 +1927,6 @@ struct ext4_xattr_block_find {
 	} else {
 		/* Allocate a buffer where we construct the new block. */
 		s->base = kzalloc(sb->s_blocksize, GFP_NOFS);
-		/* assert(header == s->base) */
 		error = -ENOMEM;
 		if (s->base == NULL)
 			goto cleanup;
-- 
1.8.3.1


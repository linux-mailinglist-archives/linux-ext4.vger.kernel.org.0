Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CAC294A4F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437562AbgJUJQQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 05:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437538AbgJUJQQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 05:16:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230C5C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so1111565pfa.9
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AF8FR3F/ClJ6EJNVBH1gLQ9CWvyd1d97y/TI4TUHyk4=;
        b=tXTPTzPSjFRrnGyT2VMA17ffTLhqXUFAxCJXH5vwnklf3kpeVW9o5FkyYBKLqEwM2E
         2JhBw/MPD1X7lB62wFEkR3S/zyCXGEQPEp+65Uv8PtRPWRLpU0ecP/tWd+fLGjJ0psOa
         NG+Ucx7cRX6CnqyVOv8fQBR5xxvvIGLFrhPg2mT3BcYSz3jjnTyE2Ytelw9yEFXWcHCa
         ikd5gq4acaxPd7OaA8DfQGh0ySpWr+dgtbf/jFZT2XvwPA1ZCl/6AY/LteZ1Doa3C7pW
         RhvP+AmH66wf8tr0ZOOW8I6YMWRBDkIbQd2Y03bD8Y3r17tIyIBV+jktHz5qeriEEXF0
         HBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AF8FR3F/ClJ6EJNVBH1gLQ9CWvyd1d97y/TI4TUHyk4=;
        b=lMLWs98hteCYG1l6HFF0B/OoDxO01XDdz7qAe5DhiLPAVlY1IGMKWYbc78HwZbnBfC
         VwYWCeQnXfvZdby9Sjsh7ZOcKafn2S1FMbq0gFRlw/ccf6kmjIyvJkINzbqkHTd3aW92
         /v1iE0fAix5aEoqV50gn86KfWU0q1dl/fUAoBKL2GMf4S2RE6jWcNUfW123tqTPNLX7u
         jETVPMgRVDJ1N2ppiTyFSnmmPm86qdKmuWCafxYPxctwY+KwN5RueiRqNEFl6LiVCysM
         Z0jr91KQxv6Y7+GJZC3irUNqu3HCwEdtQq/xrM+x7HK3xE3BVb1TsHjbSuGL8Szi9wKM
         axDw==
X-Gm-Message-State: AOAM532x+wS/J+CLb7+8jHkn0+pZOQLbnjWu44R7SWsilDf6+pJE+UAL
        4WjYuYHwGLWrg6lrT1tO7gE=
X-Google-Smtp-Source: ABdhPJyYNyMqriLnrM5UcIuArx/ish+yeU1UknUsN5C6NNt/xouZ/XHdqUazTBQDMLZoZ2JUHgrrLQ==
X-Received: by 2002:aa7:96fb:0:b029:152:879f:4782 with SMTP id i27-20020aa796fb0000b0290152879f4782mr2505207pfq.45.1603271775751;
        Wed, 21 Oct 2020 02:16:15 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x16sm1573002pff.14.2020.10.21.02.16.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 02:16:15 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 4/8] ext4: add the gdt block of meta_bg to system_zone
Date:   Wed, 21 Oct 2020 17:15:24 +0800
Message-Id: <1603271728-7198-4-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
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


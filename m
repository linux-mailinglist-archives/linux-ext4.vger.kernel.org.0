Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3E42B80FB
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbgKRPmU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgKRPmU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:42:20 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818FC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:20 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id r6so1425187pfg.4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TgxfBleuwBbiJ7V0ZDGA7yS/l34SxlrP250dNmU9++8=;
        b=Xl/oPQbhi6gbyqrHnE17F2l4yTLlEIK2hoomXsbGA3scog68er50CI5e57yewMtZyn
         P2QSePYFFfQkGI4g/ER+ph5u1B2O5uVnrvLCp5WREbUT91KbVF1/n9sFNQN7ItVApMD4
         JRj4zpFhxgpSLVXrYXvoDhesnUpboihORzeQ9WH22E3PNkj7g7cQ8LZQcrx5cMinI2lf
         flFuTdrM2nHPMvAJmZy1fkwjOqgeXkH77fL/nyJCdrlV66DxO07rojiMBOWW9nTCqsK5
         eFgazpnUrXaj4Gm2tTIL8TCf+Ji+vV52pH1WpTNbsN7PsG/fyMqYnDzenpphd6zKBu1D
         1Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TgxfBleuwBbiJ7V0ZDGA7yS/l34SxlrP250dNmU9++8=;
        b=Vf1GBdUb+oBWG+iDcJOY+sMmQd222oepBsQzil8+ztw2LSvUoRr76qphmVFFfqc2MW
         X9qR+F8T9FOwawvyAmW90vKIJBsatcKFvT19d6RyolRlnpQTKpXMD68XgfFTsWL70C6Q
         YUUvQbXca+N0egw0Yogvo3y+IGeR9o6xvQKfIYMQbDkisFEV707I4fcXPrWJLubxmAje
         TjGx2gkdVG8b+pIZM7V65mYGOt4VGeRG7tff/Br0i7EGKBCbPzK/PfnDiV3sTCVy50EV
         w8N9Lfy5g+6wDeJKJBl2ARARvW15/G2KvJEyrJMDweE63Y87TXI/4QoqUpZS7BZ6EWxc
         Usgw==
X-Gm-Message-State: AOAM531VmOYTBYlaaVkvGITTH7+qjl4GXi2XGwVhI28MsV3RK2dSUjS9
        +sDhpPhqoA7H/6rLhaDsEzTULsnL+N2bVWpF4BqNgo6Y2tRuPa56vZQpLVbj8KEPJO6NqV9Y+IU
        MDSvqdhQeCLx0kBUgefLW3USl7BmQUlc+5a1b8WYfiJN+OPaUq1bZ/N2jZqWWXRve4q2raY1pkK
        A//+lTm9A=
X-Google-Smtp-Source: ABdhPJz/klBme1zJoxTP83PgdK8RZQ9N0XsSoQWy07736wuknI77Bj7gk1cgO+sRZ87P1TZI5TxxelBJzOqn8YYzgRk=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:90b:e04:: with SMTP id
 ge4mr46609pjb.0.1605714139152; Wed, 18 Nov 2020 07:42:19 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:46 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-61-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 60/61] e2fsck: propagate number of threads
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sometimes, such as in orphan_inode case, e2fsck_pass1
is called after reading the block bitmaps. This results in
reading the block bitmap sequentially and multithreading
only gets kicked in later. Fix the thread count earlier
while setting up the file system.

Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/unix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index bebc19ed..a2c6a178 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1729,6 +1729,9 @@ failure:
 
 	ctx->fs = fs;
 	fs->now = ctx->now;
+#ifdef CONFIG_PFSCK
+	fs->fs_num_threads = ctx->pfs_num_threads;
+#endif
 	sb = fs->super;
 
 	if (sb->s_rev_level > E2FSCK_CURRENT_REV) {
-- 
2.29.2.299.gdc1121823c-goog


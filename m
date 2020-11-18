Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419E32B80D1
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgKRPlA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRPlA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:00 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8AC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:00 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id cm17so1327486pjb.2
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1EIZ1iclevf4dCNvp11Qm9wMpxo/rUpjJpT9+13i1Kc=;
        b=AX0qQQArai5teoJe/vPif3gogB/7nYFxg3ImYAGEgpVO2G52NhP4QHUEdFpnk5ZgEG
         vS3P98sPG0XArNyPoLM9YbreudWh2ho//D5cujWwJVb2ABWybVSpzTLLDfm+EcDqrHAe
         BH/z6QygaPu1fwPZKr+8v5++3Ga9VhBir1f3HQh276+UmNrwn8pzDGbxgrnkWY25/VXv
         kiZcHnOiJEJkYdAjCK92yB7wt4vb7Www9BlxlpueDmVEyPZY5y9A6iTO2VuNyz9FB55I
         ZpDL7BvIIviHN2Q5hh1NMXbej+VArKB6jLWqkyyBcQNQ4xXvmqs1wKAt4nj1ILPm2wGJ
         lv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1EIZ1iclevf4dCNvp11Qm9wMpxo/rUpjJpT9+13i1Kc=;
        b=ccmn7B4+mGuIMNq0U9qETwpGRE2pPYxHogipe33IAbCxzW5vscvB7tf3Qw89fya2hP
         9cbEFN4SEHNnXWXz92UTz6QceJLD89NSMmY09ghVzNIy7jP5bzHbCv5w+FsJl7TUYY3k
         e/q897EBQ/sH6yth3ufHCcYPYavKtiT9jJEJt3ed5JSARekNlWmx6+LbmB2CNQ/9gLjN
         l6rBQ0J1Z+WXaJJrZjlOq+TrX6iLGyPx4b6Xoetu7SCcrGL2mJ0kpBscRLh2d0T+PuiU
         UCWuffKrOfykkN4XIwHAwqjXnmDm0uSTwWyCDLTTQ9OwOHZLHrfMBwREGQSDmdte5R3H
         U2mA==
X-Gm-Message-State: AOAM532XkTnG/upSBTKJjjJP3Dt9qe7BG6iZvIO2n/b/mUIluXcTpUaw
        Vvdc7NDCmvmxlXEDIMpJJP/whqbl+SFpppV5l/TJeaInIaVnLIVo0ILDQhk4Nnqjbi7ibcuw17b
        pjQ1NqC1xnKHXH2nKy2CfebKNB6xbDuHvDcRHV99R0AspaADG7N779CWQE7TY/CEvwMhOegd/zK
        A4E272Q0Y=
X-Google-Smtp-Source: ABdhPJzXixA9EHZtkoCxFcDRIHZMWL7u2wtfcJdzRolHpPHKiKcnCt2w2DYrS6Vuy61JnEkadmDOy/XJQN0WV9q2plY=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:902:c20a:b029:d6:b2d6:8006 with
 SMTP id 10-20020a170902c20ab02900d6b2d68006mr5054069pll.31.1605714059448;
 Wed, 18 Nov 2020 07:40:59 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:04 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-19-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 18/61] e2fsck: rbtree bitmap for dir
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Only rbtree support merge operation now, use it for bitmaps.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index ef6b2d13..2147f64b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1235,6 +1235,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	}
 	pctx.errcode = e2fsck_allocate_inode_bitmap(fs,
 			_("directory inode map"),
+			ctx->global_ctx ? EXT2FS_BMAP64_RBTREE :
 			EXT2FS_BMAP64_AUTODIR,
 			"inode_dir_map", &ctx->inode_dir_map);
 	if (pctx.errcode) {
-- 
2.29.2.299.gdc1121823c-goog


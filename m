Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221BC61F2E6
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiKGMXe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiKGMXc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:23:32 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493966247
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:23:30 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b62so10338460pgc.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNH/JRMMbNBjJGEyAIMaU9Rbue7IVZktvVu0mJ7rLNc=;
        b=dzaEh4raQcQr2hBzOZqZPhKf4hDCUSrlW+7rTUcXfd1iMwnBUa/LOpM2hzOMNLJfFs
         6GXZAalYTp6sX+9rykYWWj0q+GssuY6Bdaopue+YlCq9uYQEhPZ7xw3+/Xqf3le786/S
         0hB7sPXaP4SdoVj8cduB9XbQwD1/vQrDL7erf5G4PWfW0dRBjxXaVVcLn6Jca/sueYhP
         TlelrCxhfh/eZ+mYj/+JQSgYAd2/LahF040N+51Av7fN3QW/oLq55gJTenN8XuXu+dW8
         v4hNV1sK/7yfk3yyySZShEdWd9sfrMqcxqGMAsIsMBt8zurZSgnkicYbloAHJCaegQg2
         vFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNH/JRMMbNBjJGEyAIMaU9Rbue7IVZktvVu0mJ7rLNc=;
        b=UostMGbveqRjXmzKVK2DB9L7aA3yuyf3N42GJJ8te5JuGotsS/aZxqPeP6eHSLrhJF
         myKUwD/j1YGgZ4JkZy0GbBDKVJubmn+agQAq/GJQ31BZnkqV+cWntFijOr2DJu9TK/NE
         g3wxQ2NupVhvoGvSmRAA/7pWZLl8yMwGNpjEPJNaMoy4X0lwmmJRjrf0VKJFfQaxGBtQ
         A4eUp9VlwYygwZNUaTIWSW1gS5Pl+Uf247qJUJ3vMHsev9iCa6uLpn0UHrwHJFQwILhZ
         z3uPb1QRW2deYYVz+FBBntQmQoQ5l4ZSP4Z2YtWQjOpoOGoMfKVPl+IS/IzWepRaaY5m
         PyMg==
X-Gm-Message-State: ACrzQf118dt5Z7jrDxkEJSJNvZWBbRjaXEFhdr+xdxxvxITPWmVtmn0S
        Suva02MG5cHAcWQPCknKy7M=
X-Google-Smtp-Source: AMsMyM4MdcYpDheORHYmCYatZ5QkxfB8DhbHv8BdWDOHCODe4wq8AEa4fuO+tGpJZTs2mAL5TD21EA==
X-Received: by 2002:a63:5123:0:b0:46f:f329:c013 with SMTP id f35-20020a635123000000b0046ff329c013mr27173500pgb.428.1667823809762;
        Mon, 07 Nov 2022 04:23:29 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00186f608c543sm4834064plm.304.2022.11.07.04.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:23:29 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 11/72] libext2fs: merge quota context after threads finish
Date:   Mon,  7 Nov 2022 17:50:59 +0530
Message-Id: <a318a46cc1439f32c0fb795d8aa0a435bcfb7e04.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Every threads calculate its own quota accounting,
merge them after threads finish.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
[Note: splitted the patch to seperate libext2fs changes from e2fsck]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/support/mkquota.c | 39 +++++++++++++++++++++++++++++++++++++++
 lib/support/quotaio.h |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index 9339c994..ce1ab4cd 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -618,6 +618,45 @@ out:
 	return err;
 }
 
+static errcode_t merge_usage(dict_t *dest, dict_t *src)
+{
+	dnode_t *n;
+	struct dquot *src_dq, *dest_dq;
+
+	for (n = dict_first(src); n; n = dict_next(src, n)) {
+		src_dq = dnode_get(n);
+		if (!src_dq)
+			continue;
+		dest_dq = get_dq(dest, src_dq->dq_id);
+		if (dest_dq == NULL)
+			return -ENOMEM;
+		dest_dq->dq_dqb.dqb_curspace += src_dq->dq_dqb.dqb_curspace;
+		dest_dq->dq_dqb.dqb_curinodes += src_dq->dq_dqb.dqb_curinodes;
+	}
+
+	return 0;
+}
+
+
+errcode_t quota_merge_and_update_usage(quota_ctx_t dest_qctx,
+					quota_ctx_t src_qctx)
+{
+	dict_t *dict;
+	enum quota_type	qtype;
+	errcode_t retval = 0;
+
+	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
+		dict = src_qctx->quota_dict[qtype];
+		if (!dict)
+			continue;
+		retval = merge_usage(dest_qctx->quota_dict[qtype], dict);
+		if (retval)
+			break;
+	}
+
+	return retval;
+}
+
 /*
  * Compares the measured quota in qctx->quota_dict with that in the quota inode
  * on disk and updates the limits in qctx->quota_dict. 'usage_inconsistent' is
diff --git a/lib/support/quotaio.h b/lib/support/quotaio.h
index 84fac35d..240a0762 100644
--- a/lib/support/quotaio.h
+++ b/lib/support/quotaio.h
@@ -40,6 +40,7 @@
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fs.h"
 #include "dqblk_v2.h"
+#include "support/dict.h"
 
 typedef int64_t qsize_t;	/* Type in which we store size limitations */
 
@@ -236,6 +237,8 @@ int quota_file_exists(ext2_filsys fs, enum quota_type qtype);
 void quota_set_sb_inum(ext2_filsys fs, ext2_ino_t ino, enum quota_type qtype);
 errcode_t quota_compare_and_update(quota_ctx_t qctx, enum quota_type qtype,
 				   int *usage_inconsistent);
+errcode_t quota_merge_and_update_usage(quota_ctx_t dest_qctx,
+					quota_ctx_t src_qctx);
 int parse_quota_opts(const char *opts, int (*func)(char *));
 
 /* parse_qtype.c */
-- 
2.37.3


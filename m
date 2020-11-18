Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0D2B80DC
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgKRPlR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgKRPlQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:16 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA8AC0613D6
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:14 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id y10so1673576qtw.5
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lmBUqkA6D+Dfo/wYKxTxIBoZlgxKgigsG3WwP4pFDxI=;
        b=bxZhwYLIA2DyjmSWjv9GFo3f9Yxsg2KmbYBndNOZsjit5R4Rnx3Zrntl/qhHJZLMlD
         wewABSwr31uLxlUv9zC3UHYCMKQOINA8fdl1kQnNrMg8FTxf6LbozwDAyB91/xsL/EGK
         s2QA57UjLuTc6PzX7KYiOKo7eVbVj14difRP+UGrUKXOLapqzZzg5rHlPddaOSL6ykBL
         +bEkQ3EOdXnugpcDKjuGPi+k1QWBL4b5p9vzv0frQyckERgNGeVZq/XcLjDKToQbM1xP
         shI0bYHUv4MAYl9hR32GIIBGBRNur0sgl35GoQZtViyGNWg5mvHVdqZZ27VG0BpJQIDU
         USAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lmBUqkA6D+Dfo/wYKxTxIBoZlgxKgigsG3WwP4pFDxI=;
        b=FjW9Z5OgfGOxv3AnM9vg2D7/qfvjW1erw3KWN90pk7XRqJcYOW7g/PiU/KPoYiQjPS
         01UUy6gAVz4rYGslf2FdM2kJMr9exWdKHZcvSGByAfQLihDv70R3Ikik3n+NzRNuXzCv
         ZrrZiwLX+akWZRtwMfY7znY5B+oKGhpqo6MEorV+xrdRCVanB2AutzmFHReH+7u3WHGE
         ZBQP+YmPVZAXlvJgnwU1iW8UH26JBGY+5rLNF0KVx0yzWkKlwO2YKuEitU9UneULHFIc
         F9ItNdi4mOiAmxVBEgx6UdULlIPDLe+YOa4xGxF4/oSS4Z74VnAJrKAImrg5hvUlzwSo
         BvSA==
X-Gm-Message-State: AOAM53383U1F0GHT44YI5WNZxarxH4TF5MLlqPYq6UuF5YuobvGjiDRl
        KF4UnUQs8MehxwUE/p3ok3J3uUPdV/0olWFQ+5KSLnXOxyM/Cv1PpPt+Px0WKMteYmSKLa8LgUO
        4J1yyDolFYA6Jds355wFZQTN5b5IaVs7ijRaFPemU+Y2OFUIV121VFU4k8CoFVihP3wWg0uUX7P
        qloeNMB70=
X-Google-Smtp-Source: ABdhPJy0DKe84588bI5AiHoLKb6Sd0f2W3e9Taiqk1AHDCQABK/GCvp2f5gGib4diXeLrMcUppF/MVsPmpnPdwzOuw4=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:9c05:: with SMTP id
 v5mr5078182qve.7.1605714073995; Wed, 18 Nov 2020 07:41:13 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:12 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-27-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 26/61] e2fsck: merge dirs_to_hash when threads finish
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

@dirs_to_hash list need be merged after threads finish,
test covered by t_dangerous.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 7095e8b4..5378d7da 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2463,6 +2463,25 @@ static errcode_t e2fsck_pass1_merge_icounts(e2fsck_t global_ctx, e2fsck_t thread
 	return ret;
 }
 
+static errcode_t e2fsck_pass1_merge_dirs_to_hash(e2fsck_t global_ctx,
+						 e2fsck_t thread_ctx)
+{
+	errcode_t retval = 0;
+
+	if (!thread_ctx->dirs_to_hash)
+		return 0;
+
+	if (!global_ctx->dirs_to_hash)
+		retval = ext2fs_badblocks_copy(thread_ctx->dirs_to_hash,
+					       &global_ctx->dirs_to_hash);
+	else
+		retval = ext2fs_badblocks_merge(thread_ctx->dirs_to_hash,
+						global_ctx->dirs_to_hash);
+
+	return retval;
+}
+
+
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	 retval;
@@ -2505,6 +2524,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	__u32 large_files = global_ctx->large_files;
 	ext2_ino_t dx_dir_info_size = global_ctx->dx_dir_info_size;
 	ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
+	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2574,6 +2594,14 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		return retval;
 	}
 
+	global_ctx->dirs_to_hash = dirs_to_hash;
+	retval = e2fsck_pass1_merge_dirs_to_hash(global_ctx, thread_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, 0,
+			_("while merging dirs to hash\n"));
+		return retval;
+	}
+
 	retval = e2fsck_pass1_merge_bitmap(global_fs,
 				&thread_ctx->inode_used_map,
 				&global_ctx->inode_used_map);
@@ -2660,6 +2688,8 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_free_dir_info(thread_ctx);
 	ext2fs_free_icount(thread_ctx->inode_count);
 	ext2fs_free_icount(thread_ctx->inode_link_info);
+	if (thread_ctx->dirs_to_hash)
+		ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
-- 
2.29.2.299.gdc1121823c-goog


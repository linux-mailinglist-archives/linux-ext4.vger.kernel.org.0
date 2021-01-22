Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D359E2FFCED
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 07:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbhAVGoz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 01:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbhAVGou (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 01:44:50 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC04C0613D6;
        Thu, 21 Jan 2021 22:44:10 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i5so3104200pgo.1;
        Thu, 21 Jan 2021 22:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=jlKBTxlIwTzOGnww8ex4FQyBT2PusMVn+PCpRGE69LQ=;
        b=Lpf3yPcMr0kSe8+1xH7EiJv+Jf/EyAhd7E1mMt4Ypo7sVC9Zga4HdLR0WrvP6fm2IR
         rnLQRfAePlJv3ORt9cznQENhMtNegVwlu6Bm8CmR972WWZjq4Ffc293X79Ic4Jp6VVRE
         8kWZKek82xoxKTy0PbttPa335okN9dfo/LpLKfKZO/CTor3fWM+Arhh8bfVKDKlBasm1
         4Xrw+s5r9viaMwhou2EmUjRklwMW5YtAfSqJxo4L4NHT+gs9tRvrLTv3+zDvGWuit7r9
         ua913GysW4WQoGumblz6lv8QgjupU3S8fA3qpwcxhzZoNQwceXgQGO4oWVRD3aYGX7H0
         n4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=jlKBTxlIwTzOGnww8ex4FQyBT2PusMVn+PCpRGE69LQ=;
        b=WU1CNEV5yoLZZaadCp3FQfDalCJpkYsh5BalWbnVITLAEzWVbWxRMpgSp9X1GnKzFA
         pxrogBIjQ+uMnGLZ5mUjwt2e6C1m4IqN/YZfMe/ZD6LoBFD4j3tLOHWjwerEuwWjYB61
         3d1MixUb4JZlWQvG373EigMQSEHE45+LPepqfA0l+mHnqn8neN1r88kEVQmfP5SnPSfk
         zWWPMC9tqJOMmvkM1gO7Y0O7vPvd7Fb2X+j1ZcZ8GvHoytkdVu0gjKVL7kURpu5LoX40
         RX4XowFUxZYTb1oYsbA8NiG3W9SrRdaGmoXs5X/mPoIxHq2iM+3Xs1N1j1A5Xoce3M7p
         k5mw==
X-Gm-Message-State: AOAM533ICl4chJqbsRu+JxVI8NsQxa7J1QNQ2BW3pMy0H/aimBRntCth
        L0Oupq/GnscKsU46jxjjBxVPr+MvJYxR5A==
X-Google-Smtp-Source: ABdhPJwS8rhUFeee6lmt/dTYZgRxSCAgZ+LNFZqQQH0tC2Vybpz/FjEcGHFjHGnLsurkiiHCAeHEAw==
X-Received: by 2002:a62:ddd1:0:b029:1b7:5651:f6ea with SMTP id w200-20020a62ddd10000b02901b75651f6eamr3670616pff.62.1611297849949;
        Thu, 21 Jan 2021 22:44:09 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t22sm8319641pgm.18.2021.01.21.22.44.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 22:44:09 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] jbd2: introduce some new log interfaces
Date:   Fri, 22 Jan 2021 14:43:20 +0800
Message-Id: <6e3677254fdf5be549f88b2274e0d67523bc1773.1611287342.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1611287342.git.brookxu@tencent.com>
References: <cover.1611287342.git.brookxu@tencent.com>
In-Reply-To: <cover.1611287342.git.brookxu@tencent.com>
References: <cover.1611287342.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Compared to directly using numbers to indicate levels, using abstract
error, warn, notice, info, debug to indicate levels may be more
convenient for code reading and writing. Similar to other kernel
modules, some basic log interfaces are introduced.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/linux/jbd2.h | 58 +++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 600a2ea8324a..d3d3ed33be30 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -47,23 +47,6 @@
  */
 #define JBD2_DEFAULT_MAX_COMMIT_AGE 5
 
-#ifdef CONFIG_JBD2_DEBUG
-/*
- * Define JBD2_EXPENSIVE_CHECKING to enable more expensive internal
- * consistency checks.  By default we don't do this unless
- * CONFIG_JBD2_DEBUG is on.
- */
-#define JBD2_EXPENSIVE_CHECKING
-extern ushort jbd2_journal_enable_debug;
-void __jbd2_debug(int level, const char *file, const char *func,
-		  unsigned int line, const char *fmt, ...);
-
-#define jbd_debug(n, fmt, a...) \
-	__jbd2_debug((n), __FILE__, __func__, __LINE__, (fmt), ##a)
-#else
-#define jbd_debug(n, fmt, a...)    /**/
-#endif
-
 extern void *jbd2_alloc(size_t size, gfp_t flags);
 extern void jbd2_free(void *ptr, size_t size);
 
@@ -104,6 +87,47 @@ typedef struct jbd2_journal_handle handle_t;	/* Atomic operation type */
  * This is an opaque datatype.
  **/
 typedef struct journal_s	journal_t;	/* Journal control structure */
+
+#ifdef CONFIG_JBD2_DEBUG
+/*
+ * Define JBD2_EXPENSIVE_CHECKING to enable more expensive internal
+ * consistency checks.  By default we don't do this unless
+ * CONFIG_JBD2_DEBUG is on.
+ */
+#define JBD2_EXPENSIVE_CHECKING
+void jbd2_log(int level, journal_t *j, const char *file, const char *func,
+		      unsigned int line, const char *fmt, ...);
+
+#define JBD2_ERR	1	/* error conditions */
+#define JBD2_WARN	2	/* warning conditions */
+#define JBD2_NOTICE	3	/* normal but significant condition */
+#define JBD2_INFO	4	/* informational */
+#define JBD2_DEBUG	5	/* debug-level messages */
+
+#define jbd2_err(j, fmt, a...)						\
+	jbd2_log(JBD2_ERR, j, __FILE__, __func__, __LINE__, (fmt), ##a)
+
+#define jbd2_warn(j, fmt, a...)						\
+	jbd2_log(JBD2_WARN, j, __FILE__, __func__, __LINE__, (fmt), ##a)
+
+#define jbd2_notice(j, fmt, a...)					\
+	jbd2_log(JBD2_NOTICE, j, __FILE__, __func__, __LINE__, (fmt), ##a)
+
+#define jbd2_info(j, fmt, a...)						\
+	jbd2_log(JBD2_INFO, j, __FILE__, __func__, __LINE__, (fmt), ##a)
+
+#define jbd2_debug(j, fmt, a...)					\
+	jbd2_log(JBD2_DEBUG, j, __FILE__, __func__, __LINE__, (fmt), ##a)
+
+#else
+
+#define jbd2_err(j, fmt, a...)
+#define jbd2_warn(j, fmt, a...)
+#define jbd2_notice(j, fmt, a...)
+#define jbd2_info(j, fmt, a...)
+#define jbd2_debug(j, fmt, a...)
+
+#endif
 #endif
 
 /*
-- 
2.30.0


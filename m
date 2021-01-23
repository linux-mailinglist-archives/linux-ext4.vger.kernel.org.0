Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D353014F2
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Jan 2021 13:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbhAWMCW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 23 Jan 2021 07:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbhAWMCQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 23 Jan 2021 07:02:16 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64CCC061786;
        Sat, 23 Jan 2021 04:01:35 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id c132so5685959pga.3;
        Sat, 23 Jan 2021 04:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ps390xfJkEAzn7guDUV17+9J9HWhjHDmr1/jMpEfHJ0=;
        b=pPKoMEqmHl02mNsurS3RpAYpTPk6XLod4ouHB+f8w2LfnkOgeaBFFdJU3FaZNacf50
         HVjCiYM+a2565CRvgzFsrjdm/dTEhWUUJYV4Lx2SmgdFQ0jqFx3p/XJaxYoeCtgYIu1U
         SxI1F0JWx5f57DN/baPwzYKGMZRqxBLh+BQ33bIzA429GsyUM4g/QGyz6DbU7U8hTmTn
         E2GHb5v4ORhyE56mdKPz6GTeBp3H6BNAXu7hc0m//2/XMrlIIESdVQHm00Xgm/u/b1Io
         GHqX0GVEt6GDCY5339vCRzKpRiXzGyk//+zmXdsbhUMWFVJdyId1vXh6mFaAoi4E7txW
         Eq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ps390xfJkEAzn7guDUV17+9J9HWhjHDmr1/jMpEfHJ0=;
        b=CYoC6NUrTLj7lCrgXvIREdrDlKPWG+KDdOba8yfQbzA0OGUXj9Xh3woDvuysosdJtr
         ALCPnn0UdXRaqvcuedydvMIH+B3ctXBCKz+MUGeRIRRvGmvyNxtuXxkzLKZOdT0OQ52c
         U7ZTJY8etaQv213Iu0m2Idre8v9jxikvMly02XNgbdRIRBv50X1aVt2snP6yzs+EKawt
         preQDOh9Re0HcNfRxgKrFNfE2arLRDT9Cl6ZY6ZkDnKSrpznRr4O8O+TXMYFbD13KxN7
         R5Pnz8MjgI6rOwFESo9sGq5lknwraqk/WeNSJWtohPWZd2brQcNFxjp3A3oHQQ1r1cLo
         6ILg==
X-Gm-Message-State: AOAM531f7EyYFnovu2JXhYiDTY/DVl3XftXFQUnsTcrkEcIWaHcUDMat
        ngWrFOkQjzb27SDomHmikFE=
X-Google-Smtp-Source: ABdhPJxU3ZGzIceLEosRFxsnMVR026NFv1gkv+Zl1GAOEpuuTFYUI4AJ32WqE029eqpgAk0xgQRF4Q==
X-Received: by 2002:a63:af05:: with SMTP id w5mr1035194pge.22.1611403295470;
        Sat, 23 Jan 2021 04:01:35 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x19sm11854648pfp.207.2021.01.23.04.01.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 04:01:35 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/4] jbd2: introduce some new log interfaces
Date:   Sat, 23 Jan 2021 20:00:44 +0800
Message-Id: <f19b925451351040a7e831bb1c96f062421c8ce8.1611402263.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1611402263.git.brookxu@tencent.com>
References: <cover.1611402263.git.brookxu@tencent.com>
In-Reply-To: <cover.1611402263.git.brookxu@tencent.com>
References: <cover.1611402263.git.brookxu@tencent.com>
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
 include/linux/jbd2.h | 59 +++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 600a2ea8324a..b33bb5681cae 100644
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
 
@@ -104,6 +87,48 @@ typedef struct jbd2_journal_handle handle_t;	/* Atomic operation type */
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
+extern ushort jbd2_journal_enable_debug;
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


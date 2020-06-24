Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926BE206B37
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jun 2020 06:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbgFXEeF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jun 2020 00:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbgFXEeA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Jun 2020 00:34:00 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EDEC061573
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jun 2020 21:33:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w27so780100qkw.2
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jun 2020 21:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wjYzq7dNm+b/15M65eILIbgPJ/utRyDEBt1j+IyIFNc=;
        b=tZlQ1+jyfoR+7clXo6vrzd7pzgmnVS1pNwJ0UpJnMv8xv9+lzT5abGBMINYUNEUfgy
         wdW429okaRdglWfYGu7Ufv0UtQ5ZeFFeGzVjbeo0Xr8kg504XwZmBSE6aggZ+/vpQUXr
         jf/RyvipjXVfAL3RKcKQ3/zZm23wd9GYDVLGifCgvkc9Nu3e3J5/r9Fbt9l4vnko05Lw
         3KLoYb78+1YFNX3aWw3/90HzD3sa+Per824hrr4K1hxgUMUJe5rxLQdxiTtq4A22HSw6
         tZDO7K5LI3nuAlIbk0UEgIYk7QPJ35tPLzqslI5XJF8EJLq4Utbmj6YYPnRXMwnzxzf2
         GSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wjYzq7dNm+b/15M65eILIbgPJ/utRyDEBt1j+IyIFNc=;
        b=JrU7ZjfqSOcoYpFV16a3Pv+YpDvjFjYqSIquijiz/Fw1Kb9vq24WpzJZgH8lL+OUhk
         byTUNOsvzB0KEEHOEPG9W8JhTf0B2RojXG1ahTSa35eBCpkcBWy1uoQR5juD/RykjuXc
         Nli3u0qXaeTzDErdMef7j+sf9FO1+rR/esYHDLHfDpBLkpTWwCetllCGmoYk6wPkGnfr
         FFf3Tm4wD8+SuyUAUi7PTj0Y6sQyw1VkcLs5/iOela3Puk5Arn+k2PV6xH/1M9hOqhSQ
         rIYFGlh0YMGehiEuzYpawtvu45BLHax+uAXm4Jde5XsDocneIcAk+zh9OFXy+1XzHZxe
         UfFA==
X-Gm-Message-State: AOAM530vGoBzjVnsN/yGW/5YlLFzc/QknY+TguXLvidcgSToEURZ8ceU
        U4WTb4GN+EcnfNgtkB+h+vfRQl4AxKw=
X-Google-Smtp-Source: ABdhPJwQv3r1LvOO9FWS3NA1m0vFrLjIyQEAcgvFUZrYFA3esKkj7HG6enTwbe1RS/YIKDoAxkLiThK0vyo=
X-Received: by 2002:ad4:49aa:: with SMTP id u10mr30687919qvx.162.1592973237877;
 Tue, 23 Jun 2020 21:33:57 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:33:38 -0700
In-Reply-To: <20200624043341.33364-1-drosen@google.com>
Message-Id: <20200624043341.33364-2-drosen@google.com>
Mime-Version: 1.0
References: <20200624043341.33364-1-drosen@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v9 1/4] unicode: Add utf8_casefold_hash
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This adds a case insensitive hash function to allow taking the hash
without needing to allocate a casefolded copy of the string.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/unicode/utf8-core.c  | 23 ++++++++++++++++++++++-
 include/linux/unicode.h |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 2a878b739115d..90656b9980720 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -6,6 +6,7 @@
 #include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/unicode.h>
+#include <linux/stringhash.h>
 
 #include "utf8n.h"
 
@@ -122,9 +123,29 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 	}
 	return -EINVAL;
 }
-
 EXPORT_SYMBOL(utf8_casefold);
 
+int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
+		       struct qstr *str)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur;
+	int c;
+	unsigned long hash = init_name_hash(salt);
+
+	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+		return -EINVAL;
+
+	while ((c = utf8byte(&cur))) {
+		if (c < 0)
+			return c;
+		hash = partial_name_hash((unsigned char)c, hash);
+	}
+	str->hash = end_name_hash(hash);
+	return 0;
+}
+EXPORT_SYMBOL(utf8_casefold_hash);
+
 int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 		   unsigned char *dest, size_t dlen)
 {
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 990aa97d80496..74484d44c7554 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -27,6 +27,9 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 		  unsigned char *dest, size_t dlen);
 
+int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
+		       struct qstr *str);
+
 struct unicode_map *utf8_load(const char *version);
 void utf8_unload(struct unicode_map *um);
 
-- 
2.27.0.111.gc72c7da667-goog


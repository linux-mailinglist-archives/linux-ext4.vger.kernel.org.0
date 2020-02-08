Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D820156284
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Feb 2020 02:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBHBgo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Feb 2020 20:36:44 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:34496 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbgBHBf7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Feb 2020 20:35:59 -0500
Received: by mail-pl1-f202.google.com with SMTP id j8so640217plk.1
        for <linux-ext4@vger.kernel.org>; Fri, 07 Feb 2020 17:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fTgB3kb3O+v8ILq/4TyTQ+b9UXnhOVk2x96mgR9bebg=;
        b=g8ETqpmpRRWAN/I/0ihQuyhV6cZrzbIoeWPe0HONBVPSLk67hHc/HvOH5Y3E3sfXKm
         osLLtnREDZD+rb6zzkHfRBvJ4qwb6tOshn0h48zQROO/wU8i8sGw0n8zAkLu/i4laHlm
         VC5SF2YtA82PkH2qCWdQZ3RA7cLHrzjuCckH/Zo905k7Bj/TUHVv0pdQVck5swTV6UjO
         TqoElEBtPPPO4CjPtYIJ6/4J5p2FrFj5rtoF9klcjg6S6LJUJF4xprkxdTmeJM1Cviks
         gEoth9u806ySIHFmhgq9F7gJ08gTEEDvk84fAtCnN59hxoWQi08SIbLfXedYovWzn5eQ
         qBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fTgB3kb3O+v8ILq/4TyTQ+b9UXnhOVk2x96mgR9bebg=;
        b=rYicmCTG4z9yZ8qPwW+fMobwwnz4TgUCbMMz/4EjQCfYNaRuqzLfZHXHeZUVLC1pbd
         KBmw6WOk/vAp8gQP0QMvlz47dLp2sT0VITQs75rWqHk2/Mv1gbQfMmtC9L7egijW8YDr
         CnngTGu1nAjUE400zxu3tjmmKn0F9WQGF+zk3YE6ZcCGPFXUt/IQSylpSmQBVpCYxM3r
         nFtA+r94sfRq1gjdJk1r8I8PlI4ER5l8nV+knWVIDRjpFyGn3NaSHFuCN4jX2YhTQHAi
         I1T4nzSGflEElf0R6x6wU0r7JLYNFYIPS02nsXjalUwkRHG26OkG0I8Nq9LVWrQ0mVtn
         cnIA==
X-Gm-Message-State: APjAAAVnVKLDfBiiehVlhTFEAooFXjuM3flArcK2RrjbrQpgdr65dNuD
        KeQiwUbll7GLNIXZtbQHJQpKNplkBbA=
X-Google-Smtp-Source: APXvYqw8lDISo/3URgAqCG25ywWyahbrkFc0mVlthEd962mlaZLm/wh8kHzbBfWez9CSIlqY/2EODpA3fUU=
X-Received: by 2002:a65:56c6:: with SMTP id w6mr2149182pgs.167.1581125758626;
 Fri, 07 Feb 2020 17:35:58 -0800 (PST)
Date:   Fri,  7 Feb 2020 17:35:45 -0800
In-Reply-To: <20200208013552.241832-1-drosen@google.com>
Message-Id: <20200208013552.241832-2-drosen@google.com>
Mime-Version: 1.0
References: <20200208013552.241832-1-drosen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v7 1/8] unicode: Add utf8_casefold_iter
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

This function will allow other uses of unicode to act upon a casefolded
string without needing to allocate their own copy of one.

The actor function can return an nonzero value to exit early.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/unicode/utf8-core.c  | 25 ++++++++++++++++++++++++-
 include/linux/unicode.h | 10 ++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 2a878b739115d..db050bf59a32b 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -122,9 +122,32 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 	}
 	return -EINVAL;
 }
-
 EXPORT_SYMBOL(utf8_casefold);
 
+int utf8_casefold_iter(const struct unicode_map *um, const struct qstr *str,
+		    struct utf8_itr_context *ctx)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur;
+	int c;
+	int res = 0;
+	int pos = 0;
+
+	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+		return -EINVAL;
+
+	while ((c = utf8byte(&cur))) {
+		if (c < 0)
+			return c;
+		res = ctx->actor(ctx, c, pos);
+		pos++;
+		if (res)
+			return res;
+	}
+	return res;
+}
+EXPORT_SYMBOL(utf8_casefold_iter);
+
 int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 		   unsigned char *dest, size_t dlen)
 {
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 990aa97d80496..2ae12f8710ae2 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -10,6 +10,13 @@ struct unicode_map {
 	int version;
 };
 
+struct utf8_itr_context;
+typedef int (*utf8_itr_actor_t)(struct utf8_itr_context *, int byte, int pos);
+
+struct utf8_itr_context {
+	utf8_itr_actor_t actor;
+};
+
 int utf8_validate(const struct unicode_map *um, const struct qstr *str);
 
 int utf8_strncmp(const struct unicode_map *um,
@@ -27,6 +34,9 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 		  unsigned char *dest, size_t dlen);
 
+int utf8_casefold_iter(const struct unicode_map *um, const struct qstr *str,
+		    struct utf8_itr_context *ctx);
+
 struct unicode_map *utf8_load(const char *version);
 void utf8_unload(struct unicode_map *um);
 
-- 
2.25.0.341.g760bfbb309-goog


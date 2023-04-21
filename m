Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FD6EA134
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Apr 2023 03:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjDUBsE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Apr 2023 21:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjDUBsE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Apr 2023 21:48:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0CD4C06;
        Thu, 20 Apr 2023 18:47:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94f6c285d92so167294966b.3;
        Thu, 20 Apr 2023 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682041676; x=1684633676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eDYwHq82vKxTxcR5vuod/O4FBcL/Rgh8EGKnuklb1g4=;
        b=R40+Jy8SDgI3HrxPyBTBVOGaQ2VHSsvgrrxK7ynsRm2caaOVXl4Dm5aFqLDhXZ0uF8
         v2kh/jcbjBqnxJRhmcqg0646lUmIJi/6NTySnm3BfC0Yi4xGVRtwARF6crfOiXQf2/8W
         FN0gVnMa2TYmlWHrwABnmnQvfx0YYoz2jrd8FDb1dgyBcvl2Odrt3L//KSZz11o6rsXS
         UVJAschNdkZQx7P4LJk9PaeQrbUwlrvBsHK9V2uJcPbEFFLg+TtzfsTCCHBNgttE+lvN
         wEhShnQFfwwZXceuy8LmYTZU73RaAASTy5L59mnRJys2IH2FM3J/gIWsXQeBn63fliLn
         +rDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682041676; x=1684633676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDYwHq82vKxTxcR5vuod/O4FBcL/Rgh8EGKnuklb1g4=;
        b=T9Fqt4QBC6mXEevtGVtqYPz1cXwqE1XfVn64bmwM6b+q2hzU0f1bIa1QmUYupTw1+p
         jtm7B3pCK6JU9oRJulh4Smpe9691Xu9lbrZJcrH2UX9kOSTvHC1LPLjs5hQWzEoiHVvd
         si1zIJybK0qOikf37dH5mcg1PF7W1DGYNPJPG9ungodQ25RYAXjwvnDd8K5azJuIOckn
         SOYjx1DKaldeb+7++6Sq5uIaQsYCXLjqnuEFniETWD8nkNwE0owLW7Uhnvv3EXx6w/wq
         +DSNDeOAHbQ3sPu5VsfQZRcFz2XyYESX/BqnYL37anpSBJwcIHowtvl+UAzoxwSHdD14
         AUrw==
X-Gm-Message-State: AAQBX9cIyJ8SMqOmeyYXMmVdMyq2bPDpl9/fEYPDEe8+M4YWKIarS2qJ
        +CvnFjK1RdHvDBEstmD2La6iPJsHlqc=
X-Google-Smtp-Source: AKy350bQrKchpZcfEmru0faAGFPa9zS2Qa0JpalCeHi3owdE2jdvHBD59NMxnwKNc/3OwUOQzS/vcg==
X-Received: by 2002:a17:907:3c11:b0:88a:1ea9:a5ea with SMTP id gh17-20020a1709073c1100b0088a1ea9a5eamr629559ejc.65.1682041676309;
        Thu, 20 Apr 2023 18:47:56 -0700 (PDT)
Received: from noahgold-desk.intel.com ([2600:1010:b044:5553:d1a3:a9c6:1560:d322])
        by smtp.gmail.com with ESMTPSA id z26-20020a170906715a00b0094f0237c32bsm1360932ejj.208.2023.04.20.18.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 18:47:56 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org,
        Noah Goldstein <goldstein.w.n@gmail.com>
Subject: [PATCH v1] ext4: move `ext4_count_free` to ext4.h so it can be easily inlined
Date:   Thu, 20 Apr 2023 20:47:49 -0500
Message-Id: <20230421014750.2315938-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

`ext4_count_free` is a one-line helper that is clearly better off
being inlined. This saves a handful instructions in `vmlinux` on x86.

Instruction estimates use `wc -l` on `objdump`
Before: 8539271
After : 8539248

So saves roughly 20 instructions

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
 fs/ext4/bitmap.c | 5 -----
 fs/ext4/ext4.h   | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index f63e028c638c..c3cd2b878bbd 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -11,11 +11,6 @@
 #include <linux/buffer_head.h>
 #include "ext4.h"
 
-unsigned int ext4_count_free(char *bitmap, unsigned int numchars)
-{
-	return numchars * BITS_PER_BYTE - memweight(bitmap, numchars);
-}
-
 int ext4_inode_bitmap_csum_verify(struct super_block *sb, ext4_group_t group,
 				  struct ext4_group_desc *gdp,
 				  struct buffer_head *bh, int sz)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08b29c289da4..6e1d3c175a70 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2675,7 +2675,11 @@ struct mmpd_data {
 # define NORET_AND	noreturn,
 
 /* bitmap.c */
-extern unsigned int ext4_count_free(char *bitmap, unsigned numchars);
+static inline unsigned int ext4_count_free(char *bitmap, unsigned int numchars)
+{
+	return numchars * BITS_PER_BYTE - memweight(bitmap, numchars);
+}
+
 void ext4_inode_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
 				struct ext4_group_desc *gdp,
 				struct buffer_head *bh, int sz);
-- 
2.34.1


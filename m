Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88F412AABB
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 08:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfLZHKR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 02:10:17 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54742 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfLZHKR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 02:10:17 -0500
Received: by mail-pj1-f66.google.com with SMTP id kx11so2990895pjb.4
        for <linux-ext4@vger.kernel.org>; Wed, 25 Dec 2019 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yV1bFCcYZRZ224Wb+sO6H6NHtG+4un9eeTRCHa7JoYY=;
        b=QlPiDmDpftmpJsvYzApK1rnPQf3xIQCVhozllfaTVqpPnjxYHAdP9NSUEFpTbXAolP
         OWFVmWicszXu4AtpmcgIPIu8MhzSnRLtoNV1FlyHKGPkzPbvPAi5laHTz2e+2nTHaZQt
         gS+XnMOMTOGrxvHloj9J8qNRhmyA3NkDuuD1KsO7pDQmx9bT2auhvlmwqo9MQ9mzlcX5
         98Agu0LWChcN8EDvo2qpIOg4LXfpbymJUdzXBIIGBlpY9PpCi5v/wSd2ou10Z/kksJ2k
         2IwKX/ncfCScqmrpO+I5Y0OksmL15T1Oa8fiVB1tKXD0uhLbzWTVYsiwq4P/dCccv2Zg
         S2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yV1bFCcYZRZ224Wb+sO6H6NHtG+4un9eeTRCHa7JoYY=;
        b=qVfuPoPwsx3nnNOjWyuAu07VUuagDYTpe3NZAMNeBme4iNfZqxjW7jx5PLE3gXK6e9
         /HqX6Io6unPASBMief/fc5jbrjInPJfmN47/btTiTqClzXORuFsCAMqfHy+Eyi6dZP8h
         uja81V1fOnk7qj0ZdBkDaN7OiQFBZZBAtSANc1d0AS9Tj6jJkpbEetz3G6gIrBy8X9EI
         lRBkfknWm8JhaxoA/q/Eoz9JVIEciJtNMecUcxbLMqZFzjseBOZKLhcGpqgbHVvcZlNO
         OnzZhbHCpz3RSTsFlLhqrDQH3m6BoAVmqxMSIfkM4rX8jusYADRAfqAl6BzMRcEtJ7BC
         Y+KA==
X-Gm-Message-State: APjAAAUtOO0WyVXkNZa07f+jB6VY0ame4ESRdWoiGo/1AwZsmFyBlWHo
        O56qBWaW2On9elRfm3eArnk=
X-Google-Smtp-Source: APXvYqx3Y7QtmFsQhYQybK3xpDAmtuPPda+8ERr05AVn0c4OajNHLOb4CSb89xw1xZ4fU/WAlBs9kw==
X-Received: by 2002:a17:90a:8584:: with SMTP id m4mr17579508pjn.123.1577344217080;
        Wed, 25 Dec 2019 23:10:17 -0800 (PST)
Received: from hpz4g4.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id i11sm9473439pjg.0.2019.12.25.23.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 23:10:16 -0800 (PST)
From:   Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: Prevent ext4_kvmalloc re-entring the filesystem and deadlocking
Date:   Thu, 26 Dec 2019 16:10:08 +0900
Message-Id: <20191226071008.7812-1-naoto.kobayashi4c@gmail.com>
X-Mailer: git-send-email 2.16.6
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Although __vmalloc() doesn't support GFP_NOFS[1],
ext4_kvmalloc/kvzalloc caller may be under GFP_NOFS context
(e.g. fs/ext4/resize.c::add_new_gdb). In such cases, the memory
reclaim can re-entr the filesystem and potentially deadlock.

To prevent the memory relcaim re-entring the filesystem,
use memalloc_nofs_save/restore that gets __vmalloc() to drop
__GFP_FS flag.

[1] linux-tree/Documentation/core-api/gfp-mask-fs-io.rst

Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
---
 fs/ext4/super.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 46b6d5b150ac..4a3c9ee63a34 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -43,6 +43,7 @@
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
 #include <linux/unicode.h>
+#include <linux/sched/mm.h>

 #include <linux/kthread.h>
 #include <linux/freezer.h>
@@ -204,13 +205,32 @@ void ext4_superblock_csum_set(struct super_block *sb)
 	es->s_checksum = ext4_superblock_csum(sb, es);
 }

+static inline void *ext4_vmalloc(size_t size, gfp_t flags, pgprot_t prot)
+{
+	unsigned int nofs_flag = 0;
+	void *ret;
+
+	/**
+	 * Although __vmalloc() doesn't support GFP_NOFS, we may be under
+	 * GFP_NOFS context here. Hence we need to use memalloc_nofs_save()
+	 * to prevent memory reclaim re-entring the filesystem here and
+	 * potentially deadlocking.
+	 */
+	if (!(flags & __GFP_FS))
+		nofs_flag = memalloc_nofs_save();
+	ret = __vmalloc(size, flags, prot);
+	if (!(flags & __GFP_FS))
+		memalloc_nofs_restore(nofs_flag);
+	return ret;
+}
+
 void *ext4_kvmalloc(size_t size, gfp_t flags)
 {
 	void *ret;

 	ret = kmalloc(size, flags | __GFP_NOWARN);
 	if (!ret)
-		ret = __vmalloc(size, flags, PAGE_KERNEL);
+		ret = ext4_vmalloc(size, flags, PAGE_KERNEL);
 	return ret;
 }

@@ -220,7 +240,7 @@ void *ext4_kvzalloc(size_t size, gfp_t flags)

 	ret = kzalloc(size, flags | __GFP_NOWARN);
 	if (!ret)
-		ret = __vmalloc(size, flags | __GFP_ZERO, PAGE_KERNEL);
+		ret = ext4_vmalloc(size, flags | __GFP_ZERO, PAGE_KERNEL);
 	return ret;
 }

--
2.16.5


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B28D5E90D
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 18:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfGCQbZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jul 2019 12:31:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35886 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCQbY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Jul 2019 12:31:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so1517542pgg.3;
        Wed, 03 Jul 2019 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4eVFCV4n8ApumpPcE82E9lpvBLXu1lzKnvoK5FcLU+s=;
        b=GgtlEcC2dn2vunTVRLqIxAI2DUHYqdIi5ZsdJHwRsqXsoXkbGLC8dMobe9pPOxj6wQ
         4ai1Y7Zuk3ZZUWods2gUe2Kg5Qh9HAbdLPFBKzLFMp7KlcpPFlDUTRohsIskgn6Qf3OT
         h9ozLwVSkhosDGmADyXD6oFaXMoqBsvlYOhv2uAf2MCl/mkU+s+YIDb/rwOEDjK0Drnf
         /aVc+CFMwvG6dUCWi1tOodrbpivs4Aix26uZxGO9SZxhLl544nBEXH6r1+xllmiaN34D
         CcnRkJCxfXT/O5vrwOWwcBcxun5GzQEclZCaJTjtcMVaITGRyQETORT8VzzfDtIjVr06
         l8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4eVFCV4n8ApumpPcE82E9lpvBLXu1lzKnvoK5FcLU+s=;
        b=giaLkun+9kqAgMetc9KO040ZsNcLtYJnc2JCOPv4a1ICpnUUGF22nOuh7W1FdB45WY
         gdoW0g80nAfIJz+Zjw1RV3SyDQv5fvfaP0BLbDQrK5aesApSBwjuh6/Zx2gUxhj4pBKN
         rB3DLqK5+6eMbfn3i1AKFb7C025ouaT7YkQgHj4PgM0xhAYOIXD57gTziWUwXdil7Yca
         6BPslD9iZKJyIaJrItUm2LAqsE9qVg9sioHi3MxHgMlkT4C0wgIXNlUyScmPSyHWBwaH
         gU+oTCJ65jx1RYZF+NEUXJdNdyI156o3CVoFRKOUs5vXo2noyDbvOPSRPCaqMeHgpUK8
         0cWQ==
X-Gm-Message-State: APjAAAWD962RtjRhKApFn7nC0FhWab6HuO3Ih8puHUkNeJsUizOmBZrx
        PT0wIYQUo79lC17mCXisq5A=
X-Google-Smtp-Source: APXvYqz6TnR4jSf80DCJXCRS9ctmpPhnaJe7PWy59NW0J+xyRYKw94exyXX6TzbPF1bt/58ppLzbyw==
X-Received: by 2002:a63:7945:: with SMTP id u66mr38055983pgc.127.1562171484199;
        Wed, 03 Jul 2019 09:31:24 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id h1sm5206544pfo.152.2019.07.03.09.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:31:23 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 28/35] ext4: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:31:16 +0800
Message-Id: <20190703163116.710-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 fs/ext4/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 491f9ee4040e..d09040df7014 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1898,11 +1898,10 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 
 			unlock_buffer(bs->bh);
 			ea_bdebug(bs->bh, "cloning");
-			s->base = kmalloc(bs->bh->b_size, GFP_NOFS);
+			s->base = kmemdup(BHDR(bs->bh), bs->bh->b_size, GFP_NOFS);
 			error = -ENOMEM;
 			if (s->base == NULL)
 				goto cleanup;
-			memcpy(s->base, BHDR(bs->bh), bs->bh->b_size);
 			s->first = ENTRY(header(s->base)+1);
 			header(s->base)->h_refcount = cpu_to_le32(1);
 			s->here = ENTRY(s->base + offset);
-- 
2.11.0


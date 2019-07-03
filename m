Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 171CD5E90B
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfGCQbP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jul 2019 12:31:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45986 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCQbP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Jul 2019 12:31:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so1495220pgp.12;
        Wed, 03 Jul 2019 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gMIebqMt+SP/YsSOb7MMOmptkoGKOMcJjOMMlz5MUE0=;
        b=mMjEnCRkhNfPouTar6t086iJo/nsprVCK3I6SmuuujU1d/a4GHt4+TVQOMrsgHpW7N
         j/G2LOHc0ERhqaazkyW3lLj9qjS6ucxc725smL0gAyhaOvZy7WDT/3n13gX73obAHCXc
         pg3p9CezCM0GWbfFaYb02Ls3lI9CIQ5Oz/6eHuUbkAYYJ8LpTIIyw1gIMw/LETS7x/L0
         lSx3DCUPRFK0diWB7P7XJ6l+rKeaOmzhRC4xgV0YZfgZpTBLvgsDTAtE0Xgq9adVmgti
         0EMYSfp9pBvW8NNm/tkSjrkznwN9Gj8jG3Qf247MvmXgG85WMUb/8fVUQz5g+7/vQC8u
         pzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gMIebqMt+SP/YsSOb7MMOmptkoGKOMcJjOMMlz5MUE0=;
        b=U2PVebiuMji7RTP8Q5wJsfq0/l8FswMF+CYAYzeW9SnXNlc7R5fbCU2iME8lYHzTMp
         lO98Jr8NPJD+KEk30TrNkSIn6MxyDA4JNUtT88dWh4o2egyqlS6c0AYObL6R1v/+QrVS
         y04NEV2UrBlkjiz3KPoVeY1TQ/1gb6OXGkxMmvvbn5D8fkmCIv3xfhD5rdM8vf+j0U5M
         eXS73ZWuYUewDJ1xilDsvzLb/XNKOLkT5mIkP2qyumIzlO7uoXft4KD/r+47fHoumO5C
         9Ppksx+vavicwkV2cDUAsiIOMrdng8+z88YCZA/Bxr2bVuAmih4CrzC/65XtIZugQe3z
         zfMw==
X-Gm-Message-State: APjAAAUvTqMIwUjyvixw8nnd7nKXm02/ZiRjwUnsda6l7zfgeEpvETq6
        Agc/3pNrh96srSb0fbB9KOI=
X-Google-Smtp-Source: APXvYqx40/dEuVGFC16La2oKgOMQ7JylD3+aVP3/JmuiqyVDHRLl53M72FfGLg7OEE4GntebmdLIfg==
X-Received: by 2002:a63:df05:: with SMTP id u5mr37476719pgg.171.1562171474351;
        Wed, 03 Jul 2019 09:31:14 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id w197sm5658962pfd.41.2019.07.03.09.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:31:14 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 27/35] ext2: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:31:04 +0800
Message-Id: <20190703163104.628-1-huangfq.daxian@gmail.com>
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

 fs/ext2/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 1e33e0ac8cf1..a9c641cd5484 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -506,11 +506,10 @@ bad_block:		ext2_error(sb, "ext2_xattr_set",
 
 			unlock_buffer(bh);
 			ea_bdebug(bh, "cloning");
-			header = kmalloc(bh->b_size, GFP_KERNEL);
+			header = kmemdup(HDR(bh), bh->b_size, GFP_KERNEL);
 			error = -ENOMEM;
 			if (header == NULL)
 				goto cleanup;
-			memcpy(header, HDR(bh), bh->b_size);
 			header->h_refcount = cpu_to_le32(1);
 
 			offset = (char *)here - bh->b_data;
-- 
2.11.0


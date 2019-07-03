Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7985E52C
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfGCNRg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jul 2019 09:17:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42090 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNRg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Jul 2019 09:17:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so1268336pff.9;
        Wed, 03 Jul 2019 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kID8MleQILhLJBSvhNclsUXpPABPaGgap1yaL7i2q0g=;
        b=CCFmnMno+D5GHdrxjpBvUh9B4GejAclzpHtSteg9DYMAldleYRZvdnvIATiqhNlMzS
         Bsf5LiQS7nVv5ri8fdtIp+OzbVxTgkydu1SDy2WrGQSeODbx/PVLOTwz45t0/vh+DOXq
         snKshU9fwZKy4JcndV7lwggCLt6V2+HZB54XlCcjfFTtzYDXcapKWzKNy4gQ3rdOVCU6
         oHnziz1C+8jjiBLe9kL+YcDGwsg1WwrwMPnzd+18VBLuWO+ODOcArPVOieuSquDoaVn3
         W+nxbehkRExt6sGueOQF5L7ZJGwGyomqT38z9YIIgCGlfUIRUZAv1y8nDUctow/gdhp6
         wgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kID8MleQILhLJBSvhNclsUXpPABPaGgap1yaL7i2q0g=;
        b=cUIpHL/Pa2yaE/qzjgKmxqQaMavKJY0DntkJlyWdh/6dhFzP6q4Ye0QkVqZlS1SjNw
         y1T8wkzT7GAOAdSaFSiDTQBDGOO6GGZcBHNm1nZT2smMDhlHXw8FOIjJyQe89nkSbrZP
         jseqN6ovnugZA2MHtXCDhGrUn1TdQJ7httOFdmNBby31pnXhJTtJYVDdwvK2MzopUUlH
         ivVPYpVMivYd+Xw6re7Tzyr+CZCfelanv4UuLglxGmf75rlJQSKRBDkw6jhTgJ6hxF0V
         pJSxLYcII99qnKg5xL6ble3CXL5PDZGvlGwXBuRQCBKRGrVoU/Z5lHmXokJcw1rhy235
         mK9w==
X-Gm-Message-State: APjAAAWNypXYq4NJNVEzeAaCAiGHvKkcgXtYHi84o4QLrBZNnwi80hEz
        pMTXUTcRr7zgl5kKqe96Yjg=
X-Google-Smtp-Source: APXvYqwEz82fG8Aqjq14RhP/3Hxg5ERz3mIlO9S73tgHII5YcrQYvlMJbJ7aineL7lUinnLUFpFD7w==
X-Received: by 2002:a63:607:: with SMTP id 7mr34192556pgg.240.1562159855813;
        Wed, 03 Jul 2019 06:17:35 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u10sm2255542pgk.41.2019.07.03.06.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:17:35 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 23/30] ext2: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:17:27 +0800
Message-Id: <20190703131727.25735-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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


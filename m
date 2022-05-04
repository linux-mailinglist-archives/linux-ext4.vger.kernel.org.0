Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E7F51B260
	for <lists+linux-ext4@lfdr.de>; Thu,  5 May 2022 00:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379261AbiEDWyd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 May 2022 18:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379469AbiEDWyI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 May 2022 18:54:08 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BE0B6B;
        Wed,  4 May 2022 15:50:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCDZUHE_1651704626;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VCDZUHE_1651704626)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 May 2022 06:50:27 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] fs: Remove duplicated include in inode.c
Date:   Thu,  5 May 2022 06:50:25 +0800
Message-Id: <20220504225025.44753-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix following includecheck warning:
./fs/ext4/inode.c: linux/dax.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ext4/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 987ea77e672d..60d909a528d1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -41,7 +41,6 @@
 #include <linux/bitops.h>
 #include <linux/iomap.h>
 #include <linux/iversion.h>
-#include <linux/dax.h>
 
 #include "ext4_jbd2.h"
 #include "xattr.h"
-- 
2.20.1.7.g153144c


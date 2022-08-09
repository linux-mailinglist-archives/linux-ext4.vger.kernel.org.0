Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39CC58D397
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 08:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiHIGLa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 02:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHIGLa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 02:11:30 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B1E4CE0D;
        Mon,  8 Aug 2022 23:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nWSuj
        NVLYOAC0UgNZNXBkAlGiv7EwMjesbiSHjhxGjU=; b=RnibnApbZmHe2hSWulUSG
        s90MoYTBVL2RhD51lAg2sy6jWA4oRcCn5tW+NGJwYlkSh159rqv9zfNuvQYclEQ3
        J7pDRBcDSSr38mm9VyinIXisk7j1bNhD/unHTsWTZDhUwrUMdTndRNcg0YWAzGi5
        LrIjIeMgyKasnbPUQ8j6Ds=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgCXNQhq+vFifQtOUg--.45249S2;
        Tue, 09 Aug 2022 14:10:51 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] fs/ext4: replace ternary operator with min() and max()
Date:   Tue,  9 Aug 2022 14:10:31 +0800
Message-Id: <20220809061031.3646725-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgCXNQhq+vFifQtOUg--.45249S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyDtFWftF4UuF18XFW3GFg_yoWkXrcEka
        y7Aws2grWftr1S9F1Fkw42yFyI9w40kF13Xr98JFn5Ww45ZrWUJayvvr13ArZ8CrWYvr9x
        Xr1vkr1Utasa9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1eyI5UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiVwtY+1etn6VJuwAAsN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

fs/ext4/extents.c:2631: WARNING opportunity for max().
fs/ext4/extents.c:2632: WARNING opportunity for min().

min() and max() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/ext4/extents.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c148bb97b527..3a74d0961024 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2628,9 +2628,8 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 			  unwritten, ex_ee_len);
 		path[depth].p_ext = ex;
 
-		a = ex_ee_block > start ? ex_ee_block : start;
-		b = ex_ee_block+ex_ee_len - 1 < end ?
-			ex_ee_block+ex_ee_len - 1 : end;
+		a = max(ex_ee_block, start);
+		b = min(ex_ee_block+ex_ee_len - 1, end);
 
 		ext_debug(inode, "  border %u:%u\n", a, b);
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


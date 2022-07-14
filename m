Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3E757451C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 08:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiGNGdm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 02:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGNGdm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 02:33:42 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 714E42ADF;
        Wed, 13 Jul 2022 23:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=y2Bvn
        iMhbl5jK8THTHxbQtXvRNWzTIer28MZL2NagjI=; b=MFjxR9LAZtTatjvAg+SSn
        3wsJMnONJHk7V30YTydtZZTcDNUenpZ4+UEE3q+vpSF6c90QyFvluQDhnoGaR07P
        rd7vEnz5rN9iPrLrKhotoHTAJlprSg37YERsQahCN0VH2Jd9M0mYc5EimS+0D8cF
        0zyXrlE0SONYleVCM4YawY=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp14 (Coremail) with SMTP id EsCowAAnT_K2uM9i5aWBMw--.1991S2;
        Thu, 14 Jul 2022 14:33:29 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] fs/ext2: replace ternary operator with min_t()
Date:   Thu, 14 Jul 2022 14:33:18 +0800
Message-Id: <20220714063318.1777139-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAAnT_K2uM9i5aWBMw--.1991S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFWfCr15KF1UtF1ktF4Utwb_yoW8GrykpF
        ykAr4xGFyrur1UX3ZrWw4DX3WxWayDKF40qrWj9r1UZr9xtw1fKFn8tFy5WF409r4xZ34v
        qFs09ryxJw1xWw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxF4iUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/xtbBthU++11uPnbZhAAAsA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

fs/ext2/super.c:1494: WARNING opportunity for min().
fs/ext2/super.c:1533: WARNING opportunity for min().

min_t() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/ext2/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index f6a19f6d9f6d..300f2f0cf566 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1490,8 +1490,7 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data,
 		len = i_size-off;
 	toread = len;
 	while (toread > 0) {
-		tocopy = sb->s_blocksize - offset < toread ?
-				sb->s_blocksize - offset : toread;
+		tocopy = min_t(size_t, sb->s_blocksize - offset, toread);
 
 		tmp_bh.b_state = 0;
 		tmp_bh.b_size = sb->s_blocksize;
@@ -1529,8 +1528,7 @@ static ssize_t ext2_quota_write(struct super_block *sb, int type,
 	struct buffer_head *bh;
 
 	while (towrite > 0) {
-		tocopy = sb->s_blocksize - offset < towrite ?
-				sb->s_blocksize - offset : towrite;
+		tocopy = min_t(size_t, sb->s_blocksize - offset, towrite);
 
 		tmp_bh.b_state = 0;
 		tmp_bh.b_size = sb->s_blocksize;
-- 
2.25.1


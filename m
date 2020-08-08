Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02D23F809
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Aug 2020 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHHPSk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 8 Aug 2020 11:18:40 -0400
Received: from m15112.mail.126.com ([220.181.15.112]:45296 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgHHPSf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 8 Aug 2020 11:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=WHXhFzIbKFdevwIdD+
        ipgUf5p6qP87QN0gbQI3/2iqo=; b=WppCPe6B9k1QK5HY1ceyHrHO1nR9zeVsAe
        VebFryE2Othe2r0zK+dVn0RcwfrlmRzDnepQ8RllrcD4+9umPS747sny5KU9yIAE
        VBMXsXtQosL4Qre+57G6u5QWbSLR9fLaScIeBfCRuh/FXkMo9o0mvgVKkmRGcUAI
        VpTyIOxKs=
Received: from 192.168.137.133 (unknown [112.10.84.202])
        by smtp2 (Coremail) with SMTP id DMmowABHzSGArC5fXMmZGA--.43065S3;
        Sat, 08 Aug 2020 21:45:38 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ext4: use kmemdup_nul() instead of kstrndup()
Date:   Sat,  8 Aug 2020 09:45:36 -0400
Message-Id: <1596894336-49052-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DMmowABHzSGArC5fXMmZGA--.43065S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryrZFy5Kw4DWrW3WryfZwb_yoW3uFX_XF
        WxJF4DWryftr4IkF1Fkay5tFsYkrs2vr13Xan3Ary5Xw1qq3WYgw1DZry7XF98Wr43JFZ8
        u34kJrnFqrn2vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8G2NJUUUUU==
X-Originating-IP: [112.10.84.202]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi3AJ6pFpD-WPjfAAAsY
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

kmemdup_nul() is more efficient than kmemdup_nul() if
the size is known exactly.

The description of kstrndup() already suggested:
Note: Use kmemdup_nul() instead if the size is known exactly.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957e..be37556 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4016,7 +4016,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	if (sbi->s_es->s_mount_opts[0]) {
-		char *s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
+		char *s_mount_opts = kmemdup_nul(sbi->s_es->s_mount_opts,
 					      sizeof(sbi->s_es->s_mount_opts),
 					      GFP_KERNEL);
 		if (!s_mount_opts)
-- 
1.8.3.1


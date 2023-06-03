Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE71472113F
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Jun 2023 18:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjFCQeH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Jun 2023 12:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFCQeD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Jun 2023 12:34:03 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0881D8
        for <linux-ext4@vger.kernel.org>; Sat,  3 Jun 2023 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1685810035;
        bh=uAP3FqBrEWEzvObMBRutUO4oMwLpHty4nVZ2xxX1uks=;
        h=From:To:Cc:Subject:Date;
        b=CR0Z6MPVUz2hSh4wsqCruX+KN5s70fZpx4R6kb3RyNdGFfMat/6+R54rPQZDJ57Ce
         cE3FbgUHTTQz7ICQGGICEIyQDYjuQQMgLyuBTQQs9x6ZM/GtOBaHHu25N2MUJmNRJH
         Dt8hF0wSeb9NxQCfKKA2mkXqGQgQaHqSiG4rQ8Ek=
Received: from fedora.. ([2409:8a00:2579:18c0:81cf:3f94:28ba:8d3a])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 87622CCA; Sun, 04 Jun 2023 00:33:54 +0800
X-QQ-mid: xmsmtpt1685810034t043dbu2i
Message-ID: <tencent_4A474CC049B9E77D0F172468991EED5B9105@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2FtRFERjSLev2Y3o836dxUDC+RnUeU2pnLbPD2Kqp+yWJdWVlEq
         D/01hXzmTww5jdjAj+jPJoRQkfiuvgmJf6oiiUfkG6RA6ICnNmf+GtWzSaox2bL9aYPT0xA5aiM2
         EgPvv+vwO8tn+/Io73AhH8a7/AxHvsatyihEmw4kFQRkHvOWjzfzTIUgnJNozMi3BxOIefB8wk1r
         Jxy3kHweQgUHKx6qkiCoweQWtJjK3n3pQtNamhiKeJlRI4hoHgT2hFtrax9qR/bD+pwWfQcRZlqF
         LiTSjoQg/tExuFbqfnmCNX8RQWgm8fCuvi/MJ4FrG1C7JoG5RJ0t3r2j3bcoXpOvavrx85hbTLMb
         81B+EhFieVn6fXAWmMqnR/Fa9awttpFckzBujbnkbeKFnPm5Qs3yJeFpm3azwL9G94xQX8zTGBvE
         ruuK8+O2SX2OYJy/F+CybVFYlo9mKgDRQ+xOM738FTl92IozS8hxvmQfYxd6lzcUYmWf15lpnndE
         h2pe6ZsNmWtrbe/9CD8Moil6Iwrkoqkbak3FPDjVjb3/4SUT7wsxCNrfkmfg+R0dm1NC1x0GYc+x
         tL6sd6hVTvc54KbRAOkSeVWrOks/ikSyaGulTRef9WR7PFu7x9n3hgSUWRVPAG+1rCs5hKqAIgKT
         YOg/QLz69p1AtC2bLZSClA4HGIkYCAxhxHoSw5j208+9dC27rB9mHAyjl50sHReh501SgMtDwTiX
         tYGHYffuYeLvUO4Uoqkam4EVx5RNamMJ5/SKzpeaQaJaD4UHt91cK1FPzJ6KyoJKoNev6hCaFk2r
         dCNndHbCzGfcvWDIruoZGRDrjVJ2fIjk62TGT9kdnk+7tRriMu5tKg+wisKsNt8D3/wb9bDic7pt
         FaeYIPzniIB8u2h865a0piGg9Zmg369xrS7cDbgUXIYNrXoGsW6i4AxTGB9Ge6lRXNClivUhXQIQ
         yOEgEn5LU+ntipOctc2FYp5LOaMran6kweIT1UuuZo1+SQRHbkJu+kc6eAzq8S
From:   Wang Jianjian <wangjianjian0@foxmail.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     wangjianjian0@foxmail.com
Subject: [PATCH] ext4: Add correct group descriptors and reserved GDT blocks to system zone
Date:   Sun,  4 Jun 2023 00:33:50 +0800
X-OQ-MSGID: <20230603163350.40117-1-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When setup_system_zone, flex_bg is not initialzied so it is always 1.
and when meta_bg enabled, group descriptors are located in the first,
second, and the last group of meta group.
And this patch also adds reserved GDT blocks to system zone.

Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
---
 fs/ext4/block_validity.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 5504f72bbbbe..5df357763975 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -215,7 +215,6 @@ int ext4_setup_system_zone(struct super_block *sb)
 	struct ext4_system_blocks *system_blks;
 	struct ext4_group_desc *gdp;
 	ext4_group_t i;
-	int flex_size = ext4_flex_bg_size(sbi);
 	int ret;
 
 	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
@@ -224,11 +223,14 @@ int ext4_setup_system_zone(struct super_block *sb)
 
 	for (i=0; i < ngroups; i++) {
 		cond_resched();
-		if (ext4_bg_has_super(sb, i) &&
-		    ((i < 5) || ((i % flex_size) == 0))) {
+		unsigned int sb_num = ext4_bg_has_super(sb, i);
+		unsigned long gdb_num = ext4_bg_num_gdb(sb, i);
+		unsigned int rsvd_gdt = le16_to_cpu(sbi->es->s_reserved_gdt_blocks);
+
+		if (sb_num != 0 || gdb_num != 0) {
 			ret = add_system_zone(system_blks,
 					ext4_group_first_block_no(sb, i),
-					ext4_bg_num_gdb(sb, i) + 1, 0);
+					sb_num + gdb_num + rsvd_gdt, 0);
 			if (ret)
 				goto err;
 		}
-- 
2.34.3


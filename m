Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71C076D3A5
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjHBQ3L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjHBQ3K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 12:29:10 -0400
X-Greylist: delayed 6193 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 09:29:09 PDT
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069F91FFA
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690993746;
        bh=UR+9s2ZLz4CSRCTls3vdBBk3AwwdEi6/lRJ4wKvY0GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jU17kqwOE6rkhTPJvpdhY3WYIw2GsQx6dXzpPW7/Md4e0sYySonkcRfs0RQ7PFXCr
         18ZFGp2pWLLhTfWE3d7Mxe8IZxxL6ASrgqgM2trPvynIB6ywZm6TfCa/o6mrZ9uj83
         fHnSdY602g2kpDv+Esf8kncLtzDJNj3Z/lWbVtn8=
Received: from fedora.. ([2409:8a00:2577:9740:9ca5:5f74:38db:4c67])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 72B1AE0F; Thu, 03 Aug 2023 00:28:43 +0800
X-QQ-mid: xmsmtpt1690993724tczbsrwph
Message-ID: <tencent_D744D1450CC169AEA77FCF0A64719909ED05@qq.com>
X-QQ-XMAILINFO: NOIkHYnr7VzdZ+GOzbPiwidcfm1yMskvpXhchdU/5acvMKoXNa/7HT3eCVSR1U
         9TidFEmCOK8S4f9WiInZ3Q5rSGPxRonIzTuhomRA5vSHX8/VkMsJEiM3NwdEpVXKvZ0pD5eoHfLr
         RCEQ8e4lburO2VNvxvkLG/lpq3vqdWtUI3qecZ+Lvdy7W+CfAmnI7D4QXRyb7o1ASmkxmfIH4DNg
         bj0APCktbhhI74QusFGsCJFvaHTEUdRdwnP5gCISjx/4aOH8pHiVBN1RCL1fPyzlmq+LV4I3mllB
         J8aVpbAUpBLkmS+ukDurBHDdxrwa8eBG+WncLxmwSVJqT3bTVYn7NvzeGmVjzIbcErYQ+7ipQsB4
         aap3FQOTDWsJ91fMSPuhYIuzA+GdDw4C5OjMVFKwDJJZEX7q9zwcPDJlpT944ch9lnM+FYq8iOOX
         8IiuONDadyMmGJlJMd9PfLx2XVzslR+qeVdX+y77w3yxK2hbY29waNh3sxljmY67rWmsROiDvigt
         3C79TmIfP4VJLcwhTUeeKbnD/jHpKGySwvDwHIfX4WObnWDt0lA+ie9bS5SycdBWKnVqRwdBCXpD
         R5YRGKP9TMQwDUseANMqv5qWBPNPzTZlhWPvCzMPA3VAUUQnzbk19EUXQVrQTx9tH+8RRL5/Qx1K
         MB9AZANGfpmPkWut4qlme+lrp9UVlHzmo3z/rtXSznajUl+mpaDO0TXXizpQR3GoQw7a/giTy4NV
         mBmDXAs8yNttKxV4VdP2Dmy3xWL+BivNpJP4AhDI5VqEuGstneXnZbPZ2nfwEQjnxF0kBbBnsC9G
         oKXi1fp60Aoc7IMZ5NzHHo5YOm5I+YBXQad/QTeTC8Q6W+OPtn/gSU9IXdpyHGVclPK2WbTdrd+8
         Yf3Cogaz3kP0Nf847kwGQqvsbVTgn6zzF42jQL3w66vp2unHUG6qC6EP2zUVfYs1Cx1ZAcSwqe53
         qZXHrvZEkdBGVHSMPnEId2Y+YTGHEtjK55Bxr66L5GhN/TptVw3LQgzjKSj9Eq9jxTBO3ZAd3MEb
         wR9i+Kw4uVepWCJNnHa2vitaJaBx/ogEvcDYiu2+T8vgjqIqhX
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Wang Jianjian <wangjianjian0@foxmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Wang Jianjian <wangjianjian0@foxmail.com>
Subject: [PATCH 2/2] ext4: Add correct group descriptors and reserved GDT blocks to system zone
Date:   Thu,  3 Aug 2023 00:28:40 +0800
X-OQ-MSGID: <20230802162840.331385-2-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230802162840.331385-1-wangjianjian0@foxmail.com>
References: <20230802162840.331385-1-wangjianjian0@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When setup_system_zone, flex_bg is not initialzied so it is always 1.
ext4_num_base_meta_blocks() returns the meta blocks in this group
including reserved GDT blocks, so let's use this helper.

Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
---
 fs/ext4/block_validity.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 5504f72bbbbe..558e487a0b53 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -215,7 +215,6 @@ int ext4_setup_system_zone(struct super_block *sb)
 	struct ext4_system_blocks *system_blks;
 	struct ext4_group_desc *gdp;
 	ext4_group_t i;
-	int flex_size = ext4_flex_bg_size(sbi);
 	int ret;
 
 	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
@@ -224,11 +223,11 @@ int ext4_setup_system_zone(struct super_block *sb)
 
 	for (i=0; i < ngroups; i++) {
 		cond_resched();
-		if (ext4_bg_has_super(sb, i) &&
-		    ((i < 5) || ((i % flex_size) == 0))) {
+		unsigned int meta_blks = ext4_num_base_meta_blocks(sb, i);
+		if (meta_blks != 0) {
 			ret = add_system_zone(system_blks,
 					ext4_group_first_block_no(sb, i),
-					ext4_bg_num_gdb(sb, i) + 1, 0);
+					meta_blks, 0);
 			if (ret)
 				goto err;
 		}
-- 
2.34.3


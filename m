Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2315C638B64
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Nov 2022 14:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKYNk2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Nov 2022 08:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYNk1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Nov 2022 08:40:27 -0500
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF4A1928F;
        Fri, 25 Nov 2022 05:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1669383620;
        bh=ood4vbBiDrQkuZYdST/YJDYyULNFGcAYpukDELQQS2k=;
        h=From:To:Cc:Subject:Date;
        b=ZbAzEeBjtmhddTM5vtFHUTDOJszIOqtReLofS+RB2vz1rX1om4FJI5OxCgIaMiI7Y
         EgBnRVxkUwYjIr+2gpRlm7AQVXMWL5+oywHczaMMXQ0Y/viRKbwdpNNkFmvloFXxyA
         Gmt13dnNaRtrlgbcly5rQSh/Cw3yv05C4bUOym/8=
Received: from localhost.localdomain ([221.223.28.123])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 9A522CC3; Fri, 25 Nov 2022 21:38:37 +0800
X-QQ-mid: xmsmtpt1669383517tx1rwx6he
Message-ID: <tencent_EEC5C049082D4BF0724AC5E9956BD41E5105@qq.com>
X-QQ-XMAILINFO: Ma9u/w5Vb6c03qejOHkqbN0593+fKNt7q/uoQbPqGAiyM7o4iU8RL0Suw7nFq7
         R6QRtiPIKEBgYMwgOMyToVGqibA9vzpkSNsEfVZ8kmLd0JQYwb3Nxoud5zc1Cmj+LwWz92LZNnxJ
         nAiN/PEzvgcTQuNHdMDkM0rZhKvB/m5FjNu6oCh0vUjDgapCacbKgmK3XiqqiWBacnhi1pkf6QfP
         SoiI96RBiJrhXsP6/aqZ80M0pZ96xeHfFJgcItzdnEW4A86BlCsyDW7YxRH7K47NiDrz+fCCe0+S
         wrP0P/9q4TuT7QC5g5Zxfrhy34OhuptjO+1q1ijPju1RNkmlBxfi5ydB8tPjB8QkBoid0FXzWaAR
         SGggQgHElTu9qMz7JaEM98VggNV0923IWopuW5arJyr85x8eepLZAwI7PrTuFA3Lot4gRH5iOs4p
         yn1AYu5oYvXj0GcKHL9H12GMaU1k+Oe2+skz9tVdYj3T46eiYJLuYaD/2JRlwLJtSVN2WVQNNjgg
         sGU2IOYwjhtKDNBkQ2eQOWSK4+saobgumLNs2zRJRIzkS5Ce4ICo6qbbgi6BAOLyWxG/Kc1NB8Oq
         vz6Qy7HYeCs1J8I5+jK6Wxs0UP6dcQTggU2p8azUFBuLTyravU05fnhSR/90L9HRa7tcMGT9uCUH
         8IWHzvKZKqyivxx93ku5Froosp3MQqFERu7FHvq7GuCPyCMHq2uCZxIcp5Sx+ZL9hGGXcQ5yqOMl
         BJK7LzrUXfFUhhFXMFX3VyAGIYlobBU2z/npHzV9IQvpZ9AEu+NwJXLolic91RO23ah0PbUnqCAR
         fRL6cHFdO9Sl47uRC5OJV4nC3TXc5lo7DdJ36OH8mipN/fKKa+iszlfbhdcOMTsX8IJd65R9pX8J
         u4gVJ3b9Mny3yhOQH/qH5g19KNa4jtKLyzb/uvXGo4Vu6/jZzFO0LNzxejUjdPAOLBwOIoD7UASg
         7L/zQyjbs=
From:   Rong Tao <rtoax@foxmail.com>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rong Tao <rongtao@cestc.cn>
Subject: [PATCH] fs/ext2: Fix code indentation
Date:   Fri, 25 Nov 2022 21:38:21 +0800
X-OQ-MSGID: <20221125133821.643-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

ts=4 can cause misunderstanding in code reading. It is better to replace
8 spaces with one tab.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 fs/ext2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 03f2af98b1b4..69c88facfe90 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1648,7 +1648,7 @@ static int __init init_ext2_fs(void)
 	err = init_inodecache();
 	if (err)
 		return err;
-        err = register_filesystem(&ext2_fs_type);
+	err = register_filesystem(&ext2_fs_type);
 	if (err)
 		goto out;
 	return 0;
-- 
2.31.1



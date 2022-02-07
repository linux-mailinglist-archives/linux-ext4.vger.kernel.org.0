Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74A84AB5CF
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 08:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiBGHPr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 02:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbiBGG4r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 01:56:47 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BE6C043184;
        Sun,  6 Feb 2022 22:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644217006; x=1675753006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUe9FJuEf7BWKrxSIxqPYK0eG0nCVdO3BScCuHtRrAI=;
  b=Ym+CDPpvZ5IzH5rFIajaYudXMjwDKGMM9kHbLc0gXPOVfXP39ZaTAtBu
   FJJV3sE3yJJXckoyXDPtNJ3a1VbLIHaKRfndfSOY6a9Bm9igWeZrzEWrB
   Bvkb2r9BMES35OZp6moF8pIWZkszfZyiq0e0fp4TPGi6gAE/Gfb6vXmyo
   qQAYBepoyawWMTl/9GQo4GQ3aDQWOpxzBMS54ZlOPGYJmTpdVfLWm1CKW
   5yaW6Xmb6Mk7aiH8SEMgoA1yZwdLzCruzMjtqb1Prnf8CMcmwRLLHQ/jv
   w9uH1toR7LwNCS7wlpXsJWiXf/FtADh8oHG7cK4xsi00NjAz6lNOaVzqo
   A==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635177600"; 
   d="scan'208";a="192305057"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 14:55:43 +0800
IronPort-SDR: 2MREi+8FS5XRvb3YPDJ5j/wO3grSW6mB+2WMcjsGBY/pQaU3yzAmoeNbV3Pj2+i2qlaofwk7e8
 76r8KZmpc8++CoxqPpiG/eAph4ERjp+COLKBhG0aS1fzXtm7cktlJi7IfF6idMTg7I0IU5k3Af
 Xr25E67rV/6U+5ljJ1o/8mL+HfKLjoD8gunqZX5FB01CzP9h6KMhdQvgVcsseCvD5bUsEl/RFp
 O0EXiKOZ2Wdwcs06SSKQwrRVcHqnar9oWn295Y+0sl7TQ0o5/2oWA0c4E7l5h9LcYRjhZR98IT
 sHQf/4rnabU5nSbbXQa4B3d4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:28:45 -0800
IronPort-SDR: e1JXFxzveIsv04C7p2hz7i13/BR9GkuZBcQITXqrNrhqTj1THm4SleplX5Eb1I400adAe5aLTE
 KaGJNw1tq/uHEGLXPQA8OJuDs5uNz+yK9dKVroSpuebwODf5+DadFfDkZpQ4Vte2NkeuRXhw2S
 YHdbQsE3cWDcS/RpS3audoHqSV8wA9gEhzhheDfOKnpESz1nP6bwcxooaN2G9HHjmy6/P5qpmq
 JhK1QOCFpedTTAzZf2DO1IRFK/hFo0Ie+RRfKHvpaHqmLebUGpkZ8IKyLowwQwwgQtrZR+8+hI
 xXE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 22:55:44 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/7] common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
Date:   Mon,  7 Feb 2022 15:55:35 +0900
Message-Id: <20220207065541.232685-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207065541.232685-1-shinichiro.kawasaki@wdc.com>
References: <20220207065541.232685-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The helper function _scratch_mkfs_sized needs a couple of improvements
for btrfs. At first, the function adds --mixed option to mkfs.btrfs when
the filesystem size is smaller then 256MiB, but this threshold is no
longer correct and it should be 109MiB. Secondly, the --mixed option
shall not be specified to mkfs.btrfs for zoned devices, since zoned
devices does not allow mixing metadata blocks and data blocks.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index b3289de9..eb2493d1 100644
--- a/common/rc
+++ b/common/rc
@@ -1075,10 +1075,10 @@ _scratch_mkfs_sized()
 		;;
 	btrfs)
 		local mixed_opt=
-		# minimum size that's needed without the mixed option.
-		# Ref: btrfs-prog: btrfs_min_dev_size()
-		# Non mixed mode is also the default option.
-		(( fssize < $((256 * 1024 *1024)) )) && mixed_opt='--mixed'
+		# Mixed option is required when the filesystem size is small and
+		# the device is not zoned. Ref: btrfs-progs: btrfs_min_dev_size()
+		(( fssize < $((109 * 1024 * 1024)) )) &&
+			! _scratch_btrfs_is_zoned && mixed_opt='--mixed'
 		$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
 		;;
 	jfs)
-- 
2.34.1


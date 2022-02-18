Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CA44BB34C
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Feb 2022 08:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiBRHcR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Feb 2022 02:32:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiBRHcQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Feb 2022 02:32:16 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D3328ADBC;
        Thu, 17 Feb 2022 23:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645169520; x=1676705520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X0cJo/gEUSWY7GFbHe4x4WW3rcISwkhA4qYARZRTXL0=;
  b=ZL3dy/r8JGmcFtpayRC0BOzIhR+zfSFFtJB9PoCjkzJz9DfbQS8zNzE0
   qaq3srsTpqfe8zyzi3+oJpO+lSVfupjQGiortPoTm5JhqKHtjifEOE+eX
   8PxFNz4RLRB41BbfLGHzz/80LFOQn404mbBoOMIn2wXbd7994hXzFzXNJ
   99PZhaTs0Yt/Ayt+DWVLabcJBGCUb8QW2JsW3rinaV1Simxdk7GBwl0CR
   ZCI1FAHxz+Nveorkpwee73oExh4AvZEZTixNAE6UxOIb/gYpam6IajhBZ
   GiCKz5yr1F3wLzjRVSTPCYWrcVjhmKb7TrhDCkbhcS4QdkxxeggpZGf3K
   A==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635177600"; 
   d="scan'208";a="193264892"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 15:32:00 +0800
IronPort-SDR: 7YTibtaoh4ygGH3r9wYDZbSHbSe83m01b9+17knxqQDu2GYTFNxz+5jCLr+y1MNrsrYU1NBojI
 0UfTgkT4U15VY6MF0uinHAbCNokwIYqqOU3H8JlA3LTVKNrGNQDdbKT8QYiBZJgHK0wgJiM3UB
 kb9KipSWi5SwGNKXIrd/u+Sp1gsqyxFAQL3m34ToOgWWm4Vly79X9o7QWtmujVFyx8LYhVOTmM
 zNFBe1Znz6HPykWTTMaBHYCJtTZAqwmCxmMxrZH0i1I3KaFfZED3XosMP4TXkJPdVEN2QEtPGX
 hseRUtLEJLCpTWRmG1AwopXc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 23:04:45 -0800
IronPort-SDR: lKFR5aoeC6jbqVv67g4GuRn7VTZCiHUnuouSVgkA4977nFObGZTRmZ+RF8aHxykDk94eG5kLKL
 tkR9vL17WCb6LmIE0dAElFOo85IDizqY2u7v4Zz9Md4Vx4tv8Dax7zK8vVo4Rqi3E3XONQHbPM
 0s5Vp3rv3FSl9LMzMbmuGUKqtB9CHK1gbWm23OJ+mKFMZb3XTqBJ/4B74vFrH2laDMX6+NzuQX
 8edsfz3K+I7qVYaUlE3CnsGOh5zv3ZV9uE3q0xQ8QJ3DTGh96Rf8SOQMjGx1oQ+OETk/RGEXqj
 gi4=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Feb 2022 23:31:59 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3 1/6] common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
Date:   Fri, 18 Feb 2022 16:31:51 +0900
Message-Id: <20220218073156.2179803-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218073156.2179803-1-shinichiro.kawasaki@wdc.com>
References: <20220218073156.2179803-1-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 common/rc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index de60fb7b..74d2d8bd 100644
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


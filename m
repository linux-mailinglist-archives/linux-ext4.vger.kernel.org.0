Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45BE4BB357
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Feb 2022 08:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiBRHc2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Feb 2022 02:32:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiBRHcX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Feb 2022 02:32:23 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A055C28F96C;
        Thu, 17 Feb 2022 23:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645169526; x=1676705526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oNwFFRRH3apj/4n7qSFchUH8rbWyk695r1onG5cIzSI=;
  b=fI2zwD2vKQ+Ztx6H9VNJBPtmcs7zJlZ4+m9YiYK46uTZDQSjXOonxpiJ
   fiwdNjAMkk0Lex5Wj0Kp5oX9YBz0pnijuZgSaQqdVCkAUYMYcwR7fF6SU
   qsIWLCpga7NFq8f4myOKHnDdAdWlNh2s1uDxpa6oDqr1ZNEO1RELDTzbw
   zADcXSZ1+61XltJ7piJoduPHfitDhY5oCmi3W7hHtGPLAeDK2N2sqQNAw
   ymktW1JaEYoZHO5AJZ3SY2/LPko+YO584yVLlTtaW50FuPRozwKJLu6Vt
   8jOOfrMRC+SVflEEJlpnBuIdHLH/H1P5AodVaJ0wzPBQZJ7r7BsTHeNsR
   g==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635177600"; 
   d="scan'208";a="193264908"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 15:32:05 +0800
IronPort-SDR: 1c08pjIr7C6Bam6WPsMLr6ne3yiQoRmGCdxbwUCaDs8FOSi+omvsYulLGoU/1XuOi1Ylw6sYsV
 bxY9km2fp2fRI3M2OBN1K3MwYCE8dhkgqhNtIleZsgURPBac6+hF0mX8aUUzq0sZ7aXfFvQluq
 +f3nJ6sn6JbZn+SCrtzvYivfr56RA+QuZhYFIpSl8cdf1gTp/I/eNl9a+ALnSkOHUdSIWhKcEI
 aY/9aGFC/CghEqrCuJflHogTHIGIx+GpzQypy0r2ndadK4Pu0WB4PyGF4heNM1FvZM/SWwS1yg
 G/Cj0O8qw6zDvlpLZGNGbSZR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 23:04:51 -0800
IronPort-SDR: WROGBVyGSpfS8L1IOhzjmJV1tlFLojtM6ebsEa6kc3Yx4WVzuHPo4yEvnRkIlrc6/JJ3+9nzKm
 rhSizKzD40GRQgBziYvERHPFgc8QY/eI1pu7EHnLTX7j/w9RlZl1ZcyLBnt78XvVZMbcTLxpJQ
 lk7habeRqFMFBD6JanewGSIHPPy2WkQn1VGlcA//4aFCfIXmMtE7suVP6CX87vPeBa7yNABxYu
 4rAziF8ZPnA+RqlI7+pck0wa1EPuHy8s508jkAUi77XF7lhJC67/i8EvjEYS/xVxbfXdOxLBZ3
 2OE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Feb 2022 23:32:05 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3 5/6] xfs/015: check _scratch_mkfs_sized return code
Date:   Fri, 18 Feb 2022 16:31:55 +0900
Message-Id: <20220218073156.2179803-6-shinichiro.kawasaki@wdc.com>
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

The test cases xfs/015 calls _scratch_mkfs before _scratch_mkfs_sized,
and does not check return code of _scratch_mkfs_sized. Even if
_scratch_mkfs_sized failed, _scratch_mount after it cannot detect the
sized mkfs failure because _scratch_mkfs already created a file system
on the device. This results in unexpected test condition.

To avoid the unexpected test condition, check return code of
_scratch_mkfs_sized.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/015 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/015 b/tests/xfs/015
index 86fa6336..2bb7b8d5 100755
--- a/tests/xfs/015
+++ b/tests/xfs/015
@@ -43,7 +43,7 @@ _scratch_mount
 _require_fs_space $SCRATCH_MNT 131072
 _scratch_unmount
 
-_scratch_mkfs_sized $((32 * 1024 * 1024)) > $tmp.mkfs.raw
+_scratch_mkfs_sized $((32 * 1024 * 1024)) > $tmp.mkfs.raw || _fail "mkfs failed"
 cat $tmp.mkfs.raw | _filter_mkfs >$seqres.full 2>$tmp.mkfs
 # get original data blocks number and agcount
 . $tmp.mkfs
-- 
2.34.1


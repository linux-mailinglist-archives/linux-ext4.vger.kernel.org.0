Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA34AF1C8
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 13:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiBIMeR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 07:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiBIMeL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 07:34:11 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E97C05CBB4;
        Wed,  9 Feb 2022 04:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644410053; x=1675946053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqFAptI4CAvK6M8wR+plx0XzaNREix5nWvG4orfRMAg=;
  b=FjBT2XrQ2T3ImxnK311Rd1+iatDRq1bRWBORTSHUeOdK+gFB9Fp9UmDE
   UYAGZle0FX4n4Dbww7m4qSwkf7v6NzHGx0NDWfw0kRNDK/0Yns7mhupVq
   UmkYXyERe/2V37hBgeORMiA1R5rSKDFreijptl29/Ay7YizeReDgp8frX
   stB7KjxvclfZ8jWH7RJgimM7TzGonvQhxuCxpvFCsgLbOuiPbR9z6cv4U
   zj51hP2OvSeQGkYKKoAueNrOS7brH6rw5MSGshnnYn/kc6XoJpbha6QPM
   aKHfvs38b0gbffG2GW9xG9pSE2OJkK8dNqQydyrcEBoj3JTRzfDC8D1lK
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,355,1635177600"; 
   d="scan'208";a="197323002"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 20:33:10 +0800
IronPort-SDR: mFZRlfokyvRoXI7FqS/zV2fWdE3a7+NItIiCdoq8fznulNUIR8QDxtgdO1MunJwEu2XCBeAM+I
 RLrvZUkZAIo0N30FW/CbGQlX10wYeUwuLqa44EwOc1uCmA9m4UyENr40R6pGped4UmKBdIDdCp
 MqzU/zyko6Nmqr8EvG8h5muiTnlf7aTacn5a/KwC4f5xENAfxQBjMTmtOq7JEqx7Rl3Tk00OF6
 /vGY/XDoeVu6z8OqlGAyf3VDpv/c9K/8x6O8iW1DXaqR9vTZEinVQ1chCxlgkoB1Ae4Ct6H++R
 ZWm55GGkg1xpwil/UNw3MIiW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:05:00 -0800
IronPort-SDR: W1MvrQzZxXO9gzaokMTGtCVKyoDpO+FHwt7B59GXSAQVDzu/e9HYudoFz46d7BCF6zfWHaMCp4
 j9Ib1G6NVtKaRixCMwvMI7Kws5VDTouv/dCReYR83nIoEsGnzV/zsyEIOUBXY7gDXsrs0rLB2O
 927auwjFAxcBfvwzUsIu6C9LLkwjOF0of0du8TyjgxHRQFZThLHCfq8W0lf8uTzb8rJLa8zb8e
 Xl2kd5rglWhuyNnD3rjeAuc7eXLfrO4+BKKsh1fb+Kec+uVu9h3gYOh8GOtyoeP6WIvfjnrkwl
 cmA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2022 04:33:11 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 4/6] ext4/021: check _scratch_mkfs_sized return code
Date:   Wed,  9 Feb 2022 21:33:03 +0900
Message-Id: <20220209123305.253038-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
References: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The test cases ext4/021 calls _scratch_mkfs before _scratch_mkfs_sized,
and does not check return code of _scratch_mkfs_sized. Even if
_scratch_mkfs_sized failed, _scratch_mount after it cannot detect the
sized mkfs failure because _scratch_mkfs already created a file system
on the device. This results in unexpected test condition.

To avoid the unexpected test condition, check return code of
_scratch_mkfs_sized.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/ext4/021 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/021 b/tests/ext4/021
index 62768c60..a9277abf 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -24,7 +24,7 @@ _scratch_unmount
 
 # With 4k block size, this amounts to 10M FS instance.
 fssize=$((2560 * $blocksize))
-_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
+_scratch_mkfs_sized $fssize >> $seqres.full 2>&1 || _fail "mkfs failed"
 _require_metadata_journaling $SCRATCH_DEV
 
 offset=0
-- 
2.34.1


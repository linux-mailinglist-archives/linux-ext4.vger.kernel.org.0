Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8A54BB355
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Feb 2022 08:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiBRHc1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Feb 2022 02:32:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiBRHcV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Feb 2022 02:32:21 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B90F28F944;
        Thu, 17 Feb 2022 23:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645169525; x=1676705525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Pd3b/9swSzNUyD5TIAVg8N6r2sO8Uzr5oqo/2Aj3v4=;
  b=e9R1vVLsF6KKp3IXMAF0e2SECXqYXLuqo9qHKk0ZMTrbaaJyZLLVDKjf
   Nx71ilMfrOUykoGK7slkYCIQ1yJznze2LV8Z/4DZc8Z4HFnr5aEnUWsDq
   XsdYOU6Qt2yHIUiOergRg2I2Gasx1mNrdNuuNVP1JwcxK77u6mePXWVY3
   y2QB/sR6SW/b+68ydqSGBgOR58PjG9Hfg1Z0OYzAHWLFU97hQjHLLoT+f
   4Hk/FSPAQHcwoOjHt2MhBpR+KduCmkAO+vKfaqfE+p3yDZnSqdLPR0cyY
   hJYo57JJOvUINk0FFZQOWopPAI2lu1WEaAx8Ql/pjjoe75sUvgiKC2Ko2
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635177600"; 
   d="scan'208";a="193264907"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 15:32:04 +0800
IronPort-SDR: DyAerbA+Rp8fQejIqqC+moeaB5xhABY2Gqu686kDMrOhTfv4J2Pe0qvtTxoqPgKk3/uJ0XoQ5h
 euE6yXnYyHmmf3vakYglvJ+c30e/iUF//conKB33+IRL6kzcJGT77ImkwPZ2IF0kRfCFlLby6S
 DCI/Z37+pyQ84W902s3wQtra+lG0Cjcs0/SHXBAVVOj6ykLWCuCJUNFtYtgzKhj7fhhFNIpw09
 ARnZsuGZbMfbdmP78r/SHIQKBE4sKIW3SNqDr+KnFmo4sBkBXjI5ka07hJMiYq2z/iIG8J3o/y
 yYh5OCTWc9PWshgIlCYXi6gj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 23:04:50 -0800
IronPort-SDR: AACecmJwVv9CFdEW/k5e2nFX6/PFjDjibsPKU58qvf1d5wHHSiQp/0D6deeFSMdmyakMHQdpXb
 8TA2ppbnCjfCr3sPw3E8jqgd401t+OGsZLfO/0vc4R0ZVQbdRaDKBAHY9KmPfDi47+Rcv14zlb
 WM/973JWOZHVRwJ70+q772RdZL8UKocSBH9mTz/OLHzAxQ+2tiEVjobrmiEsnteScXYAkaw2UX
 xJ24az+ttXv7rv4CUOxIuK+X3SKn4ZMasezYAWSD6fNH4ipXhNY8AR2+kuUE6BBZdOH6Xh2w3J
 wKE=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Feb 2022 23:32:04 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3 4/6] ext4/021: check _scratch_mkfs_sized return code
Date:   Fri, 18 Feb 2022 16:31:54 +0900
Message-Id: <20220218073156.2179803-5-shinichiro.kawasaki@wdc.com>
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

The test cases ext4/021 calls _scratch_mkfs before _scratch_mkfs_sized,
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


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389214AF1C1
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiBIMeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 07:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiBIMeL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 07:34:11 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E1C05CBB0;
        Wed,  9 Feb 2022 04:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644410053; x=1675946053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IjYNb7uundcc1qwAsCJBb8+PbZiYpFVjgURrlwgTinQ=;
  b=LvQqc5lH8MSnm1ToFy41dJeBPTiax6IqINpcxNAQH5nOZ4Dyx72Btd1h
   hrUAp30LR/oaCnyC2cQKYjESBba5pwj3iyDMC4T4Tl0ywa+igyxcYbnON
   JwnJClgtgkcnlBFGX0euD324JAsCy/qyIFNvQbkxYaDmjSdxjUibS3cq4
   Mcxk5fWmXg2eZxvL7yqXGL/MZfBYJvwj/WYHupuSPk3FEt21tXQFI2kcZ
   ocf09tvu6/upCz88/lXDgRU7uLvNd35Uf+uEk4XGf/E/INGHMfIh/61Ma
   8yaPiV+DjXgPcRvSmD0z/L7KAej46mRYIOoEeYVwBwXasWVSkDpCuBltt
   w==;
X-IronPort-AV: E=Sophos;i="5.88,355,1635177600"; 
   d="scan'208";a="197322998"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 20:33:07 +0800
IronPort-SDR: K0RlOruL3Zw7h3DH2A2/YI+9+3w8sWPDWOwg5n/NSLIeWZLM951d7GgtL5FlWuVbt7UloGvV+2
 EZtDUjQ2FU5mCKhvrggKQvV+gqMuNrQx/EqO4M9EryhfwDYxnU6Rgcg0cVXqZWuoFQ9wvgaYzx
 l+1BSEcBTxHl0iWrYQ1uirMYOhL6S5jYPSZ+MG9Fa86cm50Kf8gf+W9KGFYQL1lb1xtK5Tap6B
 Dq0B0MOzoK1th9mS94oWlhSlnrzzN36dj/53TbPmkPjdB+4o/rLyWAWlssGUnMfGcxNwgikmYJ
 9ej2+SOsSsVU6YRw00rnwYlw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:04:58 -0800
IronPort-SDR: UP78An+WCqiIV9bH869MRVipxVBSwY9ET7nPha/IC3RdDd33h+aZGHBFXYxkVBHZqda30SRYbR
 0QvmDqfH4SD/cJnU2xQlMHzAA3BXknSVQnKQJtRI3Nh+wCmDQlFWZIegU7R/ARSeC75lVW/lb9
 IBqcxANBIRd5NOFn0pG7wSr7hQs2CBQKjRnrRjRcMT+14zb6TWorhCxkB1Ll9cXbd5buqGVymV
 +qp9Hs+8H2CxxqYCOcDKvTWp5QZ7nU8H8YF6PIw+PZtGHoiu38c7MNY07SDVAqaZ9kIIhA0/y2
 B40=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2022 04:33:09 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 2/6] generic/204: remove unnecessary _scratch_mkfs call
Date:   Wed,  9 Feb 2022 21:33:01 +0900
Message-Id: <20220209123305.253038-3-shinichiro.kawasaki@wdc.com>
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

The test case generic/204 calls _scratch_mkfs to get data block size and
i-node size of the filesystem and obtained data block size is passed to
the following _scratch_mfks_sized call as an option. However, the
_scratch_mkfs call is unnecessary since the sizes can be obtained by
_scratch_mkfs_sized call without the data block size option.

Also the _scratch_mkfs call is harmful when the _scratch_mkfs succeeds
and the _scratch_mkfs_sized fails. In this case, the _scratch_mkfs
leaves valid working filesystem on scratch device then following mount
and IO operations can not detect the failure of _scratch_mkfs_sized.
This results in the test case run with unexpected test condition.

Hence, remove the _scratch_mkfs call and the data block size option for
_scratch_mkfs_sized call.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/generic/204 | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tests/generic/204 b/tests/generic/204
index a3dabb71..a33a090f 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -24,10 +24,6 @@ _supported_fs generic
 
 _require_scratch
 
-# get the block size first
-_scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
-. $tmp.mkfs
-
 # For xfs, we need to handle the different default log sizes that different
 # versions of mkfs create. All should be valid with a 16MB log, so use that.
 # And v4/512 v5/1k xfs don't have enough free inodes, set imaxpct=50 at mkfs
@@ -35,7 +31,7 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
 [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
 
 SIZE=`expr 115 \* 1024 \* 1024`
-_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
+_scratch_mkfs_sized $SIZE 2> /dev/null > $tmp.mkfs.raw
 cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
 _scratch_mount
 
-- 
2.34.1


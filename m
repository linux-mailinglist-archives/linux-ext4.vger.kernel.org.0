Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3CB4BB34E
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Feb 2022 08:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiBRHcU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Feb 2022 02:32:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiBRHcR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Feb 2022 02:32:17 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EBA28BF5F;
        Thu, 17 Feb 2022 23:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645169521; x=1676705521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QZPP2eUD6LmrIngJtxiooxFOTZ0FEikLbY04VUf8kXE=;
  b=IBnF9cHAlY7SLTLBQIKko5JZRuyCuF2u75Oft8EUEoTEJ/Thsw8rGBek
   GYKzI3V+SxSnIAciXGe99NMZWnJgwu52IWOT0VW0Mj1UtINPouU91yrwJ
   Dwc76T1AmaY5u77dNEgQ15e/4Pcmb3a1asH2dqEsQbQ9QjqU6GrT4Pphh
   +oBvQRNjNxVJiGOczVGp8xSbqkO2n8ca7uU54BFq9ptffWGTpVGXkoMp1
   /suKMh89L1Qz3Fr1OrGflGDYIVEhNZlWIRiibgMv+bvnkKKpv+t1pixmm
   9c47zcJX+wlAX0Ni3Hg0YLG5AUNQ/3LEaIr6czj37q5yA38PeNS53cR2Z
   w==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635177600"; 
   d="scan'208";a="193264897"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 15:32:01 +0800
IronPort-SDR: PoY3yc0/gkJlLJ2BTlH5WRYI1J6OqlCC+mdnslJ3H4RpDuzGSwsfcWMF+OxdPf3zGW5ROv0P5C
 8+xXy2Qi7gElrbVI7HSB9nmUNlBZST/EMVZuoXuyOJwyBwBcZQY7TivH+93nOpYwo8r2kRLN6s
 /8eoX9/bvJJP8PlHJmurYjcyGIzxf3kRVW6tWtTAWQflO/Bvuk/EDHhUCEaO1kvs9zLlXyoPcE
 b963t2qvCSpcwpjhxR/ro+M2nxnUNTGN54uF3HeeBnqdnxgwvQXIGTMt3dWDeA83aBygPRBDiT
 RZwiyg1amtWYN8Tyc3KL6ahU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 23:04:46 -0800
IronPort-SDR: qOXg3z9g5tkTtWbH0M+gC5EoIsS/btGA2ULv3bjrM45Ezc8OtZDH/jd4BLW4eAizrLIJsbuk+X
 fUnDgb34oiVMUs1hqJWNNrXZKPLo8yScBNHp5u4iH9RHgvr5ctCRnr0t1yvAIGEwDcH3NtZ9wg
 G/meH011EmE3FQUJI6VYjcUxdXt3BznYrsWkIUoxHc3SIY+PrQNyBFsaw0O/+wL+iKCJH2UAlN
 YbU3HEAv9sjgTQEsL/KvYbmbXWZduMb/2wtsWwFOLkMmr4ID2gsx84S8Jk3ixwzPgRG18D/BfW
 fO8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Feb 2022 23:32:01 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3 2/6] generic/204: remove unnecessary _scratch_mkfs call
Date:   Fri, 18 Feb 2022 16:31:52 +0900
Message-Id: <20220218073156.2179803-3-shinichiro.kawasaki@wdc.com>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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


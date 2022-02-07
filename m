Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F14AB5C9
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 08:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiBGHPn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 02:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbiBGG4q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 01:56:46 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 22:56:45 PST
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43774C043181;
        Sun,  6 Feb 2022 22:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644217004; x=1675753004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i499PSgK1wGpdERKxIqW9U6J6nKA+RZnj0LglIyJ4e8=;
  b=aJ3mniad3wULk8CObYXYJA1MYT7Xvj2YY3U4ARdqc2BO0LQqAsy06n38
   qi4L08AoJv0f3bWBze1EZpMN8rAF1y0yW2efxWoD6VqVQnM4cpo6lzFdk
   QE9r+QkvcdWvJKxoG0dgClJc4xIR8FWETr/QaQxCERuFdLF22ifs27u/n
   U1kpW7MN82zXLQFsaI+DR/dzH7gnMtBNcy/9nXJGlq+8nxFjIB1H3ziCA
   2bNetL3qaUr7nP+7AM8wiR4xUulvp2JmIOoPtfjVqyh3YEwpL31Sp5vuq
   oecALBzGCmaisX07c2Um2dLTBmSnc2eipgvE0P0wOEZ9vgzaQHUJSQUVt
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635177600"; 
   d="scan'208";a="192305055"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 14:55:42 +0800
IronPort-SDR: HYZBC/bnxUzpw2ytP/ahNr67xP8fX4cEOD4pWf8SBqotPsAPiHEitFuPgC8a1+IyTKoiZOXLWA
 88CDg2udSsPA+rC4UBiWX3nUQzl+7WnQJtk28TIL8BFM2uleZNd20LzoImbZ6tOlWDVfGpHGuz
 zCcLkxZT7wrRbfu5VcDCco4OjOxmOW0hO/YfJVmULZed/+/2sHcztlehOgSg6v+rPmqXkK39AB
 AILafvTXdPuun4s62fwCqCF1iyxUW9cvnKJF+juRVpcVZzFj3AwhS3QzSTdEI9rVaDGuWznvhQ
 LCnvd1kOlRVTVeVrjBT/QvHx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:28:44 -0800
IronPort-SDR: iPexuFmbMmmdkk3GO+0cfGVz3A6AhYnt+hrUJ9SuVpFNo6vogp9R0/ecWhm0G3hXwpGyz0NeNG
 WDf04YEKX04jxY+NJZYRRHOEwBaCNSL9hhPLu7sdLKERDp12OI8eBCewrqf32vItNABS1l51mE
 HvkBKQbTBGbQnK+zwhWVg1fMkQ20vkspouY4RtLyIKwxfeSLXLjgZhbPQCKocD2eFhX/LVwjAD
 1i0FU3fAQSm181qrzK92p66NJ4VGKVV80aMyB8flVSYISM6StrwMHCRb2Ph5e9MzccX3yjAw3b
 BbM=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 22:55:42 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/7] fstests: fix _scratch_mkfs_sized failure handling
Date:   Mon,  7 Feb 2022 15:55:34 +0900
Message-Id: <20220207065541.232685-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
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

Let me repost again adding CC to ext4 and xfs lists, since the series includes
changes unique to those filesystems. Sorry for repeating same posts to fstests
list and btrfs list. Reviews and comments will be appreciated.


When generic/204 is run for btrfs-zoned filesystem on zoned block devices with
GB size order, it takes very long time to complete. The test case creates 115MiB
filesystem on the scratch device and fills files in it within decent run time.
However, with btrfs-zoned condition, the test case creates filesystem as large
as the device size and it takes very long time to fill it all. Three causes were
identified for the long run time, and this series addresses them.

The first cause is mixed mode option that _scratch_mkfs_sized helper function
adds to mkfs.btrfs. This option was added for both regular btrfs and
zoned-btrfs. However, zoned-btrfs does not support mixed mode. The mkfs with
mixed mode fails and results in _scratch_mkfs_sized failure. The mixed mode
shall not be specified for btrfs-zoned filesystem.

The second cause is no check of return code from _scratch_mkfs_sized. The test
case generic/204 calls both _scratch_mkfs and _scratch_mkfs_sized, and does not
check return code from them. If _scratch_mkfs succeeds and _scratch_mkfs_sized
fails, the scratch device still has valid filesystem created by _scratch_mkfs.
Following test workload can be executed without failure, but the filesystem
does not have the size specified for _scratch_mkfs_sized. The return code of
_scratch_mkfs_sized shall be checked to catch the mkfs failure.

The third cause is unnecessary call of the _scratch_mkfs helper function in the
test case generic/204. This helper function is called together with _filter_mkfs
helper function to obtain block size of the test target filesystem. However, the
_filter_mkfs function works only for xfs, and does nothing for other filesystems
including btrfs. Such preparation unique to xfs shall be done only for xfs.

In this series, the first patch addresses the first cause. Following three
patches address the second cause. They cover not only generic/204 but also
other test cases which have the same problem. The last three patches address the
third problem. Two of them are preparation patches to clarify that the function
_filter_mkfs is xfs unique. And the last patch modifies generic/204 so that xfs
unique test preparation are run only for xfs.

Shin'ichiro Kawasaki (7):
  common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
  generic/{171,172,173,174,204}: check _scratch_mkfs_sized return code
  ext4/021: check _scratch_mkfs_sized return code
  xfs/015: check _scratch_mkfs_sized return code
  common: rename _filter_mkfs to _xfs_filter_mkfs
  common: move _xfs_filter_mkfs from common/filter to common/xfs
  generic/204: do xfs unique preparation only for xfs

 common/attr       |  2 +-
 common/filter     | 53 -----------------------------------------------
 common/rc         |  8 +++----
 common/xfs        | 45 +++++++++++++++++++++++++++++++++++++++-
 tests/ext4/021    |  2 +-
 tests/generic/171 |  2 +-
 tests/generic/172 |  2 +-
 tests/generic/173 |  2 +-
 tests/generic/174 |  2 +-
 tests/generic/204 | 26 ++++++++++++++---------
 tests/xfs/004     |  2 +-
 tests/xfs/007     |  2 +-
 tests/xfs/010     |  2 +-
 tests/xfs/013     |  2 +-
 tests/xfs/015     |  4 ++--
 tests/xfs/016     |  2 +-
 tests/xfs/029     |  2 +-
 tests/xfs/030     |  2 +-
 tests/xfs/031     |  6 +++---
 tests/xfs/033     |  4 ++--
 tests/xfs/041     |  2 +-
 tests/xfs/044     |  2 +-
 tests/xfs/050     |  2 +-
 tests/xfs/052     |  2 +-
 tests/xfs/058     |  2 +-
 tests/xfs/067     |  2 +-
 tests/xfs/070     |  2 +-
 tests/xfs/071     |  2 +-
 tests/xfs/073     |  2 +-
 tests/xfs/076     |  2 +-
 tests/xfs/078     |  2 +-
 tests/xfs/092     |  2 +-
 tests/xfs/104     |  6 +++---
 tests/xfs/108     |  2 +-
 tests/xfs/109     |  2 +-
 tests/xfs/110     |  2 +-
 tests/xfs/111     |  2 +-
 tests/xfs/144     |  2 +-
 tests/xfs/153     |  2 +-
 tests/xfs/163     |  4 ++--
 tests/xfs/168     |  6 +++---
 tests/xfs/176     |  2 +-
 tests/xfs/178     |  2 +-
 tests/xfs/186     |  2 +-
 tests/xfs/189     |  2 +-
 tests/xfs/250     |  2 +-
 tests/xfs/259     |  2 +-
 tests/xfs/276     |  2 +-
 tests/xfs/279     |  2 +-
 tests/xfs/288     |  2 +-
 tests/xfs/292     |  4 ++--
 tests/xfs/299     |  4 ++--
 tests/xfs/335     |  2 +-
 tests/xfs/336     |  2 +-
 tests/xfs/337     |  2 +-
 tests/xfs/341     |  2 +-
 tests/xfs/342     |  2 +-
 tests/xfs/443     |  2 +-
 tests/xfs/448     |  2 +-
 tests/xfs/490     |  2 +-
 tests/xfs/502     |  2 +-
 tests/xfs/513     |  2 +-
 tests/xfs/530     |  2 +-
 tests/xfs/533     |  2 +-
 64 files changed, 135 insertions(+), 139 deletions(-)

-- 
2.34.1


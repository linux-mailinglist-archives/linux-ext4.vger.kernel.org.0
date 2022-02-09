Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FBE4AF1BC
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 13:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiBIMeH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 07:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiBIMeG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 07:34:06 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 04:34:10 PST
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1057DC0613CA;
        Wed,  9 Feb 2022 04:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644410049; x=1675946049;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=48PiMc7tS+uhyadGRCXdVN/7TsrSH6CeIxMbS1nuv/4=;
  b=YSwLI1SSD+bU9HJCGBB2jtKQ8OtswOLx16DmmuvtVb82khuo7Pkvzpsx
   VioRL0p9+CIAguKmEXuwu5E4UYTj6ndLYfkssGMQw3K08QLxhpvD29LVK
   KkRXAfY9BXOQeAtJu4SKV+80EE2ljqg6g7BhedMRUWLmx4pPVZD/FY1Ys
   oQ7rN305THIRhs2QkpgBjd1g8lKypYijmQHDr3GTo2M1Nv0OxoPMqaV5s
   ZQMqLiy6UUPtQ962KnzNFE1GSZlCSxoo9Xro2KMLZgITxDDlAam1dTNTW
   U1Fq9wOATTq8R9LtBzbhR/4zqVFh8zMWoqUCET6eT/93OsFoU5tJUun29
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,355,1635177600"; 
   d="scan'208";a="197322991"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 20:33:05 +0800
IronPort-SDR: 8b37qy//8WlPxCjG9uNltytZZ+g976mf+fdtkszmA6aNDpvA295Tae9CNS4yMVvPwSR+gMKf/f
 tkFXZf9qY9kjMRaNXG8oIWsNUMK0u4GlRaEv4LIjoArJHfb0StWbQMDELdKZ0reH4RrYlC7EoP
 qNgTvqPedpERz806Kjuefdwx85fKfkCVAPEWZLdJhSDGrNouTkuzEMKTOWpgTi+rsFExjAf3Lt
 /RO1LhaLqrTDFYstioKUbMa/Th4bGLwM+zJDpymN77MA65OZv7tVwylgHXIWDXcg39C/cDqPvs
 hQl2iQnqdhSGr2XeCBRJY2V5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:04:55 -0800
IronPort-SDR: RtNunWEvnoR1A15hq9F2kEkvXhqDaCXxAmBpgts/HqWXl1b2/KlKWCVWMs7I6B77iM88/p4kBX
 hHZ1CRJebCHZqShbrC2CRykl74vupc8vPYrFdBUv7ld5PEoF4sjZjN1IZ4O3tRKdbJJUin8kz0
 gL16MxlF+n0WojcUcZucOiG15Gw7o4qjldQ2S61RAMG8BE29QDqBnX8mO1N3oeZ77xwjseCGJa
 9J0vA/YvHYAUmijMHnIa3JzjFACLUH9RqCM1AFza9tHk2MLbESd41SXS+cII1ADcUjWcyendZn
 MF8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2022 04:33:06 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 0/6] fstests: fix _scratch_mkfs_sized failure handling
Date:   Wed,  9 Feb 2022 21:32:59 +0900
Message-Id: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
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

The second cause is unnecessary call of the _scratch_mkfs helper function in the
test case generic/204. This helper function is called to obtain data block size
and i-node size. However, these numbers can be obtained from _scratch_mkfs_sized
call. The _scratch_mkfs function call shall be removed.

The third cause is no check of return code from _scratch_mkfs_sized. The test
case generic/204 calls both _scratch_mkfs and _scratch_mkfs_sized, and does not
check return code from them. If _scratch_mkfs succeeds and _scratch_mkfs_sized
fails, the scratch device still has valid filesystem created by _scratch_mkfs.
Following test workload can be executed without failure, but the filesystem
does not have the size specified for _scratch_mkfs_sized. The return code of
_scratch_mkfs_sized shall be checked to catch the mkfs failure. This problem
exists not only in generic/204, but also in other test cases which call both
_scratch_mkfs and _scratch_mkfs_sized.

In this series, the first patch addresses the first cause, and the second patch
addresses the second cause. These two patches fix the test case generic/204.
Following three patches address the third cause, and fix other test cases than
generic/204.

The last patch is an additional clean up of the helper function _filter_mkfs.
During this fix work, it was misunderstood that this function were xfs unique.
To clarify it can be extended to other filesystems, factor out xfs unique part.

Changes from v1:
* Added 2nd patch which removes _scratch_mkfs call from generic/204
* Added 6th patch which factors out xfs unique part from _filter_mkfs
* Dropped 3 patches which had renamed _filter_mkfs to _xfs_filter_mkfs
* Dropped generic/204 hunk from the 3rd patch

Shin'ichiro Kawasaki (6):
  common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
  generic/204: remove unnecessary _scratch_mkfs call
  generic/{171,172,173,174}: check _scratch_mkfs_sized return code
  ext4/021: check _scratch_mkfs_sized return code
  xfs/015: check _scratch_mkfs_sized return code
  common: factor out xfs unique part from _filter_mkfs

 common/filter     | 40 +---------------------------------------
 common/rc         |  8 ++++----
 common/xfs        | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/ext4/021    |  2 +-
 tests/generic/171 |  2 +-
 tests/generic/172 |  2 +-
 tests/generic/173 |  2 +-
 tests/generic/174 |  2 +-
 tests/generic/204 |  6 +-----
 tests/xfs/015     |  2 +-
 10 files changed, 53 insertions(+), 54 deletions(-)

-- 
2.34.1


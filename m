Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5934BB349
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Feb 2022 08:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiBRHcP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Feb 2022 02:32:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiBRHcP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Feb 2022 02:32:15 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C5286B6C;
        Thu, 17 Feb 2022 23:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645169518; x=1676705518;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L5qG7WSQJfsABVKF3+2PBPN2helzTLq3M2i7k7vgfWA=;
  b=rZiAQHUfx2223wz50O96oHt+7qkdQobjD7UmOa7ZWfefLod9MffuoIAX
   a7w/C6QVgPs1uWlrM1vuMInINgzglpG1Zipp+7/ijwC0ftTYCfBLxnmRB
   J6rhpBKu/s9j2DYVnqpA7kL2V8hFR4bTe5Nggp7JKFRFrAOxzMfI3YSeZ
   NT7h0+DegW8n781yAqyrWGoTg3qOKwj23yl8SsQ6eTURIx35/5cFzs1QL
   havrNReBVb3jsHyZ4HoGgIzX/i/ONnC0Xbp4gZaqB+xDbET9qC2Njq3Dw
   VpyMIQhzjU8EV0jU9TTds+9FQJrLBl74ABLwum23H/QHO6jUtUtVCjuud
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,378,1635177600"; 
   d="scan'208";a="193264885"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2022 15:31:58 +0800
IronPort-SDR: NGyccFi4NHIARxFYA0FM69RXdBpv8+WoIyeUAgQvmbyG7aaYgQDqpitAuaDFjrQVWvZg4GdnY+
 ybc3SNYrxJqSMnXnF5qOoJDXzGMNd5A91e0UbpoK4RGtBgCKpK+UJgK7OOvqnVILULHOWGnHcd
 75WTi8IRPXF8rUMNVS+B5jztELA9LwhMeqELcHGY6BARko+yhKqd5vU6mo1uNeYVhAgQmZ7nYD
 YWHwzVzi5rFdbAjMkxTB8Pxs8f1r7yek70xj++MmVJSV2ft0QJsHtMVAoSfE78NWFoy4fGIjj9
 zBJyMAUzT56FbX9RI1kZW1Ty
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 23:04:43 -0800
IronPort-SDR: 8e9tHaoanCXVmLbFSUTIO4CQtR8DYahbvHrJndF2e7wOfGUDV7BP92r8iIJjcGiZI+3nK2BOxH
 /Tkke6Iz6OMQJ+SqvP0uB0krxF0PAJidGmyLPlfb8A3hU0M1Z8e8r1p+39hNMeaMc87+wzp5Kz
 nclqpdW2E4wup7bkVSXHYybuhO4UVq2vfKURraRWPJ9AmLGJoB1yazFwPFl3WHZvphquO4v7l0
 8No4FwLRgXonRKNTv2IeLAXb6Ap/8hgX+4ZeKpuZzLmxC61z+vkhh0OqKj/C6CUQyAi4fp7PMr
 4ds=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Feb 2022 23:31:58 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3 0/6] fstests: fix _scratch_mkfs_sized failure handling
Date:   Fri, 18 Feb 2022 16:31:50 +0900
Message-Id: <20220218073156.2179803-1-shinichiro.kawasaki@wdc.com>
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

Changes from v2:
* Added Reviewed-by tags

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


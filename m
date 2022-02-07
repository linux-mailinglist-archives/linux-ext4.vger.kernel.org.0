Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C04AB5BF
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 08:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiBGHPL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 02:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238449AbiBGG4t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 01:56:49 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54309C043181;
        Sun,  6 Feb 2022 22:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644217009; x=1675753009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqFAptI4CAvK6M8wR+plx0XzaNREix5nWvG4orfRMAg=;
  b=SIq6/T+JoZShEbAkQdqJFxjnvH6upGztAaGudqDyfUY2xg1eZTx9ZdjL
   r0Vcp9YW0AytAVzyrlYVMMkgDDu9rfpKoCPGo7OQHuhqhsLPZnmU6XDkB
   L+zCHKxYjRdMFYt+3viXYSKZAlKMX1giK8MCXusaYHM0L/DxvCylMjihf
   0zy4gXnYhOfFq/QytwnmxWcr76gZFyv1vN+CeiftB16d0GKXylsRG8EJA
   Wlud065/gZn/u/yarzM8T3MMoLMEX19ghLJqQU+PdV+OtmDqfuSwrzY/Y
   DFUuAE2qxxnrHYavaAVvhQqFqC6sk7VIj2IYWNYbpOgcyYdvxjCejyyso
   A==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635177600"; 
   d="scan'208";a="192305059"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 14:55:46 +0800
IronPort-SDR: Ogu9eFOyBtg9dM6EsmEJAQVPIZxWwTlEWDq8aR6bJLyHxQPyx6S5wpqZiXuVZz5gCks5KQizTI
 xK0SPj/lvtkaadNLDETbX6EMGyv5jrdvEwjVTLBcHWWnuxGLa5M1DWzhRspiD4hqCZ7ZJmhqKA
 y9E2Ix6PRpzTvqo1z7Yot3Q0raSNY7w3hZ/Y/50BYaZfEIIxqjnVvHHvMPuljyNByWGsdtRgBN
 m/yex7j3NjgODPN23en4Lfjk5QFIWPgKdpZPva/nA1HGZZ7mu6wbu+7XlM29fA0o77oTgzk7f8
 Zfwo2yl/1iLoNjPs9cQkfMKD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:28:48 -0800
IronPort-SDR: 7rp953d7QjEFNKLqgIeM3C8qjiiemF4hvgK0BB+vqRPd2D0tvrzCj4GySzcfK3s/k2xLDs/DLr
 H4bFH1Kze61TgAZdKyKVCZYvLuvbyQuPKt4TKazw0F5hPc94koKnsXP1igH9/dneEA2S0NUghG
 7kzZODIulF2osHtXH6vDK4vemqWEjjc/GrVJ8x0ECOAiuEPukD7r8PUafasNNW1AVy4ILg8Rh5
 iBhYWfq61Vz05rYIcHI1pBoUn7BJd/b2z4XN79NKZ0SpJuLO55FsLvjn5b5aIPdOoLHE2j9jcb
 ECU=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 22:55:46 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 3/7] ext4/021: check _scratch_mkfs_sized return code
Date:   Mon,  7 Feb 2022 15:55:37 +0900
Message-Id: <20220207065541.232685-4-shinichiro.kawasaki@wdc.com>
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


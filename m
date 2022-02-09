Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BEC4AF1C0
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 13:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiBIMeM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 07:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiBIMeH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 07:34:07 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28761C05CB96;
        Wed,  9 Feb 2022 04:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644410050; x=1675946050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUe9FJuEf7BWKrxSIxqPYK0eG0nCVdO3BScCuHtRrAI=;
  b=mkGoSj8+sfXYSdt6PZStHKyA1AwzszXeK+PGJB6zS4GHaV8fotLq5RqM
   wkIQmbbAi27ulLVzT8BvlgRXx48sphGz4sC6GCI3evq6o6H/YuxBFQpbX
   +sbYT13qHfqJa+tildjsCyjmzH74rP454pQqpqvYQq9oY/PVKbyYDF8OZ
   ztweHqv1Oc4Ods8jrieZF02jQFIdEWDpQiFb9ZxvQrX7pvlPcYf68JCZ6
   f+YID5Xjsv5JmW+i0Tqgh6Q9fD+o1YY23TMxMsO/js3zhObnoKOrxNIqj
   /jot5ivPQ9FPCIUaLgTIlQTYcx6E7XaeZspf+vRWC/yRinXMkymvvfkfb
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,355,1635177600"; 
   d="scan'208";a="197322995"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 20:33:06 +0800
IronPort-SDR: UKvnn3t/y3EyLzUMId9SnrRlcDZ8vkfLzFAwIvs2wkTigLovNtQZQzTfWmQ1EJkS9xmqahydkK
 vAz1XVO/UZs/04nCjle7dGZWB1p3rzpgKHZAA8unq+gWLkNWBZJre+hK5aqYI+j4wghRJGSyPi
 ocTG1vQqyiNX7rGt3id+2r1q9rqWJu1xq2GI/GnM5XIVt60xKmMWAKwIahrbRXRaZIT3BVKPiL
 hkv+gAAylKO7H6sfoXm1kl/3w2DnTT57y5CJA4P2fD0Ynq07jXTJ3eyppwGA4CzoC+5TUchKWD
 l4QKVEAUpEz+KZR5NmVoCF9J
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:04:56 -0800
IronPort-SDR: vAiN5QyjjjKejAtdG4aNSJlQ6OOVQ7nxR2T5oGBTNi3VGK0TIN+Egcj7/3qS3mJpa/jbuxURfF
 vb2aVZTxwMlitQ+vFQUeixI2NGrwuP0JPru+f3vB8+626QCflo3YVd/so7/cvKLaT/KGNNGbB0
 Vt1OU/EbWoaEA+s04mu2ugRJPPdz2XW7+/fU8KGIqzjn3WJi4tidut9M3c7nPd9dsfIMGCzBpc
 xRuzR/BM2IIju0FH3crAD3ev0g3hLvNJQZzholK7eJ8psnP/4zCy+B+JxPurRV9RmZL867zRWO
 9f8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2022 04:33:07 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 1/6] common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
Date:   Wed,  9 Feb 2022 21:33:00 +0900
Message-Id: <20220209123305.253038-2-shinichiro.kawasaki@wdc.com>
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

The helper function _scratch_mkfs_sized needs a couple of improvements
for btrfs. At first, the function adds --mixed option to mkfs.btrfs when
the filesystem size is smaller then 256MiB, but this threshold is no
longer correct and it should be 109MiB. Secondly, the --mixed option
shall not be specified to mkfs.btrfs for zoned devices, since zoned
devices does not allow mixing metadata blocks and data blocks.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index b3289de9..eb2493d1 100644
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


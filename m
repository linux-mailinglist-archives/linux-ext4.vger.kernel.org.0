Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0684AB5A4
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 08:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiBGHPq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 02:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiBGG4v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 01:56:51 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58744C043181;
        Sun,  6 Feb 2022 22:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644217010; x=1675753010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgEGgT9hg08/vaCtBuyGS4ntdQzvuj9kMy+3OGsW+xU=;
  b=UNBWiQb0iYjf5uB9pqzP8Kgkm6F/ezPGtFNVGJpwRjU3sIKHGXvS0ORx
   JCIfT5ldoyqchXfiMO6JVnLat4hYGtJ6YBrVkYXqlq95l1iBstl9Pv33v
   oOEW+wgdzTdorxsUFDHoTBC0aJo0QSAPrQ5i7s16K1/oKbUaxieOdYZny
   ev6QU0rSgMiPpXZbSicQeAZLnPgjsi4XcTNuleEc9EJK7xYCN45z5CdlF
   7Fqr4Vgi19bt+/Mjpoqj7cfb02Mx8n15VadZvTpQ7crzA1JHCTuA2w/Bo
   S9ekVXV17vujGLseZWBv2W+CnXxNgAWyLC5WJSy9RDa6jPDWI0KROGCf9
   g==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635177600"; 
   d="scan'208";a="192305061"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 14:55:47 +0800
IronPort-SDR: /aB4ytln02CZUgc4RubdiLHgmyiTerkBvl3wKKHIS/iafNJSyvjCzF3gbxScKYjgoz9WJxwcrt
 cdpSQZU4VzhKMw+FoeEc1LbqCxI997cV7B2N0Hm4/1XEr0F24x0qqJ5Mda+R7ovIyC76p1hQ5C
 1nqUW1Yd6OU93zQRiDHvZn3L2bLmA32FxVKrflpWNuLO/ZWbuShSNGsa8csmXJgW/U6xuoHao+
 3tIG3TsXzMNIpHsUYgpqpd0Oo/ASrVjSB+W29QE9uoDSVJBIQOOWLtIVMj/5Cew6U2zDKl147t
 EcgtyBbVIblc1+k1+QkkfsIA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:28:49 -0800
IronPort-SDR: +GbqTEDv8vqwEHFBI0kG4ad3Y+S7Hkd8lx5ZIIeer2eJHlutG2M+lJ3kSTuSfsxJtkG3ytazEC
 dDWxeRsclxFGn8gYTom9BCeIRR4tkrYiFwcco5mtjU6nGqTb5Na5uy6ZbHToe58yn7nTaksZ6l
 N5RF4//CEMvGc9BMyv5W/67hyeOurydyKXXv0ZCz8OxqQ3sIA5Zn5cyu6D5kJOEMBcdOqSa48F
 HhjVVlc1M8P8KU1nhHiCQIuKUqh5Ov9OJ4OdefCHaL60A3SwhQ/1rbAXkDOvVuQcMTrV5fdZJ1
 Gyc=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 22:55:48 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 4/7] xfs/015: check _scratch_mkfs_sized return code
Date:   Mon,  7 Feb 2022 15:55:38 +0900
Message-Id: <20220207065541.232685-5-shinichiro.kawasaki@wdc.com>
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

The test cases xfs/015 calls _scratch_mkfs before _scratch_mkfs_sized,
and does not check return code of _scratch_mkfs_sized. Even if
_scratch_mkfs_sized failed, _scratch_mount after it cannot detect the
sized mkfs failure because _scratch_mkfs already created a file system
on the device. This results in unexpected test condition.

To avoid the unexpected test condition, check return code of
_scratch_mkfs_sized.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
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


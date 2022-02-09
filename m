Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755CB4AF1CB
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 13:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiBIMeX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 07:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiBIMeQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 07:34:16 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B859C05CB9E;
        Wed,  9 Feb 2022 04:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644410059; x=1675946059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oNwFFRRH3apj/4n7qSFchUH8rbWyk695r1onG5cIzSI=;
  b=bpJS04HnYId9GobZQ9+wV79wMHcVvTqoAWPwI0ok40UQ09l+ytQUPqSD
   7fYNyjp7VM72OQ26FXDPBfCzGrsg111MGNLGu75bGNQQwkI3j9E+uIV2+
   5e3wkmVksUeVMhKPefx89a1JuutLL1xqxXVwQFobF17xuEkuip6VIJKYy
   l8cG+urUuSBb7KV82B+mt8yT5hvjPItWs1m+z9eMKKvJ/O75U1A1OM1Qn
   yAu+epTlRfc2ABYZ8j1uZUGX4z1ZtysgygJNcuWFZmdPtgqCaa6eJTCBP
   nKlETLOssGHxi82RL5tCYOIMKVHAzG1Ikl32EG1+j5Gw7Gp9kMLNroOBM
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,355,1635177600"; 
   d="scan'208";a="197323005"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 20:33:12 +0800
IronPort-SDR: ypOjbzajne+u+VcZtk2YgVFlV/9FztTVmVZBdGrhM9WRzyntr7YsE53m+TwXm+qD0ditlhQuYd
 OR+PIx6LM/aw1aVzwm55dysUnjgEGeUW4q52XYsGA887JlyH9G9Ds27pw+n+/HNs3vaNZ3kTc8
 7Mp0ArapH3+fG1vGrp+CQZSxYbyHQNV611wnHeF46hDgtWjV8OHuMHEY9NtW2FNdLE3pgRq1qf
 PjWbHWlhTlYk3G5nPz/v6Xw87AtpArob8d9t2LOy1W4a2VrNKpKhf/fjVdHNsUP4ivT5R5tiKy
 bcbDBAcsNVU7TkrPMhAXdE/9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:05:02 -0800
IronPort-SDR: HdPriuEKVhWsCgCMJH7nM3u0NNBHMW4LdTwQRup3PhxoOSboYk5/ZH42P9eGibQOPOZTmhxnrQ
 OLotWoFkTD5ZUzvrdFsNhXMH+alx/vYgbVt6EHvjwCT+UWmy8j6AjnSEAZJp6+Vw5KBD+3LGYX
 yxy3n8JG1zepbuigMyXqTdJ6BDn5IfCAnmfw/2TZVCiSkX1ej9pav8NEzYdedgLojkMCetSLSd
 JtSsF2A7iehXr3DlI8nx4rBrujJXk6WUFW/K/Q+jvsLu+W7V2KpmcrXFy3ifJIpA5dG+Vw6kY6
 lu8=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2022 04:33:13 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 5/6] xfs/015: check _scratch_mkfs_sized return code
Date:   Wed,  9 Feb 2022 21:33:04 +0900
Message-Id: <20220209123305.253038-6-shinichiro.kawasaki@wdc.com>
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

The test cases xfs/015 calls _scratch_mkfs before _scratch_mkfs_sized,
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


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9784AB5AC
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 08:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiBGHPt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 02:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiBGG45 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 01:56:57 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA0C043184;
        Sun,  6 Feb 2022 22:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644217015; x=1675753015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=78Zs28KpKxQ8bPUPZ5jK1PRmnWo6oej03te2uWqoGL8=;
  b=LvJJWJD1fiCvDKTxHbtlVXSoTOLhD9SQgFNpO7+NMRUwRjxVq4DidYtX
   jKBOsI8plwoNyNrg4MLxPr8IZgzI+8ow4UKlGsBD26vciiqpp48oO4WL6
   kClafmIZAlEK++btL8P94XHEW9g6dAtIjbBUshLd3bQPtwhLywMPSyfPf
   M4cwZ8HUcWOafGStVFr78oJv28dH8fEroHCbgcdP4lKr9x5qehII/o9ov
   m82XHTNnEhjGzAdT6RCw5kQAARW36SyGB9LhAfp1N3E2lUQXfacnBaUIE
   zK2kLmGSMVOq5JqtfhC3vnWbNrbcFlTEJZMNDz6+VYNMLrhy6+ZjHkJn2
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,349,1635177600"; 
   d="scan'208";a="192305071"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 14:55:51 +0800
IronPort-SDR: EMJgNkMWnFfkl8IJ5MjTea6OkFCwZjeZTatf/gXYHTpkC9JCNzxI4Ha6HvoqCtZ4xswEKbqj23
 gOkPz2nrGws7WoeU84Ba5ndNmcRQqxez8XGl38Q3wMbaCcbhvK7U7kgUPGXvfVQT3OU8zVGkvO
 Re8BSBoABIx7Em0DZKffm+AlAYPibJS4mEvXLkfGHeCGsc4ImWz9nihNxL3NPVNsyw/2tsavNG
 X1dy/r/qsBmay03a6U62wNrOpVl7Z/gc+Xc7fKnPgPoPMlSGxEkFC9my4To9AtZp0xqY5yTJr1
 GiBn0nosIprTflDJEDTmFNId
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:28:53 -0800
IronPort-SDR: GMWIEtGmlMxmFLTe4Rb5AN6uU0cHMtnWRJhC+waZTS9hy7Au4NwNulNQZKvFrvlN26Xo4IMdDy
 MfstK1BTqaJG3JE0Eu8p5GKbtah5dU+1qYVVwMLFrITB+N+ppNtF/diabefS9ifyGhcv8wKFy2
 kWd7KpVTJFwYJX4ZSmHIPN4nQF/VAeh6VvJtM1lCoMgCOGfqp77sq1Npd81CHy5mbf7ZL2pQEo
 HPOHRLUN1bRh9lA+pJ/jQdFRBUYrK4NUM8jW33EdxY6zfw3+rgV2ZNqY6mMX6sKyH4EDURkSQ6
 gyA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Feb 2022 22:55:52 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 7/7] generic/204: do xfs unique preparation only for xfs
Date:   Mon,  7 Feb 2022 15:55:41 +0900
Message-Id: <20220207065541.232685-8-shinichiro.kawasaki@wdc.com>
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

The test case generic/204 formats the scratch device to get block size
as a part of preparation. However, this preparation is required only for
xfs. To simplify preparation for other filesystems, do the preparation
only for xfs.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/generic/204 | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tests/generic/204 b/tests/generic/204
index 40d524d1..ea267760 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -16,17 +16,18 @@ _cleanup()
 	sync
 }
 
-# Import common functions.
-. ./common/filter
-
 # real QA test starts here
 _supported_fs generic
 
 _require_scratch
 
-# get the block size first
-_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
-. $tmp.mkfs
+dbsize=4096
+isize=256
+if [ $FSTYP = "xfs" ]; then
+	# get the block size first
+	_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
+	. $tmp.mkfs
+fi
 
 # For xfs, we need to handle the different default log sizes that different
 # versions of mkfs create. All should be valid with a 16MB log, so use that.
@@ -37,11 +38,15 @@ _scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
 SIZE=`expr 115 \* 1024 \* 1024`
 _scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
 	|| _fail "mkfs failed"
-cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
+
+if [ $FSTYP = "xfs" ]; then
+	cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
+	# Source $tmp.mkfs to get geometry
+	. $tmp.mkfs
+fi
+
 _scratch_mount
 
-# Source $tmp.mkfs to get geometry
-. $tmp.mkfs
 
 # fix the reserve block pool to a known size so that the enospc calculations
 # work out correctly. Space usages is based 22500 files and 1024 reserved blocks
-- 
2.34.1


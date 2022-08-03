Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FDF588644
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 06:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiHCEWC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 00:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiHCEV7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 00:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA95466A;
        Tue,  2 Aug 2022 21:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F97661248;
        Wed,  3 Aug 2022 04:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93A1C433C1;
        Wed,  3 Aug 2022 04:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659500517;
        bh=3uAwmeySBlqJ5bpC+m+eSKAg6CfcTUSV/7/H5638fxw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dmMVwjjCZibKyIF8mJ4hj3V53X6V1M1RTAT9PJaLZo9LUAeuQ5LeMrdM8NPrn67sv
         TkLxCZNzuKElvzMehS/nQL+DhoI5/fftXi1PDeDDvi7D9CO6kGaLYsva3lY4RH0c04
         Ck+jvJvZPlBuJ7qrBU/66SYDGnv1VgfVIwS0MRv5hoy8ZLOO98fektyDG6qZImEhqN
         U6SN/KDIcKxV9u6Jg+k0LFXZduw+AT+OAXqRyBGJQEsAuu9e3b1NcsIA3lzPftVAVJ
         iIiVX1mZ59sppwTukaxpzcvEqIaaKbEACAMI4ZZqqd1JHtwXpwvkqL1X96I2oJleXd
         D04Ormtvwa2RQ==
Subject: [PATCH 3/3] common/ext4: provide custom ext4 scratch fs options
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, guaneryu@gmail.com, zlang@redhat.com
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Date:   Tue, 02 Aug 2022 21:21:57 -0700
Message-ID: <165950051745.198922.6487109955066878945.stgit@magnolia>
In-Reply-To: <165950050051.198922.13423077997881086438.stgit@magnolia>
References: <165950050051.198922.13423077997881086438.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Create a _scratch_options backend for ext* so that we can inject
pathnames to external log devices into the scratch fs mount options.
This enables common/dm* to install block device filters, e.g. dm-error
for stress testing.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 common/ext4 |   20 ++++++++++++++++++++
 common/rc   |    3 +++
 2 files changed, 23 insertions(+)


diff --git a/common/ext4 b/common/ext4
index 287705af..819f9786 100644
--- a/common/ext4
+++ b/common/ext4
@@ -154,3 +154,23 @@ _require_scratch_richacl_ext4()
 		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
 	_scratch_unmount
 }
+
+_scratch_ext4_options()
+{
+    local type=$1
+    local log_opt=""
+
+    case $type in
+    mkfs)
+        log_opt="-J device=$SCRATCH_LOGDEV"
+	;;
+    mount)
+	# As of kernel 5.19, the kernel mount option path parser only accepts
+	# direct paths to block devices--the final path component cannot be a
+	# symlink.
+        log_opt="-o journal_path=$(realpath $SCRATCH_LOGDEV)"
+	;;
+    esac
+    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
+	SCRATCH_OPTIONS="$SCRATCH_OPTIONS ${log_opt}"
+}
diff --git a/common/rc b/common/rc
index dc1d65c3..b82bb36b 100644
--- a/common/rc
+++ b/common/rc
@@ -178,6 +178,9 @@ _scratch_options()
     "xfs")
 	_scratch_xfs_options "$@"
 	;;
+    ext2|ext3|ext4|ext4dev)
+	_scratch_ext4_options "$@"
+	;;
     esac
 }
 


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23620588642
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 06:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiHCEV6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 00:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiHCEVx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 00:21:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3054AC1;
        Tue,  2 Aug 2022 21:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2469612E4;
        Wed,  3 Aug 2022 04:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F854C43140;
        Wed,  3 Aug 2022 04:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659500512;
        bh=bnN3+rr2Irc5hVunotTz6N7Asyuu/jHCPgME80PdV/0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mQA/70NoWex0FQGV7kcdlHEdQO/GM5DUyzVLgARuUxP4aUkktgtBCAYrEaj/Oo8f7
         ONviVRbfNUT2yZjRpch2XBIfeS5HhUGoR7BoRFm31epxdjER17DtAxi2Vs4JUZHrsQ
         I0oo5UKKYq3mNMH9F3tCgFxkWi4KiqkJT3rnT+dHIaXhuhdbmu70tF60tS9Tau50Gm
         XkyTDQS98vGK581zo0wk2aQmTg/dh1W63kDEDqLtQu79W50m7saRD07WpTyUfBB4iW
         /HZNumJyTL/s/LBsvpF6tkSRSZyf778l29cEQGcg69bjzX6il0bmYiYVnoZ3M3egbl
         u0E2R/lMXHHXw==
Subject: [PATCH 2/3] common/rc: move XFS-specific parts of _scratch_options
 into common/xfs
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, guaneryu@gmail.com, zlang@redhat.com
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Date:   Tue, 02 Aug 2022 21:21:51 -0700
Message-ID: <165950051183.198922.10544333892197894472.stgit@magnolia>
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

Move all the non-XFS code in _scratch_options into a
_scratch_xfs_options helper in common/xfs, in preparation to add ext4
bits.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 common/rc  |   23 +++--------------------
 common/xfs |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 20 deletions(-)


diff --git a/common/rc b/common/rc
index 52dd3b41..dc1d65c3 100644
--- a/common/rc
+++ b/common/rc
@@ -172,30 +172,13 @@ _clear_mount_stack()
 
 _scratch_options()
 {
-    local type=$1
-    local rt_opt=""
-    local log_opt=""
     SCRATCH_OPTIONS=""
 
-    if [ "$FSTYP" != "xfs" ]; then
-        return
-    fi
-
-    case $type in
-    mkfs)
-	SCRATCH_OPTIONS="$SCRATCH_OPTIONS -f"
-	rt_opt="-r"
-        log_opt="-l"
-	;;
-    mount)
-	rt_opt="-o"
-        log_opt="-o"
+    case "$FSTYP" in
+    "xfs")
+	_scratch_xfs_options "$@"
 	;;
     esac
-    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ] && \
-	SCRATCH_OPTIONS="$SCRATCH_OPTIONS ${rt_opt}rtdev=$SCRATCH_RTDEV"
-    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
-	SCRATCH_OPTIONS="$SCRATCH_OPTIONS ${log_opt}logdev=$SCRATCH_LOGDEV"
 }
 
 _test_options()
diff --git a/common/xfs b/common/xfs
index 9f84dffb..f6f4cdd2 100644
--- a/common/xfs
+++ b/common/xfs
@@ -265,6 +265,29 @@ _xfs_check()
 	return $status
 }
 
+_scratch_xfs_options()
+{
+    local type=$1
+    local rt_opt=""
+    local log_opt=""
+
+    case $type in
+    mkfs)
+	SCRATCH_OPTIONS="$SCRATCH_OPTIONS -f"
+	rt_opt="-r"
+        log_opt="-l"
+	;;
+    mount)
+	rt_opt="-o"
+        log_opt="-o"
+	;;
+    esac
+    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ] && \
+	SCRATCH_OPTIONS="$SCRATCH_OPTIONS ${rt_opt}rtdev=$SCRATCH_RTDEV"
+    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
+	SCRATCH_OPTIONS="$SCRATCH_OPTIONS ${log_opt}logdev=$SCRATCH_LOGDEV"
+}
+
 _scratch_xfs_db_options()
 {
 	SCRATCH_OPTIONS=""


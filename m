Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3335E58E16C
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 23:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiHIVBt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 17:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiHIVA5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 17:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471BB2C659;
        Tue,  9 Aug 2022 14:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71F1A60B9F;
        Tue,  9 Aug 2022 21:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2ABC433D6;
        Tue,  9 Aug 2022 21:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660078852;
        bh=bnN3+rr2Irc5hVunotTz6N7Asyuu/jHCPgME80PdV/0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EwdEeAVmeLmhyGUN7Dyi9mf7JE4cvsQdlP1QcGfNpm57tI/1sMIpvx3/hig7GwxOe
         Xv9D4YS8pVp2oqD+ttJfylYfaj97ZalB+rcSO3lVbTGzyMZu1F55sDAZ7E8md5AVam
         +qvP5G1VJFtv0EgLROX2sElULWT1aQdZj03zzEGWFuWmH1oLqPtUYJVwkra4giWAHM
         pqaZps2YERmd+GBrHc0kb4rpNLc6TJsF3hkvsYHQ8HuZ/0OKJHEFs4y4AKQqwtEeP0
         tLV/L/UHJbsGRrkv7bzgIYyqSRpETmXnQ9G8TuZYXcZ1pq8wtstKEaV5q+Nmd1J/1R
         5ZypLORPVytfA==
Subject: [PATCH 2/3] common/rc: move XFS-specific parts of _scratch_options
 into common/xfs
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, guaneryu@gmail.com, zlang@redhat.com
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Date:   Tue, 09 Aug 2022 14:00:52 -0700
Message-ID: <166007885241.3276300.13584305054616588936.stgit@magnolia>
In-Reply-To: <166007884125.3276300.15348421560641051945.stgit@magnolia>
References: <166007884125.3276300.15348421560641051945.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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


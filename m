Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11DC58954B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 02:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiHDAZO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 20:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiHDAZO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 20:25:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0679B52;
        Wed,  3 Aug 2022 17:25:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C99B61737;
        Thu,  4 Aug 2022 00:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88FDC433D6;
        Thu,  4 Aug 2022 00:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659572711;
        bh=kqKZ7ISpCOBkkf9SIOPno19SY8z+jeRc+EusXoBgFgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0zK5xCZh1z2AWHnjsB8hd9Vaa1oXPh+RkQWeXSRJzjy8gHy5X+pilsNL6+VHf8zG
         LI8lyn8NmmWsUskgL6VxHGzk1BMOjk8cd2/U9w0Fs2EkozH5hfM7MgzWQTnY89Y8dM
         BqqLFzcH4Y87m+UI+JEqXXof/E8h7POS03yOcLgSbcnabewtlNvppvs4kJPVu9NWRK
         /mTWSEY2rVnENtROP4cOKi2j3j1WhyQITMT2KJgj+jZVc/5QGQTYbLrWvAQr9A6AgV
         9DiyBXr8Ew8wuC0Q1mG++3+UHop9E/g/4SsOLaKzsrXwbMwZGCtK5FbfM8AqYAxdPb
         wmqexXhwKlj4g==
Date:   Wed, 3 Aug 2022 17:25:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     guaneryu@gmail.com, zlang@redhat.com
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: [PATCH v1.2 3/3] common/ext4: provide custom ext4 scratch fs options
Message-ID: <YusR5ww7Y4+/HXTt@magnolia>
References: <165950050051.198922.13423077997881086438.stgit@magnolia>
 <165950051745.198922.6487109955066878945.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165950051745.198922.6487109955066878945.stgit@magnolia>
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
v1.2: refactor _scratch_mkfs_ext4 to use _scratch_options too
---
 common/ext4 |   34 +++++++++++++++++++++++++++++++---
 common/rc   |    3 +++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/common/ext4 b/common/ext4
index 287705af..8a3385af 100644
--- a/common/ext4
+++ b/common/ext4
@@ -63,16 +63,24 @@ _setup_large_ext4_fs()
 	return 0
 }
 
+_scratch_mkfs_ext4_opts()
+{
+	mkfs_opts=$*
+
+	_scratch_options mkfs
+
+	echo "$MKFS_EXT4_PROG -F $SCRATCH_OPTIONS $mkfs_opts"
+}
+
 _scratch_mkfs_ext4()
 {
-	local mkfs_cmd="$MKFS_EXT4_PROG -F"
+	local mkfs_cmd="`_scratch_mkfs_ext4_opts`"
 	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \" | grep -v \"^$\""
 	local tmp=`mktemp -u`
 	local mkfs_status
 
 	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
-	    $mkfs_cmd -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV && \
-	    mkfs_cmd="$mkfs_cmd -J device=$SCRATCH_LOGDEV"
+	    $MKFS_EXT4_PROG -F -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV
 
 	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
 	mkfs_status=$?
@@ -154,3 +162,23 @@ _require_scratch_richacl_ext4()
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
 

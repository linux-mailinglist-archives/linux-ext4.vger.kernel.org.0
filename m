Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B99B58E170
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 23:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiHIVBi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 17:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiHIVBN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 17:01:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C9F2CDD1;
        Tue,  9 Aug 2022 14:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2C088CE1992;
        Tue,  9 Aug 2022 21:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E461C433D6;
        Tue,  9 Aug 2022 21:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660078858;
        bh=geIKBByfTrorU3rkE/v7f37+Db363m9NvHjWmSVlf3E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SRs1zJt7J9fgIrR6UkZfysGj2GPVg9Ti1TEKZprBMm2Xkbbsi9/03qk9Od6JvNvPi
         Ye1qvMP+Fv3P51nofRu4f3+X1EMBq9DeOGnqFpE1BSAFqTqkuEvcJyASKrGE6nKte8
         nnQdbdDruVPOOEpNkTURqz+CA6yOnKo4Ov2EKRKwSz7Q2LpTdz4RaWrZfoEOJ3FRLg
         miIldHqbVTItYR5148LrExPMAo63hd/1rGX2SBx7TqdgHyq0AFiqwVBvl37h75lshE
         TMaUaJS8rMlpCTRsPpBuHDLbyB/VTIX5VV+4e9MjlGYq+fpah+Hy8wtK7IiDEsWBo6
         00KSsiS3H0XWQ==
Subject: [PATCH 3/3] common/ext4: provide custom ext4 scratch fs options
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, guaneryu@gmail.com, zlang@redhat.com
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Date:   Tue, 09 Aug 2022 14:00:58 -0700
Message-ID: <166007885800.3276300.2421777224579305613.stgit@magnolia>
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

Create a _scratch_options backend for ext* so that we can inject
pathnames to external log devices into the scratch fs mount options.
This enables common/dm* to install block device filters, e.g. dm-error
for stress testing.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 common/ext4 |   45 +++++++++++++++++++++++++++++++++++++++++----
 common/rc   |   12 +++++++++++-
 2 files changed, 52 insertions(+), 5 deletions(-)


diff --git a/common/ext4 b/common/ext4
index 287705af..f4c3c413 100644
--- a/common/ext4
+++ b/common/ext4
@@ -63,16 +63,32 @@ _setup_large_ext4_fs()
 	return 0
 }
 
+_scratch_mkfs_ext4_opts()
+{
+	mkfs_opts=$*
+
+	_scratch_options mkfs
+
+	echo "$MKFS_EXT4_PROG $SCRATCH_OPTIONS $mkfs_opts"
+}
+
 _scratch_mkfs_ext4()
 {
-	local mkfs_cmd="$MKFS_EXT4_PROG -F"
+	local mkfs_cmd="`_scratch_mkfs_ext4_opts`"
 	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \" | grep -v \"^$\""
 	local tmp=`mktemp -u`
 	local mkfs_status
 
-	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
-	    $mkfs_cmd -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV && \
-	    mkfs_cmd="$mkfs_cmd -J device=$SCRATCH_LOGDEV"
+	if [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ]; then
+		$MKFS_EXT4_PROG -F -O journal_dev $MKFS_OPTIONS $* $SCRATCH_LOGDEV 2>$tmp.mkfserr 1>$tmp.mkfsstd
+		mkjournal_status=$?
+
+		if [ $mkjournal_status -ne 0 ]; then
+			cat $tmp.mkfsstd
+			cat $tmp.mkfserr >&2
+			return $mkjournal_status
+		fi
+	fi
 
 	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
 	mkfs_status=$?
@@ -154,3 +170,24 @@ _require_scratch_richacl_ext4()
 		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
 	_scratch_unmount
 }
+
+_scratch_ext4_options()
+{
+	local type=$1
+	local log_opt=""
+
+	case $type in
+	mkfs)
+		SCRATCH_OPTIONS="$SCRATCH_OPTIONS -F"
+		log_opt="-J device=$SCRATCH_LOGDEV"
+		;;
+	mount)
+		# As of kernel 5.19, the kernel mount option path parser only
+		# accepts direct paths to block devices--the final path
+		# component cannot be a symlink.
+		log_opt="-o journal_path=$(realpath -q "$SCRATCH_LOGDEV")"
+		;;
+	esac
+	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
+		SCRATCH_OPTIONS="$SCRATCH_OPTIONS ${log_opt}"
+}
diff --git a/common/rc b/common/rc
index dc1d65c3..e20c494c 100644
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
 
@@ -964,6 +967,13 @@ _scratch_mkfs_sized()
 		fi
 		;;
 	ext2|ext3|ext4|ext4dev)
+		# Can't use _scratch_mkfs_ext4 here because the block count has
+		# to come after the device path.
+		if [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ]; then
+			${MKFS_PROG} -F -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV || \
+				_notrun "Could not make scratch logdev"
+			MKFS_OPTIONS="$MKFS_OPTIONS -J device=$SCRATCH_LOGDEV"
+		fi
 		${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
 		;;
 	gfs2)
@@ -1093,7 +1103,7 @@ _scratch_mkfs_blocksized()
 		_scratch_mkfs_xfs $MKFS_OPTIONS -b size=$blocksize
 		;;
 	ext2|ext3|ext4)
-		${MKFS_PROG} -t $FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV
+		_scratch_mkfs_ext4 $MKFS_OPTIONS -b $blocksize
 		;;
 	gfs2)
 		${MKFS_PROG} -t $FSTYP $MKFS_OPTIONS -O -b $blocksize $SCRATCH_DEV


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE5516012
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Apr 2022 21:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiD3TZW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Apr 2022 15:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiD3TZW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Apr 2022 15:25:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58AA1116F;
        Sat, 30 Apr 2022 12:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85189B807EE;
        Sat, 30 Apr 2022 19:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FD2C385AA;
        Sat, 30 Apr 2022 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651346514;
        bh=nX1uiu7ILFDh2m6ItjnZSs4OJrSqppdj7AGMW93Sbjc=;
        h=From:To:Cc:Subject:Date:From;
        b=RYu3J+EItbIUAXPJxDV2VaWoI2ED/jS/kKoTTEyDPc564hbe1lPawBWMmqMINfshO
         IHRnS3wW1UtQO5Lseqp/cmqNx9iaVwpKTTZpf7l5xX/6rW/b8uekU7ZERwvvYMb/6A
         LLdsdQcaUiMA1Cp81oXyHupxpPi4oqFiaFLG/SBPCVb1m3MZUjuRbvWYezonV9sWjZ
         wkZaJze2RZst76PfeI+COhWo/GbAD3aNXtMeIp0U0fIdj5BXi9jXOlmyF+hlSvLpr6
         p+hh/SATZ2t98L7JWiFoiQfgckpCuqHzSEBgkypQYnuNMbSX2M6ha8oKfsQj6P5FkR
         /PbsTm3vwRoGw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Subject: [xfstests PATCH] ext4/053: fix the rejected mount option testing
Date:   Sat, 30 Apr 2022 12:21:30 -0700
Message-Id: <20220430192130.131842-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

'not_mnt OPTIONS' seems to have been intended to test that the
filesystem cannot be mounted at all with the given OPTIONS, meaning that
the mount fails as opposed to the options being ignored.  However, this
doesn't actually work, as shown by the fact that the test case 'not_mnt
test_dummy_encryption=v3' is passing in the !CONFIG_FS_ENCRYPTION case.
Actually ext4 ignores this mount option when !CONFIG_FS_ENCRYPTION.
(The ext4 behavior might be changed, but that is besides the point.)

The problem is that the do_mnt() helper function is being misused in a
context where a mount failure is expected, and it does some additional
remount tests that don't make sense in that context.  So if the mount
unexpectedly succeeds, then one of these later tests can still "fail",
causing the unexpected success to be shadowed by a later failure, which
causes the overall test case to pass since it expects a failure.

Fix this by reworking not_mnt() and not_remount_noumount() to use
simple_mount() in cases where they are expecting a failure.  Also fix
up some of the naming and calling conventions to be less confusing.
Finally, make sure to test that remounting fails too, not just mounting.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/ext4/053 | 148 ++++++++++++++++++++++++++-----------------------
 1 file changed, 78 insertions(+), 70 deletions(-)

diff --git a/tests/ext4/053 b/tests/ext4/053
index e1e79592..bf6e3f6b 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -225,6 +225,9 @@ do_mnt() {
 	return $ret
 }
 
+# Test that mounting or remounting with the specified mount option(s) fails
+# (meaning that the mount or remount fails, as opposed to the mount option(s)
+# just being ignored).
 not_mnt() {
 	# We don't need -t not not_ variant
 	if [ "$1" == "-t" ]; then
@@ -232,13 +235,21 @@ not_mnt() {
 	fi
 
 	print_log "SHOULD FAIL mounting $fstype \"$1\" "
-	do_mnt $@
-	if [ $? -eq 0 ]; then
+	if simple_mount -o $1 $SCRATCH_DEV $SCRATCH_MNT; then
+		print_log "(mount unexpectedly succeeded)"
 		fail
-	else
-		ok
+		$UMOUNT_PROG $SCRATCH_MNT
+		return
 	fi
-	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
+	ok
+
+	if ! simple_mount $SCRATCH_DEV $SCRATCH_MNT; then
+		print_log "(normal mount unexpectedly failed)"
+		fail
+		return
+	fi
+	not_remount $1
+	$UMOUNT_PROG $SCRATCH_MNT
 }
 
 mnt_only() {
@@ -321,43 +332,40 @@ remount() {
 	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
 }
 
-# $1 - options to mount with, or -r argument
-# $2 - options to remount with
-not_remount_noumount() {
-	remount_only=0
-	# If -r is specified we're going to do remount only
-	if [ "$1" == "-r" ]; then
-		remount_only=1
-		# Dont need shift since first argument would
-		# have been consumed by mount anyway
-	fi
-
-	if [ $remount_only -eq 0 ]; then
-		print_log "mounting $fstype \"$1\" "
-		do_mnt $1
-		[ $? -ne 0 ] && fail && return
-	fi
-	print_log "SHOULD FAIL remounting $fstype \"$2\" "
-	do_mnt remount,$2 $3
-	if [ $? -eq 0 ]; then
+# Test that the filesystem cannot be remounted with option(s) $1 (meaning that
+# the remount fails, as opposed to the mount option(s) just being ignored).  The
+# filesystem must already be mounted, and it is not unmounted afterwards.
+not_remount() {
+	print_log "SHOULD FAIL remounting $fstype \"$1\" "
+	# Try specifying both dev and mnt.
+	if simple_mount -o remount,$1 $SCRATCH_DEV $SCRATCH_MNT; then
+		print_log "(remount unexpectedly succeeded)"
 		fail
-	else
-		ok
+		return
 	fi
+	ok
 
-	# Now just specify mnt
-	print_log "SHOULD FAIL remounting $fstype (MNT ONLY) \"$2\" "
-	do_mnt -n remount,$2 $3
-	if [ $? -eq 0 ]; then
+	# Try specifying mnt only.
+	print_log "SHOULD FAIL remounting $fstype (MNT ONLY) \"$1\" "
+	if simple_mount -o remount,$1 $SCRATCH_MNT; then
+		print_log "(remount unexpectedly succeeded)"
 		fail
-	else
-		ok
+		return
 	fi
+	ok
 }
 
-not_remount() {
-	not_remount_noumount $*
-	$UMOUNT_PROG $SCRATCH_MNT 2> /dev/null
+# Mount the filesystem with option(s) $1, then test that it cannot be remounted
+# with option(s) $2 (meaning that the remount fails, as opposed to the mount
+# option(s) just being ignored).
+mnt_then_not_remount() {
+	print_log "mounting $fstype \"$1\" "
+	if ! do_mnt $1; then
+		fail
+		return
+	fi
+	not_remount $2
+	$UMOUNT_PROG $SCRATCH_MNT
 }
 
 
@@ -514,7 +522,7 @@ for fstype in ext2 ext3 ext4; do
 		mnt test_dummy_encryption ^test_dummy_encryption
 		mnt test_dummy_encryption=v1 ^test_dummy_encryption=v1
 		mnt test_dummy_encryption=v2 ^test_dummy_encryption=v2
-		not_mnt test_dummy_encryption=v3
+		mnt test_dummy_encryption=v3 ^test_dummy_encryption=v3
 		not_mnt test_dummy_encryption=
 	fi
 
@@ -567,14 +575,14 @@ for fstype in ext2 ext3 ext4; do
 		mnt dax=never
 		mnt dax=inode
 
-		not_remount lazytime dax
-		not_remount dax=always dax=never
+		mnt_then_not_remount lazytime dax
+		mnt_then_not_remount dax=always dax=never
 
 		if [[ $fstype != "ext2" ]]; then
-			not_remount data=journal dax
-			not_remount data=journal dax=always
-			not_remount data=journal dax=never
-			not_remount data=journal dax=inode
+			mnt_then_not_remount data=journal dax
+			mnt_then_not_remount data=journal dax=always
+			mnt_then_not_remount data=journal dax=never
+			mnt_then_not_remount data=journal dax=inode
 		fi
 	fi
 
@@ -584,20 +592,20 @@ for fstype in ext2 ext3 ext4; do
 	remount usrquota usrjquota=q.u,jqfmt=vfsv0
 	remount grpquota grpjquota=q.g,jqfmt=vfsv0
 
-	not_remount usrquota grpjquota=q.g,jqfmt=vfsv0
-	not_remount grpquota usrjquota=q.u,jqfmt=vfsv0
+	mnt_then_not_remount usrquota grpjquota=q.g,jqfmt=vfsv0
+	mnt_then_not_remount grpquota usrjquota=q.u,jqfmt=vfsv0
 
 	remount quota usrjquota=q.u,jqfmt=vfsv0
-	not_remount quota grpjquota=q.g,jqfmt=vfsv0
+	mnt_then_not_remount quota grpjquota=q.g,jqfmt=vfsv0
 
 	remount usrjquota=q.u,jqfmt=vfsv0 grpjquota=q.g
-	not_remount usrjquota=q.u,jqfmt=vfsv0 usrjquota=q.ua
-	not_remount grpjquota=q.g,jqfmt=vfsv0 grpjquota=q.ga
+	mnt_then_not_remount usrjquota=q.u,jqfmt=vfsv0 usrjquota=q.ua
+	mnt_then_not_remount grpjquota=q.g,jqfmt=vfsv0 grpjquota=q.ga
 
 	remount usrjquota=q.u,jqfmt=vfsv0 usrquota usrjquota=q.u,jqfmt=vfsv0
 	remount grpjquota=q.g,jqfmt=vfsv0 grpquota grpjquota=q.g,jqfmt=vfsv0
-	not_remount usrjquota=q.u,jqfmt=vfsv0 grpquota
-	not_remount grpjquota=q.g,jqfmt=vfsv0 usrquota
+	mnt_then_not_remount usrjquota=q.u,jqfmt=vfsv0 grpquota
+	mnt_then_not_remount grpjquota=q.g,jqfmt=vfsv0 usrquota
 
 	remount grpjquota=q.g,jqfmt=vfsv0 grpjquota= ^grpjquota=
 	remount usrjquota=q.u,jqfmt=vfsv0 usrjquota= ^usrjquota=
@@ -608,12 +616,12 @@ for fstype in ext2 ext3 ext4; do
 
 	if [[ $fstype != "ext2" ]]; then
 		remount noload data=journal norecovery
-		not_remount data=journal data=ordered
-		not_remount data=journal data=writeback
-		not_remount data=ordered data=journal
-		not_remount data=ordered data=writeback
-		not_remount data=writeback data=journal
-		not_remount data=writeback data=ordered
+		mnt_then_not_remount data=journal data=ordered
+		mnt_then_not_remount data=journal data=writeback
+		mnt_then_not_remount data=ordered data=journal
+		mnt_then_not_remount data=ordered data=writeback
+		mnt_then_not_remount data=writeback data=journal
+		mnt_then_not_remount data=writeback data=ordered
 	fi
 
 	do_mkfs -O journal_dev $LOOP_LOGDEV ${LOGSIZE}k
@@ -621,9 +629,9 @@ for fstype in ext2 ext3 ext4; do
 	mnt defaults
 	mnt journal_path=$LOOP_LOGDEV ignored
 	mnt journal_dev=$LOGDEV_DEVNUM ignored
-	not_mnt journal_path=${LOOP_LOGDEV}_nonexistent ignored
-	not_mnt journal_dev=123456 ignored
-	not_mnt journal_dev=999999999999999 ignored
+	not_mnt journal_path=${LOOP_LOGDEV}_nonexistent
+	not_mnt journal_dev=123456
+	not_mnt journal_dev=999999999999999
 
 	do_mkfs -E quotatype=prjquota $SCRATCH_DEV ${SIZE}k
 	mnt prjquota
@@ -636,11 +644,11 @@ for fstype in ext2 ext3 ext4; do
 	quotacheck -vugm $SCRATCH_MNT >> $seqres.full 2>&1
 	quotaon -vug $SCRATCH_MNT >> $seqres.full 2>&1
 
-	not_remount_noumount -r grpjquota=
-	not_remount_noumount -r usrjquota=aaquota.user
-	not_remount_noumount -r grpjquota=aaquota.group
-	not_remount_noumount -r jqfmt=vfsv1
-	not_remount_noumount -r noquota
+	not_remount grpjquota=
+	not_remount usrjquota=aaquota.user
+	not_remount grpjquota=aaquota.group
+	not_remount jqfmt=vfsv1
+	not_remount noquota
 	mnt_only remount,usrquota,grpquota ^usrquota,^grpquota
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
 
@@ -654,10 +662,10 @@ for fstype in ext2 ext3 ext4; do
 	quotacheck -vugm $SCRATCH_MNT >> $seqres.full 2>&1
 	quotaon -vug $SCRATCH_MNT >> $seqres.full 2>&1
 
-	not_remount_noumount -r noquota
-	not_remount_noumount -r usrjquota=aquota.user
-	not_remount_noumount -r grpjquota=aquota.group
-	not_remount_noumount -r jqfmt=vfsv1
+	not_remount noquota
+	not_remount usrjquota=aquota.user
+	not_remount grpjquota=aquota.group
+	not_remount jqfmt=vfsv1
 	mnt_only remount,grpjquota= grpquota,^grpjquota
 	mnt_only remount,usrjquota= usrquota,^usrjquota
 	mnt_only remount,usrquota,grpquota usrquota,grpquota
@@ -674,9 +682,9 @@ for fstype in ext2 ext3 ext4; do
 	mnt prjquota
 	mnt usrquota
 	mnt grpquota
-	not_remount defaults usrjquota=aquota.user
-	not_remount defaults grpjquota=aquota.user
-	not_remount defaults jqfmt=vfsv1
+	mnt_then_not_remount defaults usrjquota=aquota.user
+	mnt_then_not_remount defaults grpjquota=aquota.user
+	mnt_then_not_remount defaults jqfmt=vfsv1
 	remount defaults grpjquota=,usrjquota= ignored
 
 done #for fstype in ext2 ext3 ext4; do

base-commit: fbc6486be09c93a68d3863ebf7e3ed851fc4721c
-- 
2.36.0


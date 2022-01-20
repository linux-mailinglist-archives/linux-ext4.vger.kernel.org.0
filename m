Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF370494B8A
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jan 2022 11:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiATKUy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jan 2022 05:20:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232937AbiATKUx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Jan 2022 05:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642674052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gdoMznUoQshM/tm/E+npk4KemjnJfvqDAHaONy/08JA=;
        b=BF2bgEEZrvOAoWKbkuJHBFFaR8+kIl4e0ITxD8+jjKyLsfpLtiK3u8frHq6oHfu2Gu8MS5
        J3pbBiasvcBHteZUoSMtHYLm7BIZA9QDkx0+He7XtaQsBH+jffVIz9I3Ujxqy3wqEFMQYD
        zgpmiuiid2eZbjbWPlw1hjH1xIhP2Ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-v1pGC8SZMyK2CSp7e8szrw-1; Thu, 20 Jan 2022 05:20:51 -0500
X-MC-Unique: v1pGC8SZMyK2CSp7e8szrw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A89D104FC17;
        Thu, 20 Jan 2022 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 635CE752B0;
        Thu, 20 Jan 2022 10:20:34 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4/053: Test remount without changing mount options
Date:   Thu, 20 Jan 2022 11:20:25 +0100
Message-Id: <20220120102025.42735-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With the recent ext4 mount api change we discovered a bugs that weren't
caught by this test. It was triggered by remounting the file system
either with the same mount options, or without specifying any mount
options at all. In this case we would expect the original mount options
to remain the same, however this was either not the case, or the remount
failed.

Add a remount test after a regular mount. Remount once with specifying
the original mount option and remount second time without specifying
anything. Test the active options after each test.

Additionally include all the combinations of data= options in the
remount test for the sake of completeness.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 tests/ext4/053 | 57 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/053 b/tests/ext4/053
index eaa02508..e1e79592 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -77,6 +77,10 @@ kernel_gte 5.12 || _notrun "This test is only relevant for kernel versions 5.12
 
 IGNORED="remount,defaults,ignored,removed"
 CHECK_MINFO="lazytime,noatime,nodiratime,noexec,nosuid,ro"
+
+# List of options that can't be used for remount even if the argument
+# is not changed
+CANT_REMOUNT="defaults,remount,abort,journal_path,journal_dev,usrjquota,grpjquota,jqfmt"
 ERR=0
 
 test_mnt() {
@@ -170,6 +174,54 @@ do_mnt() {
 		print_log "(failed mount)"
 	fi
 
+	if [ $ret -ne 0 ] || [ -z "$1" ]; then
+		return $ret
+	fi
+
+	# Skip options that can't be remounted even if the argument
+	# is not changed
+	(
+	IFS=','
+	for option in $1; do
+		opt=${option%=*}
+		if echo $CANT_REMOUNT | grep -w $opt; then
+			exit 1
+		fi
+		# Skip the remount if we have data=journal on ext3 because
+		# it will set nodioread_nolock which is not supported on ext3
+		# hence remount will fail. Yes it is broken.
+		if [[ $fstype == "ext3" ]] && [[ $option == "data=journal" ]]; then
+			exit 1
+		fi
+	done
+	) > /dev/null 2>&1
+	[ $? -eq 1 ] && return 0
+	print_log "(going to remount options $1)"
+
+	# Just remount with original mnt options, don't add anything at all
+	simple_mount -o remount,$1 $SCRATCH_MNT
+	ret=$?
+	if [ $ret -eq 0 ]; then
+		test_mnt $1 $2
+		ret=$?
+		[ $ret -ne 0 ] && print_log "(not found after remount)"
+	else
+		print_log "(failed remount)"
+	fi
+
+	[ $ret -ne 0 ] && return $ret
+
+	# Plain remount without specifying any mount options
+	simple_mount -o remount $SCRATCH_MNT
+	ret=$?
+	if [ $ret -eq 0 ]; then
+		test_mnt $1 $2
+		ret=$?
+		[ $ret -ne 0 ] && print_log "(not found after plain remount)"
+	else
+		print_log "(failed plain remount)"
+	fi
+
 	return $ret
 }
 
@@ -556,8 +608,11 @@ for fstype in ext2 ext3 ext4; do
 
 	if [[ $fstype != "ext2" ]]; then
 		remount noload data=journal norecovery
-		not_remount data=ordered data=journal
+		not_remount data=journal data=ordered
 		not_remount data=journal data=writeback
+		not_remount data=ordered data=journal
+		not_remount data=ordered data=writeback
+		not_remount data=writeback data=journal
 		not_remount data=writeback data=ordered
 	fi
 
-- 
2.31.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C293C3E00F7
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 14:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbhHDMRJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 08:17:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36746 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbhHDMRJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 08:17:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C36AC22200;
        Wed,  4 Aug 2021 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628079415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1TMDbfzHGlH2wUsv4ldlI4qjexGrr77MuSs+SYSqC+Q=;
        b=KLIcth+xrrADcuEiQ6atg9MiDvZ9irRGfE2qx7wyebuByCf6RQHCJ6T6C20C9hokoQ3BsJ
        QV8Jz8cNp7Fzvek03ipYrVfBQcFxbm03QwbmViatsVnk3625i+3YL9Lp0d6sGd99uFK/Tf
        lc0H0pEN6zaxcYOqqrOM3WVbuAU2I8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628079415;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1TMDbfzHGlH2wUsv4ldlI4qjexGrr77MuSs+SYSqC+Q=;
        b=xEOmLya+ePmXpWA3gzt3XEX7Jsy+evaUZmU4jfA6YUqorgTMaJizK0GoU86z0GcnY/JtOt
        KXkatif/x6j5sxBg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id B7214A3B84;
        Wed,  4 Aug 2021 12:16:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9C6441E62D6; Wed,  4 Aug 2021 14:16:55 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] tests: check quota file space usage does not get accounted
Date:   Wed,  4 Aug 2021 14:16:52 +0200
Message-Id: <20210804121652.25833-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2201; h=from:subject; bh=hU8Q0XF8Yxe5kpLZ2upUmq9hcI/7v03GrrlK47lKDdA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhCoUQ9lzI5+ecy5ER4FU2tW5acZdCq1nD8N9ke8Pg EjTp75SJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYQqFEAAKCRCcnaoHP2RA2RgnCA CpY4MMRq4Dt1N7DNvO2S8uYIWBNowlusFkXp5rw4s3b7EQ3g+S+J1NgB61mBZpCf6nbjswk2v5Ac8C tNmiva9JST1rbqHTTq27W4xzF+9PcQ0HSezKjBuJYibMXM6aLqfCjsziIigJCgVFT//sh8gNGYVfDe IP0hRoaPsCjTpPEMsoJy2VACZdctcWRztDrlvX3uhTSARjas3XXhwlJk1K3VVujHzfl3goYRsq+zn2 JbObq4XlPvAU8v9b4ZDbdvj/GK7L66KzQck+ohMzchyjEDl9naE2aRRb1PRPHZ1wV2ba9NWky4yvuX 8WOTxa1+yhqZyuQdthflCkgV6c0UOn
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Check that space used by quota files themselves does not get accounted
into the space tracked by quota subsystem.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/t_quota_add/name   |  1 +
 tests/t_quota_add/script | 46 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 tests/t_quota_add/name
 create mode 100644 tests/t_quota_add/script

diff --git a/tests/t_quota_add/name b/tests/t_quota_add/name
new file mode 100644
index 000000000000..43a4bfd084db
--- /dev/null
+++ b/tests/t_quota_add/name
@@ -0,0 +1 @@
+add several quota types using tune2fs and check computed usage
diff --git a/tests/t_quota_add/script b/tests/t_quota_add/script
new file mode 100644
index 000000000000..c26c37a7b814
--- /dev/null
+++ b/tests/t_quota_add/script
@@ -0,0 +1,46 @@
+FSCK_OPT=-yf
+
+if [ "$QUOTA" != "y" ]; then
+	echo "$test_name: $test_description: skipped"
+	return 0
+fi
+
+$MKE2FS -q -F -o Linux -b 4096 -O quota -E quotatype=prjquota $TMPFILE 10000 > $test_name.log 2>&1
+status=$?
+if [ "$status" != 0 ] ; then
+	echo "mke2fs failed" > $test_name.failed
+	echo "$test_name: $test_description: failed"
+	return $status
+fi
+
+for type in usrquota grpquota; do
+	$TUNE2FS -Q $type $TMPFILE >> $test_name.log 2>&1
+	status=$?
+	if [ "$status" != 0 ] ; then
+		echo "tune2fs -O quota failed with $status" > $test_name.failed
+		echo "$test_name: $test_description: failed"
+		return $status
+	fi
+done
+
+UUSAGE=$($DEBUGFS 2>/dev/null -R "lq user" $TMPFILE | grep "^ *0 ")
+for type in group project; do
+	TUSAGE=$($DEBUGFS 2>/dev/null -R "lq $type" $TMPFILE | grep "^ *0 ")
+	if [ "$TUSAGE" != "$UUSAGE" ]; then
+		echo "user and $type quota entries are different" >$test_name.failed
+		echo "$test_name: $test_description: failed"
+		return 1
+	fi
+done
+
+$FSCK $FSCK_OPT $TMPFILE >> $test_name.log 2>&1
+status=$?
+if [ "$status" = 0 ] ; then
+	echo "$test_name: $test_description: ok"
+	touch $test_name.ok
+else
+	echo "e2fsck with quota enabled failed with $status" > $test_name.failed
+	echo "$test_name: $test_description: failed"
+	return $status
+fi
+rm -f $TMPFILE
-- 
2.26.2


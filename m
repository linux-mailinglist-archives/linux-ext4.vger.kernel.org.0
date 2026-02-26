Return-Path: <linux-ext4+bounces-14065-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNN4FSNcoGm3igQAu9opvQ
	(envelope-from <linux-ext4+bounces-14065-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:43:47 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6291A7CAE
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 663E5306A105
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4233DA7E5;
	Thu, 26 Feb 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6ZDeWik"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291D279DC3;
	Thu, 26 Feb 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116927; cv=none; b=ZH3xeMPuiolLeY4vk+OdyXSEak5KvPeF9JrNetT/zyk7erzwP5H6evh5YXmAXs6TOKqjT57VwHpcMlEFOi6Kv5xPqxJ6WoK8IMpLBVObuxTMTRrS112+oDXUvSYMIdQsUYB3IPUabk3QeNFoVb2B+lGhXjb7Wf07SzagmMdfpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116927; c=relaxed/simple;
	bh=Y/bGf8zwHLq7h+u+uCvSAYltuNomqiIpdMEKoLEFLz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eb5omJVOIAiPhWJ542FsC66a89hj9zoMqdPU5xsL81/S4LinmdIMMF+XSdsUY4OONr+4N8mYlJwJkoxfprB9YjRpH/jswBzElZTWN5a7J9CuJxJkPT5yQnoaLdu1F45d5E86nxYNtgOPl/WGEye0JtT0BPqvPwfUBwx7KwAUfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6ZDeWik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8AAC116C6;
	Thu, 26 Feb 2026 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116927;
	bh=Y/bGf8zwHLq7h+u+uCvSAYltuNomqiIpdMEKoLEFLz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6ZDeWikAAUQNVk7KG3/uB4ZGQyvx3zyeL90ML1TIq7IfgnOxks+jVosgRRYkAQcY
	 VYh4/Vt8AGKlnDxDJr4GozWmPEkiefnsauz031p9MLbbUjkJTTSLYmjORpw61nikW7
	 9Eg6QxXNYc03HeE05sNioGwsmQSMdiKq2xjhKrzjpttzdJ3+8sF5nE4KumWqdJ5Ut3
	 Gy11qo8sBBq6ZFdOPdoqeKNmOFvUD2WSW4m2eT2h4QBcYrkQD+usolfoFlqUt7c5n/
	 gkO7n/+K8mqQ9EdpTV/dz3Qh7HirpJq6Hse8YoIhJAxTvKZqKd6131E59q56gaywHd
	 AzBQUR42Lc1iA==
From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 4/9] fstests: add test for inotify isolation on cloned devices
Date: Thu, 26 Feb 2026 22:41:45 +0800
Message-ID: <78014ba3d564004081dca3c1d7e69cec8943f629.1772095513.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772095513.git.asj@kernel.org>
References: <cover.1772095513.git.asj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14065-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asj@kernel.org,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED6291A7CAE
X-Rspamd-Action: no action

Add a new test, to verify that the kernel correctly differentiates between
two block devices sharing the same FSID/UUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/config         |  1 +
 tests/generic/790     | 78 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/790.out |  7 ++++
 3 files changed, 86 insertions(+)
 create mode 100644 tests/generic/790
 create mode 100644 tests/generic/790.out

diff --git a/common/config b/common/config
index 1420e35ddfee..c08f828575a2 100644
--- a/common/config
+++ b/common/config
@@ -228,6 +228,7 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
 export PARTED_PROG="$(type -P parted)"
 export XFS_PROPERTY_PROG="$(type -P xfs_property)"
 export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
+export INOTIFYWAIT_PROG="$(type -P inotifywait)"
 
 # udev wait functions.
 #
diff --git a/tests/generic/790 b/tests/generic/790
new file mode 100644
index 000000000000..3809fced622d
--- /dev/null
+++ b/tests/generic/790
@@ -0,0 +1,78 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test 790
+#
+# Verify if the kernel or userspace becomes confused when two block devices
+# share the same fid/fsid/uuid. Create inotify on both original and cloned
+# filesystem. Monitor the notification in the respective logs.
+
+. ./common/preamble
+
+_begin_fstest auto quick mount clone
+
+_require_test
+_require_scratch_dev_pool 2
+_require_command "$INOTIFYWAIT_PROG" inotifywait
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	umount $mnt1 $mnt2 2>/dev/null
+	_scratch_dev_pool_put
+}
+
+_scratch_dev_pool_get 2
+_scratch_mkfs_sized_clone >$seqres.full 2>&1
+devs=($SCRATCH_DEV_POOL)
+mnt2=$TEST_DIR/mnt2
+mkdir -p $mnt2
+
+_scratch_mount $(_clone_mount_option)
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+
+log1=$tmp.inotify1
+log2=$tmp.inotify2
+
+echo "Setup inotify watchers on both SCRATCH_MNT and mnt2"
+$INOTIFYWAIT_PROG -m -e create --format '%f' $SCRATCH_MNT > $log1 2>&1 &
+pid1=$!
+$INOTIFYWAIT_PROG -m -e create --format '%f' $mnt2 > $log2 2>&1 &
+pid2=$!
+sleep 2
+
+echo "Trigger file creation on SCRATCH_MNT"
+touch $SCRATCH_MNT/file_on_scratch_mnt
+sync
+sleep 1
+
+echo "Trigger file creation on mnt2"
+touch $mnt2/file_on_mnt2
+sync
+sleep 1
+
+echo "Verify inotify isolation"
+kill $pid1 $pid2
+wait $pid1 $pid2 2>/dev/null
+
+if grep -q "file_on_scratch_mnt" $log1 && ! grep -q "file_on_mnt2" $log1; then
+	echo "SUCCESS: SCRATCH_MNT events isolated."
+else
+	echo "FAIL: SCRATCH_MNT inotify confusion!"
+	[ ! -s $log1 ] && echo "  - SCRATCH_MNT received no events."
+	grep -q "file_on_mnt2" $log1 && echo "  - SCRATCH_MNT received event from mnt2."
+fi
+
+if grep -q "file_on_mnt2" $log2 && ! grep -q "file_on_scratch_mnt" $log2; then
+	echo "SUCCESS: mnt2 events isolated."
+else
+	echo "FAIL: mnt2 inotify confusion!"
+	[ ! -s $log2 ] && echo "  - mnt2 received no events."
+	grep -q "file_on_scratch_mnt" $log2 && echo "  - mnt2 received event from SCRATCH_MNT."
+fi
+
+status=0
+exit
diff --git a/tests/generic/790.out b/tests/generic/790.out
new file mode 100644
index 000000000000..3c92c34ffbda
--- /dev/null
+++ b/tests/generic/790.out
@@ -0,0 +1,7 @@
+QA output created by 790
+Setup inotify watchers on both SCRATCH_MNT and mnt2
+Trigger file creation on SCRATCH_MNT
+Trigger file creation on mnt2
+Verify inotify isolation
+SUCCESS: SCRATCH_MNT events isolated.
+SUCCESS: mnt2 events isolated.
-- 
2.43.0



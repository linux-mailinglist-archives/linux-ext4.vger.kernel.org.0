Return-Path: <linux-ext4+bounces-14069-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIqMGktdoGm3igQAu9opvQ
	(envelope-from <linux-ext4+bounces-14069-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:48:43 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F21A7DE0
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B3A2311BE65
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42903E9593;
	Thu, 26 Feb 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb+Xw+pP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E2C13AA2F;
	Thu, 26 Feb 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116933; cv=none; b=HqDaz88qsaDZ3SW+8XCx0I0+5abZhWIOwVvVhFu06ZXfa0A13O0M739adgLeETabXI2Cv2Z3qXSV8hF7gSnWZBhdIYZF4GFlYJDcEuO1m4nGtM6gMoGLBJZcGczEVz97Q79kw+fJCrIcP8vRm9cI4X546u+lAuHKoxDfzDpfkIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116933; c=relaxed/simple;
	bh=V7Wtww/GpDxoGlANoJMjIJqEEqI1iW6xmKRbRtIOpao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5uJ+W2HRoIQKOHAviseK1UpB7ElUvXG5mmdKLM3hBt7Pa00zLiefYZH8224gwaGztyYfqMEYI59IIOK2HrGTdVqkC6SzYbNTR7WgX22BM+ajEonws59aBkaYRzOaJ6CvaLrPYQdkggdhbKPHd62+F1RMldhoQw0gwuzWkWcNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb+Xw+pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3903C19423;
	Thu, 26 Feb 2026 14:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116933;
	bh=V7Wtww/GpDxoGlANoJMjIJqEEqI1iW6xmKRbRtIOpao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sb+Xw+pPqnPyUDcRvygb5Ol+qg0RJFAi3qi/2TqRoPz7SVUqUoBFIXSuS2JZ4cTMe
	 aUTpDWTde8wUJ/sykIyjdkZerzoTD63aCWcSuGruX/7gvxmzEqKYM21ubvNwvFg1dL
	 Z/IdDHll/umBXmP1PjNpwtppKelPoFdVXirYdwevVP0/wDJ+TqcR1+xShQDxMPvABD
	 OtP/tkWFb2DIFkgzb5tdH9R3SHlH9WmdBnpX4l0gUuLmfbO9T8xGFoZOCEkLeVxv/2
	 NhDtbH6V4zBph71Ye3mz0TaJFEfHS6VutxM7Oj5Z0gntc5HYvRScL4N+fF6NyuQqMf
	 WAMcRwtKz6Vcw==
From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 8/9] fstests: verify IMA isolation on cloned filesystems
Date: Thu, 26 Feb 2026 22:41:49 +0800
Message-ID: <ca5fc0515169de2a52d39170ded5d59e56a9cc50.1772095513.git.asj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14069-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A8F21A7DE0
X-Rspamd-Action: no action

Add testcase to verify IMA measurement isolation when multiple devices
share the same FSUUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/794     | 101 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/794.out |  10 +++++
 2 files changed, 111 insertions(+)
 create mode 100644 tests/generic/794
 create mode 100644 tests/generic/794.out

diff --git a/tests/generic/794 b/tests/generic/794
new file mode 100644
index 000000000000..e3bf3f9c6a7e
--- /dev/null
+++ b/tests/generic/794
@@ -0,0 +1,101 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test 794
+# Verify IMA isolation on cloned filesystems:
+# . Mount two devices sharing the same FSUUID (cloned).
+# . Apply an IMA policy to measure files based on that FSUUID.
+# . Create unique files on each mount point to trigger measurements.
+# . Confirm the IMA log correctly attributes events to the respective mounts.
+
+. ./common/preamble
+. ./common/filter
+
+_begin_fstest auto quick clone
+
+_require_test
+_require_scratch_dev_pool 2
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: use on-disk uuid for s_uuid in temp_fsid mounts"
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: derive f_fsid from on-disk fsuuid and dev_t"
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	umount $mnt2 2>/dev/null
+	_scratch_dev_pool_put
+}
+
+filter_pool()
+{
+	_filter_scratch | \
+		sed -e "s|${devs[1]}|DEV2|g" \
+		    -e "s|$mnt2|MNT2|g" | \
+		_filter_spaces
+}
+
+do_ima()
+{
+	local ima_policy="/sys/kernel/security/ima/policy"
+	local ima_log="/sys/kernel/security/ima/ascii_runtime_measurements"
+	local fsuuid
+	local mnt=$1
+	local run_enable=$2
+
+	# Since the in-memory IMA audit log is only cleared upon reboot,
+	# use unique random filenames to avoid log collisions.
+	local foofile=$(mktemp --dry-run foobar_XXXXX)
+
+	echo $mnt $run_enable | filter_pool
+
+	[ -w "$ima_policy" ] || _notrun "IMA policy not writable"
+
+	fsuuid=$(blkid -s UUID -o value $SCRATCH_DEV)
+
+	# Load IMA policy to measure file access specifically for this
+	# filesystem UUID.
+	if [[ $run_enable -eq 1 ]]; then
+		echo "measure func=FILE_CHECK fsuuid=$fsuuid" > "$ima_policy" || \
+			_notrun "Policy rejected"
+	fi
+
+	# Create a file to trigger measurement and verify its entry in
+	# the IMA log.
+	echo "test_data" > $mnt/$foofile
+
+	# For $ima_log column entry please ref to
+	grep $foofile "$ima_log" | awk '{ print $5 }' | filter_pool | \
+						sed "s/$foofile/FOOBAR_FILE/"
+
+	echo "dbg: $mnt $fsuuid $foofile" >> $seqres.full
+	cat $ima_log | tail -1 >> $seqres.full
+	echo >> $seqres.full
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
+do_ima $SCRATCH_MNT 1
+do_ima $mnt2 0
+
+# Btrfs uses in-memory dynamic temp_fsid
+echo mount cycle
+_unmount $mnt2
+_mount $mount_opts ${devs[1]} $mnt2 || _fail "Failed to mount dev2"
+
+do_ima $SCRATCH_MNT 0
+do_ima $mnt2 0
+
+status=0
+exit
diff --git a/tests/generic/794.out b/tests/generic/794.out
new file mode 100644
index 000000000000..026b365853e6
--- /dev/null
+++ b/tests/generic/794.out
@@ -0,0 +1,10 @@
+QA output created by 794
+SCRATCH_MNT 1
+SCRATCH_MNT/FOOBAR_FILE
+MNT2 0
+MNT2/FOOBAR_FILE
+mount cycle
+SCRATCH_MNT 0
+SCRATCH_MNT/FOOBAR_FILE
+MNT2 0
+MNT2/FOOBAR_FILE
-- 
2.43.0



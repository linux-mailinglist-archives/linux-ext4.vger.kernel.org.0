Return-Path: <linux-ext4+bounces-14067-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L4tDkJdoGm3igQAu9opvQ
	(envelope-from <linux-ext4+bounces-14067-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:48:34 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A441A7DC8
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2EC130F9B49
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95403E8C60;
	Thu, 26 Feb 2026 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgLn1GGm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79F279DC3;
	Thu, 26 Feb 2026 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116930; cv=none; b=gYzYZClgSRTNJPcc4THiiGMgFTgqGzZIcD5XXyjO4CwAT5WyT+WyI6iB9vmi80bZmBkRK8G4J3isEGLydr3JcfRD83CQzftqT6cgHDeMFQvAbfu2p/0bfKCNOqVTipfH1GN3w1Nta9GnkDnKNM9PC7YG/bJc1g9mCCDaJm5lQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116930; c=relaxed/simple;
	bh=2ZmxX7pxYyToLaM0kh6Q31uX32r3aDcpfs6SLFBHw8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfH0Zrbfsz9+b9tJidVdFpAa/Do6C3KuQlRn1AIq3Fl7RPeBWy1RdiuEQ/fbjL1tNtarZx2HId85d0cleHlIZF3PbC9kYM4P47KkFuDMG7Vmc+sLWcUSAFX4Ybu4+nvioMYiEb3G6Rwhmi1tiVyynnwjP1X2zqFPvpabu8vvyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgLn1GGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BD8C19422;
	Thu, 26 Feb 2026 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116930;
	bh=2ZmxX7pxYyToLaM0kh6Q31uX32r3aDcpfs6SLFBHw8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MgLn1GGmXlopNeZADkXyeSb8rWhahNx5GWQYz68Vv8bjr+AzFgyIqbSsqx6DriZYa
	 NxMcTt0U5K4Rr83rgb0EJ49+y05TlUoV46ZNetDogE64AI1YObYeUScuv0YQ/VRHhO
	 lrwOsCEu8LvEgyOQo4JgJm6HvnfKDk4HvLNJ3arwEPRJ5Wh4uMy8dQsSNHEB0ih44P
	 ZnqSv69iw0Y8hPC6isjGCqkDC9sj9yyijBh7LnUfF8NOqPiTGRhjreWbYMnLSX3NBn
	 x5r/fvDk3MnKgfdz5zjROrafEu47LpFLJZwzGHwsxF6WLjxtKEZ3sZQf2U6Pqd+bcJ
	 pEtcD1huw8WlA==
From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 6/9] fstests: verify f_fsid for cloned filesystems
Date: Thu, 26 Feb 2026 22:41:47 +0800
Message-ID: <76e1856d716608e14809bf04cd5259dad341518d.1772095513.git.asj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-14067-lists,linux-ext4=lfdr.de];
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
X-Rspamd-Queue-Id: 83A441A7DC8
X-Rspamd-Action: no action

Verify that the cloned filesystem provides an f_fsid that is persistent
across mount cycles, yet unique from the original filesystem's f_fsid.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/792     | 57 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/792.out |  7 ++++++
 2 files changed, 64 insertions(+)
 create mode 100644 tests/generic/792
 create mode 100644 tests/generic/792.out

diff --git a/tests/generic/792 b/tests/generic/792
new file mode 100644
index 000000000000..3a2f463dc76e
--- /dev/null
+++ b/tests/generic/792
@@ -0,0 +1,57 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test 792
+# Verify f_fsid and s_uuid of cloned filesystems across mount cycle.
+
+. ./common/preamble
+
+_begin_fstest auto quick mount clone
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
+fsid_scratch=$(stat -f -c "%i" $SCRATCH_MNT)
+fsid_clone=$(stat -f -c "%i" $mnt2)
+
+echo "**** fsid initially ****"
+echo $fsid_scratch | sed -e "s/$fsid_scratch/FSID_SCRATCH/g"
+echo $fsid_clone | sed -e "s/$fsid_clone/FSID_CLONE/g"
+
+# Make sure fsid still match across a mount cycle, also reverse the order.
+echo "**** fsid after mount cycle ****"
+_scratch_unmount
+_unmount $mnt2
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+_scratch_mount $(_clone_mount_option)
+
+stat -f -c "%i" $SCRATCH_MNT | sed -e "s/$fsid_scratch/FSID_SCRATCH/g"
+stat -f -c "%i" $mnt2 | sed -e "s/$fsid_clone/FSID_CLONE/g"
+
+status=0
+exit
diff --git a/tests/generic/792.out b/tests/generic/792.out
new file mode 100644
index 000000000000..27ecbce2225e
--- /dev/null
+++ b/tests/generic/792.out
@@ -0,0 +1,7 @@
+QA output created by 792
+**** fsid initially ****
+FSID_SCRATCH
+FSID_CLONE
+**** fsid after mount cycle ****
+FSID_SCRATCH
+FSID_CLONE
-- 
2.43.0



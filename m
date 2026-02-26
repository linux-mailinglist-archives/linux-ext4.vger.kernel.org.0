Return-Path: <linux-ext4+bounces-14070-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGQ8Jm1coGm3igQAu9opvQ
	(envelope-from <linux-ext4+bounces-14070-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:45:01 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C7C1A7CFD
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BB5830420B4
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588163E9580;
	Thu, 26 Feb 2026 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C30D8nyQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4E377562;
	Thu, 26 Feb 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116935; cv=none; b=R1VcVq7ZFkAsBE4vXsBxZAeAErb6FLoju0qKl0sRnekwO2j3qpfwNl2YwWQkbhjUiM8i/PjzQaLuHvUeabrLCv2+Cfndh6rrTU/KL/9aNFJQPTiJxaHJXI+3aDeSuLH3YOU7luzVPv3oEsImNUMfpb0SBybnBu4BWtMGhS/TC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116935; c=relaxed/simple;
	bh=spl/u6G3mh/AR56lY6Yc5TU+Cds3VIwdZjxaSh1KxBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZd9pmWY83AopMGgR8N0QhMFOfH99SlyJNo9cry/TKvX91J65hFx67r6PdMeS024/yijE9VIaLhe2O8z1cGK2eV+7jDOM8aaNjCrVBqKC09GhgZAAuPFLFDePOID8KzlmR2VhXIQ19Z52etiHfFnIELAKBZVWQSh6vdLiAwPOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C30D8nyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608E2C116C6;
	Thu, 26 Feb 2026 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116934;
	bh=spl/u6G3mh/AR56lY6Yc5TU+Cds3VIwdZjxaSh1KxBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C30D8nyQFTzp/271Jgmodg/JFLYGthoyJMSz1cI+TcDk+lDt7z+JBGmMK7JPGf1LM
	 hwLT9tinf9EIVb7pYeHGEnbfKcERSh4vPsMeWsgS2R6ay/K3oMEzx82akjduLl2CiM
	 xlEVByzIJkY7FiIwe21ynGyYolYAXPgLIoCemTXVFl+///t/k9jWWskdErkiYXLvYs
	 tLxggKu7nH0iPUqzJaMfIMurCBBYxuF5gQxVAEMABQ69UuzaKcYi63AVEeO6Sc8if6
	 57fP7RJZo95eRMsWSNUD6nhdWG9RNvYHRyNsrNprnw/xOiyVe2q/lCitkrBayrgEY2
	 WWQbGFJXdHiuQ==
From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 9/9] fstests: verify exportfs file handles on cloned filesystems
Date: Thu, 26 Feb 2026 22:41:50 +0800
Message-ID: <7bca92ab726b6edc5d96abfe54ce28aeea13ac87.1772095513.git.asj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14070-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75C7C1A7CFD
X-Rspamd-Action: no action

Ensure that exportfs can correctly decode file handles on a cloned
filesystem across a mount cycle, by file handles generated on a
cloned device remain valid after mount cycle.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/795     | 67 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/795.out |  2 ++
 2 files changed, 69 insertions(+)
 create mode 100644 tests/generic/795
 create mode 100644 tests/generic/795.out

diff --git a/tests/generic/795 b/tests/generic/795
new file mode 100644
index 000000000000..b6a75e500949
--- /dev/null
+++ b/tests/generic/795
@@ -0,0 +1,67 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test No. 795
+
+. ./common/preamble
+
+_begin_fstest auto quick exportfs clone
+
+_require_test
+_require_exportfs
+_require_scratch_dev_pool 2
+_require_test_program "open_by_handle"
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	_unmount $mnt2 2>/dev/null
+	_scratch_dev_pool_put
+}
+
+# Create test dir and test files, encode file handles and store to tmp file
+create_test_files()
+{
+	rm -rf $testdir
+	mkdir -p $testdir
+	$here/src/open_by_handle -cwp -o $tmp.handles_file $testdir $NUMFILES
+}
+
+# Decode file handles loaded from tmp file
+test_file_handles()
+{
+	local opt=$1
+	local when=$2
+
+	echo test_file_handles after $when
+	$here/src/open_by_handle $opt -i $tmp.handles_file $mnt2 $NUMFILES
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
+NUMFILES=1
+testdir=$mnt2/testdir
+
+# Decode file handles of files/dir after cycle mount
+create_test_files
+
+_scratch_unmount
+_unmount $mnt2
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+_scratch_mount $(_clone_mount_option)
+
+test_file_handles -rp "cycle mount"
+
+status=0
+exit
diff --git a/tests/generic/795.out b/tests/generic/795.out
new file mode 100644
index 000000000000..774fe7487d65
--- /dev/null
+++ b/tests/generic/795.out
@@ -0,0 +1,2 @@
+QA output created by 795
+test_file_handles after cycle mount
-- 
2.43.0



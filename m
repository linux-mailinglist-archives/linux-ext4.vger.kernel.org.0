Return-Path: <linux-ext4+bounces-14068-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDHOAJVdoGm3igQAu9opvQ
	(envelope-from <linux-ext4+bounces-14068-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:49:57 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF071A7E7F
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20A9031423C2
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB33E8C7C;
	Thu, 26 Feb 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSvRb77z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3313AA2F;
	Thu, 26 Feb 2026 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116931; cv=none; b=qfvkm8mcfdd1fWUDvFbevE6jhc3s0Qcum6ax3gUeNBA1fATIuzE1HA8AGtaz5OXWGsfiap7v+8bfJjYYC4PrE/GGTsufLvzAdkPIWE8PGMo9ZpIpS6zElZ5Ze6XKWUChZvK7Rf/nsMbbZkDfOXmYwSx0OpRhzbF8eknGIXJTfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116931; c=relaxed/simple;
	bh=zpO8W0c90ct/G+SkCYLRk5Q9dA3YY9Bq32IoXlPyKaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLbYEWqn89fM3L/MLZ/A7K7TbdBuIJJLobc6kQkZusOJzqfx+30eAljK9YnWgW+v2gJyjurKSzNVPsx/GegFW0fAWv9GlHUsG5ohCY7IhSEQSKjTJFNQwAygv1psnhLp9G/HK794nkGgXHM6YU89vMr3zAfkfpjL9kyUOkgnrq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSvRb77z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929FDC116C6;
	Thu, 26 Feb 2026 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116931;
	bh=zpO8W0c90ct/G+SkCYLRk5Q9dA3YY9Bq32IoXlPyKaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSvRb77z+NaONnUuBluYrqkvFEZrat8eheXYTZevkCcDxVZd10acnHG80BM9wE6Fd
	 nig++YNmOcyS4TqaLtF0D7H+bIoK46EohXQqB0T10PLZSX8Yk9t1s7wGZTQBHAHCZX
	 7QMa8RXoIPWzzHASZ7WSg5Prf6Fu0KEIJByV8sLShZsOD/Od+vCEJfMIY401XjAjJH
	 lydT5xGa25eVlhlCahrt5ckiGg/zCMU9uf7MP59RH+hnzMcDshwdZZ+kp1v2My54nn
	 YB6wH42MPXvXiirZOPvkSkTcUJPrzasz08l5RFPsY2+FNwfceqsaytr7+zVZdhOlB9
	 SshCxy6rIGswA==
From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 7/9] fstests: verify libblkid resolution of duplicate UUIDs
Date: Thu, 26 Feb 2026 22:41:48 +0800
Message-ID: <a2e17f994fd7e8545501f512647e642b047e4103.1772095513.git.asj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14068-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EF071A7E7F
X-Rspamd-Action: no action

Verify how findmnt, df (libblkid) resolve device paths when multiple
block devices share the same FSUUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 tests/generic/793     | 73 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/793.out | 22 +++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 tests/generic/793
 create mode 100644 tests/generic/793.out

diff --git a/tests/generic/793 b/tests/generic/793
new file mode 100644
index 000000000000..dd80212fad73
--- /dev/null
+++ b/tests/generic/793
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test 793
+# Verify how libblkid resolve devices when multiple devices sharing the
+# same FSUUID.
+
+. ./common/preamble
+. ./common/filter
+
+_begin_fstest auto quick mount clone
+
+_require_test
+_require_scratch_dev_pool 2
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
+print_info()
+{
+	local mntpt=$1
+	local tgt=$(findmnt -no SOURCE $mntpt)
+	local fsuuid=$(blkid -s UUID -o value $tgt)
+
+	echo "mntpt=$mntpt tgt=$tgt fsuuid=$fsuuid" >> $seqres.full
+	echo
+	findmnt -o SOURCE,TARGET,UUID "$tgt" | tail -n +2 | \
+					sed -e "s/$fsuuid/FSUUID/g" | filter_pool
+	awk -v dev="$tgt" '$1 == dev { print $1, $2 }' /proc/self/mounts | \
+								filter_pool
+	df --all --output=source,target "$tgt" | tail -n +2 | filter_pool
+	echo
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
+print_info $SCRATCH_MNT
+print_info $mnt2
+
+echo "**** mount cycle ****"
+_scratch_unmount
+_unmount $mnt2
+_mount $(_common_dev_mount_options) $(_clone_mount_option) ${devs[1]} $mnt2 || \
+						_fail "Failed to mount dev2"
+_scratch_mount $(_clone_mount_option)
+
+print_info $SCRATCH_MNT
+print_info $mnt2
+
+status=0
+exit
diff --git a/tests/generic/793.out b/tests/generic/793.out
new file mode 100644
index 000000000000..4c7c349ec4ed
--- /dev/null
+++ b/tests/generic/793.out
@@ -0,0 +1,22 @@
+QA output created by 793
+
+SCRATCH_DEV SCRATCH_MNT FSUUID
+SCRATCH_DEV SCRATCH_MNT
+SCRATCH_DEV SCRATCH_MNT
+
+
+DEV2 MNT2 FSUUID
+DEV2 MNT2
+DEV2 MNT2
+
+**** mount cycle ****
+
+SCRATCH_DEV SCRATCH_MNT FSUUID
+SCRATCH_DEV SCRATCH_MNT
+SCRATCH_DEV SCRATCH_MNT
+
+
+DEV2 MNT2 FSUUID
+DEV2 MNT2
+DEV2 MNT2
+
-- 
2.43.0



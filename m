Return-Path: <linux-ext4+bounces-14066-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJKXDDJdoGm3igQAu9opvQ
	(envelope-from <linux-ext4+bounces-14066-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:48:18 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE721A7DAC
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3626030EA2E3
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496F83DAC02;
	Thu, 26 Feb 2026 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irDeFROJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134A279DC3;
	Thu, 26 Feb 2026 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116929; cv=none; b=k6dwdza+bbCps8ama+YLUkMRI3Kf1/OA2Im/NZokZOwJfWBNP25ppj8kE8qx3mYCEl6me93oK3DG6mR6fbdbXAV5vr/uDshlY3Q8NAKQ0xyc3ShqHPFgl0xQUKAsAjYY8u6V3qHsCiS92kBwAbrx+qhqG5PJtJxZj0EMIWPg2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116929; c=relaxed/simple;
	bh=kvQH+Tslxp9v+GlXpjridu5nkvjx9ZDv6XfIgdh+Tj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdoz7Kcm50VsV5g8uBiA3/irEKvDZB+8MzIh+M8GXVtGL7ApRsuo1TmWM60wdEzTIvwJx6hKCLuUNIfumVBZeN/J9znlbRi9+KtvvAEuLZj+U0wk5k8mN7UDkEoEjadWrbXHhcogwMyTP4v2nHJK514txH2AT6QZRjxWQlbnuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irDeFROJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C55C116C6;
	Thu, 26 Feb 2026 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772116928;
	bh=kvQH+Tslxp9v+GlXpjridu5nkvjx9ZDv6XfIgdh+Tj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irDeFROJPsR0lqjHejj0JdwgC31KBFgWEGHUVlWB0/Y8MriRFjVKrUNbBo0wB3Le7
	 Cxf0urhetPMPqs/d6RD2yr2kwmdxhQcLOT30uHAJDeBHGl/RGPEsLO5LxKbKh2DZ7n
	 fdJP2s2oBCvONyLGxbLL6DNTjbRino12jUtE+Vw57SlY+kJgBNBuZooZMGSMzOfenG
	 6s9Muj4/EBZPhnB59oopFtSJ5J0Spl/wce7VZVf2ioEqRdz9JFmEVNNgYYRRUtFSBQ
	 gBU7VcVVd35Bx41IEELVTaoFRkKM6awUfKxlaaxN5Mjf6HYlBXp+gszu4K5YXBH7kL
	 Mxw7TeJFjxGjg==
From: Anand Jain <asj@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 5/9] fstests: verify fanotify isolation on cloned filesystems
Date: Thu, 26 Feb 2026 22:41:46 +0800
Message-ID: <b54dea5e72585db5f5c3d74ce399f9d839965821.1772095513.git.asj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14066-lists,linux-ext4=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,btrfs_crc32c_forged_name.py:url,popdir.pl:url]
X-Rspamd-Queue-Id: 7CE721A7DAC
X-Rspamd-Action: no action

Verify that fanotify events are correctly routed to the appropriate
watcher when cloned filesystems are mounted.
Helps verify kernel's event notification distinguishes between devices
sharing the same FSID/UUID.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/fanotify.c        | 66 +++++++++++++++++++++++++++++++++
 tests/generic/791     | 86 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/791.out |  7 ++++
 5 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 src/fanotify.c
 create mode 100644 tests/generic/791
 create mode 100644 tests/generic/791.out

diff --git a/.gitignore b/.gitignore
index 82c57f415301..7f91310ce58b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -212,6 +212,7 @@ tags
 /src/dio-writeback-race
 /src/unlink-fsync
 /src/file_attr
+/src/fanotify
 
 # Symlinked files
 /tests/generic/035.out
diff --git a/src/Makefile b/src/Makefile
index d0a4106e6be8..ff71cde936a7 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
 	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
-	rw_hint
+	rw_hint fanotify
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/fanotify.c b/src/fanotify.c
new file mode 100644
index 000000000000..e30c48dc0e52
--- /dev/null
+++ b/src/fanotify.c
@@ -0,0 +1,66 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+ *
+ * Simple fanotify monitor to verify mount-point event isolation.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <stdint.h>
+#include <sys/fanotify.h>
+
+int main(int argc, char *argv[])
+{
+	int fd;
+	char buf[4096] __attribute__((aligned(8)));
+	setlinebuf(stdout);
+
+	if (argc < 2) {
+		fprintf(stderr, "Usage: %s <path>\n", argv[0]);
+		return 1;
+	}
+
+	// Initialize with FID reporting
+	fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
+	if (fd < 0) {
+		perror("fanotify_init");
+		return 1;
+	}
+
+	if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+			  FAN_CREATE, AT_FDCWD, argv[1]) < 0) {
+		perror("fanotify_mark");
+		return 1;
+	}
+
+	printf("Listening for events on %s...\n", argv[1]);
+	while (1) {
+		struct fanotify_event_metadata *metadata = (struct fanotify_event_metadata *)buf;
+		ssize_t len = read(fd, buf, sizeof(buf));
+
+		if (len <= 0) break;
+
+		while (FAN_EVENT_OK(metadata, len)) {
+			// metadata_len is the offset to the first info record
+			if (metadata->event_len > metadata->metadata_len) {
+				struct fanotify_event_info_header *hdr =
+(struct fanotify_event_info_header *)((char *)metadata + metadata->metadata_len);
+
+				if (hdr->info_type == FAN_EVENT_INFO_TYPE_FID) {
+					struct fanotify_event_info_fid *fid = (struct fanotify_event_info_fid *)hdr;
+					printf("FSID: %08x%08x\n",
+						fid->fsid.val[0], fid->fsid.val[1]);
+				}
+			}
+			metadata = FAN_EVENT_NEXT(metadata, len);
+		}
+	}
+
+	fflush(stdout);
+	close(fd);
+	return 0;
+}
diff --git a/tests/generic/791 b/tests/generic/791
new file mode 100644
index 000000000000..fe8109083732
--- /dev/null
+++ b/tests/generic/791
@@ -0,0 +1,86 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Anand Jain <asj@kernel.org>.  All Rights Reserved.
+#
+# FS QA Test 791
+# Verify fanotify FID functionality on cloned filesystems by setting up
+# watchers and making sure notifications are in the correct logs files.
+
+. ./common/preamble
+
+_begin_fstest auto quick mount clone
+
+_require_test
+_require_scratch_dev_pool 2
+
+[ "$FSTYP" = "ext4" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"ext4: derive f_fsid from block device to avoid collisions"
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
+fsid1=$(stat -f -c "%i" $SCRATCH_MNT)
+fsid2=$(stat -f -c "%i" $mnt2)
+
+[[ "$fsid1" == "$fsid2" ]] && \
+	_notrun "Require clone filesystem with unique f_fsid"
+
+log1=$tmp.fanotify1
+log2=$tmp.fanotify2
+
+echo "Setup FID fanotify watchers on both SCRATCH_MNT and mnt2"
+$here/src/fanotify $SCRATCH_MNT > $log1 2>&1 &
+pid1=$!
+$here/src/fanotify $mnt2 > $log2 2>&1 &
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
+echo "Verify fsid in the fanotify"
+kill $pid1 $pid2
+wait $pid1 $pid2 2>/dev/null
+
+echo fsid1=$fsid1 fsid2=$fsid2 >> $seqres.full
+cat $log1 >> $seqres.full
+cat $log2 >> $seqres.full
+
+if grep -q "${fsid1}" $log1 && ! grep -q "${fsid2}" $log1; then
+	echo "SUCCESS: SCRATCH_MNT events found"
+else
+	[ ! -s $log1 ] && echo "  - SCRATCH_MNT received no events."
+	grep -q "${fsid2}" $log1 && echo "  - SCRATCH_MNT received event from mnt2."
+fi
+
+if grep -q "${fsid2}" $log2 && ! grep -q "${fsid1}" $log2; then
+	echo "SUCCESS: mnt2 events found"
+else
+	[ ! -s $log2 ] && echo "  - mnt2 received no events."
+	grep -q "${fsid1}" $log2 && echo "  - mnt2 received event from SCRATCH_MNT."
+fi
+
+status=0
+exit
diff --git a/tests/generic/791.out b/tests/generic/791.out
new file mode 100644
index 000000000000..9725c99bcb4b
--- /dev/null
+++ b/tests/generic/791.out
@@ -0,0 +1,7 @@
+QA output created by 791
+Setup FID fanotify watchers on both SCRATCH_MNT and mnt2
+Trigger file creation on SCRATCH_MNT
+Trigger file creation on mnt2
+Verify fsid in the fanotify
+SUCCESS: SCRATCH_MNT events found
+SUCCESS: mnt2 events found
-- 
2.43.0



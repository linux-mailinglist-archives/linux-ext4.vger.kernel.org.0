Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D432D42F1F
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jun 2019 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403765AbfFLSkm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jun 2019 14:40:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47570 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfFLSkm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jun 2019 14:40:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D20092610C6
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 1/2] common/casefold: Add infrastructure to test filename casefold feature
Date:   Wed, 12 Jun 2019 14:40:32 -0400
Message-Id: <20190612184033.21845-1-krisman@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a set of basic helper functions to simplify the testing of
casefolding capable filesystems.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 common/casefold | 92 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 common/casefold

diff --git a/common/casefold b/common/casefold
new file mode 100644
index 000000000000..df01029a3d44
--- /dev/null
+++ b/common/casefold
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2019 Collabora, Ltd.  All Rights Reserved.
+#
+# Common functions for testing filename casefold feature
+
+_has_casefold_kernel_support()
+{
+	case $FSTYP in
+		ext4)
+			test -f '/sys/fs/ext4/features/casefold'
+			;;
+		*)
+			# defaults to unsupported
+			false
+			;;
+	esac
+}
+
+_require_scratch_casefold()
+{
+	if ! _has_casefold_kernel_support ; then
+		_notrun "$FSTYP does not support casefold feature"
+	fi
+
+	if ! _scratch_mkfs_casefold &>>seqres.full; then
+		_notrun "$FSTYP userspace tools do not support casefold"
+	fi
+
+	# Make sure the kernel can mount a filesystem with the encoding
+	# defined by the userspace tools.  This will fail if
+	# the userspace tool used a more recent encoding than the one
+	# supported in kernel space.
+	if ! _try_scratch_mount &>>seqres.full; then
+		_notrun \
+		    "kernel can't mount filesystem with the encoding set by userspace"
+	fi
+	_scratch_unmount
+
+	# utilities used by casefold
+	_require_command "$CHATTR_PROG" chattr
+	_require_command "$LSATTR_PROG" lsattr
+}
+
+_scratch_mkfs_casefold()
+{
+	case $FSTYP in
+		ext4)
+			_scratch_mkfs -O casefold $*
+			;;
+		*)
+			_notrun "Don't know how to mkfs with casefold support on $FSTYP"
+			;;
+	esac
+}
+
+_scratch_mkfs_casefold_strict()
+{
+	case $FSTYP in
+		ext4)
+			_scratch_mkfs -O casefold -E encoding_flags=strict
+			;;
+		*)
+			_notrun \
+			    "Don't know how to mkfs with casefold-strict support on $FSTYP"
+			;;
+	esac
+}
+
+# To get the exact disk name, we need some method that does a
+# getdents() on the parent directory, such that we don't get
+# normalized/casefolded results.  'Find' works ok.
+_casefold_check_exact_name()
+{
+	local basedir=$1
+	local exact_name=$2
+	find ${basedir} | grep -q ${exact_name}
+}
+
+_casefold_set_attr()
+{
+	$CHATTR_PROG +F "${1}"
+}
+
+_casefold_unset_attr()
+{
+	$CHATTR_PROG -F "${1}"
+}
+
+_casefold_lsattr_dir()
+{
+	$LSATTR_PROG -ld "${1}" | _filter_spaces
+}
-- 
2.20.1


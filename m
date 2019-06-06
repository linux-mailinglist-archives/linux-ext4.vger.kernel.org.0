Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 574FD37D3F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2019 21:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfFFTbw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jun 2019 15:31:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60352 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFFTbw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jun 2019 15:31:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 37662283DB8
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 1/2] common/casefold: Add infrastructure to test filename casefold feature
Date:   Thu,  6 Jun 2019 15:31:37 -0400
Message-Id: <20190606193138.25852-1-krisman@collabora.com>
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
 common/casefold | 108 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 common/casefold

diff --git a/common/casefold b/common/casefold
new file mode 100644
index 000000000000..34c1d4ae1af1
--- /dev/null
+++ b/common/casefold
@@ -0,0 +1,108 @@
+#-----------------------------------------------------------------------
+#
+# Common functions for testing filename casefold feature
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2018 Collabora, Ltd.  All Rights Reserved.
+#
+# Author: Gabriel Krisman Bertazi <krisman@collabora.com>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+
+_has_casefold_feature_kernel_support() {
+    case $FSTYP in
+	ext4)
+	    test -f '/sys/fs/ext4/features/casefold'
+	    ;;
+	*)
+	    # defaults to unsupported
+	    false
+	    ;;
+    esac
+}
+
+_require_casefold_support() {
+    if ! _has_casefold_feature_kernel_support ; then
+	_notrun "$FSTYP does not support casefold feature"
+    fi
+
+    if ! _scratch_mkfs_casefold &>>seqres.full; then
+	_notrun "$FSTYP userspace tools do not support casefold"
+    fi
+
+    # Make sure the kernel can mount a filesystem with the encoding
+    # defined by the userspace tools.  This will fail if
+    # the userspace tool used a more recent encoding than the one
+    # supported in kernel space.
+    if ! _try_scratch_mount &>>seqres.full; then
+	_notrun \
+	    "kernel can't mount filesystem using the encoding set by userspace"
+    fi
+    _scratch_unmount
+}
+
+_scratch_mkfs_casefold () {
+    case $FSTYP in
+	ext4)
+	    _scratch_mkfs -O casefold $*
+	    ;;
+	*)
+	    _notrun "Don't know how to mkfs with casefold support on $FSTYP"
+	    ;;
+	esac
+}
+
+_scratch_mkfs_casefold_strict () {
+    case $FSTYP in
+	ext4)
+	    _scratch_mkfs -O casefold -E encoding_flags=strict
+	    ;;
+	*)
+	    _notrun \
+		"Don't know how to mkfs with casefold-strict support on $FSTYP"
+	    ;;
+	esac
+}
+
+_casefold_check_exact_name () {
+    # To get the exact disk name, we need some method that does a
+    # getdents() on the parent directory, such that we don't get
+    # normalized/casefolded results.  'Find' works ok.
+    basedir=$1
+    exact_name=$2
+    find ${basedir} | grep -q ${exact_name}
+}
+
+_try_set_casefold_attr () {
+    chattr +F "${1}" &>/dev/null
+}
+
+_try_unset_casefold_attr () {
+    chattr -F "${1}" &>/dev/null
+}
+
+_set_casefold_attr () {
+    _try_set_casefold_attr "${1}" || \
+	_fail "Unable to set casefold attribute on ${1}"
+}
+
+_unset_casefold_attr () {
+    _try_unset_casefold_attr "${1}" || \
+	_fail "Unable to unset casefold attribute on ${1}"
+}
+
+_is_casefolded_dir () {
+    lsattr -ld "${1}" | grep -q "Casefold"
+}
-- 
2.20.1


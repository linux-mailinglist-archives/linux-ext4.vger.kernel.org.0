Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3D15416
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2019 20:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfEFS77 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 May 2019 14:59:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33078 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEFS76 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 May 2019 14:59:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id CAAC32735FD
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     fstests@vger.kernel.org
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH xfstests 1/2] common/casefold: Add infrastructure to test filename casefold feature
Date:   Mon,  6 May 2019 14:59:40 -0400
Message-Id: <20190506185941.10570-1-krisman@collabora.com>
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
 common/casefold | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 common/casefold

diff --git a/common/casefold b/common/casefold
new file mode 100644
index 000000000000..c2436179265e
--- /dev/null
+++ b/common/casefold
@@ -0,0 +1,74 @@
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
+_has_casefold_feature() {
+    dumpe2fs -h "$1" 2>&1 | grep -Gq "Filesystem features.*casefold"
+}
+
+_require_test_casefold_feature () {
+    _has_casefold_feature $TEST_DEV || \
+	_notrun "Feature casefold required for this test"
+}
+_require_scratch_casefold_feature () {
+    _has_casefold_feature $SCRATCH_DEV || \
+	_notrun "Feature casefold required for this test"
+}
+_exclude_test_casefold_feature () {
+    _has_casefold_feature $TEST_DEV && \
+	_notrun "Feature casefold forbidden for this test"
+}
+_exclude_scratch_casefold_feature () {
+    _has_casefold_feature $SCRATCH_DEV && \
+	_notrun "Feature casefold forbidden for this test"
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


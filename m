Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F864D50C9
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Mar 2022 18:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiCJRpP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Mar 2022 12:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiCJRpO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Mar 2022 12:45:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C3D180D0F
        for <linux-ext4@vger.kernel.org>; Thu, 10 Mar 2022 09:44:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FE3061DEA
        for <linux-ext4@vger.kernel.org>; Thu, 10 Mar 2022 17:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E44C340E8;
        Thu, 10 Mar 2022 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646934250;
        bh=bZ5toTTlnEJ5kLVLkXnkssZ2AG1nXVxxkxY6+xyW4+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvFpCERpRidfp5VUU/Jdt6i9fNZvTNvza3ru+sXem1MXRaxaT9BP6VbaKa4Sqt1Yb
         XCXsNwOHkmXSxwgUFhgaolqb20v1WKlK7hba9FruPvAC18IOt4+no4evYBdYqrqE+z
         Tbzx6P1qVypG0aulY2F/bgR+DA+Pii5mKk9PilVAimBWwZT07u9o1s5z06UCvBX7mF
         SKxkvk7zmlCL3E4ag+oe0khQvQQg/RCllwihVSruAiZ4iowKV7juz8I5iMQppthJVy
         h4sUDozKDMA+XnVjnbjCQsYBjeX4N39sSR/x/O6AVG5xxeKvJN7Iy0bK//5Ty38qVg
         xc/u+QZyLInhA==
Date:   Thu, 10 Mar 2022 09:44:10 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Cc:     ebiggers@kernel.org
Subject: [PATCH RFC] fstests: ensure we drop suid after fallocate
Message-ID: <20220310174410.GB8172@magnolia>
References: <20220308185043.GA117678@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308185043.GA117678@magnolia>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

fallocate changes file contents, so make sure that we drop privileges
and file capabilities after each fallocate operation.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/generic/834     |  129 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/834.out |   33 +++++++++++++
 tests/generic/835     |  129 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/835.out |   33 +++++++++++++
 tests/generic/836     |  129 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/836.out |   33 +++++++++++++
 tests/generic/837     |  129 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/837.out |   33 +++++++++++++
 tests/generic/838     |  129 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/838.out |   33 +++++++++++++
 tests/generic/839     |   79 ++++++++++++++++++++++++++++++
 tests/generic/839.out |   13 +++++
 12 files changed, 902 insertions(+)
 create mode 100755 tests/generic/834
 create mode 100644 tests/generic/834.out
 create mode 100755 tests/generic/835
 create mode 100644 tests/generic/835.out
 create mode 100755 tests/generic/836
 create mode 100644 tests/generic/836.out
 create mode 100755 tests/generic/837
 create mode 100644 tests/generic/837.out
 create mode 100755 tests/generic/838
 create mode 100644 tests/generic/838.out
 create mode 100755 tests/generic/839
 create mode 100755 tests/generic/839.out

diff --git a/tests/generic/834 b/tests/generic/834
new file mode 100755
index 00000000..27552221
--- /dev/null
+++ b/tests/generic/834
@@ -0,0 +1,129 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Oracle.  All Rights Reserved.
+#
+# FS QA Test No. 834
+#
+# Functional test for dropping suid and sgid bits as part of a fallocate.
+#
+. ./common/preamble
+_begin_fstest auto clone quick
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.* $junk_dir
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_user
+_require_test
+verb=falloc
+_require_xfs_io_command $verb
+
+_require_congruent_file_oplen $TEST_DIR 65536
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/a
+mkdir -p $junk_dir/
+chmod a+rw $junk_dir/
+
+setup_testfile() {
+	rm -f $junk_file
+	_pwrite_byte 0x58 0 192k $junk_file >> $seqres.full
+	sync
+}
+
+commit_and_check() {
+	local user="$1"
+	local command="$2"
+	local start="$3"
+	local end="$4"
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+
+	local cmd="$XFS_IO_PROG -c '$command $start $end' $junk_file"
+	if [ -n "$user" ]; then
+		su - "$user" -c "$cmd" >> $seqres.full
+	else
+		$SHELL -c "$cmd" >> $seqres.full
+	fi
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+
+	# Blank line in output
+	echo
+}
+
+nr=0
+# Commit to a non-exec file by an unprivileged user clears suid but
+# leaves sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, non-exec file $verb"
+setup_testfile
+chmod a+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a group-exec file by an unprivileged user clears suid and
+# sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, group-exec file $verb"
+setup_testfile
+chmod g+x,a+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a user-exec file by an unprivileged user clears suid but
+# not sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, user-exec file $verb"
+setup_testfile
+chmod u+x,a+rws,g-x $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a all-exec file by an unprivileged user clears suid and
+# sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, all-exec file $verb"
+setup_testfile
+chmod a+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a non-exec file by root clears suid but leaves sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, non-exec file $verb"
+setup_testfile
+chmod a+rws $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a group-exec file by root clears suid and sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, group-exec file $verb"
+setup_testfile
+chmod g+x,a+rws $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a user-exec file by root clears suid but not sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, user-exec file $verb"
+setup_testfile
+chmod u+x,a+rws,g-x $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a all-exec file by root clears suid and sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, all-exec file $verb"
+setup_testfile
+chmod a+rwxs $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/834.out b/tests/generic/834.out
new file mode 100644
index 00000000..2226eea6
--- /dev/null
+++ b/tests/generic/834.out
@@ -0,0 +1,33 @@
+QA output created by 834
+Test 1 - qa_user, non-exec file falloc
+6666 -rwSrwSrw- TEST_DIR/834/a
+666 -rw-rw-rw- TEST_DIR/834/a
+
+Test 2 - qa_user, group-exec file falloc
+6676 -rwSrwsrw- TEST_DIR/834/a
+676 -rw-rwxrw- TEST_DIR/834/a
+
+Test 3 - qa_user, user-exec file falloc
+6766 -rwsrwSrw- TEST_DIR/834/a
+766 -rwxrw-rw- TEST_DIR/834/a
+
+Test 4 - qa_user, all-exec file falloc
+6777 -rwsrwsrwx TEST_DIR/834/a
+777 -rwxrwxrwx TEST_DIR/834/a
+
+Test 5 - root, non-exec file falloc
+6666 -rwSrwSrw- TEST_DIR/834/a
+6666 -rwSrwSrw- TEST_DIR/834/a
+
+Test 6 - root, group-exec file falloc
+6676 -rwSrwsrw- TEST_DIR/834/a
+6676 -rwSrwsrw- TEST_DIR/834/a
+
+Test 7 - root, user-exec file falloc
+6766 -rwsrwSrw- TEST_DIR/834/a
+6766 -rwsrwSrw- TEST_DIR/834/a
+
+Test 8 - root, all-exec file falloc
+6777 -rwsrwsrwx TEST_DIR/834/a
+6777 -rwsrwsrwx TEST_DIR/834/a
+
diff --git a/tests/generic/835 b/tests/generic/835
new file mode 100755
index 00000000..56e4d80c
--- /dev/null
+++ b/tests/generic/835
@@ -0,0 +1,129 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Oracle.  All Rights Reserved.
+#
+# FS QA Test No. 835
+#
+# Functional test for dropping suid and sgid bits as part of a fpunch.
+#
+. ./common/preamble
+_begin_fstest auto clone quick
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.* $junk_dir
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_user
+_require_test
+verb=fpunch
+_require_xfs_io_command $verb
+
+_require_congruent_file_oplen $TEST_DIR 65536
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/a
+mkdir -p $junk_dir/
+chmod a+rw $junk_dir/
+
+setup_testfile() {
+	rm -f $junk_file
+	_pwrite_byte 0x58 0 192k $junk_file >> $seqres.full
+	sync
+}
+
+commit_and_check() {
+	local user="$1"
+	local command="$2"
+	local start="$3"
+	local end="$4"
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+
+	local cmd="$XFS_IO_PROG -c '$command $start $end' $junk_file"
+	if [ -n "$user" ]; then
+		su - "$user" -c "$cmd" >> $seqres.full
+	else
+		$SHELL -c "$cmd" >> $seqres.full
+	fi
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+
+	# Blank line in output
+	echo
+}
+
+nr=0
+# Commit to a non-exec file by an unprivileged user clears suid but
+# leaves sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, non-exec file $verb"
+setup_testfile
+chmod a+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a group-exec file by an unprivileged user clears suid and
+# sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, group-exec file $verb"
+setup_testfile
+chmod g+x,a+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a user-exec file by an unprivileged user clears suid but
+# not sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, user-exec file $verb"
+setup_testfile
+chmod u+x,a+rws,g-x $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a all-exec file by an unprivileged user clears suid and
+# sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, all-exec file $verb"
+setup_testfile
+chmod a+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a non-exec file by root clears suid but leaves sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, non-exec file $verb"
+setup_testfile
+chmod a+rws $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a group-exec file by root clears suid and sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, group-exec file $verb"
+setup_testfile
+chmod g+x,a+rws $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a user-exec file by root clears suid but not sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, user-exec file $verb"
+setup_testfile
+chmod u+x,a+rws,g-x $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a all-exec file by root clears suid and sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, all-exec file $verb"
+setup_testfile
+chmod a+rwxs $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/835.out b/tests/generic/835.out
new file mode 100644
index 00000000..186d7da4
--- /dev/null
+++ b/tests/generic/835.out
@@ -0,0 +1,33 @@
+QA output created by 835
+Test 1 - qa_user, non-exec file fpunch
+6666 -rwSrwSrw- TEST_DIR/835/a
+666 -rw-rw-rw- TEST_DIR/835/a
+
+Test 2 - qa_user, group-exec file fpunch
+6676 -rwSrwsrw- TEST_DIR/835/a
+676 -rw-rwxrw- TEST_DIR/835/a
+
+Test 3 - qa_user, user-exec file fpunch
+6766 -rwsrwSrw- TEST_DIR/835/a
+766 -rwxrw-rw- TEST_DIR/835/a
+
+Test 4 - qa_user, all-exec file fpunch
+6777 -rwsrwsrwx TEST_DIR/835/a
+777 -rwxrwxrwx TEST_DIR/835/a
+
+Test 5 - root, non-exec file fpunch
+6666 -rwSrwSrw- TEST_DIR/835/a
+6666 -rwSrwSrw- TEST_DIR/835/a
+
+Test 6 - root, group-exec file fpunch
+6676 -rwSrwsrw- TEST_DIR/835/a
+6676 -rwSrwsrw- TEST_DIR/835/a
+
+Test 7 - root, user-exec file fpunch
+6766 -rwsrwSrw- TEST_DIR/835/a
+6766 -rwsrwSrw- TEST_DIR/835/a
+
+Test 8 - root, all-exec file fpunch
+6777 -rwsrwsrwx TEST_DIR/835/a
+6777 -rwsrwsrwx TEST_DIR/835/a
+
diff --git a/tests/generic/836 b/tests/generic/836
new file mode 100755
index 00000000..b355f6e9
--- /dev/null
+++ b/tests/generic/836
@@ -0,0 +1,129 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Oracle.  All Rights Reserved.
+#
+# FS QA Test No. 836
+#
+# Functional test for dropping suid and sgid bits as part of a fzero.
+#
+. ./common/preamble
+_begin_fstest auto clone quick
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.* $junk_dir
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_user
+_require_test
+verb=fzero
+_require_xfs_io_command $verb
+
+_require_congruent_file_oplen $TEST_DIR 65536
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/a
+mkdir -p $junk_dir/
+chmod a+rw $junk_dir/
+
+setup_testfile() {
+	rm -f $junk_file
+	_pwrite_byte 0x58 0 192k $junk_file >> $seqres.full
+	sync
+}
+
+commit_and_check() {
+	local user="$1"
+	local command="$2"
+	local start="$3"
+	local end="$4"
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+
+	local cmd="$XFS_IO_PROG -c '$command $start $end' $junk_file"
+	if [ -n "$user" ]; then
+		su - "$user" -c "$cmd" >> $seqres.full
+	else
+		$SHELL -c "$cmd" >> $seqres.full
+	fi
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+
+	# Blank line in output
+	echo
+}
+
+nr=0
+# Commit to a non-exec file by an unprivileged user clears suid but
+# leaves sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, non-exec file $verb"
+setup_testfile
+chmod a+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a group-exec file by an unprivileged user clears suid and
+# sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, group-exec file $verb"
+setup_testfile
+chmod g+x,a+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a user-exec file by an unprivileged user clears suid but
+# not sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, user-exec file $verb"
+setup_testfile
+chmod u+x,a+rws,g-x $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a all-exec file by an unprivileged user clears suid and
+# sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, all-exec file $verb"
+setup_testfile
+chmod a+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a non-exec file by root clears suid but leaves sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, non-exec file $verb"
+setup_testfile
+chmod a+rws $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a group-exec file by root clears suid and sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, group-exec file $verb"
+setup_testfile
+chmod g+x,a+rws $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a user-exec file by root clears suid but not sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, user-exec file $verb"
+setup_testfile
+chmod u+x,a+rws,g-x $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a all-exec file by root clears suid and sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, all-exec file $verb"
+setup_testfile
+chmod a+rwxs $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/836.out b/tests/generic/836.out
new file mode 100644
index 00000000..9f9f5f12
--- /dev/null
+++ b/tests/generic/836.out
@@ -0,0 +1,33 @@
+QA output created by 836
+Test 1 - qa_user, non-exec file fzero
+6666 -rwSrwSrw- TEST_DIR/836/a
+666 -rw-rw-rw- TEST_DIR/836/a
+
+Test 2 - qa_user, group-exec file fzero
+6676 -rwSrwsrw- TEST_DIR/836/a
+676 -rw-rwxrw- TEST_DIR/836/a
+
+Test 3 - qa_user, user-exec file fzero
+6766 -rwsrwSrw- TEST_DIR/836/a
+766 -rwxrw-rw- TEST_DIR/836/a
+
+Test 4 - qa_user, all-exec file fzero
+6777 -rwsrwsrwx TEST_DIR/836/a
+777 -rwxrwxrwx TEST_DIR/836/a
+
+Test 5 - root, non-exec file fzero
+6666 -rwSrwSrw- TEST_DIR/836/a
+6666 -rwSrwSrw- TEST_DIR/836/a
+
+Test 6 - root, group-exec file fzero
+6676 -rwSrwsrw- TEST_DIR/836/a
+6676 -rwSrwsrw- TEST_DIR/836/a
+
+Test 7 - root, user-exec file fzero
+6766 -rwsrwSrw- TEST_DIR/836/a
+6766 -rwsrwSrw- TEST_DIR/836/a
+
+Test 8 - root, all-exec file fzero
+6777 -rwsrwsrwx TEST_DIR/836/a
+6777 -rwsrwsrwx TEST_DIR/836/a
+
diff --git a/tests/generic/837 b/tests/generic/837
new file mode 100755
index 00000000..348a9168
--- /dev/null
+++ b/tests/generic/837
@@ -0,0 +1,129 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Oracle.  All Rights Reserved.
+#
+# FS QA Test No. 837
+#
+# Functional test for dropping suid and sgid bits as part of a finsert.
+#
+. ./common/preamble
+_begin_fstest auto clone quick
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.* $junk_dir
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_user
+_require_test
+verb=finsert
+_require_xfs_io_command $verb
+
+_require_congruent_file_oplen $TEST_DIR 65536
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/a
+mkdir -p $junk_dir/
+chmod a+rw $junk_dir/
+
+setup_testfile() {
+	rm -f $junk_file
+	_pwrite_byte 0x58 0 192k $junk_file >> $seqres.full
+	sync
+}
+
+commit_and_check() {
+	local user="$1"
+	local command="$2"
+	local start="$3"
+	local end="$4"
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+
+	local cmd="$XFS_IO_PROG -c '$command $start $end' $junk_file"
+	if [ -n "$user" ]; then
+		su - "$user" -c "$cmd" >> $seqres.full
+	else
+		$SHELL -c "$cmd" >> $seqres.full
+	fi
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+
+	# Blank line in output
+	echo
+}
+
+nr=0
+# Commit to a non-exec file by an unprivileged user clears suid but
+# leaves sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, non-exec file $verb"
+setup_testfile
+chmod a+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a group-exec file by an unprivileged user clears suid and
+# sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, group-exec file $verb"
+setup_testfile
+chmod g+x,a+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a user-exec file by an unprivileged user clears suid but
+# not sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, user-exec file $verb"
+setup_testfile
+chmod u+x,a+rws,g-x $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a all-exec file by an unprivileged user clears suid and
+# sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, all-exec file $verb"
+setup_testfile
+chmod a+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a non-exec file by root clears suid but leaves sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, non-exec file $verb"
+setup_testfile
+chmod a+rws $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a group-exec file by root clears suid and sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, group-exec file $verb"
+setup_testfile
+chmod g+x,a+rws $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a user-exec file by root clears suid but not sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, user-exec file $verb"
+setup_testfile
+chmod u+x,a+rws,g-x $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a all-exec file by root clears suid and sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, all-exec file $verb"
+setup_testfile
+chmod a+rwxs $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/837.out b/tests/generic/837.out
new file mode 100644
index 00000000..686b806e
--- /dev/null
+++ b/tests/generic/837.out
@@ -0,0 +1,33 @@
+QA output created by 837
+Test 1 - qa_user, non-exec file finsert
+6666 -rwSrwSrw- TEST_DIR/837/a
+666 -rw-rw-rw- TEST_DIR/837/a
+
+Test 2 - qa_user, group-exec file finsert
+6676 -rwSrwsrw- TEST_DIR/837/a
+676 -rw-rwxrw- TEST_DIR/837/a
+
+Test 3 - qa_user, user-exec file finsert
+6766 -rwsrwSrw- TEST_DIR/837/a
+766 -rwxrw-rw- TEST_DIR/837/a
+
+Test 4 - qa_user, all-exec file finsert
+6777 -rwsrwsrwx TEST_DIR/837/a
+777 -rwxrwxrwx TEST_DIR/837/a
+
+Test 5 - root, non-exec file finsert
+6666 -rwSrwSrw- TEST_DIR/837/a
+6666 -rwSrwSrw- TEST_DIR/837/a
+
+Test 6 - root, group-exec file finsert
+6676 -rwSrwsrw- TEST_DIR/837/a
+6676 -rwSrwsrw- TEST_DIR/837/a
+
+Test 7 - root, user-exec file finsert
+6766 -rwsrwSrw- TEST_DIR/837/a
+6766 -rwsrwSrw- TEST_DIR/837/a
+
+Test 8 - root, all-exec file finsert
+6777 -rwsrwsrwx TEST_DIR/837/a
+6777 -rwsrwsrwx TEST_DIR/837/a
+
diff --git a/tests/generic/838 b/tests/generic/838
new file mode 100755
index 00000000..1e76b584
--- /dev/null
+++ b/tests/generic/838
@@ -0,0 +1,129 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Oracle.  All Rights Reserved.
+#
+# FS QA Test No. 838
+#
+# Functional test for dropping suid and sgid bits as part of a fcollapse.
+#
+. ./common/preamble
+_begin_fstest auto clone quick
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.* $junk_dir
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_user
+_require_test
+verb=fcollapse
+_require_xfs_io_command $verb
+
+_require_congruent_file_oplen $TEST_DIR 65536
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/a
+mkdir -p $junk_dir/
+chmod a+rw $junk_dir/
+
+setup_testfile() {
+	rm -f $junk_file
+	_pwrite_byte 0x58 0 192k $junk_file >> $seqres.full
+	sync
+}
+
+commit_and_check() {
+	local user="$1"
+	local command="$2"
+	local start="$3"
+	local end="$4"
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+
+	local cmd="$XFS_IO_PROG -c '$command $start $end' $junk_file"
+	if [ -n "$user" ]; then
+		su - "$user" -c "$cmd" >> $seqres.full
+	else
+		$SHELL -c "$cmd" >> $seqres.full
+	fi
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+
+	# Blank line in output
+	echo
+}
+
+nr=0
+# Commit to a non-exec file by an unprivileged user clears suid but
+# leaves sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, non-exec file $verb"
+setup_testfile
+chmod a+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a group-exec file by an unprivileged user clears suid and
+# sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, group-exec file $verb"
+setup_testfile
+chmod g+x,a+rws $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a user-exec file by an unprivileged user clears suid but
+# not sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, user-exec file $verb"
+setup_testfile
+chmod u+x,a+rws,g-x $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a all-exec file by an unprivileged user clears suid and
+# sgid.
+nr=$((nr + 1))
+echo "Test $nr - qa_user, all-exec file $verb"
+setup_testfile
+chmod a+rwxs $junk_file
+commit_and_check "$qa_user" "$verb" 64k 64k
+
+# Commit to a non-exec file by root clears suid but leaves sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, non-exec file $verb"
+setup_testfile
+chmod a+rws $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a group-exec file by root clears suid and sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, group-exec file $verb"
+setup_testfile
+chmod g+x,a+rws $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a user-exec file by root clears suid but not sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, user-exec file $verb"
+setup_testfile
+chmod u+x,a+rws,g-x $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# Commit to a all-exec file by root clears suid and sgid.
+nr=$((nr + 1))
+echo "Test $nr - root, all-exec file $verb"
+setup_testfile
+chmod a+rwxs $junk_file
+commit_and_check "" "$verb" 64k 64k
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/838.out b/tests/generic/838.out
new file mode 100644
index 00000000..cdc29f4b
--- /dev/null
+++ b/tests/generic/838.out
@@ -0,0 +1,33 @@
+QA output created by 838
+Test 1 - qa_user, non-exec file fcollapse
+6666 -rwSrwSrw- TEST_DIR/838/a
+666 -rw-rw-rw- TEST_DIR/838/a
+
+Test 2 - qa_user, group-exec file fcollapse
+6676 -rwSrwsrw- TEST_DIR/838/a
+676 -rw-rwxrw- TEST_DIR/838/a
+
+Test 3 - qa_user, user-exec file fcollapse
+6766 -rwsrwSrw- TEST_DIR/838/a
+766 -rwxrw-rw- TEST_DIR/838/a
+
+Test 4 - qa_user, all-exec file fcollapse
+6777 -rwsrwsrwx TEST_DIR/838/a
+777 -rwxrwxrwx TEST_DIR/838/a
+
+Test 5 - root, non-exec file fcollapse
+6666 -rwSrwSrw- TEST_DIR/838/a
+6666 -rwSrwSrw- TEST_DIR/838/a
+
+Test 6 - root, group-exec file fcollapse
+6676 -rwSrwsrw- TEST_DIR/838/a
+6676 -rwSrwsrw- TEST_DIR/838/a
+
+Test 7 - root, user-exec file fcollapse
+6766 -rwsrwSrw- TEST_DIR/838/a
+6766 -rwsrwSrw- TEST_DIR/838/a
+
+Test 8 - root, all-exec file fcollapse
+6777 -rwsrwsrwx TEST_DIR/838/a
+6777 -rwsrwsrwx TEST_DIR/838/a
+
diff --git a/tests/generic/839 b/tests/generic/839
new file mode 100755
index 00000000..a1e23916
--- /dev/null
+++ b/tests/generic/839
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Oracle.  All Rights Reserved.
+#
+# FS QA Test No. 839
+#
+# Functional test for dropping capability bits as part of an fallocate.
+#
+. ./common/preamble
+_begin_fstest auto fiexchange swapext quick
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.* $junk_dir
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_user
+_require_command "$GETCAP_PROG" getcap
+_require_command "$SETCAP_PROG" setcap
+_require_xfs_io_command falloc
+_require_test
+
+_require_congruent_file_oplen $TEST_DIR 65536
+
+junk_dir=$TEST_DIR/$seq
+junk_file=$junk_dir/a
+mkdir -p $junk_dir/
+chmod a+rw $junk_dir/
+
+setup_testfile() {
+	rm -f $junk_file
+	touch $junk_file
+	chmod a+rwx $junk_file
+	$SETCAP_PROG cap_setgid,cap_setuid+ep $junk_file
+	sync
+}
+
+commit_and_check() {
+	local user="$1"
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+	_getcap -v $junk_file | _filter_test_dir
+
+	local cmd="$XFS_IO_PROG -c 'falloc 0 64k' $junk_file"
+	if [ -n "$user" ]; then
+		su - "$user" -c "$cmd" >> $seqres.full
+	else
+		$SHELL -c "$cmd" >> $seqres.full
+	fi
+
+	stat -c '%a %A %n' $junk_file | _filter_test_dir
+	_getcap -v $junk_file | _filter_test_dir
+
+	# Blank line in output
+	echo
+}
+
+# Commit by an unprivileged user clears capability bits.
+echo "Test 1 - qa_user"
+setup_testfile
+commit_and_check "$qa_user"
+
+# Commit by root leaves capability bits.
+echo "Test 2 - root"
+setup_testfile
+commit_and_check
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/839.out b/tests/generic/839.out
new file mode 100755
index 00000000..f571cd26
--- /dev/null
+++ b/tests/generic/839.out
@@ -0,0 +1,13 @@
+QA output created by 839
+Test 1 - qa_user
+777 -rwxrwxrwx TEST_DIR/839/a
+TEST_DIR/839/a cap_setgid,cap_setuid=ep
+777 -rwxrwxrwx TEST_DIR/839/a
+TEST_DIR/839/a
+
+Test 2 - root
+777 -rwxrwxrwx TEST_DIR/839/a
+TEST_DIR/839/a cap_setgid,cap_setuid=ep
+777 -rwxrwxrwx TEST_DIR/839/a
+TEST_DIR/839/a
+

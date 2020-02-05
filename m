Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1851528E0
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2020 11:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBEKJh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Feb 2020 05:09:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:53570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbgBEKJg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 Feb 2020 05:09:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07D8FB116;
        Wed,  5 Feb 2020 10:09:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D08051E0E42; Wed,  5 Feb 2020 11:01:47 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] tests: Add tests for ext2fs_link() into htree dir
Date:   Wed,  5 Feb 2020 11:01:38 +0100
Message-Id: <20200205100138.30053-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200205100138.30053-1-jack@suse.cz>
References: <20200205100138.30053-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add two tests adding 50000 files into a htree directory to test various
cases of htree modification.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/d_htree_link/expect.gz         | Bin 0 -> 141017 bytes
 tests/d_htree_link/image.gz          | Bin 0 -> 72945 bytes
 tests/d_htree_link/is_slow_test      |   0
 tests/d_htree_link/name              |   1 +
 tests/d_htree_link/script            |  48 +++++++++++++++++++++++++++++++++++
 tests/d_htree_link_csum/expect.gz    | Bin 0 -> 141009 bytes
 tests/d_htree_link_csum/image.gz     | Bin 0 -> 71810 bytes
 tests/d_htree_link_csum/is_slow_test |   0
 tests/d_htree_link_csum/name         |   1 +
 tests/d_htree_link_csum/script       |  48 +++++++++++++++++++++++++++++++++++
 10 files changed, 98 insertions(+)
 create mode 100644 tests/d_htree_link/expect.gz
 create mode 100644 tests/d_htree_link/image.gz
 create mode 100644 tests/d_htree_link/is_slow_test
 create mode 100644 tests/d_htree_link/name
 create mode 100644 tests/d_htree_link/script
 create mode 100644 tests/d_htree_link_csum/expect.gz
 create mode 100644 tests/d_htree_link_csum/image.gz
 create mode 100644 tests/d_htree_link_csum/is_slow_test
 create mode 100644 tests/d_htree_link_csum/name
 create mode 100644 tests/d_htree_link_csum/script

diff --git a/tests/d_htree_link/expect.gz b/tests/d_htree_link/expect.gz
new file mode 100644
index 0000000000000000000000000000000000000000..e47c18496763e3fecbc17a327b32528683e06e29
GIT binary patch
literal 141017
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
Xo{Lt?`Vr&qNACXUf81aFt403@q@y#i

literal 0
HcmV?d00001

diff --git a/tests/d_htree_link/image.gz b/tests/d_htree_link/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..1b600d8fc3af9f53e0ccffc6ed7f708bbf64024e
GIT binary patch
literal 72945
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
R{}zG3MM3@Ty>nfC@Na(`$LIh6

literal 0
HcmV?d00001

diff --git a/tests/d_htree_link/is_slow_test b/tests/d_htree_link/is_slow_test
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/d_htree_link/name b/tests/d_htree_link/name
new file mode 100644
index 000000000000..4e767ef83a16
--- /dev/null
+++ b/tests/d_htree_link/name
@@ -0,0 +1 @@
+link lots of files in htree dir
diff --git a/tests/d_htree_link/script b/tests/d_htree_link/script
new file mode 100644
index 000000000000..d6acc1d0a705
--- /dev/null
+++ b/tests/d_htree_link/script
@@ -0,0 +1,48 @@
+if ! test -x $DEBUGFS_EXE; then
+	echo "$test_name: $test_description: skipped (no debugfs)"
+	return 0
+fi
+
+FSCK_OPT=-fy
+OUT=$test_name.log
+if [ -f $test_dir/expect.gz ]; then
+	EXP=$test_name.tmp
+	gunzip < $test_dir/expect.gz > $EXP
+else
+	EXP=$test_dir/expect
+fi
+
+gunzip < $test_dir/image.gz > $TMPFILE
+
+# Generate command file for debugfs
+COUNT=50000
+for (( i = 0; i < $COUNT; i++ )); do
+	printf "ln link_target dir/a_rather_long_long_long_long_long_long_long_file_name_for_file%04d\n" $i
+done > $TMPFILE.cmd
+echo "set_inode_field link_target links_count $((COUNT+1))" >>$TMPFILE.cmd
+
+echo "debugfs link files" >> $OUT.new
+$DEBUGFS -w -f $TMPFILE.cmd $TMPFILE >> $OUT.new 2>&1
+
+$FSCK $FSCK_OPT -N test_filesys $TMPFILE >> $OUT.new 2>&1
+status=$?
+echo Exit status is $status >> $OUT.new
+sed -f $cmd_dir/filter.sed $OUT.new > $OUT
+rm -f $TMPFILE $TMPFILE.cmd $TMPFILE.cmd2 $OUT.new
+
+cmp -s $OUT $EXP
+status=$?
+
+if [ "$status" = 0 ] ; then
+	echo "$test_name: $test_description: ok"
+	touch $test_name.ok
+else
+	echo "$test_name: $test_description: failed"
+	diff $DIFF_OPTS $EXP $OUT > $test_name.failed
+fi
+
+if [ -f $test_dir/expect.gz ]; then
+	rm -f $EXP
+fi
+
+unset IMAGE FSCK_OPT OUT EXP
diff --git a/tests/d_htree_link_csum/expect.gz b/tests/d_htree_link_csum/expect.gz
new file mode 100644
index 0000000000000000000000000000000000000000..800e376a16bd18cbd2052da597e9a7c9ad43f210
GIT binary patch
literal 141009
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
OI}c6W<^0^Ym;DjLXpqYQ

literal 0
HcmV?d00001

diff --git a/tests/d_htree_link_csum/image.gz b/tests/d_htree_link_csum/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..4ef44c0c3a33b7176cabfa53190003d101e7cee7
GIT binary patch
literal 71810
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

literal 0
HcmV?d00001

diff --git a/tests/d_htree_link_csum/is_slow_test b/tests/d_htree_link_csum/is_slow_test
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/d_htree_link_csum/name b/tests/d_htree_link_csum/name
new file mode 100644
index 000000000000..8b47ad63e51f
--- /dev/null
+++ b/tests/d_htree_link_csum/name
@@ -0,0 +1 @@
+link lots of files in htree dir with metadata csum
diff --git a/tests/d_htree_link_csum/script b/tests/d_htree_link_csum/script
new file mode 100644
index 000000000000..ac345b8ee99b
--- /dev/null
+++ b/tests/d_htree_link_csum/script
@@ -0,0 +1,48 @@
+if ! test -x $DEBUGFS_EXE; then
+	echo "$test_name: $test_description: skipped (no debugfs)"
+	return 0
+fi
+
+FSCK_OPT=-fy
+OUT=$test_name.log
+if [ -f $test_dir/expect.gz ]; then
+	EXP=$test_name.tmp
+	gunzip < $test_dir/expect.gz > $EXP
+else
+	EXP=$test_dir/expect
+fi
+
+gunzip < $test_dir/image.gz > $TMPFILE
+
+# Generate command file for debugfs
+COUNT=50000
+for (( i = 0; i < $COUNT; i++ )); do
+	printf "ln link_target dir/a_rather_long_long_long_long_long_long_long_file_name_for_file%04d\n" $i
+done > $TMPFILE.cmd
+echo "set_inode_field link_target links_count $((COUNT+1))" >>$TMPFILE.cmd
+
+echo "debugfs link files" >> $OUT.new
+$DEBUGFS -w -f $TMPFILE.cmd $TMPFILE >> $OUT.new 2>&1
+
+$FSCK $FSCK_OPT -N test_filesys  $TMPFILE >> $OUT.new 2>&1
+status=$?
+echo Exit status is $status >> $OUT.new
+sed -f $cmd_dir/filter.sed $OUT.new > $OUT
+rm -f $TMPFILE $TMPFILE.cmd $TMPFILE.cmd2 $OUT.new
+
+cmp -s $OUT $EXP
+status=$?
+
+if [ "$status" = 0 ] ; then
+	echo "$test_name: $test_description: ok"
+	touch $test_name.ok
+else
+	echo "$test_name: $test_description: failed"
+	diff $DIFF_OPTS $EXP $OUT > $test_name.failed
+fi
+
+if [ -f $test_dir/expect.gz ]; then
+	rm -f $EXP
+fi
+
+unset IMAGE FSCK_OPT OUT EXP
-- 
2.16.4


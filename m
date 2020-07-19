Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E39225180
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Jul 2020 13:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgGSLIo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Jul 2020 07:08:44 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:34174 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgGSLIo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Jul 2020 07:08:44 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jul 2020 07:08:43 EDT
Received: from cabot.adilger.int ([70.77.221.9])
        by shaw.ca with ESMTP
        id x73Zjyec1ng7Kx73aj5HPV; Sun, 19 Jul 2020 05:00:35 -0600
X-Authority-Analysis: v=2.3 cv=ecemg4MH c=1 sm=1 tr=0
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=qSHJuj8W1XDaRDDPfbkA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] tests: replace perl usage with shell built-in
Date:   Sun, 19 Jul 2020 05:00:33 -0600
Message-Id: <20200719110033.78844-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
X-CMAE-Envelope: MS4wfMndP7t1W/G97Z+bf0tlfLVcE/x91jQpl6Poh5LeCsom5sYxGhlj2vG9evPh0FXYOLMhRQ+yB1JYwgTG75R4lEacfe1ehTsPIFBI6A+CFo07aahK9CBx
 lVPtoBrcohxfTdpU79Q2u0tvFpD3RMEaZG69lNDWkm3kzhAA/0gBysuvintZcH4nuRmlUaTJt8gHkl5oUTm4q71+fBm69QryBPJGaHFJu2OpAv0oEuqiaD4L
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A couple of tests use perl only for generating a string of
N characters long.  Instead of requiring perl to run a few
tests, use shell built-in commands and don't repeatedly run
a separate subshell just to get a string of characters.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 tests/d_xattr_sorting/script    |  2 +-
 tests/f_badsymlinks2/mkimage.sh |  4 +++-
 tests/f_create_symlinks/script  | 12 ++++++------
 util/gen-sample-fs              |  4 +++-
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tests/d_xattr_sorting/script b/tests/d_xattr_sorting/script
index 866611502012..65c74840f517 100644
--- a/tests/d_xattr_sorting/script
+++ b/tests/d_xattr_sorting/script
@@ -22,7 +22,7 @@ echo Exit status is $status >> $OUT.new
 
 B=$(mktemp ${TMPDIR:-/tmp}/b.XXXXXX)
 
-perl -e 'print "x" x 256;' > $B
+printf 'x%.0s' {1..256} > $B
 
 echo "ea_set -f /tmp/b / security.SMEG64" >> $OUT.new
 $DEBUGFS -w -R "ea_set -f $B / security.SMEG64" $TMPFILE >> $OUT.new 2>&1
diff --git a/tests/f_badsymlinks2/mkimage.sh b/tests/f_badsymlinks2/mkimage.sh
index 6bbf020de0d7..297633790bee 100755
--- a/tests/f_badsymlinks2/mkimage.sh
+++ b/tests/f_badsymlinks2/mkimage.sh
@@ -18,10 +18,12 @@ do_tune2fs() {
 	mount image mnt
 }
 
+A=$(printf 'A%.0s' {1..4096})
 symlink() {
 	local len=$1
 	local src=$2
-	local target=$(perl -e 'print "A" x '$len)
+	local target=${A:0:$len}
+
 	ln -s $target $src
 	stat -c %i $src
 }
diff --git a/tests/f_create_symlinks/script b/tests/f_create_symlinks/script
index 169f58dbed2f..8906f3d65653 100644
--- a/tests/f_create_symlinks/script
+++ b/tests/f_create_symlinks/script
@@ -15,22 +15,22 @@ fi
 dd if=/dev/zero of=$TMPFILE bs=1k count=512 > /dev/null 2>&1
 
 echo mke2fs -q -F -o Linux -b 1024 -g 256 -O inline_data,extents -I 256 test.img 1024 > $OUT.new
-$MKE2FS -q -F -o Linux -b 1024 -g 256 -O inline_data,extents -I 256 $TMPFILE 1024 >> $OUT 2>&1
+$MKE2FS -q -F -o Linux -b 1024 -g 256 -O inline_data,extents -I 256 $TMPFILE 1024 >> $OUT.new 2>&1
 
 $FSCK $FSCK_OPT  -N test_filesys $TMPFILE >> $OUT.new 2>&1
 status=$?
 echo Exit status is $status >> $OUT.new
 
+B=$(printf 'x%.0s' {1..1500})
 for i in 30 60 70 500 1023 1024 1500; do
-	echo "debugfs -R \"symlink /l_$i $(perl -e "print 'x' x $i;")\" test.img" >> $OUT.new
-	$DEBUGFS -w -R "symlink /l_$i $(perl -e "print 'x' x $i;")" $TMPFILE \
-		 2>&1 | sed -f $cmd_dir/filter.sed >> $OUT.new
+	echo "debugfs -R \"symlink /l_$i ${B:0:i}\" test.img" >> $OUT.new
+	$DEBUGFS -w -R "symlink /l_$i ${B:0:i}" $TMPFILE >> $OUT.new 2>&1
 done
+unset B
 
 for i in 30 60 70 500 1023 1024 1500; do
 	echo "debugfs -R \"stat /l_$i\" test.img" >> $OUT.new
-	$DEBUGFS -R "stat /l_$i" $TMPFILE 2>&1 | \
-		 grep -v "time: " >> $OUT.new
+	$DEBUGFS -R "stat /l_$i" $TMPFILE 2>&1 | grep -v "time: " >> $OUT.new
 done
 
 $FSCK $FSCK_OPT  -N test_filesys $TMPFILE >> $OUT.new 2>&1
diff --git a/util/gen-sample-fs b/util/gen-sample-fs
index 8e139160fd01..290da33f51c3 100755
--- a/util/gen-sample-fs
+++ b/util/gen-sample-fs
@@ -7,8 +7,10 @@ cp /dev/null $FS
 mke2fs -q -t ext4 -O inline_data,^has_journal -I 256 -b 4096 -N 64 $FS 256
 mount -t ext4 $FS $MNT
 ln -s symlink_data $MNT/symlink
+
+L=$(printf 'x%.0s' {1..1024})
 for i in 30 70 500 1023 1024; do
-	ln -s /$(perl -e "print 'x' x $i;") $MNT/l_$i
+	ln -s /${L:0:$i} $MNT/l_$i
 done
 touch $MNT/acl
 setfacl -m u:daemon:r $MNT/acl
-- 
2.14.3 (Apple Git-98)


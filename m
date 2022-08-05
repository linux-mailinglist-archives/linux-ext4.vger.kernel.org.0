Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2058B25D
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Aug 2022 00:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbiHEWN3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Aug 2022 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbiHEWN2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Aug 2022 18:13:28 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5794175BB
        for <linux-ext4@vger.kernel.org>; Fri,  5 Aug 2022 15:13:26 -0700 (PDT)
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id K0X7oYX5aSp39K5ZOoM5CK; Fri, 05 Aug 2022 22:13:26 +0000
Received: from webber.adilger.int ([174.0.67.248])
        by cmsmtp with ESMTP
        id K5ZMol0YSC3uhK5ZMoFyVy; Fri, 05 Aug 2022 22:13:25 +0000
X-Authority-Analysis: v=2.4 cv=a6MjSGeF c=1 sm=1 tr=0 ts=62ed9605
 a=5skvQWjG3xExD1Ft+FuDHA==:117 a=5skvQWjG3xExD1Ft+FuDHA==:17 a=RPJ6JBhKAAAA:8
 a=MvuuwTCpAAAA:8 a=lB0dNpNiAAAA:8 a=gNVM8dTUbziaowDnDuEA:9
 a=fa_un-3J20JGBB2Tu-mn:22 a=dVHiktpip_riXrfdqayU:22 a=c-ZiYqmG3AbHTdtsH08C:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>,
        Li Dongyang <dongyangli@ddn.com>
Subject: [PATCH resend] tests: fix ACL-printing tests
Date:   Fri,  5 Aug 2022 16:13:00 -0600
Message-Id: <20220805221259.23896-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDCpi4bJul5RDFUPcmfFb0i435tkAyjUVvRf5+AjI/Gs2MvrXshLg8cR8Nc8NCh+7oN4hF/owA1ruM76fcoaG0G9ygkUXmBxAJYQ0BwiHEeqe920uGWf
 vzYgmNGD0y+ekd1l/OqTVLeMHrMu35mEQx/I3ufq+LY+ZP49ufJ+GbJVYmdlQ1SUTq/FsTRic38RayDVZ+3FnX11Sr37GUPY6I+gKdXG9WIiTyDL8teC2f3y
 Osf3Jab20A6ztXsy9lCXsYkKzjmMilfRIxEMxKi7dOOIE+fOLTFBpbhdo9nYQuSL/s3r9d2PS1j4URAEIfFrNg==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix the ACL-printing tests to be more flexible for different configs.
If the MKFS_DIR is on tmpfs, it will not list "system.posix_acl*"
xattrs, so they will not be copied.  Create this on a real filesystem
or skip the test if that doesn't work.

Filter out the security.selinux xattr if it is printed, since this
depends on the selinux configuration of the host system.  However,
this also spills xattrs for "acl_dir/file" into an external xattr
block, and causes it to fail due to different block allocations.
Increase the filesystem inode size so that the allocation is the same
regardless of whether selinux is enabled or not.

Change-Id: I82d2795f9fde7420f36d7c468a96ebe5f448a491
Fixes: 67e6ae0a35 ("mke2fs: fix a importing a directory with an ACL")
Signed-off-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
Reviewed-by: Li Dongyang <dongyangli@ddn.com>
---
 tests/filter.sed           |  1 +
 tests/m_rootdir_acl/expect | 18 +++++++++---------
 tests/m_rootdir_acl/script | 13 +++++++++----
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/tests/filter.sed b/tests/filter.sed
index 796186e7..5fd68f34 100644
--- a/tests/filter.sed
+++ b/tests/filter.sed
@@ -20,6 +20,7 @@ s/\\015//g
 /^Maximum mount count:/d
 /^Next check after:/d
 /^Suggestion:/d
+/security.selinux/d
 /Reserved blocks uid:/s/ (user .*)//
 /Reserved blocks gid:/s/ (group .*)//
 /whichever comes first/d
diff --git a/tests/m_rootdir_acl/expect b/tests/m_rootdir_acl/expect
index babd8025..57f03e5c 100644
--- a/tests/m_rootdir_acl/expect
+++ b/tests/m_rootdir_acl/expect
@@ -10,8 +10,8 @@ Filesystem OS type:       Linux
 Inode count:              1024
 Block count:              16384
 Reserved block count:     819
-Overhead clusters:        1543
-Free blocks:              14788
+Overhead clusters:        1799
+Free blocks:              14533
 Free inodes:              1003
 First block:              1
 Block size:               1024
@@ -21,14 +21,14 @@ Reserved GDT blocks:      127
 Blocks per group:         8192
 Fragments per group:      8192
 Inodes per group:         512
-Inode blocks per group:   128
+Inode blocks per group:   256
 Flex block group size:    16
 Mount count:              0
 Check interval:           15552000 (6 months)
 Reserved blocks uid:      0
 Reserved blocks gid:      0
 First inode:              11
-Inode size:	          256
+Inode size:	          512
 Required extra isize:     32
 Desired extra isize:      32
 Journal inode:            8
@@ -49,16 +49,16 @@ Group 0: (Blocks 1-8192)
   Reserved GDT blocks at 3-129
   Block bitmap at 130 (+129)
   Inode bitmap at 132 (+131)
-  Inode table at 134-261 (+133)
-  7750 free blocks, 491 free inodes, 5 directories, 491 unused inodes
-  Free blocks: 443-8192
+  Inode table at 134-389 (+133)
+  7495 free blocks, 491 free inodes, 5 directories, 491 unused inodes
+  Free blocks: 698-8192
   Free inodes: 22-512
 Group 1: (Blocks 8193-16383) [INODE_UNINIT]
   Backup superblock at 8193, Group descriptors at 8194-8194
   Reserved GDT blocks at 8195-8321
   Block bitmap at 131 (bg #0 + 130)
   Inode bitmap at 133 (bg #0 + 132)
-  Inode table at 262-389 (bg #0 + 261)
+  Inode table at 390-645 (bg #0 + 389)
   7038 free blocks, 512 free inodes, 0 directories, 512 unused inodes
   Free blocks: 9346-16383
   Free inodes: 513-1024
@@ -116,4 +116,4 @@ Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-test.img: 21/1024 files (0.0% non-contiguous), 1596/16384 blocks
+test.img: 21/1024 files (0.0% non-contiguous), 1851/16384 blocks
diff --git a/tests/m_rootdir_acl/script b/tests/m_rootdir_acl/script
index e81c82ce..a00e4c42 100644
--- a/tests/m_rootdir_acl/script
+++ b/tests/m_rootdir_acl/script
@@ -16,12 +16,10 @@ if [ "$os" = "GNU" ]; then
 	return 0
 fi
 
-MKFS_DIR=$TMPFILE.dir
+MKFS_DIR=$(mktemp -d ./$test_name-XXXXXX.tmp)
 OUT=$test_name.log
 EXP=$test_dir/expect
 
-rm -rf $MKFS_DIR
-mkdir -p $MKFS_DIR
 touch $MKFS_DIR/emptyfile
 dd if=/dev/zero bs=1024 count=32 2> /dev/null | tr '\0' 'a' > $MKFS_DIR/bigfile
 echo "M" | dd of=$MKFS_DIR/sparsefile bs=1 count=1 seek=1024 2> /dev/null
@@ -60,7 +58,14 @@ mask::r-x
 other::r-x
 EOF
 
-$MKE2FS -q -F -o Linux -T ext4 -O metadata_csum,inline_data,64bit -E lazy_itable_init=1 -b 1024 -d $MKFS_DIR $TMPFILE 16384 > $OUT 2>&1
+if ! getfattr -d -m - $MKFS_DIR/acl_dir | grep -q posix_acl; then
+	echo "$test_name: $test_description: skipped (no posix_acl xattrs)"
+	rm -rf $MKFS_DIR
+	return 0
+fi
+
+# use 512-byte inodes so with/out security.selinux xattr doesn't fail
+$MKE2FS -q -F -o Linux -T ext4 -I 512 -O metadata_csum,inline_data,64bit -E lazy_itable_init=1 -b 1024 -d $MKFS_DIR $TMPFILE 16384 > $OUT 2>&1
 
 $DUMPE2FS $TMPFILE >> $OUT 2>&1
 cat > $TMPFILE.cmd << ENDL
-- 
2.25.1


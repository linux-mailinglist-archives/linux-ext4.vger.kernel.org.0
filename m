Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34EA4C8218
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 05:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiCAER5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Feb 2022 23:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiCAERw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Feb 2022 23:17:52 -0500
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9983B473A9
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 20:17:11 -0800 (PST)
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
        by cmsmtp with ESMTP
        id OohUneddvgTZYOtwkn7QlV; Tue, 01 Mar 2022 04:17:10 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id OtwknaEgzd7RfOtwkn6jM1; Tue, 01 Mar 2022 04:17:10 +0000
X-Authority-Analysis: v=2.4 cv=XrLphHJ9 c=1 sm=1 tr=0 ts=621d9e46
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=MvuuwTCpAAAA:8 a=lB0dNpNiAAAA:8 a=gNVM8dTUbziaowDnDuEA:9
 a=ZUkhVnNHqyo2at-WnAgH:22 a=dVHiktpip_riXrfdqayU:22 a=c-ZiYqmG3AbHTdtsH08C:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>,
        Li Dongyang <dongyangli@ddn.com>
Subject: [PATCH] tests: fix ACL-printing tests
Date:   Mon, 28 Feb 2022 21:17:06 -0700
Message-Id: <20220301041706.75079-1-adilger@whamcloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfK5aqC//9tNQXwByoKPPubufiV4eW6TsmKWZvgWG1dy9660OaKtLdciI47y38iSn8394COh9SHWjuWYykF7NmlJIMeti7FvKkF8rGemXpULZS/4weG5w
 xrGBYZmj0h3vbrkyLT+D0/HFpQ/Gj6fhnXMukB1LttNjgCyuONobxwMFdk9MMuhr1QlTplcaE2HC9KviuMuUQy5N7etaGd0zrskyTHADtjHS/UzcKf5y8J7/
 gwNC69T7oM2MJw2Ib91uEidT8xgVNLyqLDSZVmP0xaEUE4N6viF2D7R4CMIH1HNc1Lo5x+894ts0Z3oK9ALQJ96yZ/UtcknfvkqmW12tz18=
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix the ACL-printing tests to be more flexible for different systems.
If the MKFS_DIR is on tmpfs, it will not list "system.posix_acl*"
xattrs, so they will not be copied.  Create this on a real filesystem
or skip the test if that doesn't work.

Filter out the security.selinux xattr if it is printed, since this
depends on the selinux configuration of the host system.  However,
this also spills xattrs for "acl_dir/file" into an external xattr
block, and causes it to fail due to different block allocations.
Increase the filesystem inode size so that the allocation is the same
regardless of whether selinux is enabled or not.

Fixes: 67e6ae0a35 ("mke2fs: fix a importing a directory with an ACL")
Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
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


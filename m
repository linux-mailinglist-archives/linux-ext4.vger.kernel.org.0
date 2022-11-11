Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F9362651C
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Nov 2022 00:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKKXBR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Nov 2022 18:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiKKXBQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Nov 2022 18:01:16 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EDC11A3C
        for <linux-ext4@vger.kernel.org>; Fri, 11 Nov 2022 15:01:14 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id ml12so4286753qvb.0
        for <linux-ext4@vger.kernel.org>; Fri, 11 Nov 2022 15:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tFMB/dLTt33glB1Olafhw56Tne1gnjZUX+BLtiR4pE0=;
        b=I7CyDVrA8OPTSXosVbfNWyYbfuSrx06JtlBUy/DSQtEwskPFa359Kj/DrKIpkY9O5p
         nT2LOWshHCGeot7CLfpBXctT/sovblZ7Y0e/QvPO+PrVXCdg2NyAs1cK6BbvlDtX2f4/
         xnspJjexMXNytcPg6gIDaDWYE79plxk53+w+QG1CV749sfzQkr8rv51u91PjlJXLQHuu
         Cipg3hKjtQ59e2oCye1nCvGAxNN7BRU3rnRPimf3SKv2TFjT4sndLiRApfOrsXfFTh9j
         jPI+n9B8y9wYvlRRkBHHINoHoj2mmYDmi2ywDsJ/EU1JNbroBK2j8WoIU7sCzFJxo6oY
         noXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFMB/dLTt33glB1Olafhw56Tne1gnjZUX+BLtiR4pE0=;
        b=1lYAlKIG6MV6jh+cfeHifFuP2hhEGOiSRlbuM0OBpa9DKan8Y8rHaUVPgNVWVbSJjX
         k3WhrsGRn1KJpAVgryCf6oRRryBJSJSLhi04t/I/6z3iJJbzzDoFmXBHWMdfFtvR/62L
         MpToQxLVKzSaBzYF3XPgmQ22/aH8H+P361GJcmb23PfmXsyW7Fwa+VDjeVqV+/xfHVlq
         ZqNrwuQQx9bAD++LgybbG065fANqYJE+phxijXcQyAC9cmg2V7GN44F2e4QuHneJzSST
         ISMFffb7HN4uE45klmOIb7ldv6eZv7161BwAIfLx6h85sEz/OlPL8H8/UrYfIeConpQv
         I8CQ==
X-Gm-Message-State: ANoB5pnVonePt3U9PGbOia8mhNGvC8fFMJvtjHdW1gnKskk/bLuquhlL
        0wW893ciLAeOIbpyM6RopottEcGRP7o=
X-Google-Smtp-Source: AA0mqf7fx7l5Hm0LlRPzVqG8Y0X6/ZOeeUGYcJ4iXQe2ng/xk7ee/wGlex47MrsLLC94IrG0zrLzOg==
X-Received: by 2002:a05:6214:3c08:b0:4bb:7bc0:30bb with SMTP id nt8-20020a0562143c0800b004bb7bc030bbmr3906793qvb.58.1668207673351;
        Fri, 11 Nov 2022 15:01:13 -0800 (PST)
Received: from localhost.localdomain (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id bp44-20020a05620a45ac00b006f956766f76sm2200897qkb.1.2022.11.11.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 15:01:12 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH v2] test-appliance: force 4 KB block size for bigalloc, bigalloc_inline
Date:   Fri, 11 Nov 2022 18:01:01 -0500
Message-Id: <20221111230101.135830-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The cfg file for the bigalloc test configuration does not explicitly
define the file system block size as is done for the 4k configuration,
although the intent is to test a file system with 4 KB blocks and 64 KB
clusters.  At least one test, shared/298, runs with a block size of
1 KB instead under bigalloc because it creates a file system image less
than 512 MB in size, a result of the mke2fs.conf block size rule
for small files.

shared/298 currently fails when run under bigalloc with 1 KB blocks.
When the block size is set to 4 KB for the test, it passes.

Explicitly defining the bigalloc block size will help avoid similar
surprises in current or future tests written to use small test files.
Make the same change to the bigalloc_inline config file while we're
at it.

v2:  Modify the names of the bigalloc test configurations using 4 KB
block sizes to explicitly reflect the block size.  Change the
documentation and supporting files to reflect this.  Bring the
bigalloc_4k_inline.exclude file up to date (and propagate a change to
the other .exclude files).  Add a new test configuration for bigalloc
with 64k blocks, but don't add this configuration to the default list
of all tests to be run for now.

The bigalloc_64k and huge_bigalloc_4k configurations are untested.  The
huge_bigalloc_4k.exclude file will likely need further work if used.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 Documentation/android-xfstests.md             |  2 +-
 Documentation/kvm-quickstart.md               |  2 +-
 Documentation/kvm-xfstests.md                 |  2 +-
 Documentation/what-is-xfstests.md             |  2 +-
 run-fstests/util/parse_cli                    |  2 +-
 .../files/root/fs/ext4/cfg/all.list           |  2 +-
 .../fs/ext4/cfg/{bigalloc => bigalloc_4k}     |  2 +-
 .../{bigalloc.exclude => bigalloc_4k.exclude} |  8 ++-
 .../{bigalloc_inline => bigalloc_4k_inline}   |  2 +-
 .../fs/ext4/cfg/bigalloc_4k_inline.exclude    | 38 ++++++++++++++
 .../files/root/fs/ext4/cfg/bigalloc_64k       | 14 ++++++
 .../root/fs/ext4/cfg/bigalloc_64k.exclude     | 49 +++++++++++++++++++
 .../root/fs/ext4/cfg/bigalloc_inline.exclude  | 13 -----
 .../files/root/fs/ext4/cfg/huge.list          |  2 +-
 .../cfg/{huge_bigalloc => huge_bigalloc_4k}   |  3 +-
 ...alloc.exclude => huge_bigalloc_4k.exclude} |  2 +-
 16 files changed, 119 insertions(+), 26 deletions(-)
 rename test-appliance/files/root/fs/ext4/cfg/{bigalloc => bigalloc_4k} (90%)
 rename test-appliance/files/root/fs/ext4/cfg/{bigalloc.exclude => bigalloc_4k.exclude} (83%)
 rename test-appliance/files/root/fs/ext4/cfg/{bigalloc_inline => bigalloc_4k_inline} (88%)
 create mode 100644 test-appliance/files/root/fs/ext4/cfg/bigalloc_4k_inline.exclude
 create mode 100644 test-appliance/files/root/fs/ext4/cfg/bigalloc_64k
 create mode 100644 test-appliance/files/root/fs/ext4/cfg/bigalloc_64k.exclude
 delete mode 100644 test-appliance/files/root/fs/ext4/cfg/bigalloc_inline.exclude
 rename test-appliance/files/root/fs/ext4/cfg/{huge_bigalloc => huge_bigalloc_4k} (90%)
 rename test-appliance/files/root/fs/ext4/cfg/{huge_bigalloc.exclude => huge_bigalloc_4k.exclude} (70%)

diff --git a/Documentation/android-xfstests.md b/Documentation/android-xfstests.md
index 049f7b4..a896b31 100644
--- a/Documentation/android-xfstests.md
+++ b/Documentation/android-xfstests.md
@@ -26,7 +26,7 @@ devices.  If you encounter a problem, please submit a fix!
   sufficient.  This is the sum of three 5 GiB partitions, a shrunken 4
   GiB userdata partition, and the various other partitions used by
   Android devices.  For test configurations requiring large
-  partitions, like bigalloc, you'll need about 64 GiB instead.
+  partitions, like bigalloc_4k, you'll need about 64 GiB instead.
 
 - Ability to connect to the Android device with adb and fastboot.
   Usually this is done via a USB cable.
diff --git a/Documentation/kvm-quickstart.md b/Documentation/kvm-quickstart.md
index 1c4b098..669faf8 100644
--- a/Documentation/kvm-quickstart.md
+++ b/Documentation/kvm-quickstart.md
@@ -41,7 +41,7 @@
 
 6.  Run "kvm-xfstests smoke" to do a quick test.  Or "kvm-xfstests
     -g auto" to do a full test.  You can also run specific tests on
-    specific configurations, i.e., "kvm-xfstests -c bigalloc
+    specific configurations, i.e., "kvm-xfstests -c bigalloc_4k
     generic/013 generic/127".   To run a shell, use "kvm-xfstests shell"
 
 For more information, please see the full [kvm-xfstests
diff --git a/Documentation/kvm-xfstests.md b/Documentation/kvm-xfstests.md
index c0a5337..0b397d6 100644
--- a/Documentation/kvm-xfstests.md
+++ b/Documentation/kvm-xfstests.md
@@ -100,7 +100,7 @@ appliance is:
 
 By default <cfg> defaults to all, which will run the following
 configurations: "4k", "1k", "ext3", "nojournal", "ext3conv",
-"dioread_nolock, "data_journal", "inline", "bigalloc", and
+"dioread_nolock, "data_journal", "inline", "bigalloc_4k", and
 "bigalloc_1k".  You may specify a single configuration or a comma
 separated list if you want to run a subset of all possible file system
 configurations.
diff --git a/Documentation/what-is-xfstests.md b/Documentation/what-is-xfstests.md
index 8bdf7ea..8e21ca0 100644
--- a/Documentation/what-is-xfstests.md
+++ b/Documentation/what-is-xfstests.md
@@ -59,7 +59,7 @@ should be 5GB.  Smaller, and some tests may not run correctly.
 Larger, and the tests will take a long time to run --- especially
 those tests that need to fill the file system to test ENOSPC handling.
 There are a few file system configurations for ext4 (most notable,
-bigalloc) which require a 20GB test and scratch device.
+bigalloc_4k) which require a 20GB test and scratch device.
 
 For this reason, kvm-xfstests uses five file system devices, /dev/vdb,
 /dev/vdc, /dev/vdd, /dev/vde, and /dev/vdf.  (/dev/vda is used for the
diff --git a/run-fstests/util/parse_cli b/run-fstests/util/parse_cli
index 75ec9b8..f55de22 100644
--- a/run-fstests/util/parse_cli
+++ b/run-fstests/util/parse_cli
@@ -79,7 +79,7 @@ print_help ()
     echo ""
     echo "Common file system configurations are:"
     echo "	4k 1k ext3 nojournal ext3conv metacsum dioread_nolock "
-    echo "	data_journal bigalloc bigalloc_1k inline"
+    echo "	data_journal bigalloc_4k bigalloc_1k inline"
     echo ""
     echo "xfstest names have the form: ext4/NNN generic/NNN shared/NNN"
     echo ""
diff --git a/test-appliance/files/root/fs/ext4/cfg/all.list b/test-appliance/files/root/fs/ext4/cfg/all.list
index 09faac0..75b2643 100644
--- a/test-appliance/files/root/fs/ext4/cfg/all.list
+++ b/test-appliance/files/root/fs/ext4/cfg/all.list
@@ -7,6 +7,6 @@ ext3conv
 adv
 dioread_nolock
 data_journal
-bigalloc
+bigalloc_4k
 bigalloc_1k
 dax
diff --git a/test-appliance/files/root/fs/ext4/cfg/bigalloc b/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k
similarity index 90%
rename from test-appliance/files/root/fs/ext4/cfg/bigalloc
rename to test-appliance/files/root/fs/ext4/cfg/bigalloc_4k
index 18b0a60..366bf38 100644
--- a/test-appliance/files/root/fs/ext4/cfg/bigalloc
+++ b/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k
@@ -1,5 +1,5 @@
 SIZE=large
-export EXT_MKFS_OPTIONS="-O bigalloc"
+export EXT_MKFS_OPTIONS="-b 4096 -O bigalloc"
 export EXT_MOUNT_OPTIONS=""
 
 # Until we can teach xfstests the difference between cluster size and
diff --git a/test-appliance/files/root/fs/ext4/cfg/bigalloc.exclude b/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k.exclude
similarity index 83%
rename from test-appliance/files/root/fs/ext4/cfg/bigalloc.exclude
rename to test-appliance/files/root/fs/ext4/cfg/bigalloc_4k.exclude
index 33c325a..c81fbdd 100644
--- a/test-appliance/files/root/fs/ext4/cfg/bigalloc.exclude
+++ b/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k.exclude
@@ -1,4 +1,4 @@
-// exclude file for ext4/bigalloc
+// exclude file for ext4/bigalloc_4k
 
 ext4/004	// dump/restore doesn't handle the bigalloc feature
 
@@ -8,6 +8,12 @@ ext4/004	// dump/restore doesn't handle the bigalloc feature
 // don't need to test this for all file system configs, so just skip it here.
 ext4/033
 
+// ext4/044 tries to mkfs the test file system as ext3 explicitly.  This
+// initially fails because ext3 and the inline_data feature are incompatible.
+// However, _scratch_do_mkfs() retries by stripping off the bigalloc and
+// inline_data options, resulting in a successful but irrelevant test.
+ext4/044
+
 // This takes a *long* time and doesn't add much value to run on all
 // configurations.  So we're going to be selective where we run it.
 generic/027
diff --git a/test-appliance/files/root/fs/ext4/cfg/bigalloc_inline b/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k_inline
similarity index 88%
rename from test-appliance/files/root/fs/ext4/cfg/bigalloc_inline
rename to test-appliance/files/root/fs/ext4/cfg/bigalloc_4k_inline
index 46af536..12ad66e 100644
--- a/test-appliance/files/root/fs/ext4/cfg/bigalloc_inline
+++ b/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k_inline
@@ -1,5 +1,5 @@
 SIZE=large
-export EXT_MKFS_OPTIONS="-O bigalloc,inline_data"
+export EXT_MKFS_OPTIONS="-b 4096 -O bigalloc,inline_data"
 export EXT_MOUNT_OPTIONS=""
 
 # Until we can teach xfstests the difference between cluster size and
diff --git a/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k_inline.exclude b/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k_inline.exclude
new file mode 100644
index 0000000..cc8fa5c
--- /dev/null
+++ b/test-appliance/files/root/fs/ext4/cfg/bigalloc_4k_inline.exclude
@@ -0,0 +1,38 @@
+// exclude file for ext4/bigalloc_4k_inline
+
+ext4/004	// dump/restore doesn't handle the bigalloc feature
+
+// ext4/033 creates a special file system using dmhugedisk to test for
+// inode overflow when online resizing.  With a bigalloc config, this takes
+// too much space, so test VM will hang or abort the test run.  We
+// don't need to test this for all file system configs, so just skip it here.
+ext4/033
+
+// ext4/044 tries to mkfs the test file system as ext3 explicitly.  This
+// initially fails because ext3 and the inline_data feature are incompatible.
+// However, _scratch_do_mkfs() retries by stripping off the bigalloc and
+// inline_data options, resulting in a successful but irrelevant test.
+ext4/044
+
+// This takes a *long* time and doesn't add much value to run on all
+// configurations.  So we're going to be selective where we run it.
+generic/027
+
+// This test is a quota accounting test.  For bigalloc, the cluster
+// size of 64k is way too big to deal with the artificial fudge used
+// in the test to deal with wrong block sizes.  The test really needs
+// to be rewritten to understand block/allocation sizes....
+generic/219
+
+// This test uses the block size to figure out how many files to
+// create; for bigalloc, we need to use the cluster size instead of the
+// block size.
+generic/273
+
+// These tests assume that the directory will get expanded when
+// additional entries are added.  With bigalloc and with htree
+// directories, this is not the case.  Since no blocks are added,
+// there is no attempted block allocation and so the expected
+// EDQUOT failure didn't happen.
+generic/681
+generic/682
diff --git a/test-appliance/files/root/fs/ext4/cfg/bigalloc_64k b/test-appliance/files/root/fs/ext4/cfg/bigalloc_64k
new file mode 100644
index 0000000..79df267
--- /dev/null
+++ b/test-appliance/files/root/fs/ext4/cfg/bigalloc_64k
@@ -0,0 +1,14 @@
+SIZE=large
+export EXT_MKFS_OPTIONS="-b 65536 -O bigalloc"
+export EXT_MOUNT_OPTIONS=""
+
+# Until we can teach xfstests the difference between cluster size and
+# block size, avoid collapse_range and insert_range since these will
+# fail due the fact that these operations require cluster-aligned
+# ranges.
+export FSX_AVOID="-C -I"
+export FSSTRESS_AVOID="-f collapse=0 -f insert=0"
+export XFS_IO_AVOID="fcollapse finsert"
+TEST_SET_EXCLUDE="-x collapse,insert"
+
+TESTNAME="Ext4 64k block w/bigalloc"
diff --git a/test-appliance/files/root/fs/ext4/cfg/bigalloc_64k.exclude b/test-appliance/files/root/fs/ext4/cfg/bigalloc_64k.exclude
new file mode 100644
index 0000000..c9a90bf
--- /dev/null
+++ b/test-appliance/files/root/fs/ext4/cfg/bigalloc_64k.exclude
@@ -0,0 +1,49 @@
+// exclude file for ext4/bigalloc_64k
+
+ext4/004	// dump/restore doesn't handle the bigalloc feature
+
+// ext4/033 creates a special file system using dmhugedisk to test for
+// inode overflow when online resizing.  With a bigalloc config, this takes
+// too much space, so test VM will hang or abort the test run.  We
+// don't need to test this for all file system configs, so just skip it here.
+ext4/033
+
+// ext4/044 tries to mkfs the test file system as ext3 explicitly.  This
+// initially fails because ext3 and the inline_data feature are incompatible.
+// However, _scratch_do_mkfs() retries by stripping off the bigalloc and
+// inline_data options, resulting in a successful but irrelevant test.
+ext4/044
+
+// This takes a *long* time and doesn't add much value to run on all
+// configurations.  So we're going to be selective where we run it.
+generic/027
+
+// This test needs to know the inode size and block size for the file
+// system; for bigalloc, we need to use the cluster size instead of the
+// block size.
+generic/204
+
+// This test is a quota accounting test.  For bigalloc, the cluster
+// size of 64k is way too big to deal with the artificial fudge used
+// in the test to deal with wrong block sizes.  The test really needs
+// to be rewritten to understand block/allocation sizes....
+generic/219
+
+// This test uses the block size to figure out how many files to
+// create; for bigalloc, we need to use the cluster size instead of the
+// block size.
+generic/273
+
+// This test creates a very small file system on a dm-thin device.
+// The file system is too small for bigalloc, so skip it.  It was
+// introduced to test a dm-thin bug combined with an XFS bug regression.
+// If it's a problem for ext4, we'll catch it in other ext4 configs.
+generic/500
+
+// These tests assume that the directory will get expanded when
+// additional entries are added.  With bigalloc and with htree
+// directories, this is not the case.  Since no blocks are added,
+// there is no attempted block allocation and so the expected
+// EDQUOT failure didn't happen.
+generic/681
+generic/682
diff --git a/test-appliance/files/root/fs/ext4/cfg/bigalloc_inline.exclude b/test-appliance/files/root/fs/ext4/cfg/bigalloc_inline.exclude
deleted file mode 100644
index 356ddb5..0000000
--- a/test-appliance/files/root/fs/ext4/cfg/bigalloc_inline.exclude
+++ /dev/null
@@ -1,13 +0,0 @@
-// exclude file for ext4/bigalloc_inline
-
-ext4/004	// dump/restore doesn't handle the bigalloc feature
-
-// ext4/033 creates a special file system using dmhugedisk to test for
-// inode overflow when online resizing.  With a bigalloc config, this takes
-// too much space, so test VM will hang or abort the test run.  We
-// don't need to test this for all file system configs, so just skip it here.
-ext4/033
-
-// This takes a *long* time and doesn't add much value to run on all
-// configurations.  So we're going to be selective where we run it.
-generic/027
diff --git a/test-appliance/files/root/fs/ext4/cfg/huge.list b/test-appliance/files/root/fs/ext4/cfg/huge.list
index 6d4e9a5..9f3c7b6 100644
--- a/test-appliance/files/root/fs/ext4/cfg/huge.list
+++ b/test-appliance/files/root/fs/ext4/cfg/huge.list
@@ -1,4 +1,4 @@
 huge_4k
 huge_1k
-huge_bigalloc
+huge_bigalloc_4k
 huge_encrypt
diff --git a/test-appliance/files/root/fs/ext4/cfg/huge_bigalloc b/test-appliance/files/root/fs/ext4/cfg/huge_bigalloc_4k
similarity index 90%
rename from test-appliance/files/root/fs/ext4/cfg/huge_bigalloc
rename to test-appliance/files/root/fs/ext4/cfg/huge_bigalloc_4k
index 82effda..de4a53d 100644
--- a/test-appliance/files/root/fs/ext4/cfg/huge_bigalloc
+++ b/test-appliance/files/root/fs/ext4/cfg/huge_bigalloc_4k
@@ -1,5 +1,5 @@
 SIZE=large
-export EXT_MKFS_OPTIONS="-O bigalloc"
+export EXT_MKFS_OPTIONS="-b 4096 -O bigalloc"
 export EXT_MOUNT_OPTIONS="huge=always"
 
 # Until we can teach xfstests the difference between cluster size and
@@ -11,4 +11,3 @@ export FSSTRESS_AVOID="-f collapse=0 -f insert=0 -f zero=0"
 export XFS_IO_AVOID="fcollapse finsert zero"
 
 TESTNAME="Ext4 4k block w/bigalloc"
-
diff --git a/test-appliance/files/root/fs/ext4/cfg/huge_bigalloc.exclude b/test-appliance/files/root/fs/ext4/cfg/huge_bigalloc_4k.exclude
similarity index 70%
rename from test-appliance/files/root/fs/ext4/cfg/huge_bigalloc.exclude
rename to test-appliance/files/root/fs/ext4/cfg/huge_bigalloc_4k.exclude
index fe1a2f0..378e28d 100644
--- a/test-appliance/files/root/fs/ext4/cfg/huge_bigalloc.exclude
+++ b/test-appliance/files/root/fs/ext4/cfg/huge_bigalloc_4k.exclude
@@ -1,4 +1,4 @@
-// exclude file for ext4/huge_bigalloc
+// exclude file for ext4/huge_bigalloc_4k
 
 // bigalloc does not support on-line defrag
 ext4/301
-- 
2.30.2


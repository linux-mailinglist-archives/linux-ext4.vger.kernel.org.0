Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996702938BD
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Oct 2020 12:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405318AbgJTKCm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Oct 2020 06:02:42 -0400
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:63690 "EHLO
        cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728719AbgJTKCm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 20 Oct 2020 06:02:42 -0400
Received: from cpsps-ews16.kpnxchange.com ([10.94.84.197]) by cpsmtpb-ews05.kpnxchange.com with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 20 Oct 2020 11:56:25 +0200
X-Brand: /q/rzKX13g==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e1=10;e3=10;e2=11;e4=10);EVW:Whi
        te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.4 cv=Fu67Q0nq c=1 sm=1 tr=0 ts=5f8eb449
         cx=a_idp_e a=4/rmT19p7yX2nqNQQg5uwQ==:117
         a=X0PnwcQ2/mKcBfosUKIoXQ==:17 a=UhJ12kwm0HYA:10 a=afefHYAZSVUA:10
         a=rXqF8srVhRqhauQ8XqUA:9 a=AFNF9bY1f6fGpPuB:21 a=-2yA8-y4yQyLvJS0:21
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from smtp.kpnmail.nl ([195.121.84.44]) by cpsps-ews16.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 20 Oct 2020 11:56:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=mime-version:message-id:date:subject:to:from;
        bh=T0jbN3bNufywMRQsFYm2PF/Aj90XcEO/0QlMXdCWRus=;
        b=HFtoDeWtgYHrEuDWaHanLvWz6tA+DvmOAzB5jbtz6EPKIpoUiOpD6oonrUHQ4OVoAw/rfwcMJuL9t
         2CHFhDpjhqiZEQDHWvKYQ2MhjKHHJo1BRYkwrt7wjOZdeeBsvWzGgwuwVJxx6tkghcJK+JOsQAjkFc
         1lqTyfO+pf8AI41A=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|bSlEBGewVLZK23OJA5pSbBRoxJk0hSWSSlXbsoqZKjHSuPX9R1jlyu37iRb9nTb
 oCjUTSy8GEgHEc42sVMKY7Q==
X-Originating-IP: 77.173.60.12
Received: from localhost (77-173-60-12.fixed.kpn.net [77.173.60.12])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id 83fd96d0-12ba-11eb-8a34-005056abf0db;
        Tue, 20 Oct 2020 11:56:25 +0200 (CEST)
From:   Benno Schulenberg <bensberg@telfort.nl>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] release notes: delete two files that are fully contained within v1.41.txt
Date:   Tue, 20 Oct 2020 11:56:12 +0200
Message-Id: <20201020095612.3459-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Oct 2020 09:56:25.0606 (UTC) FILETIME=[45EFE260:01D6A6C7]
X-RcptDomain: vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

They are pure duplicates.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 doc/RelNotes/v1.41.13 | 145 ------------------------------------------
 doc/RelNotes/v1.41.14 |  31 ---------
 2 files changed, 176 deletions(-)
 delete mode 100644 doc/RelNotes/v1.41.13
 delete mode 100644 doc/RelNotes/v1.41.14

diff --git a/doc/RelNotes/v1.41.13 b/doc/RelNotes/v1.41.13
deleted file mode 100644
index 3d334d44..00000000
--- a/doc/RelNotes/v1.41.13
+++ /dev/null
@@ -1,145 +0,0 @@
-E2fsprogs 1.41.13 (December 13, 2010)
-=====================================
-
-E2fsck now supports the extended option "-E journal_only", which
-causes it to only do a journal replay.  This is useful for scripts
-that want to first replay the journal and then check to see if it
-contains errors.
-
-E2fsck will now support UUID= and LABEL= specifiers for the -j option
-(which specifies where to find the external journal).  (Addresses
-Debian Bug #559315)
-
-E2fsck now has support for the problems/<problem code>/force_no
-configuration option in e2fsck.conf, which forces a problem to not be
-fixed.
-
-Dumpe2fs will now avoid printing large negative offsets for the bitmap
-blocks and instead print a message which is a bit more helpful for
-flex_bg file systems.
-
-Mke2fs will now check the file system type (specified with the -t
-option) to make sure it is defined in the mke2fs.conf file; if it is
-not, it will print an error and abort.  If the usage type (specified
-with the -T option) is not defined in mke2fs.conf, mke2fs will print a
-warning but will continue.  (Addresses Debian Bug #594609)
-
-Clarified error message from resize2fs clarifying that on-line
-shrinking is not supported at all.  (Addresses Debian Bug #599786)
-    
-Fix an e2fsck bug that could cause a PROGRAMMING BUG error to be
-displayed.  (Addresses Debian Bug #555456)
-
-E2fsck will open the external journal in exclusive mode, to prevent
-the journal from getting truncated while it is in use due to a user
-accidentally trying to run e2fsck on a snapshotted file system volume.
-(Addresses Debian Bug #587531)
-
-Fix a bug in e2fsck so it has the correct test for the EOFBLOCKS_FL
-flag.
-
-The tune2fs program can now set the uninit_bg feature without
-requiring an fsck.
-
-The tune2fs, dumpe2fs, and debugfs programs now support the new ext4
-default mount options settings which were added in 2.6.35.
-
-The e2fsck and dumpe2fs programs now support the new ext4 superblock
-fields which track where and when the first and most recent file
-system errors occurred.  These fields are displayed by dumpe2fs and
-cleared by e2fsck.  These new superblock fields were added in 2.6.36.
-
-Debugfs now uses a more concise format for listing extents in its
-stat command.  This format also includes the interior extent tree
-blocks, which previously was missing from stat's output for
-extent-based files.
-
-Debugfs has a new option, -D, which will request Direct I/O access of
-the file system.
-
-Mke2fs will skip initializing the inode table if a device supports
-discard and the discard operation will result in zero'ed blocks.
-
-Badblocks will now correctly backspace over UTF-8 characters when
-displaying its progress bar.  (Addresses Gentoo Bug #309909; Addresses
-Debian Bugs #583782 and #587834)
-
-E2freefrag will now display the total number of free extents.
-
-Resize2fs -P no longer requires a freshly checked filesystem before
-printing the minimum resize size.
-
-Fixed a floating point precision error in a binary tree search routine
-that can lead to seg fault in e2fsck and resize2fs.
-
-Fixed a bug in e2fsck where if both the original and backup superblock
-are invalid in some way, e2fsck will fail going back to the original
-superblock because it didn't close the backup superblock first, and
-the exclusive open prevented the file system from being reopened.
-
-Fixed a big in e2freefrag which caused getopt parsing to fail on
-architectures with unsigned chars.  (Addresses Gentoo Bug: #299386)
-
-Clarified an mke2fs error message so a missed common in an -E option
-(i.e., mke2fs -t ext4 -E stride=128 stripe-width=512 /dev/sda1")
-results in a more understandable explanation to the user.
-
-Mke2fs now displays the correct valid inode ratio range when
-complaining about an invalid inode ratio specified by the user.
-
-Mke2fs now understands the extended option "discard" and "nodiscard",
-and the older option -K is deprecated.  The default of whether
-discards are enabled by default can be controlled by the mke2fs.conf
-file.
-
-Mke2fs's handling of logical and physical sector sizes has been
-improved to reflect the fact that there will be some SSD's with 8k and
-16k physical sectors arriving soon.  Mke2fs will no longer force block
-size to be the physical sector size, since there will be devices where
-the physical sector size is larger than the system's page size, and
-hence larger than the maximal supported block size.  In addition, if
-the minimal and optimal io size are not exported by the device, and
-the physical sector size is larger than the block size, the physical
-sector size will be used to set the Raid I/O optimization hints in the
-superblock.
-
-E2fsck will now display a better, more specific error message when the
-user enters a typo'ed device name, instead of blathering on about
-alternate superblocks.
-
-Fixed various Debian Packaging Issues
-
-Updated/clarified man pages (Addresses Debian Bugs: #580236, #594004,
-#589345, #591083; Addresses Launchpad Bug: #505719)
-
-Update the Chinese, Chzech, Dutch, French, Germany, Indonesian,
-Polish, Swedish, and Vietnamese translations.
-
-
-Programmer's Notes
-------------------
-
-Fix a dependency definition for the static and profiled blkid
-libraries which could cause compile failures in some configurations.
-(Addresses Debian Bug: #604629)
-    
-Add support for Direct I/O in the Unix I/O access layer.
-
-Fixed a memory leak in the Unix I/O layer when changing block sizes.
-
-Fixed minor memory leaks in mke2fs.
-
-Added a new function to the ext2fs library, ext2fs_get_memalign().
-
-The tst_super_size test program will check to make sure the superblock
-fields are correctly aligned and will print them out so they can be
-manually checked for correctness.
-
-Fixed some makefile dependencies for test programs in lib/ext2fs.
-
-Reserved the feature flags and superblock fields needed for the Next3
-snapshot feature.
-
-Reserved the feature flags for EXT4_FEATURE_INCOMPAT_DIRDATA and
-EXT4_INCOMPAT_EA_INODE.
-
diff --git a/doc/RelNotes/v1.41.14 b/doc/RelNotes/v1.41.14
deleted file mode 100644
index 84e2e6e5..00000000
--- a/doc/RelNotes/v1.41.14
+++ /dev/null
@@ -1,31 +0,0 @@
-E2fsprogs 1.41.14 (December 22, 2010)
-=====================================
-
-Fix spurious complaint in mke2fs where it would complain if the file
-system type "default" is not defined in mke2fs.conf.
-
-The resize2fs program will no longer clear the resize_inode feature
-when the number reserved group descriptor blocks reaches zero.  This
-allows for subsequent shrinks of the file system to work cleanly for
-flex_bg file systems.
-
-The resize2fs program now handles devices which are exactly 16T;
-previously it would give an error saying that the file system was too
-big.
-
-E2fsck (and the libext2fs library) will not use the extended rec_len
-encoding for file systems whose block size is less than 64k, for
-consistency with the kernel.
-
-Programming notes
------------------
-
-E2fsprogs 1.41.13 would not compile on big-endian systems.  This has
-been fixed.  (Addresses Sourceforge Bug: #3138115)
-
-The ext2fs_block_iterator2() function passed an incorrect ref_offset
-to its callback function in the case of sparse files.  (Addresses
-Sourceforge Bug: #3081087)
-    
-Fix some type-punning warnings generated by newer versions of gcc.
-
-- 
2.25.4


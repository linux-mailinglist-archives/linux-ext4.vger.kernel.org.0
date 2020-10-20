Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009DB2938BB
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Oct 2020 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405317AbgJTKCF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Oct 2020 06:02:05 -0400
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:59573 "EHLO
        cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731571AbgJTKCF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 20 Oct 2020 06:02:05 -0400
Received: from cpsps-ews09.kpnxchange.com ([10.94.84.176]) by cpsmtpb-ews01.kpnxchange.com with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 20 Oct 2020 11:48:58 +0200
X-Brand: /q/rzKX13g==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e1=10;e3=10;e2=11;e4=10);EVW:Whi
        te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.4 cv=Fu67Q0nq c=1 sm=1 tr=0 ts=5f8eb28a
         cx=a_idp_e a=YnLMpE5S06+Zisl5ga1zfg==:117
         a=X0PnwcQ2/mKcBfosUKIoXQ==:17 a=UhJ12kwm0HYA:10 a=afefHYAZSVUA:10
         a=TLLqb6gPi_POIADbNFkA:9 a=I-LW6ZRQ73-UjOXr:21 a=GdOTXSjQ4IiPnEbJ:21
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from smtp.kpnmail.nl ([195.121.84.46]) by cpsps-ews09.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 20 Oct 2020 11:48:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=mime-version:message-id:date:subject:to:from;
        bh=UjhjgQ5KASkfVsl2JOReHa8EzVR+MqcgYGfa8vgX3hg=;
        b=Qkj/6bFbDH2brmLqTv2Qp+/rnPM5PqMcdEn5xG2UTzo4P/nnVUJVnboUBMxkUKVImljYZM46g21oe
         A7owpYwhjByaAweTzIMVvgw4Ove0cDZbyd4ta/fraPYfq71qgTNgHzZK1qedFblUkvXY3Jia5tILAf
         maPW8Z9RAYZfFgFA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Ijg6TUVcF7W54Lr5oxsxTSZMP2OV6z7awdTJeMrg5i5rruvLw9PVsBVrNQ/KpJF
 XQ6mBmuhLpAKRtibsX6pu+Q==
X-Originating-IP: 77.173.60.12
Received: from localhost (77-173-60-12.fixed.kpn.net [77.173.60.12])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id 797a5a3b-12b9-11eb-9654-005056ab7584;
        Tue, 20 Oct 2020 11:48:58 +0200 (CEST)
From:   Benno Schulenberg <bensberg@telfort.nl>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/2] mke2fs.8: fix various formatting issues, and sort the synopsis
Date:   Tue, 20 Oct 2020 11:48:29 +0200
Message-Id: <20201020094829.3234-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201020094829.3234-1-bensberg@telfort.nl>
References: <20201020094829.3234-1-bensberg@telfort.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Oct 2020 09:48:58.0477 (UTC) FILETIME=[3B6D69D0:01D6A6C6]
X-RcptDomain: vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Also, delete the sentence that says that the inode size cannot
be changed after creating the file system, as tune2fs acquired
the -I option.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc/mke2fs.8.in | 144 +++++++++++++++++++++++------------------------
 1 file changed, 71 insertions(+), 73 deletions(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index e6bfc6d6..b2e8d89b 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -8,16 +8,16 @@ mke2fs \- create an ext2/ext3/ext4 filesystem
 .SH SYNOPSIS
 .B mke2fs
 [
+.B \-b
+.I block-size
+]
+[
 .B \-c
 |
 .B \-l
 .I filename
 ]
 [
-.B \-b
-.I block-size
-]
-[
 .B \-C
 .I cluster-size
 ]
@@ -29,6 +29,17 @@ mke2fs \- create an ext2/ext3/ext4 filesystem
 .B \-D
 ]
 [
+.B \-e
+.I errors-behavior
+]
+[
+.B \-E
+.I extended-options
+]
+[
+.B \-F
+]
+[
 .B \-g
 .I blocks-per-group
 ]
@@ -52,15 +63,23 @@ mke2fs \- create an ext2/ext3/ext4 filesystem
 .I journal-options
 ]
 [
-.B \-N
-.I number-of-inodes
+.B \-L
+.I volume-label
+]
+[
+.B \-m
+.I reserved-blocks-percentage
+]
+[
+.B \-M
+.I last-mounted-directory
 ]
 [
 .B \-n
 ]
 [
-.B \-m
-.I reserved-blocks-percentage
+.B \-N
+.I number-of-inodes
 ]
 [
 .B \-o
@@ -68,7 +87,7 @@ mke2fs \- create an ext2/ext3/ext4 filesystem
 ]
 [
 .B \-O
-[^]\fIfeature\fR[,...]
+.RI [\fB^\fR] feature [\fB,\fR...]
 ]
 [
 .B \-q
@@ -78,24 +97,6 @@ mke2fs \- create an ext2/ext3/ext4 filesystem
 .I fs-revision-level
 ]
 [
-.B \-E
-.I extended-options
-]
-[
-.B \-v
-]
-[
-.B \-F
-]
-[
-.B \-L
-.I volume-label
-]
-[
-.B \-M
-.I last-mounted-directory
-]
-[
 .B \-S
 ]
 [
@@ -111,15 +112,14 @@ mke2fs \- create an ext2/ext3/ext4 filesystem
 .I UUID
 ]
 [
-.B \-V
+.B \-v
 ]
 [
-.B \-e
-.I errors-behavior
+.B \-V
 ]
 [
 .B \-z
-.I undo_file
+.I undo-file
 ]
 .I device
 [
@@ -171,7 +171,7 @@ option is specified, in which case
 .I fs-size
 is interpreted as the number of
 .I blocksize
-blocks.   If the fs-size is suffixed by 'k', 'm', 'g', 't'
+blocks.  If \fIfs-size\fR is suffixed by 'k', 'm', 'g', 't'
 (either upper-case or lower-case), then it is interpreted in
 power-of-two kilobytes, megabytes, gigabytes, terabytes, etc.
 If
@@ -228,13 +228,13 @@ Check the device for bad blocks before creating the file system.  If
 this option is specified twice, then a slower read-write
 test is used instead of a fast read-only test.
 .TP
-.B \-C " cluster-size"
-Specify the size of cluster in bytes for filesystems using the bigalloc
+.BI \-C " cluster-size"
+Specify the size of a cluster in bytes for filesystems using the bigalloc
 feature.  Valid cluster-size values are from 2048 to 256M bytes per
 cluster.  This can only be specified if the bigalloc feature is
 enabled.  (See the
-.B ext4 (5)
-man page for more details about bigalloc.)   The default cluster size if
+.BR ext4 (5)
+man page for more details about bigalloc.)  The default cluster size if
 bigalloc is enabled is 16 times the block size.
 .TP
 .BI \-d " root-directory"
@@ -242,9 +242,9 @@ Copy the contents of the given directory into the root directory of the
 filesystem.
 .TP
 .B \-D
-Use direct I/O when writing to the disk.  This avoids mke2fs dirtying a
+Use direct I/O when writing to the disk.  This avoids \fBmke2fs\fR dirtying a
 lot of buffer cache memory, which may impact other applications running
-on a busy server.  This option will cause mke2fs to run much more
+on a busy server.  This option will cause \fBmke2fs\fR to run much more
 slowly, however, so there is a tradeoff to using direct I/O.
 .TP
 .BI \-e " error-behavior"
@@ -392,7 +392,7 @@ Shingled Drives.
 Specify the numeric user and group ID of the root directory.  If no UID:GID
 is specified, use the user and group ID of the user running \fBmke2fs\fR.
 In \fBmke2fs\fR 1.42 and earlier the UID and GID of the root directory were
-set by default to the UID and GID of the user running the mke2fs command.
+set by default to the UID and GID of the user running the \fBmke2fs\fR command.
 The \fBroot_owner=\fR option allows explicitly specifying these values,
 and avoid side-effects for users that do not expect the contents of the
 filesystem to change based on the user running \fBmke2fs\fR.
@@ -413,14 +413,14 @@ as default.
 Do not attempt to discard blocks at mkfs time.
 .TP
 .B quotatype
-Specify the which  quota types (usrquota, grpquota, prjquota) which
+Specify which quota types (usrquota, grpquota, prjquota)
 should be enabled in the created file system.  The argument of this
-extended option should be a colon separated list.  This option has
+extended option should be a colon-separated list.  This option has
 effect only if the
 .B quota
-feature is set.   The default quota types to be initialized if this
-option is not specified is both user and group quotas.  If the project
-feature is enabled that project quotas will be initialized as well.
+feature is set.  The default quota types to be initialized if this
+option is not specified are both user and group quotas.  If the project
+feature is enabled, then project quotas will be initialized as well.
 .RE
 .TP
 .B \-F
@@ -481,8 +481,6 @@ value must be a power of 2 larger or equal to 128.  The larger the
 .I inode-size
 the more space the inode table will consume, and this reduces the usable
 space in the filesystem and can also negatively impact performance.
-It is not
-possible to change this value after the filesystem is created.
 .IP
 File systems with an inode size of 128 bytes do not support timestamps
 beyond January 19, 2038.  Inodes which are 256 bytes or larger will
@@ -508,7 +506,7 @@ which has ext3 support in order to actually make use of the journal.
 .BI \-J " journal-options"
 Create the ext3 journal using options specified on the command-line.
 Journal options are comma
-separated, and may take an argument using the equals ('=')  sign.
+separated, and may take an argument using the equals ('=') sign.
 The following journal options are supported:
 .RS 1.2i
 .TP
@@ -630,7 +628,7 @@ filesystem.  The creator field is set by default to the name of the OS the
 .B mke2fs
 executable was compiled for.
 .TP
-.B "\-O \fR[^]\fIfeature\fR[,...]"
+.BR \-O " [\fB^\fR]\fIfeature\fR[\fB,\fR...]"
 Create a filesystem with the given features (filesystem options),
 overriding the default filesystem options.  The features that are
 enabled by default are specified by the
@@ -669,8 +667,8 @@ by commas, that are to be enabled.  To disable a feature, simply
 prefix the feature name with a caret ('^') character.
 Features with dependencies will not be removed successfully.
 The pseudo-filesystem feature "none" will clear all filesystem features.
-.TP
-For more information about the features which can be set, please see
+.sp
+For more information about the features that can be set, see
 the manual page
 .BR ext4 (5).
 .TP
@@ -719,7 +717,7 @@ will pick a default either via how
 the command was run (for example, using a name of the form mkfs.ext2,
 mkfs.ext3, etc.) or via a default as defined by the
 .B /etc/mke2fs.conf
-file.   This option controls which filesystem options are used by
+file.  This option controls which filesystem options are used by
 default, based on the
 .B fstypes
 configuration stanza in
@@ -737,14 +735,14 @@ the Linux kernel; and "\fBmke2fs \-t ext3 \-O ^has_journal /dev/hdXX\fR"
 will create a filesystem that does not have a journal and hence will not
 be supported by the ext3 filesystem code in the Linux kernel.)
 .TP
-.BI \-T " usage-type[,...]"
+.BI \-T " usage-type\fR[\fB,\fR...]"
 Specify how the filesystem is going to be used, so that
 .B mke2fs
 can choose optimal filesystem parameters for that use.  The usage
 types that are supported are defined in the configuration file
 .BR /etc/mke2fs.conf .
 The user may specify one or more usage types
-using a comma separated list.
+using a comma-separated list.
 .sp
 If this option is is not specified,
 .B mke2fs
@@ -752,25 +750,25 @@ will pick a single default usage type based on the size of the filesystem to
 be created.  If the filesystem size is less than 3 megabytes,
 .B mke2fs
 will use the filesystem type
-.IR floppy .
+.BR floppy .
 If the filesystem size is greater than or equal to 3 but less than
 512 megabytes,
-.BR mke2fs (8)
+.B mke2fs
 will use the filesystem type
-.IR small .
+.BR small .
 If the filesystem size is greater than or equal to 4 terabytes but less than
 16 terabytes,
-.BR mke2fs (8)
+.B mke2fs
 will use the filesystem type
-.IR big .
+.BR big .
 If the filesystem size is greater than or equal to 16 terabytes,
-.BR mke2fs (8)
+.B mke2fs
 will use the filesystem type
-.IR huge .
+.BR huge .
 Otherwise,
-.BR mke2fs (8)
-will use the default filesystem type
-.IR default .
+.B mke2fs
+will use the filesystem type
+.BR default .
 .TP
 .BI \-U " UUID"
 Set the universally unique identifier (UUID) of the filesystem to
@@ -783,14 +781,14 @@ The
 parameter may also be one of the following:
 .RS 1.2i
 .TP
-.I clear
-clear the filesystem UUID
+.B clear
+Clear the filesystem UUID.
 .TP
-.I random
-generate a new randomly-generated UUID
+.B random
+Generate a new randomly-generated UUID.
 .TP
-.I time
-generate a new time-based UUID
+.B time
+Generate a new time-based UUID.
 .RE
 .TP
 .B \-v
@@ -801,12 +799,12 @@ Print the version number of
 .B mke2fs
 and exit.
 .TP
-.BI \-z " undo_file"
+.BI \-z " undo-file"
 Before overwriting a file system block, write the old contents of the block to
-an undo file.  This undo file can be used with e2undo(8) to restore the old
+an undo file.  This undo file can be used with \fBe2undo\fR(8) to restore the old
 contents of the file system should something go wrong.  If the empty string is
-passed as the undo_file argument, the undo file will be written to a file named
-mke2fs-\fIdevice\fR.e2undo in the directory specified via the
+passed as the \fIundo-file\fR argument, the undo file will be written to a file
+named \fBmke2fs-\fIdevice\fB.e2undo\fR in the directory specified via the
 \fIE2FSPROGS_UNDO_DIR\fR environment variable or the \fIundo_dir\fR directive
 in the configuration file.
 
-- 
2.25.4


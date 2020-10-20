Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5726B2938B9
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Oct 2020 12:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgJTKBy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Oct 2020 06:01:54 -0400
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:62258 "EHLO
        cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731571AbgJTKBy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 20 Oct 2020 06:01:54 -0400
Received: from cpsps-ews18.kpnxchange.com ([10.94.84.184]) by cpsmtpb-ews08.kpnxchange.com with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 20 Oct 2020 11:48:42 +0200
X-Brand: /q/rzKX13g==
X-KPN-SpamVerdict: e1=0;e2=0;e3=0;e4=(e1=10;e3=10;e2=11;e4=10);EVW:Whi
        te;BM:NotScanned;FinalVerdict:Clean
X-CMAE-Analysis: v=2.4 cv=S61nfKgP c=1 sm=1 tr=0 ts=5f8eb27a
         cx=a_idp_e a=/dHbpd/3q0lrH6oA/zwSgQ==:117
         a=/dHbpd/3q0lrH6oA/zwSgQ==:17 a=UhJ12kwm0HYA:10 a=afefHYAZSVUA:10
         a=aCX8Z3ww337eUAp6eBoA:9 a=Bvh1cMyPIlFTqqrt:21 a=lXBf7U04JynxQd-z:21
X-CM-AcctID: kpn@feedback.cloudmark.com
Received: from smtp.kpnmail.nl ([195.121.84.45]) by cpsps-ews18.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Tue, 20 Oct 2020 11:48:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=mime-version:message-id:date:subject:to:from;
        bh=u9gRRwP5+kn5QnSa+2YoJigLUsRlY/8xuF80YUj7NZ8=;
        b=HSQn3zKOmrH5w5H7YKqEsCIiMu6Dsvlff/SvVWYNIOaOnE6f3tN0CsqXtT6qdaKNExR71or1KSOId
         ZqsYrMkKkjUnMf81GtLBfznj7TtpEzaGVpWucax5lROa2iPGkfXBrPHQcCSXf81qlfs82g/W8WQQgA
         J6yKBpeARADHTDvo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|UHLNwJn2UPtbPzAmwIRbcY+NiGsaPuTwa1vSTRGDciF9V77MAS5U6P0K6ktnQqj
 qxMUAo/Z/Kk5VXdgOCiFPOQ==
X-Originating-IP: 77.173.60.12
Received: from localhost (77-173-60-12.fixed.kpn.net [77.173.60.12])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id 6fd3230e-12b9-11eb-9953-005056ab7447;
        Tue, 20 Oct 2020 11:48:42 +0200 (CEST)
From:   Benno Schulenberg <bensberg@telfort.nl>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/2] tune2fs.8: fix various wording and formatting issues
Date:   Tue, 20 Oct 2020 11:48:28 +0200
Message-Id: <20201020094829.3234-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Oct 2020 09:48:42.0400 (UTC) FILETIME=[31D84200:01D6A6C6]
X-RcptDomain: vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For example: the argument of -c had a mistaken plural "s", the argument
of -o was misformatted, the main description spoke of "options" instead
of "parameters" and used a mistaken "i.e." instead of "e.g.", and so on.

Also, sort the options in the synopsis alphabetically, to make it easier
to find a specific one and to match the order in which they are listed
further down.  Also, remove some excess spaces, harmonize the style of
some decriptions, sort d, w, m in the order of ascending duration, and
for consistency use hyphens instead of underscores in option arguments.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc/tune2fs.8.in | 173 +++++++++++++++++++++++-----------------------
 1 file changed, 88 insertions(+), 85 deletions(-)

diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index 582d1da5..b2fb58e8 100644
--- a/misc/tune2fs.8.in
+++ b/misc/tune2fs.8.in
@@ -8,26 +8,35 @@ tune2fs \- adjust tunable filesystem parameters on ext2/ext3/ext4 filesystems
 .SH SYNOPSIS
 .B tune2fs
 [
-.B \-l
+.B \-c
+.I max-mount-count
 ]
 [
-.B \-c
-.I max-mount-counts
+.B \-C
+.I mount-count
 ]
 [
 .B \-e
 .I errors-behavior
 ]
 [
+.B \-E
+.I extended-options
+]
+[
 .B \-f
 ]
 [
+.B \-g
+.I group
+]
+[
 .B \-i
 .I interval-between-checks
 ]
 [
 .B \-I
-.I new_inode_size
+.I new-inode-size
 ]
 [
 .B \-j
@@ -37,93 +46,84 @@ tune2fs \- adjust tunable filesystem parameters on ext2/ext3/ext4 filesystems
 .I journal-options
 ]
 [
-.B \-m
-.I reserved-blocks-percentage
-]
-[
-.B \-o
-.RI [^]mount-options [,...]
-]
-[
-.B \-r
-.I reserved-blocks-count
-]
-[
-.B \-u
-.I user
-]
-[
-.B \-g
-.I group
-]
-[
-.B \-C
-.I mount-count
-]
-[
-.B \-E
-.I extended-options
+.B \-l
 ]
 [
 .B \-L
 .I volume-label
 ]
 [
+.B \-m
+.I reserved-blocks-percentage
+]
+[
 .B \-M
 .I last-mounted-directory
 ]
 [
+.B \-o
+.RI [\fB^\fR] mount-option [\fB,\fR...]
+]
+[
 .B \-O
-.RI [^] feature [,...]
+.RI [\fB^\fR] feature [\fB,\fR...]
 ]
 [
 .B \-Q
 .I quota-options
 ]
 [
+.B \-r
+.I reserved-blocks-count
+]
+[
 .B \-T
 .I time-last-checked
 ]
 [
+.B \-u
+.I user
+]
+[
 .B \-U
 .I UUID
 ]
 [
 .B \-z
-.I undo_file
+.I undo-file
 ]
-device
+.I device
 .SH DESCRIPTION
 .B tune2fs
 allows the system administrator to adjust various tunable filesystem
 parameters on Linux ext2, ext3, or ext4 filesystems.  The current values
-of these options can be displayed by using the
+of these parameters can be displayed by using the
 .B -l
-option to
-.BR tune2fs (8)
-program, or by using the
+option with
+.BR tune2fs ,
+or by using the
 .BR dumpe2fs (8)
 program.
 .PP
 The
 .I device
-specifier can either be a filename (i.e., /dev/sda1), or a LABEL or UUID
-specifier: "\fBLABEL=\fIvolume-label\fR" or "\fBUUID=\fIuuid\fR".  (i.e.,
+specifier can either be a filename (for example, /dev/sda1), or a LABEL or UUID
+specifier: "\fBLABEL=\fIvolume-label\fR" or "\fBUUID=\fIuuid\fR" (for example,
 LABEL=home or UUID=e40486c6-84d5-4f2f-b99c-032281799c9d).
 .SH OPTIONS
 .TP
-.BI \-c " max-mount-counts"
+.BI \-c " max-mount-count"
 Adjust the number of mounts after which the filesystem will be checked by
 .BR e2fsck (8).
 If
-.I max-mount-counts
+.I max-mount-count
 is 0 or \-1, the number of times the filesystem is mounted will be disregarded
 by
 .BR e2fsck (8)
 and the kernel.
 .sp
-Staggering the mount-counts at which filesystems are forcibly
-checked will avoid all filesystems being checked at one time
+Staggering the mount counts at which filesystems are forcibly
+checked will avoid all filesystems being checked at the same time
 when using journaled filesystems.
 .sp
 Mount-count-dependent checking is disabled by default to avoid
@@ -145,8 +145,9 @@ option for time-dependent checking.
 .TP
 .BI \-C " mount-count"
 Set the number of times the filesystem has been mounted.
-If set to a greater value than the max-mount-counts parameter
-set by the
+If set to a greater value than the
+.I max-mount-count
+parameter set by the
 .B \-c
 option,
 .BR e2fsck (8)
@@ -258,7 +259,7 @@ option is useful when removing the
 filesystem feature from a filesystem which has
 an external journal (or is corrupted
 such that it appears to have an external journal), but that
-external journal is not available.   If the filesystem appears to require
+external journal is not available.  If the filesystem appears to require
 journal replay, the
 .B \-f
 flag must be specified twice to proceed.
@@ -275,31 +276,31 @@ The
 parameter can be a numerical gid or a group name.  If a group name is given,
 it is converted to a numerical gid before it is stored in the superblock.
 .TP
-.B \-i " \fIinterval-between-checks\fR[\fBd\fR|\fBm\fR|\fBw\fR]"
+.B \-i " \fIinterval-between-checks\fR[\fBd\fR|\fBw\fR|\fBm\fR]"
 Adjust the maximal time between two filesystem checks.
 No suffix or
 .B d
-will interpret the number
+will interpret the
 .I interval-between-checks
-as days,
-.B m
-as months, and
+number as days,
 .B w
-as weeks.  A value of zero will disable the time-dependent checking.
+as weeks, and
+.B m
+as months.  A value of zero will disable the time-dependent checking.
 .sp
 There are pros and cons to disabling these periodic checks; see the
 discussion under the
 .B \-c
 (mount-count-dependent check) option for details.
 .TP
-.B \-I
-Change the inode size used by the file system.   This requires rewriting
-the inode table, so it requires that the file system is checked for
+.BI \-I " new-inode-size"
+Change the inode size used by the filesystem.  This requires rewriting
+the inode table, so it requires that the filesystem is checked for
 consistency first using
 .BR e2fsck (8).
-This operation can also take a while and the file system can be
-corrupted and data lost if it is interrupted while in the middle of
-converting the file system.  Backing up the file system before changing
+The conversion can take a while, and the filesystem can be
+corrupted and data can be lost if it is interrupted.
+Backing up the filesystem before changing the
 inode size is recommended.
 .IP
 File systems with an inode size of 128 bytes do not support timestamps
@@ -328,7 +329,7 @@ While checking unmounted filesystems,
 will automatically move
 .B .journal
 files to the invisible, reserved journal inode.  For all filesystems
-except for the root filesystem,  this should happen automatically and
+except for the root filesystem, this should happen automatically and
 naturally during the next reboot cycle.  Since the root filesystem is
 mounted read-only,
 .BR e2fsck (8)
@@ -342,16 +343,16 @@ file specifies the ext3 filesystem for the root filesystem in order to
 avoid requiring the use of a rescue floppy to add an ext3 journal to
 the root filesystem.
 .TP
-.BR \-J " journal-options"
+.BI \-J " journal-options"
 Override the default ext3 journal parameters. Journal options are comma
-separated, and may take an argument using the equals ('=')  sign.
+separated, and may take an argument using the equals ('=') sign.
 The following journal options are supported:
 .RS 1.2i
 .TP
 .BI size= journal-size
 Create a journal stored in the filesystem of size
 .I journal-size
-megabytes.   The size of the journal must be at least 1024 filesystem blocks
+megabytes.  The size of the journal must be at least 1024 filesystem blocks
 (i.e., 1MB if using 1k blocks, 4MB if using 4k blocks, etc.)
 and may be no more than 10,240,000 filesystem blocks.
 There must be enough free space in the filesystem to create a journal of
@@ -425,7 +426,7 @@ instead of a block special device name like
 .TP
 .BI \-m " reserved-blocks-percentage"
 Set the percentage of the filesystem which may only be allocated
-by privileged processes.   Reserving some number of filesystem blocks
+by privileged processes.  Reserving some number of filesystem blocks
 for use by privileged processes is done
 to avoid filesystem fragmentation, and to allow system
 daemons, such as
@@ -437,7 +438,7 @@ of reserved blocks is 5%.
 .BI \-M " last-mounted-directory"
 Set the last-mounted directory for the filesystem.
 .TP
-.BR \-o " [^]\fImount-option\fR[,...]"
+.BR \-o " [\fB^\fR]\fImount-option\fR[\fB,\fR...]"
 Set or clear the indicated default mount options in the filesystem.
 Default mount options can be overridden by mount options specified
 either in
@@ -525,7 +526,7 @@ will disable the delayed allocation feature.  (This option is currently
 only supported by the ext4 file system driver in 2.6.35+ kernels.)
 .RE
 .TP
-.BR \-O " [^]\fIfeature\fR[,...]"
+.BR \-O " [\fB^\fR]\fIfeature\fR[\fB,\fR...]"
 Set or clear the indicated filesystem features (options) in the filesystem.
 More than one filesystem feature can be cleared or set by separating
 features with commas.  Filesystem features prefixed with a
@@ -680,23 +681,25 @@ features are only supported by the ext4 filesystem.
 Set the number of reserved filesystem blocks.
 .TP
 .BI \-Q " quota-options"
-Sets 'quota' feature on the superblock and works on the quota files for the
-given quota type. Quota options could be one or more of the following:
+Set the 'quota' feature on the superblock and work on the quota files
+for the given quota type.
+.I quota-options
+can be one or more of the following (colon-separated):
 .RS 1.2i
 .TP
-.B [^]usrquota
-Sets/clears user quota inode in the superblock.
+.RB [ ^ ] usrquota
+Set/clear the user quota inode in the superblock.
 .TP
-.B [^]grpquota
-Sets/clears group quota inode in the superblock.
+.RB [ ^ ] grpquota
+Set/clear the group quota inode in the superblock.
 .TP
-.B [^]prjquota
-Sets/clears project quota inode in the superblock.
+.RB [ ^ ] prjquota
+Set/clear the project quota inode in the superblock.
 .RE
 .TP
 .BI \-T " time-last-checked"
 Set the time the filesystem was last checked using
-.BR  e2fsck .
+.BR e2fsck .
 The time is interpreted using the current (local) timezone.
 This can be useful in scripts which use a Logical Volume Manager to make
 a consistent snapshot of a filesystem, and then check the filesystem
@@ -706,7 +709,7 @@ be used to set the last checked time on the original filesystem.  The format
 of
 .I time-last-checked
 is the international date format, with an optional time specifier, i.e.
-YYYYMMDD[HH[MM[SS]]].   The keyword
+YYYYMMDD[HH[MM[SS]]].  The keyword
 .B now
 is also accepted, in which case the last checked time will be set to the
 current time.
@@ -728,14 +731,14 @@ The
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
 .IP
 The UUID may be used by
@@ -758,12 +761,12 @@ or
 .B tune2fs
 will automatically use a time-based UUID instead of a randomly-generated UUID.
 .TP
-.BI \-z " undo_file"
+.BI \-z " undo-file"
 Before overwriting a file system block, write the old contents of the block to
-an undo file.  This undo file can be used with e2undo(8) to restore the old
+an undo file.  This undo file can be used with \fBe2undo\fR(8) to restore the old
 contents of the file system should something go wrong.  If the empty string is
-passed as the undo_file argument, the undo file will be written to a file named
-tune2fs-\fIdevice\fR.e2undo in the directory specified via the
+passed as the \fIundo-file\fR argument, the undo file will be written to a file
+named \fBtune2fs-\fIdevice\fB.e2undo\fR in the directory specified via the
 \fIE2FSPROGS_UNDO_DIR\fR environment variable.
 
 WARNING: The undo file cannot be used to recover from a power or system crash.
-- 
2.25.4


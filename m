Return-Path: <linux-ext4+bounces-762-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB3E829382
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 06:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F99728955E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 05:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2227EDF6B;
	Wed, 10 Jan 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmjrCm4F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE8DF56
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 05:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159C7C433C7;
	Wed, 10 Jan 2024 05:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704866290;
	bh=EoWJHcoW8dpNkUVZDx2nqfgQqLVvHbY6OPIJXsC9rKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmjrCm4FWZ2GSy9gayCUACrY0M5v6GqhdyVwZL40bXX0AY17Fx5hB68la5/pPc9C/
	 Z3MSFSPXnib6tJTK0+wGuHFpB9+csqW16iJAEve5EKIBNXyLJSwYmip7my+bd6GSsB
	 ZZJj2tdOnuC85jf54N5HITH7lC2rij5PTS9vBhtLElNh/QOizldtKIcuQoIK3FyKNJ
	 wAvDGW5918yD5VP7AnLSDPIoMxhXCYPfIb+Novzn0WCX9xfCCt6+D+dNeT28Dem7FT
	 HMSa+UJtmaTvHo4/xvPXAQ0eIsD0oTz4SXPEm2mxBWLuKlftDJBqYb6z/F3bAewGgh
	 oqqqx/YuIpu6g==
Date: Tue, 9 Jan 2024 21:58:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: [RFC PATCH 6/2] e2scrub: skip filesystems that don't have journals
Message-ID: <20240110055809.GD722946@frogsfrogsfrogs>
References: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

Brian J. Murrell reported that e2scrub reports failures with one of his
filesystems.  From the email discussion after he supplied a metadump:

AHA!  This is an ext2 filesystem, since it doesn't have the
"has_journal" or "extents" features turned on:

# e2image -r /tmp/disk.qcow2 /dev/sda
# dumpe2fs /dev/sda -h
dumpe2fs 1.47.1~WIP-2023-12-27 (27-Dec-2023)
Filesystem volume name:   <none>
Last mounted on:          /opt
Filesystem UUID:          2c70368a-0d54-4805-8620-fda19466d819
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      ext_attr resize_inode dir_index filetype sparse_super large_file
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         not clean with errors

(Note: Filesystem state == "clean" means that EXT2_VALID_FS is set in
the superblock s_state field; "not clean with errors" means that the
flag is not set.)

I bet the "journal only" preen doesn't actually reset the filesystem
state either:

# e2fsck -E journal_only -p  /dev/sda
# dumpe2fs /dev/sda -h | grep state
dumpe2fs 1.47.1~WIP-2023-12-27 (27-Dec-2023)
Filesystem state:         not clean with errors

Nope.

So now I know what happened -- when mounting an ext* filesystem that
doesn't have a journal, the driver clears EXT2_VALID_FS from the primary
superblock.  This forces the system to run e2fsck after a crash, because
that's what you have to do for unjournalled filesystems.

The "e2fsck -E journal_only -p" call in e2scrub only replays the
journal.  Since there is no journal, it exits almost immediately.
That's the intended behavior, but then it means that the "e2fsck -fy"
call immediately after sees that the superblock doesn't have
EXT2_VALID_FS set, sets it, and makes e2fsck return 1.

So that's why you're getting the e2scrub failures.

Contrast this to what you get when the filesystem has a journal:

# dumpe2fs -h /dev/sdb
dumpe2fs 1.47.0 (5-Feb-2023)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          e18b8b57-a75e-4316-87ce-6a08969476c3
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery sparse_super large_file
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean

Filesystems with journals retain their EXT4_VALID_FS state when they're
mounted.

Hmm.  What e2scrub should do about unjournalled filesystems is a thorny
question.  My initial thought is that it should skip them, because a
mounted unjournalled filesystem cannot by definition be kept consistent.
Therefore, teach e2scrub_all to avoid them and e2scrub to fail them at
the onset.

Restricting the scope of e2scrub sucks, but in the meantime at least it
means that your filesystem isn't massively corrupt.  Thanks for the
metadump, it was very useful for root cause analysis.

Reported-by: "Brian J. Murrell" <brian@interlinx.bc.ca>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 scrub/e2scrub.in     |    7 +++++++
 scrub/e2scrub_all.in |    4 ++++
 2 files changed, 11 insertions(+)

diff --git a/scrub/e2scrub.in b/scrub/e2scrub.in
index 7ed57f2d..043bc12b 100644
--- a/scrub/e2scrub.in
+++ b/scrub/e2scrub.in
@@ -159,6 +159,13 @@ if [ ! -e "${dev}" ]; then
 	exitcode 16
 fi
 
+# Do not scrub unjournalled filesystems; they are inconsistent when mounted
+if [ "${reap}" -eq 0 ] && ! dumpe2fs -h "${dev}" | grep -q 'has_journal'; then
+	echo "${arg}: Filesystem has no journal, cannot check."
+	print_help
+	exitcode 16
+fi
+
 # Make sure this is an LVM device we can snapshot
 lvm_vars="$(lvs --nameprefixes -o name,vgname,lv_role --noheadings "${dev}" 2> /dev/null)"
 eval "${lvm_vars}"
diff --git a/scrub/e2scrub_all.in b/scrub/e2scrub_all.in
index 437f6cc2..fe4dda95 100644
--- a/scrub/e2scrub_all.in
+++ b/scrub/e2scrub_all.in
@@ -125,6 +125,10 @@ ls_scan_targets() {
 	while read vars ; do
 		eval "${vars}"
 
+		# Skip unjournalled filesystems; they are inconsistent when
+		# mounted
+		dumpe2fs -h "${NAME}" | grep -q 'has_journal' || continue
+
 		if [ "${scrub_all}" -eq 1 ] || [ -n "${MOUNTPOINT}" ]; then
 		    echo ${MOUNTPOINT:-${NAME}}
 		fi


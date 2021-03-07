Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16EF330234
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Mar 2021 15:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhCGOuN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Mar 2021 09:50:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46875 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231263AbhCGOuM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Mar 2021 09:50:12 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 127Eo4T0011831
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 7 Mar 2021 09:50:04 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D78A115C3A97; Sun,  7 Mar 2021 09:50:03 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     984472@bugs.debian.org, nabijaczleweli@nabijaczleweli.xyz,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] resize2fs: close the file system on errors or early exits
Date:   Sun,  7 Mar 2021 09:49:50 -0500
Message-Id: <20210307144950.197569-2-tytso@mit.edu>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210307144950.197569-1-tytso@mit.edu>
References: <20210307144950.197569-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When resize2fs exits early, perhaps because of an error, we should
free the file system so that if MMP is in use, the MMP block is reset.
This also releases the memory to avoid memory leak reports.

Addresses-Debian-Bug: #984472
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 resize/main.c | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/resize/main.c b/resize/main.c
index ccfd2896..8621d101 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -448,11 +448,15 @@ int main (int argc, char ** argv)
 		    (fs->super->s_free_inodes_count > fs->super->s_inodes_count))
 			checkit = 1;
 
+		if ((fs->super->s_last_orphan != 0) ||
+		    ext2fs_has_feature_journal_needs_recovery(fs->super))
+			checkit = 1;
+
 		if (checkit) {
 			fprintf(stderr,
 				_("Please run 'e2fsck -f %s' first.\n\n"),
 				device_name);
-			exit(1);
+			goto errout;
 		}
 	}
 
@@ -463,7 +467,7 @@ int main (int argc, char ** argv)
 	if (fs->super->s_feature_compat & ~EXT2_LIB_FEATURE_COMPAT_SUPP) {
 		com_err(program_name, EXT2_ET_UNSUPP_FEATURE,
 			"(%s)", device_name);
-		exit(1);
+		goto errout;
 	}
 
 	min_size = calculate_minimum_resize_size(fs, flags);
@@ -471,6 +475,9 @@ int main (int argc, char ** argv)
 	if (print_min_size) {
 		printf(_("Estimated minimum size of the filesystem: %llu\n"),
 		       (unsigned long long) min_size);
+	success_exit:
+		(void) ext2fs_close_free(&fs);
+		remove_error_table(&et_ext2_error_table);
 		exit(0);
 	}
 
@@ -497,7 +504,7 @@ int main (int argc, char ** argv)
 	if (retval) {
 		com_err(program_name, retval, "%s",
 			_("while trying to determine filesystem size"));
-		exit(1);
+		goto errout;
 	}
 	if (force_min_size)
 		new_size = min_size;
@@ -507,7 +514,7 @@ int main (int argc, char ** argv)
 		if (new_size == 0) {
 			com_err(program_name, 0,
 				_("Invalid new size: %s\n"), new_size_str);
-			exit(1);
+			goto errout;
 		}
 	} else {
 		new_size = max_size;
@@ -527,7 +534,7 @@ int main (int argc, char ** argv)
 			com_err(program_name, 0, "%s",
 				_("New size too large to be "
 				  "expressed in 32 bits\n"));
-			exit(1);
+			goto errout;
 		}
 	}
 	new_group_desc_count = ext2fs_div64_ceil(new_size -
@@ -540,20 +547,20 @@ int main (int argc, char ** argv)
 		com_err(program_name, 0,
 			_("New size results in too many block group "
 			  "descriptors.\n"));
-		exit(1);
+		goto errout;
 	}
 
 	if (!force && new_size < min_size) {
 		com_err(program_name, 0,
 			_("New size smaller than minimum (%llu)\n"),
 			(unsigned long long) min_size);
-		exit(1);
+		goto errout;
 	}
 	if (use_stride >= 0) {
 		if (use_stride >= (int) fs->super->s_blocks_per_group) {
 			com_err(program_name, 0, "%s",
 				_("Invalid stride length"));
-			exit(1);
+			goto errout;
 		}
 		fs->stride = fs->super->s_raid_stride = use_stride;
 		ext2fs_mark_super_dirty(fs);
@@ -580,52 +587,52 @@ int main (int argc, char ** argv)
 			" is only %llu (%dk) blocks.\nYou requested a new size"
 			" of %llu blocks.\n\n"), (unsigned long long) max_size,
 			blocksize / 1024, (unsigned long long) new_size);
-		exit(1);
+		goto errout;
 	}
 	if ((flags & RESIZE_DISABLE_64BIT) && (flags & RESIZE_ENABLE_64BIT)) {
 		fprintf(stderr, _("Cannot set and unset 64bit feature.\n"));
-		exit(1);
+		goto errout;
 	} else if (flags & (RESIZE_DISABLE_64BIT | RESIZE_ENABLE_64BIT)) {
 		if (new_size >= (1ULL << 32)) {
 			fprintf(stderr, _("Cannot change the 64bit feature "
 				"on a filesystem that is larger than "
 				"2^32 blocks.\n"));
-			exit(1);
+			goto errout;
 		}
 		if (mount_flags & EXT2_MF_MOUNTED) {
 			fprintf(stderr, _("Cannot change the 64bit feature "
 				"while the filesystem is mounted.\n"));
-			exit(1);
+			goto errout;
 		}
 		if (flags & RESIZE_ENABLE_64BIT &&
 		    !ext2fs_has_feature_extents(fs->super)) {
 			fprintf(stderr, _("Please enable the extents feature "
 				"with tune2fs before enabling the 64bit "
 				"feature.\n"));
-			exit(1);
+			goto errout;
 		}
 	} else if (new_size == ext2fs_blocks_count(fs->super)) {
 		fprintf(stderr, _("The filesystem is already %llu (%dk) "
 			"blocks long.  Nothing to do!\n\n"),
 			(unsigned long long) new_size,
 			blocksize / 1024);
-		exit(0);
+		goto success_exit;
 	}
 	if ((flags & RESIZE_ENABLE_64BIT) &&
 	    ext2fs_has_feature_64bit(fs->super)) {
 		fprintf(stderr, _("The filesystem is already 64-bit.\n"));
-		exit(0);
+		goto success_exit;
 	}
 	if ((flags & RESIZE_DISABLE_64BIT) &&
 	    !ext2fs_has_feature_64bit(fs->super)) {
 		fprintf(stderr, _("The filesystem is already 32-bit.\n"));
-		exit(0);
+		goto success_exit;
 	}
 	if (new_size < ext2fs_blocks_count(fs->super) &&
 	    ext2fs_has_feature_stable_inodes(fs->super)) {
 		fprintf(stderr, _("Cannot shrink this filesystem "
 			"because it has the stable_inodes feature flag.\n"));
-		exit(1);
+		goto errout;
 	}
 	if (mount_flags & EXT2_MF_MOUNTED) {
 		retval = online_resize_fs(fs, mtpt, &new_size, flags);
@@ -652,8 +659,7 @@ int main (int argc, char ** argv)
 			_("Please run 'e2fsck -fy %s' to fix the filesystem\n"
 			  "after the aborted resize operation.\n"),
 			device_name);
-		ext2fs_close_free(&fs);
-		exit(1);
+		goto errout;
 	}
 	printf(_("The filesystem on %s is now %llu (%dk) blocks long.\n\n"),
 	       device_name, (unsigned long long) new_size, blocksize / 1024);
@@ -676,5 +682,9 @@ int main (int argc, char ** argv)
 	if (fd > 0)
 		close(fd);
 	remove_error_table(&et_ext2_error_table);
-	return (0);
+	return 0;
+errout:
+	(void) ext2fs_close_free(&fs);
+	remove_error_table(&et_ext2_error_table);
+	return 1;
 }
-- 
2.30.0


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D182F878F
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jan 2021 22:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbhAOVVU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jan 2021 16:21:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49545 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbhAOVVU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jan 2021 16:21:20 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10FLKUJh027837
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 16:20:30 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D861115C399F; Fri, 15 Jan 2021 16:20:29 -0500 (EST)
Date:   Fri, 15 Jan 2021 16:20:29 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 bug fixes for v5.11-rc4
Message-ID: <YAIHHfxGQfj96di/@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Note: there is a fairly simple merge conflict, which can be resolved
by taking EXT4_SB(sb) and replacing it with sbi using the version in
your tree.  My merge resolution (which I used to run regression tests)
is attached below.

					- Ted


The following changes since commit be993933d2e997fdb72b8b1418d2a84df79b8962:

  ext4: remove unnecessary wbc parameter from ext4_bio_write_page (2020-12-22 13:08:45 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to e9f53353e166a67dfe4f8295100f8ac39d6cf10b:

  ext4: remove expensive flush on fast commit (2021-01-15 14:41:31 -0500)

----------------------------------------------------------------
A number of bug fixes for ext4:

   * For the new fast_commit feature
   * Fix some error handling codepaths in whiteout handling and
     mountpoint sampling
   * Fix how we write ext4_error information so it goes through the journal
     when journalling is active, to avoid races that can lead to lost
     error information, superblock checksum failures, or DIF/DIX features.

----------------------------------------------------------------
Daejun Park (2):
      ext4: fix wrong list_splice in ext4_fc_cleanup
      ext4: remove expensive flush on fast commit

Jan Kara (7):
      ext4: combine ext4_handle_error() and save_error_info()
      ext4: drop sync argument of ext4_commit_super()
      ext4: protect superblock modifications with a buffer lock
      ext4: save error info to sb through journal if available
      ext4: use sbi instead of EXT4_SB(sb) in ext4_update_super()
      ext4: fix superblock checksum failure when setting password salt
      ext4: drop ext4_handle_dirty_super()

Theodore Ts'o (1):
      ext4: don't leak old mountpoint samples

Yi Li (1):
      ext4: use IS_ERR instead of IS_ERR_OR_NULL and set inode null when IS_ERR

yangerkun (1):
      ext4: fix bug for rename with RENAME_WHITEOUT

 fs/ext4/ext4_jbd2.c   |  17 ------
 fs/ext4/ext4_jbd2.h   |   5 --
 fs/ext4/fast_commit.c |  35 +++++------
 fs/ext4/file.c        |   7 ++-
 fs/ext4/inode.c       |   6 +-
 fs/ext4/ioctl.c       |   3 +
 fs/ext4/namei.c       |  27 +++++---
 fs/ext4/resize.c      |  20 ++++--
 fs/ext4/super.c       | 193 ++++++++++++++++++++++++++++++++++++----------------------
 fs/ext4/xattr.c       |   5 +-
 10 files changed, 187 insertions(+), 131 deletions(-)

-------------------------

commit c3d123034d72849414f4b88bcd78843cec16caa5
Merge: 146620506274 8f4949dacec8
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Jan 14 22:09:51 2021 -0500

    Merge branch 'dev' into test

diff --cc fs/ext4/super.c
index 21121787c874,0f0db49031dc..9a6f9875aa34
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@@ -5450,18 -5494,22 +5488,18 @@@ static void ext4_update_super(struct su
  	 */
  	if (!(sb->s_flags & SB_RDONLY))
  		ext4_update_tstamp(es, s_wtime);
 -	if (sb->s_bdev->bd_part)
 -		es->s_kbytes_written =
 -			cpu_to_le64(sbi->s_kbytes_written +
 -			    ((part_stat_read(sb->s_bdev->bd_part,
 -					     sectors[STAT_WRITE]) -
 -			      sbi->s_sectors_written_start) >> 1));
 -	else
 -		es->s_kbytes_written = cpu_to_le64(sbi->s_kbytes_written);
 +	es->s_kbytes_written =
- 		cpu_to_le64(EXT4_SB(sb)->s_kbytes_written +
++		cpu_to_le64(sbi->s_kbytes_written +
 +		    ((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
- 		      EXT4_SB(sb)->s_sectors_written_start) >> 1));
- 	if (percpu_counter_initialized(&EXT4_SB(sb)->s_freeclusters_counter))
++		      sbi->s_sectors_written_start) >> 1));
+ 	if (percpu_counter_initialized(&sbi->s_freeclusters_counter))
  		ext4_free_blocks_count_set(es,
- 			EXT4_C2B(EXT4_SB(sb), percpu_counter_sum_positive(
- 				&EXT4_SB(sb)->s_freeclusters_counter)));
- 	if (percpu_counter_initialized(&EXT4_SB(sb)->s_freeinodes_counter))
+ 			EXT4_C2B(sbi, percpu_counter_sum_positive(
+ 				&sbi->s_freeclusters_counter)));
+ 	if (percpu_counter_initialized(&sbi->s_freeinodes_counter))
  		es->s_free_inodes_count =
  			cpu_to_le32(percpu_counter_sum_positive(
- 				&EXT4_SB(sb)->s_freeinodes_counter));
+ 				&sbi->s_freeinodes_counter));
  	/* Copy error information to the on-disk superblock */
  	spin_lock(&sbi->s_error_lock);
  	if (sbi->s_add_error_count > 0) {

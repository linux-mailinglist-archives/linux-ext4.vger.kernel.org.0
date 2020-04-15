Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D867C1A91F6
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 06:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393062AbgDOEgO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 00:36:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53465 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388430AbgDOEgN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Apr 2020 00:36:13 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03F4ZrA8004305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 00:35:54 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C36DD42013D; Wed, 15 Apr 2020 00:35:53 -0400 (EDT)
Date:   Wed, 15 Apr 2020 00:35:53 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+bca9799bf129256190da@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 generic_perform_write (2)
Message-ID: <20200415043553.GH90651@mit.edu>
References: <00000000000016a67305a33a11f7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000016a67305a33a11f7@google.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5b8b9d0c6d0e0f1993c6c56deaf9646942c49d94

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9728e7b0e84f..e44fee317965 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1728,6 +1728,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_NO_EXT3	0x0200
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
+#define MOPT_NO_REMOUNT 0x0800
 
 static const struct mount_opts {
 	int	token;
@@ -1777,7 +1778,7 @@ static const struct mount_opts {
 	{Opt_min_batch_time, 0, MOPT_GTE0},
 	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
 	{Opt_init_itable, 0, MOPT_GTE0},
-	{Opt_dax, EXT4_MOUNT_DAX, MOPT_SET},
+	{Opt_dax, EXT4_MOUNT_DAX, MOPT_SET | MOPT_NO_REMOUNT},
 	{Opt_stripe, 0, MOPT_GTE0},
 	{Opt_resuid, 0, MOPT_GTE0},
 	{Opt_resgid, 0, MOPT_GTE0},
@@ -1819,7 +1820,7 @@ static const struct mount_opts {
 	{Opt_jqfmt_vfsv1, QFMT_VFS_V1, MOPT_QFMT},
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
-	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
+	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET | MOPT_NO_REMOUNT},
 	{Opt_err, 0, 0}
 };
 
@@ -1917,6 +1918,12 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 			 "Mount option \"%s\" incompatible with ext3", opt);
 		return -1;
 	}
+	if ((m->flags & MOPT_NO_REMOUNT) && is_remount) {
+		ext4_msg(sb, KERN_ERR,
+			 "Mount option \"%s\" not supported when remounting",
+			 opt);
+		return -1;
+	}
 
 	if (args->from && !(m->flags & MOPT_STRING) && match_int(args, &arg))
 		return -1;
@@ -5429,18 +5436,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
-	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_NO_MBCACHE) {
-		ext4_msg(sb, KERN_ERR, "can't enable nombcache during remount");
-		err = -EINVAL;
-		goto restore_opts;
-	}
-
-	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX) {
-		ext4_msg(sb, KERN_WARNING, "warning: refusing change of "
-			"dax flag with busy inodes while remounting");
-		sbi->s_mount_opt ^= EXT4_MOUNT_DAX;
-	}
-
 	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
 		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by user");
 

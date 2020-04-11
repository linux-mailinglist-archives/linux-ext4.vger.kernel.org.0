Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F49D1A55F8
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Apr 2020 01:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgDKXNW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 Apr 2020 19:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730401AbgDKXNW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 11 Apr 2020 19:13:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC2D217D8;
        Sat, 11 Apr 2020 23:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646800;
        bh=1vPcV8somdtnL8mk5d4tR2o0GR4cfjZjti7/SpYaUHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n40B4avKx88jXAtsQ6UR2j/C5cNru9tDAU9fZd95rqqKdXvHHbotBolrP7t4Ct86i
         irihvRcOIghpFq9IJGO62VwnAlGy68D4t3FgprKQfaqomKHXpw8m8xGabJK9QzeCKk
         uhXeQHIgMoa+2suyNiqnUpWypgWMKRFZN5OOI0P4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Harish Sriram <harish@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 63/66] ext4: check for non-zero journal inum in ext4_calculate_overhead
Date:   Sat, 11 Apr 2020 19:12:00 -0400
Message-Id: <20200411231203.25933-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231203.25933-1-sashal@kernel.org>
References: <20200411231203.25933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ritesh Harjani <riteshh@linux.ibm.com>

[ Upstream commit f1eec3b0d0a849996ebee733b053efa71803dad5 ]

While calculating overhead for internal journal, also check
that j_inum shouldn't be 0. Otherwise we get below error with
xfstests generic/050 with external journal (XXX_LOGDEV config) enabled.

It could be simply reproduced with loop device with an external journal
and marking blockdev as RO before mounting.

[ 3337.146838] EXT4-fs error (device pmem1p2): ext4_get_journal_inode:4634: comm mount: inode #0: comm mount: iget: illegal inode #
------------[ cut here ]------------
generic_make_request: Trying to write to read-only block-device pmem1p2 (partno 2)
WARNING: CPU: 107 PID: 115347 at block/blk-core.c:788 generic_make_request_checks+0x6b4/0x7d0
CPU: 107 PID: 115347 Comm: mount Tainted: G             L   --------- -t - 4.18.0-167.el8.ppc64le #1
NIP:  c0000000006f6d44 LR: c0000000006f6d40 CTR: 0000000030041dd4
<...>
NIP [c0000000006f6d44] generic_make_request_checks+0x6b4/0x7d0
LR [c0000000006f6d40] generic_make_request_checks+0x6b0/0x7d0
<...>
Call Trace:
generic_make_request_checks+0x6b0/0x7d0 (unreliable)
generic_make_request+0x3c/0x420
submit_bio+0xd8/0x200
submit_bh_wbc+0x1e8/0x250
__sync_dirty_buffer+0xd0/0x210
ext4_commit_super+0x310/0x420 [ext4]
__ext4_error+0xa4/0x1e0 [ext4]
__ext4_iget+0x388/0xe10 [ext4]
ext4_get_journal_inode+0x40/0x150 [ext4]
ext4_calculate_overhead+0x5a8/0x610 [ext4]
ext4_fill_super+0x3188/0x3260 [ext4]
mount_bdev+0x778/0x8f0
ext4_mount+0x28/0x50 [ext4]
mount_fs+0x74/0x230
vfs_kern_mount.part.6+0x6c/0x250
do_mount+0x2fc/0x1280
sys_mount+0x158/0x180
system_call+0x5c/0x70
EXT4-fs (pmem1p2): no journal found
EXT4-fs (pmem1p2): can't get journal size
EXT4-fs (pmem1p2): mounted filesystem without journal. Opts: dax,norecovery

Fixes: 3c816ded78bb ("ext4: use journal inode to determine journal overhead")
Reported-by: Harish Sriram <harish@linux.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20200316093038.25485-1-riteshh@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d44fc3f579e13..e00a9a51be42f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3523,7 +3523,8 @@ int ext4_calculate_overhead(struct super_block *sb)
 	 */
 	if (sbi->s_journal && !sbi->journal_bdev)
 		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_maxlen);
-	else if (ext4_has_feature_journal(sb) && !sbi->s_journal) {
+	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
+		/* j_inum for internal journal is non-zero */
 		j_inode = ext4_get_journal_inode(sb, j_inum);
 		if (j_inode) {
 			j_blocks = j_inode->i_size >> sb->s_blocksize_bits;
-- 
2.20.1


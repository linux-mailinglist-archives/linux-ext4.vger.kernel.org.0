Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77A2DBE85
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 11:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgLPKUN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 05:20:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:49040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgLPKUM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 05:20:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D415AF30;
        Wed, 16 Dec 2020 10:18:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E84B31E136C; Wed, 16 Dec 2020 11:18:49 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>, Michael Halcrow <mhalcrow@google.com>
Subject: [PATCH 7/8] ext4: Fix superblock checksum failure when setting password salt
Date:   Wed, 16 Dec 2020 11:18:43 +0100
Message-Id: <20201216101844.22917-8-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201216101844.22917-1-jack@suse.cz>
References: <20201216101844.22917-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When setting password salt in the superblock, we forget to recompute the
superblock checksum so it will not match until the next superblock
modification which recomputes the checksum. Fix it.

CC: Michael Halcrow <mhalcrow@google.com>
Reported-by: Andreas Dilger <adilger@dilger.ca>
Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f0381876a7e5..106bf149e8ca 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1157,7 +1157,10 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			err = ext4_journal_get_write_access(handle, sbi->s_sbh);
 			if (err)
 				goto pwsalt_err_journal;
+			lock_buffer(sbi->s_sbh);
 			generate_random_uuid(sbi->s_es->s_encrypt_pw_salt);
+			ext4_superblock_csum_set(sb);
+			unlock_buffer(sbi->s_sbh);
 			err = ext4_handle_dirty_metadata(handle, NULL,
 							 sbi->s_sbh);
 		pwsalt_err_journal:
-- 
2.16.4


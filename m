Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5A44E9F6
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Nov 2021 16:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhKLPZI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Nov 2021 10:25:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54582 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhKLPZI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Nov 2021 10:25:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B2F312170E;
        Fri, 12 Nov 2021 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636730536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9S68nlQGUWBRelVTy/2kuHpr0kUB9PkPfbGZjaqrtD8=;
        b=lcCRY3SXqPT9B0PZLRiAa7YFgKjov0ED2AMJ0sl4nKeZnmzXbK8Hwj9vpN0fmpQzj2N+FT
        PWsdPwx8jOOIKXqnAjRND395ARtEgo50PBWc6bqaWpe5jznSJTi10FBRLJ8hFRlGzfbupO
        yXQ/f9QmtOxxLQM04KEop/GG2gHUoi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636730536;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9S68nlQGUWBRelVTy/2kuHpr0kUB9PkPfbGZjaqrtD8=;
        b=AnAsDAN7+g3WW7uPu+Q+1D7XXkXIMBcZnXiOBuITq0bXdpbfG+MyyhLjdP/JiuMC1UFhTp
        qsuySbX/D5PRhoAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A4246A3B81;
        Fri, 12 Nov 2021 15:22:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 799B61F2B50; Fri, 12 Nov 2021 16:22:13 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH] ext4: Avoid trim error on fs with small groups
Date:   Fri, 12 Nov 2021 16:22:02 +0100
Message-Id: <20211112152202.26614-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367; h=from:subject; bh=LTgOYF9vJ8dKpfwA2KH7G6pPSAH0ZWT8TUrlkbPtlEU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhjoZ5SpDClM/tked+gpI8upxWEGIF4i2x3NCRJsIM WX05wHyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYY6GeQAKCRCcnaoHP2RA2QFgCA DQiqfHn4TinCvHzSHXlZ3eoSkaLda0jJvNhzfx7ukaBh67DNbBA0w130IXnpuCjkfXviF+TgfBvmMM cUx+WH8VLW2iMdBSEU3/agPlpkP2EdLg40noRucg4dE3xi4wYW34tenmz4Jt/qjmGYYSxQFtAC4+Qq 6QXjZkXB49wLBdQ6Ihu1aBGBrMqOS0fXIP+y8ZQK+f6PUjvEjHlHdlWkpDkLoi2mT8f6Kd+W4dfwdR rB/3vXdbEbHBmGD2Dj8mKP/kappT1l0Rf/HhjwKaD9vJeNPiYsVzIvdks1qNt2jcZGJ30hsLb/w9L5 NZ2b/jB3/Cz5n1DTZ20bWPfjQKv/74
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A user reported FITRIM ioctl failing for him on ext4 on some devices
without apparent reason.  After some debugging we've found out that
these devices (being LVM volumes) report rather large discard
granularity of 42MB and the filesystem had 1k blocksize and thus group
size of 8MB. Because ext4 FITRIM implementation puts discard
granularity into minlen, ext4_trim_fs() declared the trim request as
invalid. However just silently doing nothing seems to be a more
appropriate reaction to such combination of parameters since user did
not specify anything wrong.

CC: Lukas Czerner <lczerner@redhat.com>
Fixes: 5c2ed62fd447 ("ext4: Adjust minlen with discard_granularity in the FITRIM ioctl")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ioctl.c   | 2 --
 fs/ext4/mballoc.c | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 606dee9e08a3..220a4c8178b5 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1117,8 +1117,6 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		    sizeof(range)))
 			return -EFAULT;
 
-		range.minlen = max((unsigned int)range.minlen,
-				   q->limits.discard_granularity);
 		ret = ext4_trim_fs(sb, &range);
 		if (ret < 0)
 			return ret;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 72bfac2d6dce..7174add7b153 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6405,6 +6405,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
  */
 int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 {
+	struct request_queue *q = bdev_get_queue(sb->s_bdev);
 	struct ext4_group_info *grp;
 	ext4_group_t group, first_group, last_group;
 	ext4_grpblk_t cnt = 0, first_cluster, last_cluster;
@@ -6423,6 +6424,13 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	    start >= max_blks ||
 	    range->len < sb->s_blocksize)
 		return -EINVAL;
+	/* No point to try to trim less than discard granularity */
+	if (range->minlen < q->limits.discard_granularity) {
+		minlen = EXT4_NUM_B2C(EXT4_SB(sb),
+			q->limits.discard_granularity >> sb->s_blocksize_bits);
+		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
+			goto out;
+	}
 	if (end >= max_blks)
 		end = max_blks - 1;
 	if (end <= first_data_blk)
-- 
2.26.2


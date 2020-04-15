Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98401AA074
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409895AbgDOM1Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 08:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406253AbgDOLpV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 07:45:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27AF920732;
        Wed, 15 Apr 2020 11:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951121;
        bh=WK6PI55FunTNr/JYm4AJc5j5XPkmbtyiqnzP8rvCP8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcsPvsaru+YnpIFy+8XaNfzJva5qKA6919aiPU1dODnQSX4xrBsOhYSCvcV/yeGG4
         HTMFCDizt6Y1EEmekXfHD1yIvTePuBQBLjIpurTMTtOU6RzDrnNiYP6Rx0x6xQQKSq
         rRYKmk6p9FeRvu/6l7K9D7GPv6yGJIcGBVDaocRs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Sandeen <sandeen@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 34/84] ext4: do not commit super on read-only bdev
Date:   Wed, 15 Apr 2020 07:43:51 -0400
Message-Id: <20200415114442.14166-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit c96e2b8564adfb8ac14469ebc51ddc1bfecb3ae2 ]

Under some circumstances we may encounter a filesystem error on a
read-only block device, and if we try to save the error info to the
superblock and commit it, we'll wind up with a noisy error and
backtrace, i.e.:

[ 3337.146838] EXT4-fs error (device pmem1p2): ext4_get_journal_inode:4634: comm mount: inode #0: comm mount: iget: illegal inode #
------------[ cut here ]------------
generic_make_request: Trying to write to read-only block-device pmem1p2 (partno 2)
WARNING: CPU: 107 PID: 115347 at block/blk-core.c:788 generic_make_request_checks+0x6b4/0x7d0
...

To avoid this, commit the error info in the superblock only if the
block device is writable.

Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Link: https://lore.kernel.org/r/4b6e774d-cc00-3469-7abb-108eb151071a@sandeen.net
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8bd806a03a90c..ff3f300dbd642 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -389,7 +389,8 @@ static void save_error_info(struct super_block *sb, const char *func,
 			    unsigned int line)
 {
 	__save_error_info(sb, func, line);
-	ext4_commit_super(sb, 1);
+	if (!bdev_read_only(sb->s_bdev))
+		ext4_commit_super(sb, 1);
 }
 
 /*
-- 
2.20.1


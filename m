Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E2A1B74E4
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 14:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgDXMXw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Apr 2020 08:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbgDXMXu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 Apr 2020 08:23:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E106B2087E;
        Fri, 24 Apr 2020 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731030;
        bh=d9WCOVPH7L+/dPvkYP6Uk/9VEzZL2uz/ct95MRypraM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QK+EMd5vPKqzzg20lb+tT6HP9W8+6+NxVWOxe+b04hdfU6Mu4GC7WiCMJ1rgfZd2B
         YWWiMYO/uFZfR9XYDAqnzEiBDi7bpGG1rwMNW2FnOcVeZCiHYbBhKwvm2dep3pRiRG
         6x8HI6Sd72zOTOrGPShttSaKOtwcSMz+b8VRRQX8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 23/26] ext4: increase wait time needed before reuse of deleted inode numbers
Date:   Fri, 24 Apr 2020 08:23:20 -0400
Message-Id: <20200424122323.10194-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122323.10194-1-sashal@kernel.org>
References: <20200424122323.10194-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit a17a9d935dc4a50acefaf319d58030f1da7f115a ]

Current wait times have proven to be too short to protect against inode
reuses that lead to metadata inconsistencies.

Now that we will retry the inode allocation if we can't find any
recently deleted inodes, it's a lot safer to increase the recently
deleted time from 5 seconds to a minute.

Link: https://lore.kernel.org/r/20200414023925.273867-1-tytso@mit.edu
Google-Bug-Id: 36602237
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ialloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index a6288730210e8..64b6549dd9016 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -660,7 +660,7 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
  * block has been written back to disk.  (Yes, these values are
  * somewhat arbitrary...)
  */
-#define RECENTCY_MIN	5
+#define RECENTCY_MIN	60
 #define RECENTCY_DIRTY	300
 
 static int recently_deleted(struct super_block *sb, ext4_group_t group, int ino)
-- 
2.20.1


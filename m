Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02AA19777C
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Mar 2020 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgC3JJj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Mar 2020 05:09:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbgC3JJi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Mar 2020 05:09:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 98A70AFC0;
        Mon, 30 Mar 2020 09:09:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 021EE1E0E03; Mon, 30 Mar 2020 11:09:36 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] ext2fs: Fix error checking in dx_link()
Date:   Mon, 30 Mar 2020 11:09:31 +0200
Message-Id: <20200330090932.29445-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200330090932.29445-1-jack@suse.cz>
References: <20200330090932.29445-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

dx_lookup() uses errcode_t return values. As such anything non-zero is
an error, not values less than zero. Fix the error checking to avoid
crashes on corrupted filesystems.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/ext2fs/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
index 6f523aee718c..7b5bb022117c 100644
--- a/lib/ext2fs/link.c
+++ b/lib/ext2fs/link.c
@@ -571,7 +571,7 @@ static errcode_t dx_link(ext2_filsys fs, ext2_ino_t dir,
 	dx_info.namelen = strlen(name);
 again:
 	retval = dx_lookup(fs, dir, diri, &dx_info);
-	if (retval < 0)
+	if (retval)
 		goto free_buf;
 
 	retval = add_dirent_to_buf(fs,
-- 
2.16.4


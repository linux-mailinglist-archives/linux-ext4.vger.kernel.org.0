Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3D3C5F8A
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jul 2021 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhGLPqO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jul 2021 11:46:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52448 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhGLPqK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jul 2021 11:46:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A9DEE22133;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626104601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5rEfG7aB6VAs4bnjkgZIQtiuA8OYJfyMHGtZHye36Y=;
        b=dQjVq1/Dmyu+XeZCMG5u8KZ5U7YnV2rJ7diNuYmCzmxs9zsjW56FPU7P7GKxakJmuImwRW
        XJ2awgoiWMynujWgzJaivPaYztFLrL3RvEoPH9imhRvoftWP0Ca+Su62LF2jOqncnVIFb0
        tiUn6lEP82cyEB+bS9a0WjJXHWf/vvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626104601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5rEfG7aB6VAs4bnjkgZIQtiuA8OYJfyMHGtZHye36Y=;
        b=aR1HLK4LVvt2fLkuIy1tJapVo14wWgboa1tgTAMjkx/eiG+hh07okGEtFFhE6q/hj8h89W
        zu9wOhXz3hGuyNDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 9FC16A3B96;
        Mon, 12 Jul 2021 15:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8B9141F2C73; Mon, 12 Jul 2021 17:43:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/9] quota: Do not account space used by project quota file to quota
Date:   Mon, 12 Jul 2021 17:43:08 +0200
Message-Id: <20210712154315.9606-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712154315.9606-1-jack@suse.cz>
References: <20210712154315.9606-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=960; h=from:subject; bh=5im1/rLcsGrGIog+vagdlp9riKn7Qwj5Iuc7YHUOxcM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7GMMJiIHiIXG00n/8nr8YstadbvlKtEnhDWLxSob mRkOnwSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOxjDAAKCRCcnaoHP2RA2YYGCA Cu9W0Cgon1pS8s/jBa9tU9YxPbettHD7XxbnVtdRzp4+FSHAb5T+InvFACnHw7bz8espi+FouBkqf8 kblr2sa741VpXfPfGt7yvdahCvNafxDbgx2FICmS6SIdloz9gtO3eaJgTugpddIXqX9oqtBCrcOq2o Ld+Fvpur532Nb3CtnKBgBI8DZDbH9hljYGA7VQF6wKjdu2ExI76AKib2tKlqC7H+TBV41DKEtdCcWN 2hGZOAMDWLYUGPRAWBvJ7sC5XRfVSQWUwodqAZldSD/Wmhg1H1OoUuKz5tgDxNPMyyaTI3yoQrEIRZ lMjtKBf0UGJDJUH5e6jBTJwWPkReo8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Project quota files have high inode numbers but are not accounted in
quota usage. Do not track them when computing quota usage.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/support/mkquota.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index fbc3833aee98..21a5c34d6921 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -500,9 +500,11 @@ errcode_t quota_compute_usage(quota_ctx_t qctx)
 		}
 		if (ino == 0)
 			break;
-		if (inode->i_links_count &&
-		    (ino == EXT2_ROOT_INO ||
-		     ino >= EXT2_FIRST_INODE(fs->super))) {
+		if (!inode->i_links_count)
+			continue;
+		if (ino == EXT2_ROOT_INO ||
+		    (ino >= EXT2_FIRST_INODE(fs->super) &&
+		     ino != quota_type2inum(PRJQUOTA, fs->super))) {
 			space = ext2fs_get_stat_i_blocks(fs,
 						EXT2_INODE(inode)) << 9;
 			quota_data_add(qctx, inode, ino, space);
-- 
2.26.2


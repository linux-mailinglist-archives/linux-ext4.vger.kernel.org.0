Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF59D3A9848
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFPK7w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 06:59:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40674 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhFPK7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 06:59:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9FF0F219D6;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5rEfG7aB6VAs4bnjkgZIQtiuA8OYJfyMHGtZHye36Y=;
        b=ncy9UNxj917KET6VfA0a57n8LT49kb97BqozHwm9AEje8UM8Ba1WXmnHKT6vLgP8AM89Rs
        1JW6wf4ARvMxOrg/PXrWGFMVSFHoAab/ysLQ7Giy+QhbUm8jSWkNntaHcUhOwvWWSVFQT8
        pzYSvC4cfzs1OIuKW++aBW6SIqqWy44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5rEfG7aB6VAs4bnjkgZIQtiuA8OYJfyMHGtZHye36Y=;
        b=3XrAraFOgtk5TXogf2pmNKaBftjIYeHm1WHBJhbOJMJnrSFBo5fD/kGBze1vHIXXzS4ZkP
        aEDugAsQMkNUhVAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 8A577A3BAA;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5FC751F2CBA; Wed, 16 Jun 2021 12:57:45 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/9] quota: Do not account space used by project quota file to quota
Date:   Wed, 16 Jun 2021 12:57:28 +0200
Message-Id: <20210616105735.5424-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616105735.5424-1-jack@suse.cz>
References: <20210616105735.5424-1-jack@suse.cz>
MIME-Version: 1.0
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


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6245E474A14
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Dec 2021 18:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhLNRvE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Dec 2021 12:51:04 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43436 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbhLNRvE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Dec 2021 12:51:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE5B821101;
        Tue, 14 Dec 2021 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639504262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9HYbUPArg5Npi8nSB59qNt54gDj1XOV5BLqPw1AnSX4=;
        b=gINm6zX/x5w2pmFOctMsC5fGO6Bv7mdHF3OT5c1p0qxOZq9vVLQ87YcXK122UnD0rNts0a
        aJ5FWDI7uTSQC+xcn7wgWdUmMhIxhX+EH5Vh9DUp2U3mF0eA4/B9OxjsbyCeOV7+sy9qUr
        AX/8SsQU0u3L5kHBkh7CNpsBawuOZgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639504262;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9HYbUPArg5Npi8nSB59qNt54gDj1XOV5BLqPw1AnSX4=;
        b=V6ZYopLlXacqa+I+XpkvmQGbdo1R9mN6Z7HErFoNjZOg4rjfr2k9KDexhi+8JN7MOcdQxx
        A9o96sepuAphMaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E57E13EC8;
        Tue, 14 Dec 2021 17:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OINjE4bZuGGaKQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 14 Dec 2021 17:51:02 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 7150d799;
        Tue, 14 Dec 2021 17:50:59 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: [PATCH v2] ext4: set csum seed in tmp inode while migrating to extents
Date:   Tue, 14 Dec 2021 17:50:58 +0000
Message-Id: <20211214175058.19511-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When migrating to extents, the temporary inode will have it's own checksum
seed.  This means that, when swapping the inodes data, the inode checksums
will be incorrect.

This can be fixed by recalculating the extents checksums again.  Or simply
by copying the seed into the temporary inode.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=213357
Reported-by: Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 fs/ext4/migrate.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

changes since v1:

* Dropped tmp_ei variable
* ->i_csum_seed is now initialised immediately after tmp_inode is created
* New comment about the seed initialization and stating that recovery
  needs to be fixed.

Cheers,
--
Luís

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 7e0b4f81c6c0..36dfc88ce05b 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -459,6 +459,17 @@ int ext4_ext_migrate(struct inode *inode)
 		ext4_journal_stop(handle);
 		goto out_unlock;
 	}
+	/*
+	 * Use the correct seed for checksum (i.e. the seed from 'inode').  This
+	 * is so that the metadata blocks will have the correct checksum after
+	 * the migration.
+	 *
+	 * Note however that, if a crash occurs during the migration process,
+	 * the recovery process is broken because the tmp_inode checksums will
+	 * be wrong and the orphans cleanup will fail.
+	 */
+	ei = EXT4_I(inode);
+	EXT4_I(tmp_inode)->i_csum_seed = ei->i_csum_seed;
 	i_size_write(tmp_inode, i_size_read(inode));
 	/*
 	 * Set the i_nlink to zero so it will be deleted later
@@ -502,7 +513,6 @@ int ext4_ext_migrate(struct inode *inode)
 		goto out_tmp_inode;
 	}
 
-	ei = EXT4_I(inode);
 	i_data = ei->i_data;
 	memset(&lb, 0, sizeof(lb));
 

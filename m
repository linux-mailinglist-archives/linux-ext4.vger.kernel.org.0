Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA7469926
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Dec 2021 15:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbhLFOlH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Dec 2021 09:41:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34800 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244773AbhLFOlF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Dec 2021 09:41:05 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EB221FD34;
        Mon,  6 Dec 2021 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638801456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJOFlQjAKHcH0wqO+IJBUf4iHa9DwBG2cjInTKyoM4E=;
        b=el5TjAHKLWW2wM3zq3SuwP85wmOjdWL2W7Belcj2QLQt76bBXjq9Q8I/LO6iPlcS3+UMdp
        tRAAqLZcdokJcAwRpre4MobQQw7oj11U2wLevTVI+Frt3WRZ9dPmVq099M40WG3R/aNIuc
        c1+NgeK/gj9ANXfEE0aoDaoY5Rx8/5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638801456;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJOFlQjAKHcH0wqO+IJBUf4iHa9DwBG2cjInTKyoM4E=;
        b=TLkeKaekyqkOO95lQp68lKsorvQ3apRfoG/W1CMBDU18/bUxZihRAjCRtoyLU2SSabEs0G
        HtRKTpoAoSkX94Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5D4C13BBC;
        Mon,  6 Dec 2021 14:37:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kKRAJS8grmH/PwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 06 Dec 2021 14:37:35 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 4b702813;
        Mon, 6 Dec 2021 14:37:34 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: [PATCH] ext4: set csum seed in tmp inode while migrating to extents
Date:   Mon,  6 Dec 2021 14:37:33 +0000
Message-Id: <20211206143733.18918-1-lhenriques@suse.de>
In-Reply-To: <bug-213357-13602@https.bugzilla.kernel.org>
References: <bug-213357-13602@https.bugzilla.kernel.org>
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
 fs/ext4/migrate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 7e0b4f81c6c0..dd4ece38fc83 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -413,7 +413,7 @@ int ext4_ext_migrate(struct inode *inode)
 	handle_t *handle;
 	int retval = 0, i;
 	__le32 *i_data;
-	struct ext4_inode_info *ei;
+	struct ext4_inode_info *ei, *tmp_ei;
 	struct inode *tmp_inode = NULL;
 	struct migrate_struct lb;
 	unsigned long max_entries;
@@ -503,6 +503,10 @@ int ext4_ext_migrate(struct inode *inode)
 	}
 
 	ei = EXT4_I(inode);
+	tmp_ei = EXT4_I(tmp_inode);
+	/* Use the right seed for checksumming */
+	tmp_ei->i_csum_seed = ei->i_csum_seed;
+
 	i_data = ei->i_data;
 	memset(&lb, 0, sizeof(lb));
 

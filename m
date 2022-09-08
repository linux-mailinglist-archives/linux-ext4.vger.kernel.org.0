Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5525D5B1881
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiIHJXY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiIHJWy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:22:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D970E1248
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:21:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA01C33A5D;
        Thu,  8 Sep 2022 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662628896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWobdIdBVqzKk8PTxur1hZpvv7SZFf41/a/VOf26Qr8=;
        b=DRqu1t+AaWCTp8jLjMJLTbMZDbVDMmHK+6qA+91QvTjNFAvYzsT+GEflftqg0+3fko3xTy
        H5OjcaZUWYk+XMrT7X6a25PgEo1t/S68NRUGx7TTCivF6ZB5GLFiEcuu8xQqEEfvDm9aVn
        fG9WYp3YGYtf36Q612iigBxEq0Q1nus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662628896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWobdIdBVqzKk8PTxur1hZpvv7SZFf41/a/VOf26Qr8=;
        b=is//Hlo59PGxb1/egI/dpNBHvPxRk9f5eaBPZMDDccuYBQK/r8t9SO7n6bfTtY52JUFW0b
        9NF1d121Xg452IBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA7F213A72;
        Thu,  8 Sep 2022 09:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8YmXKSC0GWOrRAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 09:21:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1CB7AA0684; Thu,  8 Sep 2022 11:21:36 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/5] ext4: Make directory inode spreading reflect flexbg size
Date:   Thu,  8 Sep 2022 11:21:26 +0200
Message-Id: <20220908092136.11770-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220908091301.147-1-jack@suse.cz>
References: <20220908091301.147-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; h=from:subject; bh=Nfjo5UZc1lyu8JjrRbs/4cX/UGYB6EcxiocVkBovhvs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjGbQVUwdtDwfA4J9yJwE/M/Z+SOgDx7nZsFN9Cp2z C3SItK2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYxm0FQAKCRCcnaoHP2RA2bltCA DldTAR6xeNciWva9fBlGHvqIvGY8aEAopTtxcy2RfUY6mxYh+E0FJgmgQP3fcb4PlkV/77uFdd7Ix3 0prDkbYdMNCKqk1oPvFpwsNjuV3oae8Q86WJD/gk6qHkEujiMisss5xGPm0AaWzYA9jU267eznYlmk ns3IC8D/hzkiH4D8BsxI3VC7vFD+gpubmmXul/0ZvVeq4XyXyl+pZvwPUex3e10hQZXfJL2z5p7R4C gxa9DZlUQW2rAaoToIa79gFzNxy3COayfE6ETQ/9r/lF1tvI/xImYnj7Iy57NO18HjTiSy8FHGvI/q OXVKB/dolVbowy59lCGGY9qUDo2s50
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently the Orlov inode allocator searches for free inodes for a
directory only in flex block groups with at most inodes_per_group/16
more directory inodes than average per flex block group. However with
growing size of flex block group this becomes unnecessarily strict.
Scale allowed difference from average directory count per flex block
group with flex block group size as we do with other metrics.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ialloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index f73e5eb43eae..208b87ce8858 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -510,7 +510,7 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 		goto fallback;
 	}
 
-	max_dirs = ndirs / ngroups + inodes_per_group / 16;
+	max_dirs = ndirs / ngroups + inodes_per_group*flex_size / 16;
 	min_inodes = avefreei - inodes_per_group*flex_size / 4;
 	if (min_inodes < 1)
 		min_inodes = 1;
-- 
2.35.3


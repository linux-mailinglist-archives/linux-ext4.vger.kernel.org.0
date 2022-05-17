Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A0652A97A
	for <lists+linux-ext4@lfdr.de>; Tue, 17 May 2022 19:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351515AbiEQRkn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 May 2022 13:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351549AbiEQRkl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 May 2022 13:40:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832E63A18E
        for <linux-ext4@vger.kernel.org>; Tue, 17 May 2022 10:40:39 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24HHeY3O031451
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 13:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652809235; bh=qR4xPIdfTgHBwtGxk8wapvkaYBY73EgPKvXLJnR4gQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KgS08hJveat3B6u0Mh7MXGpxGYrFB+Tdqtdsgpg+/lI+fATFDXAjyV79JPNceqT8v
         cSJC8+u6mCGXwsRLlHbtrPavRcwSfW3wySCgfHp1758YywzSZsFrZ+PW6CjMxwtPlr
         jTMmB/QKJsnOySi2pUY4Badqh1HbOootV5xs9sgJeSuDt4kpSKWz9YnIyTfrfHsf8N
         Au1QE+QDvKstL3XqhFEN0iV6AY/sK9MipFnYIfQE7Binw9wqR71Jj75p7JwibGQbX5
         txS6vOY2T1wdjIQ27i9zkbfZKwUY92gDVARQuPt2SMEZMzLfOtDO/roFcqLkXqjlp2
         b55mnB83UIZbQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0A41A15C3EC0; Tue, 17 May 2022 13:40:34 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Nguyen Dinh Phi <phind.uet@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com
Subject: [PATCH] ext4: filter out EXT4_FC_REPLAY from on-disk superblock field s_state
Date:   Tue, 17 May 2022 13:40:28 -0400
Message-Id: <20220517174028.942119-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <Yn8kBKV7bZXCIDsB@mit.edu>
References: <Yn8kBKV7bZXCIDsB@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The EXT4_FC_REPLAY bit in sbi->s_mount_state is used to indicate that
we are in the middle of replay the fast commit journal.  This was
actually a mistake, since the sbi->s_mount_info is initialized from
es->s_state.  Arguably s_mount_state is misleadingly named, but the
name is historical --- s_mount_state and s_state dates back to ext2.

What should have been used is the ext4_{set,clear,test}_mount_flag()
inline functions, which sets EXT4_MF_* bits in sbi->s_mount_flags.

The problem with using EXT4_FC_REPLAY is that a maliciously corrupted
superblock could result in EXT4_FC_REPLAY getting set in
s_mount_state.  This bypasses some sanity checks, and this can trigger
a BUG() in ext4_es_cache_extent().  As a easy-to-backport-fix, filter
out the EXT4_FC_REPLAY bit for now.  We should eventually transition
away from EXT4_FC_REPLAY to something like EXT4_MF_REPLAY.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20220420192312.1655305-1-phind.uet@gmail.com
Reported-by: syzbot+c7358a3cd05ee786eb31@syzkaller.appspotmail.com
---
 fs/ext4/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4b0ea8df1f5c..f7ae53d986f1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4889,7 +4889,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 					sbi->s_inodes_per_block;
 	sbi->s_desc_per_block = blocksize / EXT4_DESC_SIZE(sb);
 	sbi->s_sbh = bh;
-	sbi->s_mount_state = le16_to_cpu(es->s_state);
+	sbi->s_mount_state = le16_to_cpu(es->s_state) & ~EXT4_FC_REPLAY;
 	sbi->s_addr_per_block_bits = ilog2(EXT4_ADDR_PER_BLOCK(sb));
 	sbi->s_desc_per_block_bits = ilog2(EXT4_DESC_PER_BLOCK(sb));
 
@@ -6452,7 +6452,8 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 				if (err)
 					goto restore_opts;
 			}
-			sbi->s_mount_state = le16_to_cpu(es->s_state);
+			sbi->s_mount_state = (le16_to_cpu(es->s_state) &
+					      ~EXT4_FC_REPLAY);
 
 			err = ext4_setup_super(sb, es, 0);
 			if (err)
-- 
2.31.0


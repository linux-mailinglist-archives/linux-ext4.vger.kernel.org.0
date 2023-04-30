Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2062C6F2967
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjD3PnY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjD3PnX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 11:43:23 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB8319AF
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 08:43:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UFhGbO021728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 11:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682869397; bh=WzpHreJGFcaaxgm7kWLsXwX4Tn7aNtKLigaC5RrlqhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KswkmOfqM3+RjnqFRQRzKHj1jqEiPlEkE8ApZHSf031ZWspYf6uBfTovdI/g3JXlK
         II8muqG6pZe97x5qTYTYiFqubLjAQOf8x4GqhYM/56yRt5CuvoVx6P7v4M3DrRynmQ
         BUsZ7NRdcg4FhHAce91JxVjGd5xKY2m49gf42/XuLDbzOHgnkV4jMzyJrkQn56lQta
         NTiBiqRFREAiuGiP2RtqlkT9XIMOiOXlrkm4F4pYqOz5E9MPf4m05GlS/syLjvFXF9
         I/gDhFefDRom3IBhK46zky2SHspcM/QJuZ4b0I4Lsh4MAz+xzsOF+01KMdJyFEo5LQ
         p0yShq8Q1PClQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6341215C02E4; Sun, 30 Apr 2023 11:43:16 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] ext4: remove a BUG_ON in ext4_mb_release_group_pa()
Date:   Sun, 30 Apr 2023 11:43:11 -0400
Message-Id: <20230430154311.579720-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230430154311.579720-1-tytso@mit.edu>
References: <20230430154311.579720-1-tytso@mit.edu>
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

If a malicious fuzzer overwrites the ext4 superblock while it is
mounted such that the s_first_data_block is set to a very large
number, the calculation of the block group can underflow, and trigger
a BUG_ON check.  Change this to be an ext4_warning so that we don't
crash the kernel.

Reported-by: syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=69b28112e098b070f639efb356393af3ffec4220
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/mballoc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index dc13734f399d..9c7881a4ea75 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5047,7 +5047,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 	trace_ext4_mb_release_group_pa(sb, pa);
 	BUG_ON(pa->pa_deleted == 0);
 	ext4_get_group_no_and_offset(sb, pa->pa_pstart, &group, &bit);
-	BUG_ON(group != e4b->bd_group && pa->pa_len != 0);
+	if (unlikely(group != e4b->bd_group && pa->pa_len != 0)) {
+		ext4_warning(sb, "bad group: expected %u, group %u, pa_start %llu",
+			     e4b->bd_group, group, pa->pa_pstart);
+		return 0;
+	}
 	mb_free_blocks(pa->pa_inode, e4b, bit, pa->pa_len);
 	atomic_add(pa->pa_len, &EXT4_SB(sb)->s_mb_discarded);
 	trace_ext4_mballoc_discard(sb, NULL, group, bit, pa->pa_len);
-- 
2.31.0


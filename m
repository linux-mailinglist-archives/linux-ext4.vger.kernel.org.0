Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF558630C
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Aug 2022 05:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbiHADZA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 31 Jul 2022 23:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiHADY6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 31 Jul 2022 23:24:58 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3AB65B1;
        Sun, 31 Jul 2022 20:24:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B1E785C00A3;
        Sun, 31 Jul 2022 23:24:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 31 Jul 2022 23:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659324295; x=1659410695; bh=gMZgdyYp8c
        FAC5VD+4qabL5nDDePRou6YT7DYrrfPjI=; b=cOU1dy4e8cSqv41xnwzteNFNTM
        yLE3XusVWrc5D34bS8wI8UVs2plXSb9iuRTBydERXAlTqQi4MRp0ZPBOGRNGgi+c
        Web5EEeo514X0BI3sQ00PIGxwlto7di0tdXlS+D7i8ZgpzdpTHby96nOffG5jspa
        VhD9Il85hJriaZ2W0SDiQAcqv9vWt7HyVmaAzmBYTrMqf6Ri9Pu3WqY4XKnj5zM0
        Sb9082pKnqiCkyKnC3OLCWCTtfCxhvlX9tHhWWOBZDaO8wBy/hE0GUUye8aomAXH
        f6e32YK4blQFiuC+5IVLtGyyXL/rHRihrjM/GoS4vOnmOYUe3siQi+1nvelA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659324295; x=
        1659410695; bh=gMZgdyYp8cFAC5VD+4qabL5nDDePRou6YT7DYrrfPjI=; b=t
        PwRgE+PoeSiq4n7416AuxSOid+gooUjbYYiYkeHsncZvHfQBdstXrGzbsa92uGq8
        piVNLSRVZKHvmaLRGE1DSIeCmlRQ34cgm/2hLyGEE5bufq1o7iNvFPbgOGk59rto
        YvLsAsKueVvZ0TekZCAOn2YNLMWRrMz6NCvOyylilHPlZGDPvHx2JQMYkyMbM5ru
        cjOIu0jN2Q5slDhlG5JGWX17LJ975J9IffLvVkRV38vRS3IcgWOXYMBX2prpMDSF
        rYXqsX4k8yIb5/Ta1yZ04hBiF81t0wy5Ff4aRI2uS/G66rC6FXArFVMzEtn7NhAZ
        mAQlSsUrxEfxjiMp/rqyA==
X-ME-Sender: <xms:h0fnYlAVX4pNoPFhzBWB41kNZQSD4IKQG0fbnzQUpjg1gBDZ6eypFw>
    <xme:h0fnYjgPWKVZhOrX2Av5Srtf0UZfhtu_AsrA_L2CqaBGI5pjTN74vD1MNCObcQRu5
    Swmyv3LlUEh7qb2J10>
X-ME-Received: <xmr:h0fnYgkjKxMhknC1NkFT6WlregqnYpbwPTsUSirve480khPASnZsmLlwrrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpeflohhshhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhht
    rhhiphhlvghtthdrohhrgheqnecuggftrfgrthhtvghrnhepuddvleehtedtgfdvvdelge
    eufedugeduveffkeejgefffedvieekhedvheelkefhnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvghtth
    drohhrgh
X-ME-Proxy: <xmx:h0fnYvxsB0p9BJz792N_8H5fz-qSJM7a_s3NAY7shvDAOvuD0AeVJw>
    <xmx:h0fnYqSTp23QqTuoKS9BftPlqkEgYltpNqkoFM8oTEnuVXge_wCCMg>
    <xmx:h0fnYibRFRPP4szCY83D61k-oP-YOhCNBO_-yzsdFKAVqQlNzYmMFA>
    <xmx:h0fnYlfxyyb1Yr6c5qqGi-2BGHSwk1RKLLYmaMPeQM0qMCfisage1w>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 23:24:54 -0400 (EDT)
Date:   Sun, 31 Jul 2022 20:24:53 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Don't run ext4lazyinit for read-only filesystems
Message-ID: <48b41da1498fcac3287e2e06b660680646c1c050.1659323972.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On a read-only filesystem, we won't invoke the block allocator, so we
don't need to prefetch the block bitmaps.

This avoids starting and running the ext4lazyinit thread at all on a
system with no read-write ext4 filesystems (for instance, a container VM
with read-only filesystems underneath an overlayfs).

Fixes: 21175ca434c5 ("ext4: make prefetch_block_bitmaps default")
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

Tested in a VM, with a read-only ext4 root filesystem. Confirmed that
ext4lazyinit starts without this patch, and does not start with this
patch.

(For a future merge window, not the current one. Please let me know if I
need to re-send this at a later, more convenient time.)

 fs/ext4/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 845f2f8aee5f..20437acc8865 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3973,9 +3973,9 @@ int ext4_register_li_request(struct super_block *sb,
 		goto out;
 	}
 
-	if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
-	    (first_not_zeroed == ngroups || sb_rdonly(sb) ||
-	     !test_opt(sb, INIT_INODE_TABLE)))
+	if (sb_rdonly(sb) ||
+	    (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
+	     (first_not_zeroed == ngroups || !test_opt(sb, INIT_INODE_TABLE))))
 		goto out;
 
 	elr = ext4_li_request_new(sb, first_not_zeroed);
-- 
2.36.1


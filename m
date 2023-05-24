Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBA970EC17
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 05:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbjEXDuS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 May 2023 23:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjEXDuN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 May 2023 23:50:13 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CA3A3
        for <linux-ext4@vger.kernel.org>; Tue, 23 May 2023 20:50:12 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34O3nvSs023547
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 23:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684900199; bh=FBHE5G3da35LitPoga6hWGXfIB/BQHj4xRYCoiX+6gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KmRrZvvESaFtPBkm3XbKqvS9asftRfGaNtzOYve+DvHR5NPQ1iGE7h5fr2FBiOfZp
         yBUoL1VOU4gbBtinOKQLJrFO0/NTX41VSVADIOlV3T1aGYN7rjNtB5KE3N/BYm4K+h
         RWxEDyaiFNi+LKJfOjaHN+cEjm/+FNMRoyv6+AbqKMG90M70JxR/o8bhiamRBlWw/u
         32p8eFQVL7SZUWi1uz2oB0YVkN8CuHoss+XHzB6nXxHAK9FwoMuymoMTxmuoC+3dk9
         YHfaZ/xORJ3nCvY4GC9j1+WGzk1K4CPNuMkWhSadBs3GNWXxiaKpaqYPBTa9pj/l2c
         JCntmYSq+e73A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8C18615C052E; Tue, 23 May 2023 23:49:57 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, stable@kernel.org,
        syzbot+e44749b6ba4d0434cd47@syzkaller.appspotmail.com
Subject: [PATCH 3/4] ext4: disallow ea_inodes with extended attributes
Date:   Tue, 23 May 2023 23:49:50 -0400
Message-Id: <20230524034951.779531-4-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230524034951.779531-1-tytso@mit.edu>
References: <20230524034951.779531-1-tytso@mit.edu>
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

An ea_inode stores the value of an extended attribute; it can not have
extended attributes itself, or this will cause recursive nightmares.
Add a check in ext4_iget() to make sure this is the case.

Cc: stable@kernel.org
Reported-by: syzbot+e44749b6ba4d0434cd47@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 258f3cbed347..02de439bf1f0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4647,6 +4647,9 @@ static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
 	if (flags & EXT4_IGET_EA_INODE) {
 		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
 			return "missing EA_INODE flag";
+		if (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
+		    EXT4_I(inode)->i_file_acl)
+			return "ea_inode with extended attributes";
 	} else {
 		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
 			return "unexpected EA_INODE flag";
-- 
2.31.0


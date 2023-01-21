Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C80676942
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjAUUgn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjAUUgm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0263D28D3E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8038760ADD
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2018C4339E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333399;
        bh=IRtFKx1Qv/BeXJIpY4N5ZFn3oUsQkx1zaMi9+y9XAAM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hB2pT9IoMRtbID42+4+nFdbMbwplG3jCUwO0ij0o4ve/PNKvbjsQBlYzj5ma+ik8g
         xGik4EKvKiSMhzlVVK/vPy9SkbkvN7sYsifzgxzfqu8/9C8qTvel+Igi3+Ki5L0qav
         fcAT0I5z95hYrlNsdmFs5+mXrdSe9EVayWFUqbQ0bTrDcoNzsgajFvN5JsbAiKlVe9
         KSxGdYRyRbrGWR5GMSwSx27ETD1DGHpEL0X3YlZUXAURFLJMnMkcAmUiwW5akO4zgt
         skWcIE+Gt5m987ED18uG731+aXr3HIHOxtm4iNLu9uXaba0IldYYWOWXbCYE6zAOAh
         82IUYX2AIfJKg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 08/38] lib/blkid: fix unaligned access to hfs_mdb
Date:   Sat, 21 Jan 2023 12:32:00 -0800
Message-Id: <20230121203230.27624-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

With -Wall, gcc warns:

      ./probe.c:1209:42: error: taking address of packed member of
               'struct hfs_mdb' may result in an unaligned pointer value

This seems to be a real unaligned memory access bug, as the offset of
the 64-bit value from the start of the buffer is 116, which is not a
multiple of 8.  Fix it by using memcpy().

Do the same for hfsplus to fix the same warning, though in that case the
offset is a multiple of 8 so it was defined behavior.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/blkid/probe.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/blkid/probe.c b/lib/blkid/probe.c
index b8b6558e3..6a3bb2478 100644
--- a/lib/blkid/probe.c
+++ b/lib/blkid/probe.c
@@ -1198,7 +1198,6 @@ static int probe_hfs(struct blkid_probe *probe __BLKID_ATTR((unused)),
 			 unsigned char *buf)
 {
 	struct hfs_mdb *hfs = (struct hfs_mdb *)buf;
-	unsigned long long *uuid_ptr;
 	char	uuid_str[17];
 	__u64	uuid;
 
@@ -1206,8 +1205,8 @@ static int probe_hfs(struct blkid_probe *probe __BLKID_ATTR((unused)),
 	    (memcmp(hfs->embed_sig, "HX", 2) == 0))
 		return 1;	/* Not hfs, but an embedded HFS+ */
 
-	uuid_ptr = (unsigned long long *)hfs->finder_info.id;
-	uuid = blkid_le64(*uuid_ptr);
+	memcpy(&uuid, hfs->finder_info.id, 8);
+	uuid = blkid_le64(uuid);
 	if (uuid) {
 		sprintf(uuid_str, "%016llX", uuid);
 		blkid_set_tag(probe->dev, "UUID", uuid_str, 0);
@@ -1243,7 +1242,6 @@ static int probe_hfsplus(struct blkid_probe *probe,
 	unsigned int leaf_node_size;
 	unsigned int leaf_block;
 	unsigned int label_len;
-	unsigned long long *uuid_ptr;
 	__u64 leaf_off, uuid;
 	char	uuid_str[17], label[512];
 	int ext;
@@ -1274,8 +1272,8 @@ static int probe_hfsplus(struct blkid_probe *probe,
 	    (memcmp(hfsplus->signature, "HX", 2) != 0))
 		return 1;
 
-	uuid_ptr = (unsigned long long *)hfsplus->finder_info.id;
-	uuid = blkid_le64(*uuid_ptr);
+	memcpy(&uuid, hfsplus->finder_info.id, 8);
+	uuid = blkid_le64(uuid);
 	if (uuid) {
 		sprintf(uuid_str, "%016llX", uuid);
 		blkid_set_tag(probe->dev, "UUID", uuid_str, 0);
-- 
2.39.0


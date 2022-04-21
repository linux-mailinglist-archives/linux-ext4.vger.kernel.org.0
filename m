Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3F550A72C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Apr 2022 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390803AbiDURfv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Apr 2022 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390853AbiDURfq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Apr 2022 13:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A5E8496B2
        for <linux-ext4@vger.kernel.org>; Thu, 21 Apr 2022 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650562314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZaoB/2ZvV5Qlz0GduVdKHMTAx69SDtFKGceytmwrZhI=;
        b=K5d98RHXNXlWuGUACh/n66PnU2gs0Zuoahu4O6soDjiwwA6TUdbSQ2ZDuZXHdmDKpgf+E8
        685zQJG2CZeBjCmXbq75L1J3tOzak39B4LPxdmsfnE2VY74yMk99p+E5U/MMVgf9y+wsKZ
        314A0qjXMI40Pw58xgzMU1i/IbtBXFU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-uR_Y6wf-Nw6W5hbHs0aChg-1; Thu, 21 Apr 2022 13:31:50 -0400
X-MC-Unique: uR_Y6wf-Nw6W5hbHs0aChg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E246185A79C;
        Thu, 21 Apr 2022 17:31:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.192.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B769D145BA47;
        Thu, 21 Apr 2022 17:31:49 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Nils Bars <nils_bars@t-online.de>
Subject: [PATCH] e2fsprogs: add sanity check to extent manipulation
Date:   Thu, 21 Apr 2022 19:31:48 +0200
Message-Id: <20220421173148.20193-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It is possible to have a corrupted extent tree in such a way that a leaf
node contains zero extents in it. Currently if that happens and we try
to traverse the tree we can end up accessing wrong data, or possibly
even uninitialized memory. Make sure we don't do that.

Additionally make sure that we have a sane number of bytes passed to
memmove() in ext2fs_extent_delete().

Note that e2fsck is currently unable to spot and fix such corruption in
pass1.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reported-by: Nils Bars <nils_bars@t-online.de>
Addressess: https://bugzilla.redhat.com/show_bug.cgi?id=2068113
---
 lib/ext2fs/extent.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/ext2fs/extent.c b/lib/ext2fs/extent.c
index b324c7b0..1a206a16 100644
--- a/lib/ext2fs/extent.c
+++ b/lib/ext2fs/extent.c
@@ -495,6 +495,10 @@ retry:
 			ext2fs_le16_to_cpu(eh->eh_entries);
 		newpath->max_entries = ext2fs_le16_to_cpu(eh->eh_max);
 
+		/* Make sure there is at least one extent present */
+		if (newpath->left <= 0)
+			return EXT2_ET_EXTENT_NO_DOWN;
+
 		if (path->left > 0) {
 			ix++;
 			newpath->end_blk = ext2fs_le32_to_cpu(ix->ei_block);
@@ -1630,6 +1634,10 @@ errcode_t ext2fs_extent_delete(ext2_extent_handle_t handle, int flags)
 
 	cp = path->curr;
 
+	/* Sanity check before memmove() */
+	if (path->left < 0)
+		return EXT2_ET_EXTENT_LEAF_BAD;
+
 	if (path->left) {
 		memmove(cp, cp + sizeof(struct ext3_extent_idx),
 			path->left * sizeof(struct ext3_extent_idx));
-- 
2.35.1


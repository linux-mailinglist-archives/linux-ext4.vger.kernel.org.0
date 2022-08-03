Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5EE588ACD
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 12:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiHCKxq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 06:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiHCKxq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 06:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E864E1C927
        for <linux-ext4@vger.kernel.org>; Wed,  3 Aug 2022 03:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659524024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d7/N+5T0L5YVCabYi0HwTKIlxTiBQG7EgyPU+y7E0Tc=;
        b=J4m83zjoKMGmKa25wcJmsIoFZXaGyTCV98gKprH2C3ZxHtREh2A+jfQDTRnellKv19v9j+
        XsynYhxvef1xPaBWfdsY0N7S6mEUY2IIOcnjKirUgmeZTYZJRj/17+hmUXDw4F5J1fIXC3
        81DH4tEcnD9W0U9TTGI2Jpr6ySKDH/k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-6RMINI7kPAiStbVsUj22Qg-1; Wed, 03 Aug 2022 06:53:42 -0400
X-MC-Unique: 6RMINI7kPAiStbVsUj22Qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFCD385A581;
        Wed,  3 Aug 2022 10:53:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 088021121314;
        Wed,  3 Aug 2022 10:53:40 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     jlayton@kernel.org, tytso@mit.edu, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/3] ext4: don't increase iversion counter for ea_inodes
Date:   Wed,  3 Aug 2022 12:53:38 +0200
Message-Id: <20220803105340.17377-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ea_inodes are using i_version for storing part of the reference count so
we really need to leave it alone.

The problem can be reproduced by xfstest ext4/026 when iversion is
enabled. Fix it by not calling inode_inc_iversion() for EXT4_EA_INODE_FL
inodes in ext4_mark_iloc_dirty().

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
v2: no changes

 fs/ext4/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 84c0eb55071d..b76554124224 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5717,7 +5717,12 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 	}
 	ext4_fc_track_inode(handle, inode);
 
-	if (IS_I_VERSION(inode))
+	/*
+	 * ea_inodes are using i_version for storing reference count, don't
+	 * mess with it
+	 */
+	if (IS_I_VERSION(inode) &&
+	    !(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
 		inode_inc_iversion(inode);
 
 	/* the do_update_inode consumes one bh->b_count */
-- 
2.37.1


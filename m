Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9293256589B
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 16:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiGDO2V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 10:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiGDO11 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 10:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5F57636A
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656944845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFheRc6ahFYZU0nsUZgmnAMawQpOetoOvsCOk95T5Y4=;
        b=itZflsLxVcC3qBmvCd8YpagDDQbwQz02gP3GI6ISywSMM3QHIB9HT1tpkx7mDP2zrEZNb2
        nC8RqxwovxSl/zg4ogrJeBG6XZVRLZu3gTF3hZSEntTVl3DKHhnSmKIWJtNRMKLawY2omY
        xriJTTKazyRKg2+S0LnWGYB24TWBdAQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-mtI9X-EcOE6Lom9y5T3Zlw-1; Mon, 04 Jul 2022 10:27:24 -0400
X-MC-Unique: mtI9X-EcOE6Lom9y5T3Zlw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D8871035341;
        Mon,  4 Jul 2022 14:27:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 830D2492C3B;
        Mon,  4 Jul 2022 14:27:23 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
Subject: [PATCH 2/2] ext4: make sure ext4_append() always allocates new block
Date:   Mon,  4 Jul 2022 16:27:21 +0200
Message-Id: <20220704142721.157985-2-lczerner@redhat.com>
In-Reply-To: <20220704142721.157985-1-lczerner@redhat.com>
References: <20220704142721.157985-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_append() must always allocate a new block, otherwise we run the
risk of overwriting existing directory block corrupting the directory
tree in the process resulting in all manner of problems later on.

Add a sanity check to see if the logical block is already allocated and
error out if it is.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/namei.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cf460aa4f81d..4af441494e09 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -54,6 +54,7 @@ static struct buffer_head *ext4_append(handle_t *handle,
 					struct inode *inode,
 					ext4_lblk_t *block)
 {
+	struct ext4_map_blocks map;
 	struct buffer_head *bh;
 	int err;
 
@@ -63,6 +64,21 @@ static struct buffer_head *ext4_append(handle_t *handle,
 		return ERR_PTR(-ENOSPC);
 
 	*block = inode->i_size >> inode->i_sb->s_blocksize_bits;
+	map.m_lblk = *block;
+	map.m_len = 1;
+
+	/*
+	 * We're appending new directory block. Make sure the block is not
+	 * allocated yet, otherwise we will end up corrupting the
+	 * directory.
+	 */
+	err = ext4_map_blocks(NULL, inode, &map, 0);
+	if (err < 0)
+		return ERR_PTR(err);
+	if (err) {
+		EXT4_ERROR_INODE(inode, "Logical block already allocated");
+		return ERR_PTR(-EFSCORRUPTED);
+	}
 
 	bh = ext4_bread(handle, inode, *block, EXT4_GET_BLOCKS_CREATE);
 	if (IS_ERR(bh))
-- 
2.35.3


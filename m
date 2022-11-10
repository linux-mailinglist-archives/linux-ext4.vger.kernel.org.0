Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE07624B84
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 21:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbiKJUQn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Nov 2022 15:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiKJUQj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Nov 2022 15:16:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B343841
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 12:16:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3C081CE24C8
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 20:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A639C433C1;
        Thu, 10 Nov 2022 20:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668111395;
        bh=lvfocEHnjnGZ0LZx3BIJzkv0kFaM8jAH6ujgOBrvRdY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=caEDb0O/YFmNnsbZrV6R2koc5X7cZBxSTXOUkpc01APUqZjE7Q9QJ25U6BPcnVw90
         2BvS/h2udA3cN3vsQmTKzcUWEV4jCjYa0d+bm+LGIYDSQMDdjyXMjMCGiYDvm2dG3e
         5KAj5pQOuYqRU5lZmw9bHYwZCXJE/d67YHTMZ93nV/ZZq/kY68Y7JSlI0zwe7mE17y
         DVYVskZepxY1gtz8weI6OWq30ulZjT2i7WG0LpRpJki6qDZj3vjU4PLpZy+RIBt7Sa
         xvbsVCW0IwIJ/7gLzoDlhLKWsN55TVv0kRsIVFzkohgAooNbpRzgvrVxnjZYKVPNlt
         MG/69LxP7rsHw==
Subject: [PATCH 2/2] ext4: don't fail GETFSUUID when the caller provides a
 long buffer
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, tytso@mit.edu
Cc:     catherine.hoang@oracle.com, linux-ext4@vger.kernel.org
Date:   Thu, 10 Nov 2022 12:16:34 -0800
Message-ID: <166811139478.327006.13879198441587445544.stgit@magnolia>
In-Reply-To: <166811138334.327006.2601737065307668866.stgit@magnolia>
References: <166811138334.327006.2601737065307668866.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

If userspace provides a longer UUID buffer than is required, we
shouldn't fail the call with EINVAL -- rather, we can fill the caller's
buffer with the bytes we /can/ fill, and update the length field to
reflect what we copied.  This doesn't break the UAPI since we're
enabling a case that currently fails, and so far Ted hasn't released a
version of e2fsprogs that uses the new ext4 ioctl.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/ext4/ioctl.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 5f91f3ad3e50..31e643795016 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1159,14 +1159,16 @@ static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
 		return 0;
 	}
 
-	if (fsuuid.fsu_len != UUID_SIZE || fsuuid.fsu_flags != 0)
+	if (fsuuid.fsu_len < UUID_SIZE || fsuuid.fsu_flags != 0)
 		return -EINVAL;
 
 	lock_buffer(sbi->s_sbh);
 	memcpy(uuid, sbi->s_es->s_uuid, UUID_SIZE);
 	unlock_buffer(sbi->s_sbh);
 
-	if (copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
+	fsuuid.fsu_len = UUID_SIZE;
+	if (copy_to_user(ufsuuid, &fsuuid, sizeof(fsuuid)) ||
+	    copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
 		return -EFAULT;
 	return 0;
 }


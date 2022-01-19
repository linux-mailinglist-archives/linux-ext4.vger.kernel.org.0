Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABDE493AC9
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jan 2022 14:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354631AbiASNCf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jan 2022 08:02:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354590AbiASNC2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Jan 2022 08:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642597347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RCTDMFnnkgSll+dNVUpvfhl079rhxjaakfF8jMhfM6s=;
        b=JoJ4BBBeJSQribDPHavtIwwnW4xXR9PvFRyohmzk2kCg0CI1ei9ytoRlEncdcMAOYhVyEE
        XI3n+d+s83g7tz742ejloIfkGuaHzc3wVfbM3ROKBJRwm6StTPuCHaepZraLxGNY61jO0A
        Gk5Xx+rh0zfpTM/27Sh9X1zB+mYOGEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-99MWPBYZPU676gtSHTWa_Q-1; Wed, 19 Jan 2022 08:02:22 -0500
X-MC-Unique: 99MWPBYZPU676gtSHTWa_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21ECB1008063;
        Wed, 19 Jan 2022 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1FCD79C53;
        Wed, 19 Jan 2022 13:02:19 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ext4: fix potential NULL pointer dereference in ext4_fill_super()
Date:   Wed, 19 Jan 2022 14:02:09 +0100
Message-Id: <20220119130209.40112-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

By mistake we fail to return an error from ext4_fill_super() in case
that ext4_alloc_sbi() fails to allocate a new sbi. Instead we just set
the ret variable and allow the function to continue which will later
lead to a NULL pointer dereference. Fix it by returning -ENOMEM in the
case ext4_alloc_sbi() fails.

Fixes: cebe85d570cf ("ext4: switch to the new mount api")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index db9fe4843529..6023ebb5b19d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5543,7 +5543,7 @@ static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sbi = ext4_alloc_sbi(sb);
 	if (!sbi)
-		ret = -ENOMEM;
+		return -ENOMEM;
 
 	fc->s_fs_info = sbi;
 
-- 
2.31.1


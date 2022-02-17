Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD82F4B9BF9
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Feb 2022 10:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiBQJZf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Feb 2022 04:25:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiBQJZe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Feb 2022 04:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAEF92819AD
        for <linux-ext4@vger.kernel.org>; Thu, 17 Feb 2022 01:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645089919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NxqNMB0amI5w6rChJtS8Sih//dTfwjjkpy+T1F4Z35k=;
        b=PhKribLZ+Q0kE07n3QhhAx0O1gxcM3BkJLOJHlWi591b9JxBJNB6yNTsxYegH1BysC5c9r
        HyH6fVpJtI7MPQcJaCjGr97p7zoi3JZF+QZuSiLCQprtfhXaUUJc2TDWmXDLIyvuy8AHW4
        aQ4iwLT8t2Wkrf0yKtX1swGCTdRefoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-311-IV9PyEuhPsuuW_Ti6aoE2w-1; Thu, 17 Feb 2022 04:25:18 -0500
X-MC-Unique: IV9PyEuhPsuuW_Ti6aoE2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E805801ADB;
        Thu, 17 Feb 2022 09:25:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E3597B6C7;
        Thu, 17 Feb 2022 09:25:16 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/3] resize2fs: remove unused variable 'c'
Date:   Thu, 17 Feb 2022 10:24:58 +0100
Message-Id: <20220217092500.40525-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 resize/resize2fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index b9783e8c..d69cb01e 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -2847,7 +2847,7 @@ static errcode_t resize2fs_calculate_summary_stats(ext2_filsys fs)
 	errcode_t	retval;
 	blk64_t		blk = fs->super->s_first_data_block;
 	ext2_ino_t	ino;
-	unsigned int	n, c, group, count;
+	unsigned int	n, group, count;
 	blk64_t		total_clusters_free = 0;
 	int		total_inodes_free = 0;
 	int		group_free = 0;
-- 
2.34.1


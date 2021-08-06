Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7822B3E27E7
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 11:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbhHFJ6q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 05:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhHFJ6p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Aug 2021 05:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628243910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pp4cUo6Urex2ncLw8sNzXK3pUupYQ+I60V4OTvLx3zQ=;
        b=Y5Ari0BeaQUIiiWMz3j7Lwjr+1kkLhtuzA/35r+NUBBUhtL2e2/cgMYoQSr4isX2ZoaRmN
        GDb1XOIcBdcoQ6cKCHXWRTAN84lMBmu89/ZKOhoteQliVSI8IKb9GwRQ/yxmWCvF0xH1qt
        opDjBcILkQdbClphkpSUOuvd41sbLb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-Ijmam_rxPWePDof00R-1rg-1; Fri, 06 Aug 2021 05:58:28 -0400
X-MC-Unique: Ijmam_rxPWePDof00R-1rg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4828801AE7;
        Fri,  6 Aug 2021 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB43D60938;
        Fri,  6 Aug 2021 09:58:26 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/7] ext2fs: initialize retval before using it
Date:   Fri,  6 Aug 2021 11:58:15 +0200
Message-Id: <20210806095820.83731-2-lczerner@redhat.com>
In-Reply-To: <20210806095820.83731-1-lczerner@redhat.com>
References: <20210806095820.83731-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 lib/ext2fs/gen_bitmap64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index a2b89898..d9809084 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -948,7 +948,7 @@ errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
 {
 	blk64_t		next;
 	blk64_t		tot_set = 0;
-	errcode_t	retval;
+	errcode_t	retval = 0;
 
 	while (start < end) {
 		retval = ext2fs_find_first_set_block_bitmap2(fs->block_map,
-- 
2.31.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520163E27E8
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 11:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbhHFJ6s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 05:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhHFJ6q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Aug 2021 05:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628243911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jWddt1ZdyVWL4U580tGfka04KjQdfIlMUDT0ifQ4TaM=;
        b=OZzTFi9/aYJSnDyIKSjmIkcISbyq8Xg8XOF8zCKlCS0y8+dUcAEBMBP/amDx+eRew+Mjao
        PKQ77U1PfLvD0WcckGg7fqM7hHKTv9dF9XQBTC9B6zcNCoClaCKSwtBI/pe6O7VDXM/BvC
        nVf6f3bVeNMHweaak3g7Hgif1UMT5pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-gLT3YJcONUyFKW7Im3E2kg-1; Fri, 06 Aug 2021 05:58:29 -0400
X-MC-Unique: gLT3YJcONUyFKW7Im3E2kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADC7287D541;
        Fri,  6 Aug 2021 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 016321B5C0;
        Fri,  6 Aug 2021 09:58:27 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 3/7] e2fsprogs: fix unexpected NULL variable
Date:   Fri,  6 Aug 2021 11:58:16 +0200
Message-Id: <20210806095820.83731-3-lczerner@redhat.com>
In-Reply-To: <20210806095820.83731-1-lczerner@redhat.com>
References: <20210806095820.83731-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The ext2fs_check_mount_point() function can be called with mtpt being
NULL as for example from ext2fs_check_if_mounted(). However in the
is_swap_device condition we use the mtpt in strncpy without checking
whether it is non-null first.

This should not be a problem on linux since the previous attempt to open
the device exclusively would have prevented us from ever reaching the
problematic strncpy. However it's still a bug and can cause problems on
other systems, fix it by conditioning strncpy on mtpt not being null.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 lib/ext2fs/ismounted.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
index c9e6a9d0..aee7d726 100644
--- a/lib/ext2fs/ismounted.c
+++ b/lib/ext2fs/ismounted.c
@@ -393,7 +393,8 @@ errcode_t ext2fs_check_mount_point(const char *device, int *mount_flags,
 
 	if (is_swap_device(device)) {
 		*mount_flags = EXT2_MF_MOUNTED | EXT2_MF_SWAP;
-		strncpy(mtpt, "<swap>", mtlen);
+		if (mtpt)
+			strncpy(mtpt, "<swap>", mtlen);
 	} else {
 #ifdef HAVE_SETMNTENT
 		retval = check_mntent(device, mount_flags, mtpt, mtlen);
-- 
2.31.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D192F1EF2E5
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 10:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgFEIOz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 04:14:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24149 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgFEIOz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 04:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591344894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVDhWb1r7rguUcuYJMaAA2ah74lsJ+LpFlzYZhEXRdA=;
        b=Wlt+LlFoa03Nbz9LBbrNxK8lrsfvoFDZ8O4/gFiYE/KxMUTiHlBdPcimJTpWG7zkyD52CZ
        f2IehllCFDvzYK7E3hLwkgn/yl8bF25QiVI4yX3FyX8B76hPmlnbrSBhIFRafRNO3LS9AA
        d7GdmaStvYtk5yBbxrh5Qk7xo+GjkBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-MhrP8fvGPEegi_BALlelKg-1; Fri, 05 Jun 2020 04:14:52 -0400
X-MC-Unique: MhrP8fvGPEegi_BALlelKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 179EA835B41
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85E0C6ACF6
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 08:14:51 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 3/4] e2fsck: use the right conversion specifier in e2fsck_allocate_memory()
Date:   Fri,  5 Jun 2020 10:14:41 +0200
Message-Id: <20200605081442.13428-3-lczerner@redhat.com>
In-Reply-To: <20200605081442.13428-1-lczerner@redhat.com>
References: <20200605081442.13428-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 e2fsck/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/e2fsck/util.c b/e2fsck/util.c
index 88e0ea8a..79916928 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -123,10 +123,10 @@ void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
 	char buf[256];
 
 #ifdef DEBUG_ALLOCATE_MEMORY
-	printf("Allocating %u bytes for %s...\n", size, description);
+	printf("Allocating %lu bytes for %s...\n", size, description);
 #endif
 	if (ext2fs_get_memzero(size, &ret)) {
-		sprintf(buf, "Can't allocate %u bytes for %s\n",
+		sprintf(buf, "Can't allocate %lu bytes for %s\n",
 			size, description);
 		fatal_error(ctx, buf);
 	}
-- 
2.21.3


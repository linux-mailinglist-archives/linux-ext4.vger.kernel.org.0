Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5401EF2E9
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFEIO6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 04:14:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27449 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726154AbgFEIO4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 04:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591344895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Pr/VVEJ7Lim1SaDde6feugBnnSZWMiiMNk5yB6GNSs=;
        b=JSCyPNhqZhROR9fJPSK6J1RC7wf21lEnhxboXEiY7OdkrbXm225j+KZIhRR/yEl1pY3MV5
        Tyg58m5mE8AWgDZq0aWlRAduK8Xxl5RM9tbNYmwrpau2SnaZFNxIZoCJ7iKR+QB69AZ9OH
        FcgPRup+MBL2NAb9hyvo2LDfmhBlL0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-_a3oDM12NnS-NhiJ1k9hBA-1; Fri, 05 Jun 2020 04:14:53 -0400
X-MC-Unique: _a3oDM12NnS-NhiJ1k9hBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2032100A614
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69DA778FC2
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 08:14:52 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 4/4] ext2fs: remove unused variable 'left'
Date:   Fri,  5 Jun 2020 10:14:42 +0200
Message-Id: <20200605081442.13428-4-lczerner@redhat.com>
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
 lib/ext2fs/swapfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/ext2fs/swapfs.c b/lib/ext2fs/swapfs.c
index 5b93b501..bc9f3230 100644
--- a/lib/ext2fs/swapfs.c
+++ b/lib/ext2fs/swapfs.c
@@ -456,12 +456,11 @@ errcode_t ext2fs_dirent_swab_out2(ext2_filsys fs, char *buf,
 {
 	errcode_t	retval;
 	char		*p, *end;
-	unsigned int	rec_len, left;
+	unsigned int	rec_len;
 	struct ext2_dir_entry *dirent;
 
 	p = buf;
 	end = buf + size;
-	left = size;
 	while (p < end) {
 		dirent = (struct ext2_dir_entry *) p;
 		retval = ext2fs_get_rec_len(fs, dirent, &rec_len);
-- 
2.21.3


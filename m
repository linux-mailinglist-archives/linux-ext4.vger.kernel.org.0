Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FED1EF2E6
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 10:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgFEIOz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 04:14:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35928 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726154AbgFEIOz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 04:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591344894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xoZiFBpOskZXw9DOIYk77ySxOoJI4ixsLClVfTYhpNI=;
        b=HP3axj5pWhHDn69tQsNIpGbkiAA7sdD1uxdfju18i1CBJEOksIwCaMHFCXbLjJ+nC6VqZi
        xR9PPJDjkA0m3pJ1gjBOpT5kMQR8kj6jUYEhHYdoOnRSFQxydrQNHNBzxppolDSI0zTBEf
        C002jA3EEqXApMmqn6/PZS7jsJstyvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-4XOrfE33MsyXcxZJAnfpWQ-1; Fri, 05 Jun 2020 04:14:52 -0400
X-MC-Unique: 4XOrfE33MsyXcxZJAnfpWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B48F18A8221
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 08:14:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8FE778FC2
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 08:14:49 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/4] e2fsck: remove unused variable 'new_array'
Date:   Fri,  5 Jun 2020 10:14:39 +0200
Message-Id: <20200605081442.13428-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 e2fsck/rehash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index 1616d07a..b356b92d 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -109,7 +109,7 @@ static int fill_dir_block(ext2_filsys fs,
 			  void *priv_data)
 {
 	struct fill_dir_struct	*fd = (struct fill_dir_struct *) priv_data;
-	struct hash_entry 	*new_array, *ent;
+	struct hash_entry 	*ent;
 	struct ext2_dir_entry 	*dirent;
 	char			*dir;
 	unsigned int		offset, dir_offset, rec_len, name_len;
-- 
2.21.3


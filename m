Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED0B3E27EC
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbhHFJ6y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 05:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244770AbhHFJ6u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Aug 2021 05:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628243915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BAuFF+ysMIhpafjymRqiwbGdHJ9222ktt2kf0Z31Fvs=;
        b=HQjLTxPK4ppj/++HAcoD3ZlvgYDyiAciwBU02y34GMCxbhWsqc5ZpMPpqueMbkBANOXBox
        pBMcnUY5q91Cyjnk09MzILvCEN314DgKqFS4mfKgoA1Vt6TEXq1X6ZHY3tdSH3TPKrKrHB
        3UABfweBkbqzThXEuFcQiOQzNfCtdsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-jevdoz8CMcatOQeFOlwhYg-1; Fri, 06 Aug 2021 05:58:31 -0400
X-MC-Unique: jevdoz8CMcatOQeFOlwhYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3B031008061;
        Fri,  6 Aug 2021 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15F667A8D7;
        Fri,  6 Aug 2021 09:58:29 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 5/7] libss: handle memory allcation failure in ss_help()
Date:   Fri,  6 Aug 2021 11:58:18 +0200
Message-Id: <20210806095820.83731-5-lczerner@redhat.com>
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
 lib/ss/help.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/ss/help.c b/lib/ss/help.c
index 96eb1092..a22b4017 100644
--- a/lib/ss/help.c
+++ b/lib/ss/help.c
@@ -96,7 +96,12 @@ void ss_help(int argc, char const * const *argv, int sci_idx, pointer info_ptr)
     }
     if (fd < 0) {
 #define MSG "No info found for "
-        char *buf = malloc(strlen (MSG) + strlen (argv[1]) + 1);
+	char *buf = malloc(strlen (MSG) + strlen (argv[1]) + 1);
+	if (!buf) {
+		ss_perror(sci_idx, 0,
+			  "couldn't allocate memory to print error message");
+		return;
+	}
 	strcpy(buf, MSG);
 	strcat(buf, argv[1]);
 	ss_perror(sci_idx, 0, buf);
-- 
2.31.1


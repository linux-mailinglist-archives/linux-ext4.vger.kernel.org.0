Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A14F2A8DDD
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgKFD7i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgKFD7i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:59:38 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2344DC0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:59:38 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id z24so2938358pgk.3
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4pHhz/vACRiu7SOP6so0FB0d0zwPKfuxvqxVl7ZmMc=;
        b=dvVL/mdKWjQ4ngHqTxXsCyC1CvJX91rO5m8gkdDmwXIAD8aUbpejQ2W48TPQWKwMu5
         zzE02ewxdnOKTbmQlqP5Yf2/OgBrnS+JLzaCGHljng5EYz5VMz0Ar8UnkO0NXwAuRYtG
         5YtAA1aFUYcJmbZNsc3caOMutK8qeg2eF3WDoXD8QN/4ErKxK/AGANcs5KyzJNrlJUUc
         dP0USgmszXfaV+8BGAUdqSovJu86lpxUf4fHGTyAn68Hzi3DOHQ9yFWRVjgREb8S/CjZ
         Y45Ck6OQbYEHOFgmx1smLCmeGvT1nu3nGfC2KdABNXtTcE1LgVNu9yOuWrF91HNIiAeE
         kYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4pHhz/vACRiu7SOP6so0FB0d0zwPKfuxvqxVl7ZmMc=;
        b=AkWONVpeCYJgJndNiWu+INXMrgNp/oGqZu8xVdacPLpXoRRFWURoS77RcxC/ZEiMHw
         lfX+yLTP/O4YbuObjUp7P+6+SOgoKR74L7JclU0xTZtOlzUaPHYxDRT0ITYn+JT6lMn3
         vtN+nw5k2ggWRAJdCxWxME8G5xp86Zl6fXN3nbdTtOPS6w0otFHuhaDF2ufV9M3xpOSn
         uNPS8BIpjtAVWxDt+hOyqvv3uJz1auWfTQj+Y8QmLUWBP6xAon510LtGgy2VFfMKtnBq
         hnjWUDFkP1iDK9e5kg3MECcYMwCfP1snAdfEvcZBycrHPTpoaHLA3THuECD25Hp4rFly
         CEEQ==
X-Gm-Message-State: AOAM531UngJ401O+jhAckVkzwyA8cBxDY96MqftYrk3mxx0+jWOo2+X+
        A0C9rH8KzyPC3wXjXM3tYKoIoAB3X88=
X-Google-Smtp-Source: ABdhPJxBbKQ5pbna5v5O6xavxMxtz/Qvd7TqDHByfArzaYGyTZ379Txqg7nnnbM8o6qfhuejlvB5Og==
X-Received: by 2002:a17:90a:7886:: with SMTP id x6mr260660pjk.21.1604635177308;
        Thu, 05 Nov 2020 19:59:37 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id z13sm3869429pgc.44.2020.11.05.19.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 19:59:36 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2 11/22] jbd2: don't touch buffer state until it is filled
Date:   Thu,  5 Nov 2020 19:59:00 -0800
Message-Id: <20201106035911.1942128-12-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
References: <20201106035911.1942128-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fast commit buffers should be filled in before toucing their
state. Remove code that sets buffer state as dirty before the buffer
is passed to the file system.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 59166e299cde..b5fbcd1b444c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -891,11 +891,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	if (!bh)
 		return -ENOMEM;
 
-	lock_buffer(bh);
 
-	clear_buffer_uptodate(bh);
-	set_buffer_dirty(bh);
-	unlock_buffer(bh);
 	journal->j_fc_wbuf[fc_off] = bh;
 
 	*bh_out = bh;
-- 
2.29.1.341.ge80a0c044ae-goog


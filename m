Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEA1B69FA
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgDWXhb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55834 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgDWXhb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:31 -0400
Received: from mail-qv1-f70.google.com ([209.85.219.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlPN-0003sp-Bu
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:29 +0000
Received: by mail-qv1-f70.google.com with SMTP id b4so7835549qvt.15
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7sK01bAHOMEeT6iR141dOPtYZnHNizmZjnaiXYItr0=;
        b=fbht92Zv6PQmZ9IIAWU921UVrSKhiNG6+zc4dtKpkZp1E7fvXwrJv53gVCv+KbO909
         1W8wNxUWE6C279xOoaxT9edz80hEv69cNB87MYbkRZS0/NRuK+NET9ymTFRySZNvCPA/
         /ehF9h5a4swP/iwtHTZNRoqZSSjEJ5SIuBeSq1NRqmI9Q+reB4Wp40umqYhnLt425xNL
         tJ6cPhlILBTDrsHFXsNFL1etaklmeQgHdTYpvNNJ2JGNC1zdr8i2MRcvA6OYvgU/zAo0
         GQ6kL+iN2l37WWteOH639W3xc9IAIyqPeM/WMO7UViejrVllavT17tTabZZgjjupOpLj
         IUrg==
X-Gm-Message-State: AGi0PuZSGCK7gVchwln0V2+NLizTGpa44xB390bcJgI6WQYce5mhvJe6
        bIIq/aKAHKM6fh0t0ADZkR0yutnr2HiyQaI+wBGyU/MNh6FP6OZmgSOxnAR30vq5I3yEvFIzDPj
        0J7pL3ESFKldX44u8hVICqdlaA1FQJtJFYfjgkVU=
X-Received: by 2002:a37:94c3:: with SMTP id w186mr4159808qkd.419.1587685048384;
        Thu, 23 Apr 2020 16:37:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJY37HVPwDDZr6n3pagKKjFMz/E5/jKy1JOzPJjOKf2AHir04NExpe2NWmQrqiAUTi/jLCVOw==
X-Received: by 2002:a37:94c3:: with SMTP id w186mr4159787qkd.419.1587685048162;
        Thu, 23 Apr 2020 16:37:28 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:27 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 08/11] ext4: data=journal: prevent journalled writeback deadlock in ext4_convert_inline_data_to_extent()
Date:   Thu, 23 Apr 2020 20:37:02 -0300
Message-Id: <20200423233705.5878-9-mfo@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423233705.5878-1-mfo@canonical.com>
References: <20200423233705.5878-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch checks for and prevents the deadlock with a page in
journalled writeback in ext4_convert_inline_data_to_extent().

Finally, add wait_on_page_writeback() if data=journal mode.

Note: similar changes are not needed in ext4_da_convert_inline_data_to_extent()
as delayed allocation is not applicable to data journalling
(different struct address_space_operations).

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ext4/inline.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 5fd275098d10..10665b066bb7 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -562,6 +562,8 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		handle = NULL;
 		goto out;
 	}
+	if (ext4_should_journal_data(inode))
+		wait_on_page_writeback(page);
 	unlock_page(page);
 
 retry_journal:
@@ -581,9 +583,19 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		put_page(page);
 		ext4_journal_stop(handle);
 		goto retry_grab;
+	} else if (ext4_should_journal_data(inode) &&
+		   ext4_check_journalled_writeback(handle, page)) {
+		/* Or transaction may block page writeback */
+		unlock_page(page);
+		put_page(page);
+		ext4_journal_stop(handle);
+		ext4_start_commit_datasync(inode);
+		goto retry_grab;
 	}
 	/* In case writeback began while the page was unlocked */
 	wait_for_stable_page(page);
+	if (ext4_should_journal_data(inode))
+		wait_on_page_writeback(page);
 
 	ext4_write_lock_xattr(inode, &no_expand);
 	sem_held = 1;
-- 
2.20.1


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04341B69FD
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgDWXhi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 19:37:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55853 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgDWXhi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Apr 2020 19:37:38 -0400
Received: from mail-qv1-f69.google.com ([209.85.219.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mfo@canonical.com>)
        id 1jRlPU-0003uC-5G
        for linux-ext4@vger.kernel.org; Thu, 23 Apr 2020 23:37:36 +0000
Received: by mail-qv1-f69.google.com with SMTP id m20so7854492qvy.13
        for <linux-ext4@vger.kernel.org>; Thu, 23 Apr 2020 16:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8AXqxfd/fjGsfc11JvhbwqPDle1t9NYcIAmYU/4G1eA=;
        b=FRhY3o8OAc6mG8+Ptd+Vgcza3Qge+AcCDCcsGDGcb4Uo+rHJUsSCFMolmxYaetJhxi
         aI/wI1ntDUuq6r0LaC+DnjL5iosyZ7y1c8rN7wOybjYOo3SNNH7QI5DonusjY0NHLpLw
         lNUpn8pCk31B4deb3A64zSURFgABW1jrzVIRypbAqwkapnR2mmSixmiM1Q7brxlyCWsk
         q5xIV4tEv6NnPByaFPM/SVMOtlgjPRjbGA0s/dBFATEF1lDypIVyk+UJ4iE++/cr3Ec5
         a35WOlxWbc+ffUBrCgvzVolr1TqC2EMelKGZjzYPiIQTD3I6YB/TpdWzZq7yy5N3S4Oc
         NZ2g==
X-Gm-Message-State: AGi0Pub+NV6FOyejVwl+rpj5Lwj5VLW4nwUquw4F35hAa+Bkd/DOdlqf
        nKxijMOEDio/Vj3nRB1UZC74zkddLYG+gAx/2/8Wdkqajh+G+eNjtMr1DejkD2SEElaL5xUSrPh
        dF4ydRdC09vJn+MvpvFnJYwOptFP6Uyf/4463R3Q=
X-Received: by 2002:a05:620a:15e8:: with SMTP id p8mr6250994qkm.331.1587685055171;
        Thu, 23 Apr 2020 16:37:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypJOZ8xMqJk9r/WiUyNd2B1OqHUqhV89X6O3xPfJKllU9W9OpD5DURM4UW7Rew2PdtS7fwGHFw==
X-Received: by 2002:a05:620a:15e8:: with SMTP id p8mr6250986qkm.331.1587685054975;
        Thu, 23 Apr 2020 16:37:34 -0700 (PDT)
Received: from localhost.localdomain ([201.82.49.101])
        by smtp.gmail.com with ESMTPSA id j14sm2529171qkk.92.2020.04.23.16.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:37:34 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     linux-ext4@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dann frazier <dann.frazier@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>
Subject: [RFC PATCH 11/11] ext4: data=journal: prevent journalled writeback deadlock in ext4_try_to_write_inline_data()
Date:   Thu, 23 Apr 2020 20:37:05 -0300
Message-Id: <20200423233705.5878-12-mfo@canonical.com>
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
journalled writeback in ext4_try_to_write_inline_data().

Finally, add wait_on_page_writeback() if data=journal mode.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 fs/ext4/inline.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3d370b04a740..c55a11f515d3 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -710,6 +710,8 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		handle = NULL;
 		goto out;
 	}
+	if (ext4_should_journal_data(inode))
+		wait_on_page_writeback(page);
 	unlock_page(page);
 
 	/*
@@ -732,9 +734,18 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		put_page(page);
 		ext4_journal_stop(handle);
 		goto retry_grab;
+	} else if (ext4_should_journal_data(inode) &&
+		   ext4_check_journalled_writeback(handle, page)) {
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
 
 	ret = ext4_prepare_inline_data(handle, inode, pos + len);
 	if (ret) {
-- 
2.20.1


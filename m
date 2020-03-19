Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F0618B9E5
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Mar 2020 16:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgCSPAl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 11:00:41 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40686 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgCSPAl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 11:00:41 -0400
Received: by mail-qt1-f194.google.com with SMTP id i9so1395519qtw.7
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q4/rbX35jArBajYr9qYa1uFpcN3cYffhkvjxUV9+Gy4=;
        b=LWldlKj9X8La9GnbT5yeDgin1GXFDfgC3WROsZ6JtznllNyeE50+LUiU+Hd2jf7zj0
         uvA6faSgGcHS41oyOXoq36YY7URRNs20pDQzZ4gnMd+919bfKGMAdzREfabLYamVDR5b
         OXjonMdxT3+bqlddpAdUN1brK8S+JWfJaEdiRrcOsmEv4F1+RYxtL2s36rpHZeN+q6mA
         s7ohsUeDl3Tob2UKQMYw4DxkqBT0uEEKTmgB9NXxd9H+iN52h8DBfR+1bspCy2Q1F8YU
         jtAab+F34+DbrYCCHCfLNwuwIcl+tUM1tWsIhtGgHAr5Jr5XBqQs5PEXQwW4LTSdxqgZ
         JnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q4/rbX35jArBajYr9qYa1uFpcN3cYffhkvjxUV9+Gy4=;
        b=iQliY8XEHV9zrhPtzF94p6J8ac8cdEl3wfHfLnxs2z2nkbqJBINyCiLV0D/6sDgEVc
         fTxwJW/KSQ+1FM5rDDPP22LM6TjKkPZw9Wfp8rvOmLaOxvBN2VQ1YRTNGOD4+Q6B3yBG
         7OH6SI3EwX9Wootzb1joIeJG2PqlK0QCbzLc/E4S7VktW3Qev9bUWJKcbXTAved+wWgK
         Gq9qMciIPx8n3qDZjhe7An9cw5AGex5O9OO8wCRfaqRh+vn/N/qBxZKSYoN/GSep9jTg
         2vupTaWOhEXf1fgBAaGAjwp1UNqHrHO/a8c0bt9ShjdE7+WvL6c/JhvpqNf+6lcyF9Lz
         4S1Q==
X-Gm-Message-State: ANhLgQ21eq6lfjrAWpcLkitJfN2lqB6aGEjlB7Pzh7CXy8k6wZr8YYr/
        7MQxqyvNEzhe8Fof6FvXOO7f9B4j
X-Google-Smtp-Source: ADFU+vvPoxaTjNwOoO7o9m0JJ2p+JI3pQEz/CHIaE5asD4BYQDeH1d9LOWAb4BMkcaRHPcmBRfBf3Q==
X-Received: by 2002:aed:3ecd:: with SMTP id o13mr3348147qtf.88.1584630039211;
        Thu, 19 Mar 2020 08:00:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id g10sm1728531qkb.9.2020.03.19.08.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:00:38 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: disable dioread_nolock whenever delayed allocation is disabled
Date:   Thu, 19 Mar 2020 11:00:28 -0400
Message-Id: <20200319150028.24592-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The patch "ext4: make dioread_nolock the default" (244adf6426ee) causes
generic/422 to fail when run in kvm-xfstests' ext3conv test case.  This
applies both the dioread_nolock and nodelalloc mount options, a
combination not previously tested by kvm-xfstests.  The failure occurs
because the dioread_nolock code path splits a previously fallocated
multiblock extent into a series of single block extents when overwriting
a portion of that extent.  That causes allocation of an extent tree leaf
node and a reshuffling of extents.  Once writeback is completed, the
individual extents are recombined into a single extent, the extent is
moved again, and the leaf node is deleted.  The difference in block
utilization before and after writeback due to the leaf node triggers the
failure.

The original reason for this behavior was to avoid ENOSPC when handling
I/O completions during writeback in the dioread_nolock code paths when
delayed allocation is disabled.  It may no longer be necessary, because
code was added in the past to reserve extra space to solve this problem
when delayed allocation is enabled, and this code may also apply when
delayed allocation is disabled.  Until this can be verified, don't use
the dioread_nolock code paths if delayed allocation is disabled.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/ext4_jbd2.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 7ea4f6fa173b..4b9002f0e84c 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -512,6 +512,9 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
 		return 0;
 	if (ext4_should_journal_data(inode))
 		return 0;
+	/* temporary fix to prevent generic/422 test failures */
+	if (!test_opt(inode->i_sb, DELALLOC))
+		return 0;
 	return 1;
 }
 
-- 
2.11.0


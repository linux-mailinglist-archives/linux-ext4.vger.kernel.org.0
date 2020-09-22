Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D73B274774
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Sep 2020 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIVR2A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Sep 2020 13:28:00 -0400
Received: from m12-14.163.com ([220.181.12.14]:53116 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVR2A (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 22 Sep 2020 13:28:00 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 13:27:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=L2/Uu
        dvyM2p1C8zBPshjVLH+yWc3nDVZtuzaWQJI5jA=; b=Drs9fP2+FfG3UV5hn7FFr
        5uHHZ2nUIeVFsHGu0k8U9whlHCLlW7voj3BeleoGqiegM7ycs9WGkMAsaREM8DtW
        DsxWF1a7LY4XRkUuw7Lzuwd5fNO7EDcYH2tNXQn99KI1lhRBho0nA5b3RyzYC3eg
        vRfvIWGeVyRLhcV9nVwILY=
Received: from localhost (unknown [101.86.214.224])
        by smtp10 (Coremail) with SMTP id DsCowACndbR_MGpfWQCsMQ--.9315S2;
        Wed, 23 Sep 2020 01:12:32 +0800 (CST)
Date:   Wed, 23 Sep 2020 01:12:31 +0800
From:   Hui Su <sh_def@163.com>
To:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] FIX the comment of struct jbd2_journal_handle
Message-ID: <20200922171231.GA53120@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DsCowACndbR_MGpfWQCsMQ--.9315S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw17Kr4kAr48KFWxKF43Awb_yoWfWFc_Zw
        s2qr43GF1fXFnxAr4fCrnrXFn3Cr1kJr1q9rn3twsFkF98Za9xW3WkJF9rGryUWan5Cr98
        ZF1kWryIqr1ktjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnaZX5UUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiMQCnX1UMVpNM+wAAsi
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

the struct name was modified long ago, but the comment still
use struct handle_s.

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/jbd2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 08f904943ab2..a1ef05412acf 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -452,8 +452,8 @@ struct jbd2_inode {
 struct jbd2_revoke_table_s;
 
 /**
- * struct handle_s - The handle_s type is the concrete type associated with
- *     handle_t.
+ * struct jbd2_journal_handle - The jbd2_journal_handle type is the concrete
+ *     type associated with handle_t.
  * @h_transaction: Which compound transaction is this update a part of?
  * @h_journal: Which journal handle belongs to - used iff h_reserved set.
  * @h_rsv_handle: Handle reserved for finishing the logical operation.
-- 
2.25.1



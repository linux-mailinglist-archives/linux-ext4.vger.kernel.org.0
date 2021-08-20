Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C416E3F34C7
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 21:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhHTTro (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 15:47:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55762 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhHTTrn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 15:47:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 58B022221E;
        Fri, 20 Aug 2021 19:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629488824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkC9oaxc3wQOA/lbNO7zLO/DmDdT+WdSVQAyCB8yKDM=;
        b=Ex/PXP3gNbtiFWTFNUsenK1oZ/lWy3fBhFF9qrG5Du0GB2+3wfP2Bh1tBYovdzX+KjTJbM
        LSZQADhN4TmcvqFwN7uLxAFwSLHPIn9d0fiArrUo5FLk+rCEASTCrDi1c4OUteUSA17L6L
        2QyMU07sEQUExx6Ybi5YBPVEqbeNODc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629488824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IkC9oaxc3wQOA/lbNO7zLO/DmDdT+WdSVQAyCB8yKDM=;
        b=z9ReJb50psjxdqkMEniWO/DjYaqtSCuvIgYFVnmiTXcuQDeMHtrL9hiwJIEhb3Dt7L8l4g
        5tWmlwgUebGHInCw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 4DBE9A3B87;
        Fri, 20 Aug 2021 19:47:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3510C1E12C5; Fri, 20 Aug 2021 21:47:01 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] tune2fs: Fix conversion of quota files
Date:   Fri, 20 Aug 2021 21:46:56 +0200
Message-Id: <20210820194656.27799-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210820194656.27799-1-jack@suse.cz>
References: <20210820194656.27799-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549; h=from:subject; bh=t/NziwFjzSaq1r4z23Jvqtk4y/dfAqGbvYRlw/rxWUA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhIAav2IRBMSM7POeDzEbMVid2AGNBWBxFpH6s6f2d 2lwnxnmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSAGrwAKCRCcnaoHP2RA2fTcCA DppVkCjp/9SV088OBJxLphfjfD6H6+ndpYR///VkQHcbnXMZEgqrlk8rwn2auElBjpj3ZniYveksEx Z05ZRY4xIMuFYedkFz6OoKw7bIJdKjorvo5cP73L3oSteVhHBBhz7o+UH01fR9z4ARY+VHdMhx4O2R lJ28+JY5Wijep+tYCHrA9Rieur+Tm/gm/RRQetyIvdXESNWfZiyuMW5Eq35Sx2j0nKW/oS8Fh5Rzzh F/E7+TTKeKpxEE3xZyIslMVMsOd7mxIc89wwIzN9/EVLRfmcAheMH0Dy0ajR0G/0jisX8A+ezUgB3i O6PoJOWPg0rmORQeI56o3AoFTl1Sdn
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When tune2fs is enabling quota feature, it looks for old-style quota
files and tries to transfer limits stored in these files into newly
created hidded quota files. However the code doing the transfer setups
the quota scan wrongly and instead of transferring limits we transfer
usage. So not only quota limits are lost (at least they can still be
recovered from the old quota files) but also usage information may be
wrong if the accounting in e2fsprogs does not exactly match the
accounting in quota-tools (which is actually the case). Fix the setup of
the quota scan.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/support/mkquota.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index fbc3833aee98..34ab632fb81c 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -569,14 +569,14 @@ static int scan_dquots_callback(struct dquot *dquot, void *cb_data)
  */
 static errcode_t quota_read_all_dquots(struct quota_handle *qh,
                                        quota_ctx_t qctx,
-				       int update_limits EXT2FS_ATTR((unused)))
+				       int update_limits)
 {
 	struct scan_dquots_data scan_data;
 
 	scan_data.quota_dict = qctx->quota_dict[qh->qh_type];
 	scan_data.check_consistency = 0;
-	scan_data.update_limits = 0;
-	scan_data.update_usage = 1;
+	scan_data.update_limits = update_limits;
+	scan_data.update_usage = 0;
 
 	return qh->qh_ops->scan_dquots(qh, scan_dquots_callback, &scan_data);
 }
-- 
2.26.2


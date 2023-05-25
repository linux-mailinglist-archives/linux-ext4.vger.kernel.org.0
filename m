Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FE710C3D
	for <lists+linux-ext4@lfdr.de>; Thu, 25 May 2023 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjEYMmO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 May 2023 08:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbjEYMmN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 May 2023 08:42:13 -0400
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 05:42:11 PDT
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BD0AA
        for <linux-ext4@vger.kernel.org>; Thu, 25 May 2023 05:42:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685018149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y/C2o+NUOjPmOevyE1wBh9bW5wgFZ/f5eKZm3vN/Gyo=;
        b=Pp/la4YQSBaft0UhPWDJ1MhIZS81UTPGa4eY2T+SMRxyNL4eKucsAi6PptBLFHulsz8Hlu
        teAcCyySOKsXZbm3ZvZdC/VU46z2STUSdayW3A8QCbSRGmlEC1CEPT4rHpSEqIE90qDjDI
        vTCJeYiweMdrr+hTgdKgy1dq95dec0Q=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 0/2] two clean up patches for mballoc
Date:   Thu, 25 May 2023 20:35:35 +0800
Message-Id: <20230525123537.22543-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Please review the two patches which clean up code a bit.

Thanks,
Guoqing

Guoqing Jiang (2):
  ext4: cleanup ext4_issue_discard
  ext4: make ext4_mb_release_group_pa returns void

 fs/ext4/mballoc.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

-- 
2.35.3


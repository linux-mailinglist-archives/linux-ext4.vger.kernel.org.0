Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3063EF5F2
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Aug 2021 00:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhHQW53 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Aug 2021 18:57:29 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:9687 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQW53 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Aug 2021 18:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1629241015; x=1660777015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nKUCIbr2RRCf5z1v0bU4pvCv+W2/znOARFn4m62bvl4=;
  b=F/EvHogVOOMsEAdZvZEIOecFsFRkCmnj6pHWtkjvhucL0T5iQ2SOSHMk
   HzjOEaOGMzWqXHKK8+0nF0MMqPqK7uXV+zr3EUcKQ+BTtug/62jSvZ54T
   J/Klmn4WlligEq1gFLTIHOtJp+qRe5kw7FZETMMjY4w61v8XMLorc07eL
   E=;
X-IronPort-AV: E=Sophos;i="5.84,330,1620691200"; 
   d="scan'208";a="951110899"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 17 Aug 2021 22:56:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-456ef9c9.us-west-2.amazon.com (Postfix) with ESMTPS id 54B17ADD30;
        Tue, 17 Aug 2021 22:56:55 +0000 (UTC)
Received: from EX13D46UWC004.ant.amazon.com (10.43.162.173) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Tue, 17 Aug 2021 22:56:54 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D46UWC004.ant.amazon.com (10.43.162.173) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Tue, 17 Aug 2021 22:56:54 +0000
Received: from dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (172.22.152.76)
 by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Tue, 17 Aug 2021 22:56:54 +0000
Received: by dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (Postfix, from userid 13116433)
        id A1492436B6; Tue, 17 Aug 2021 22:56:54 +0000 (UTC)
From:   Shaoying Xu <shaoyi@amazon.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <fllinden@amazon.com>, <benh@amazon.com>, <shaoyi@amazon.com>
Subject: [PATCH 0/1] ext4: fix lazy initialization next schedule time computation in more granular unit
Date:   Tue, 17 Aug 2021 22:56:53 +0000
Message-ID: <20210817225654.30487-1-shaoyi@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Description
===========
Ext4 FS has issue on the next schedule time calculation which is based on 
the time one request takes to zero out inode table. In the implementations of ext4 
lazy initialization, all time related unit is jiffy and also use the current 
value of jiffies to calculate time intervals. Around 11 years ago, data from 
Lukas that “zeroing one single group takes approx. 28ms without any load” 
however with hardware as well as software are getting much upgraded, this number 
becomes much smaller today that is even less than 1 jiffy, which makes the calculation 
of the next schedule time not accurate and it is reflected on Amazon Linux 2 in 
x86_64 and arm64 these two architectures with various HZ values (x86_64: 250, arm64: 100) 
that the sleeping time is the same in both arches which is 10 jiffies given the 
default multiplier 10, while 10 jiffies are different in these 2 arches in real time 
which leads to obvious performance degradation of this ext4lazyinit thread.

Test
====
Tested the patch in stable kernel 5.10 with FS volume 2T and 3T on EC2
x86_64 and arm64 instances. Before the fix, x86_64 instances with HZ value 
250 finished the lazy initialization in around 2.4x time less than arm64
instances with HZ value 100. After the fix, both of them finished within
approximately same time. Then changed HZ value in arm64 to 250, no obvious
difference in terms of time was observed. 

Patch
=====
Shaoying Xu (1):
  ext4: fix lazy initialization next schedule time computation in more
    granular unit

 fs/ext4/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.16.6


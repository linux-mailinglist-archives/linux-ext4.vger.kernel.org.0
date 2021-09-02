Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49823FF1BD
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Sep 2021 18:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346409AbhIBQpT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 12:45:19 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:6916 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242304AbhIBQpO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Sep 2021 12:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1630601057; x=1662137057;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=B9I29+nLfN1HhtPMBvajbM4PPB+iF05uDdsVf19ddmU=;
  b=UoIsUvP5na6QGpD2gvF6LwBa7r+66F8+BKLYLvkEWKL0zVVlbusf61+N
   IYXgN9rtGdZZwW5WdlQFe9c8xX74HjI9c4nyp4gBddT+ptKh3Vk9VJ4iQ
   MYG5ksJ6+vhIuadKeo65gHfQvunGZGcK5q2Kz9xm+PPOuX29RB/v5XVHL
   o=;
X-IronPort-AV: E=Sophos;i="5.85,262,1624320000"; 
   d="scan'208";a="157198972"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 02 Sep 2021 16:44:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 77001A1DFD;
        Thu,  2 Sep 2021 16:44:14 +0000 (UTC)
Received: from EX13D46UWB002.ant.amazon.com (10.43.161.70) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 2 Sep 2021 16:44:13 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D46UWB002.ant.amazon.com (10.43.161.70) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 2 Sep 2021 16:44:13 +0000
Received: from dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (172.22.152.76)
 by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Thu, 2 Sep 2021 16:44:12 +0000
Received: by dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (Postfix, from userid 13116433)
        id 8B6A741AC5; Thu,  2 Sep 2021 16:44:12 +0000 (UTC)
From:   Shaoying Xu <shaoyi@amazon.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benh@amazon.com>, <shaoyi@amazon.com>
Subject: [PATCH 0/1] [RESEND] ext4: fix lazy initialization next schedule time computation in more granular unit
Date:   Thu, 2 Sep 2021 16:44:11 +0000
Message-ID: <20210902164412.9994-1-shaoyi@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Description
===========
Ext4 FS has inappropriate implementations on the next schedule time calculation
that use jiffies to measure the time for one request to zero out inode table. This
actually makes the wait time effectively dependent on CONFIG_HZ, which is
undesirable. We have observed on server systems with 100HZ some fairly long delays
in initialization as a result. Therefore, we propose to use more granular unit to
calculate the next schedule time.

Test
====
Tested the patch in stable kernel 5.10 with FS volume 2T and 3T on EC2
instances. Before the fix, instances with 250HZ finished the lazy initialization 
in around 2.4x time less than instances with 100HZ. 
After the fix, both of them finished within approximately same time. 

Patch
=====
Shaoying Xu (1):
  ext4: fix lazy initialization next schedule time computation in more
    granular unit

 fs/ext4/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.16.6


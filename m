Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53534412710
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Sep 2021 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhITT7q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Sep 2021 15:59:46 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:54823 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346968AbhITT5p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Sep 2021 15:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1632167778; x=1663703778;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=VGCAh2/X9B7s47ZlI2jWLZuZmG6ax30G1VRtR1CiL/w=;
  b=SRbGw1P+W+Iw6VxwJ9cjFlJtnHBT+MbpgM4tzBpAOtK+F4FM5P6DT8Xl
   9CtiUKxWQr6tOK85rpJNGi+6v4PHcGvD0Rw+MxbRbXDCxfur68G3FOhXW
   BgWvG/GVjGXxBKITyb1d7ftUsb9QU+gLWEcLGrdmGBp8L+GF0NUCjke7P
   Q=;
X-IronPort-AV: E=Sophos;i="5.85,309,1624320000"; 
   d="scan'208";a="959003975"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 20 Sep 2021 19:56:17 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com (Postfix) with ESMTPS id 9780086D24;
        Mon, 20 Sep 2021 19:56:16 +0000 (UTC)
Received: from EX13D46UWC004.ant.amazon.com (10.43.162.173) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 20 Sep 2021 19:56:15 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D46UWC004.ant.amazon.com (10.43.162.173) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 20 Sep 2021 19:56:15 +0000
Received: from dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (172.22.152.76)
 by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Mon, 20 Sep 2021 19:56:15 +0000
Received: by dev-dsk-shaoyi-2b-c0ca772a.us-west-2.amazon.com (Postfix, from userid 13116433)
        id 694FD42867; Mon, 20 Sep 2021 19:56:15 +0000 (UTC)
Date:   Mon, 20 Sep 2021 19:56:15 +0000
From:   Shaoying Xu <shaoyi@amazon.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benh@amazon.com>, <shaoyi@amazon.com>
Subject: Re: [PATCH 0/1] [RESEND] ext4: fix lazy initialization next schedule
 time computation in more granular unit
Message-ID: <20210920195615.GB27753@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210902164412.9994-1-shaoyi@amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Here are more context and testing details:

This issue was originally identified in Amazon Linux 2 with kernel 5.10 and
CONFIG_HZ is 250 in x86_64 while 100 in arm64. It can be reproduced by launching
EC2 instances c5.2xlarge (x86_64) and c6g.2xlarge (arm64) then measuring time to
finish ext4lazyinit thread after mounting the ext4 FS.

w/o fix in kernel 5.10
|----------------+-------------+------------|
| ext4 FS volume | c6g.2xlarge | c5.2xlarge |
|----------------+-------------+------------|
| 2T             | 1842 secs   | 743 secs   |
|----------------+-------------+------------|
| 3T             | 2690 secs   | 1110 secs  |
|----------------+-------------+------------|

w/ fix in kernel 5.10
|----------------+-------------+------------|
| ext4 FS volume | c6g.2xlarge | c5.2xlarge |
|----------------+-------------+------------|
| 2T             | 660 secs    | 544 secs   |
|----------------+-------------+------------|
| 3T             | 1053 secs   | 932 secs   |
|----------------+-------------+------------|

On Thu, Sep 02, 2021 at 04:44:11PM +0000, Shaoying Xu wrote:
> Description
> ===========
> Ext4 FS has inappropriate implementations on the next schedule time calculation
> that use jiffies to measure the time for one request to zero out inode table. This
> actually makes the wait time effectively dependent on CONFIG_HZ, which is
> undesirable. We have observed on server systems with 100HZ some fairly long delays
> in initialization as a result. Therefore, we propose to use more granular unit to
> calculate the next schedule time.
> 
> Test
> ====
> Tested the patch in stable kernel 5.10 with FS volume 2T and 3T on EC2
> instances. Before the fix, instances with 250HZ finished the lazy initialization 
> in around 2.4x time less than instances with 100HZ. 
> After the fix, both of them finished within approximately same time. 
> 
> Patch
> =====
> Shaoying Xu (1):
>   ext4: fix lazy initialization next schedule time computation in more
>     granular unit
> 
>  fs/ext4/super.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> -- 
> 2.16.6
> 

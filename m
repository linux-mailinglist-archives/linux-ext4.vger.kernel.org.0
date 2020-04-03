Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC14C19CE33
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Apr 2020 03:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390195AbgDCBhj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Apr 2020 21:37:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53688 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbgDCBhj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Apr 2020 21:37:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0331YuCL122558;
        Fri, 3 Apr 2020 01:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=AAWhAAAFdiQeUES/NY2jJoUKaK90NYOzyu6H/DiDukQ=;
 b=T5Cu4uWGW+UhaYi6M2/hpGIYriHpKQhzMlVN0eS4JkiPqGvP5RlXR4So4qb5pQorx1sx
 MbQMC7eH+lSJ7O50z3V+it9mHreEIkesTzbWOGOetbZRCqqRkL1ugmKYeSEpvLhwTxtb
 Y0xTmJ1UeNss8LbWJc/XWy6YnsLjtHBgacqUkjTnMJhpKpa+ota/hMovOiwmdSkkBZnJ
 vc5+h7ZI0W+rmB/3Q/WzXD0xQswndPrgLX/onyqpbOJ4M1WEd4aUpck78V+bbirdlxKx
 jb2B2HTEYkOeagKSMOXtxHFRiIeXdU6bs/3a41T5YO58uQTsaGwOEsuvPRI2hNkEv9du eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 303cevejyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 01:37:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0331X0IE101807;
        Fri, 3 Apr 2020 01:35:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 302g2kqeh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 01:35:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0331YmkI009701;
        Fri, 3 Apr 2020 01:34:48 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 18:34:47 -0700
To:     Dave Chinner <david@fromorbit.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
        martin.petersen@oracle.com, darrick.wong@oracle.com,
        axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        ming.lei@redhat.com, jthumshirn@suse.de, minwoo.im.dev@gmail.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
        <20200402224124.GK10737@dread.disaster.area>
Date:   Thu, 02 Apr 2020 21:34:43 -0400
In-Reply-To: <20200402224124.GK10737@dread.disaster.area> (Dave Chinner's
        message of "Fri, 3 Apr 2020 09:41:24 +1100")
Message-ID: <yq1imih4aj0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030009
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hi Dave!

> Ok, so ext4 has a very limited max allocation size for an extent, so
> I expect this won't cause huge latency problems. However, what
> happens when we use XFS, have a 64kB block size, and fallocate() is
> allocating disk space in continguous 100GB extents and passing those
> down to the block device?

Depends on the device.

> How does this get split by dm devices? Are raid stripes going to dice
> this into separate stripe unit sized bios, so instead of single large
> requests we end up with hundreds or thousands or tiny allocation
> requests being issued?

There is nothing special about this operation. It needs to be handled
the same way as all other splits. I.e. ideally coalesced at the bottom
of the stack so we can issue larger, contiguous commands to the
hardware.

> How are we expecting hardware to behave here? Is this a queued
> command in the scsi/nvme/sata protocols? Or is this, for the moment,
> just a special snowflake that we can't actually use in production
> because the hardware just can't handle what we throw at it?

For now it's SCSI and queued. Only found in high-end thinly provisioned
storage arrays and not in your average SSD.

The performance expectation for REQ_OP_ALLOCATE is that it is faster
than a write to the same block range since the device potentially needs
to do less work. I.e. the device simply needs to decrement the free
space and mark the LBAs reserved in a map. It doesn't need to write all
the blocks to zero them. If you want zeroed blocks, use
REQ_OP_WRITE_ZEROES.

> IOWs, what sort of latency issues is this operation going to cause
> on real hardware? Is this going to be like discard? i.e. where we
> end up not using it at all because so few devices actually handle
> the massive stream of operations the filesystem will end up sending
> the device(s) in the course of normal operations?

The intended use case, from a SCSI perspective, is that on a thinly
provisioned device you can use this operation to preallocate blocks so
that future writes to the LBAs in question will not fail due to the
device being out of space. I.e. you would use this to pin down block
ranges where you can not tolerate write failures. The advantage over
writing the blocks individually is that dedup won't apply and that the
device doesn't actually have to go write all the individual blocks.

-- 
Martin K. Petersen	Oracle Linux Engineering

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776E91A1AC1
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 06:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDHELI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 00:11:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34400 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgDHELI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 00:11:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0384932Y108909;
        Wed, 8 Apr 2020 04:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=D1Vpn8Y4RU/HeZhVhrJTGT9xkAMeVhXHc/+Q5lb+pTw=;
 b=X6VqYBewwvUPKFl/JNWIByiaODrH759sM1S2Uo7c0xm71cUR+dcGxMMctC6Hyo9SIJUD
 KAnxfl3ehcut01FComRTuFPHSwsqWlgjK+miKjLtU7e73jRthmhDaRPinPb0umIWYxhC
 CLIIJl6cZzCM81VxKMQHiOcEET43LG5xq6fEVa/hKm7JruLTYDkSXnLfS9M6epP8+nmt
 KEXVGJrbZcnoFGFAoSwPQmsg/0V8XllEcFLP+UaBlIepiA1rRK0NWpSzDH78pBw2+cgK
 pegoDC193E2XgZiFDScml1t46Ts0zBVlIuHQ9oXn1KZuNZ4zE/j++U9VNx+KhhglIkFg gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3091mngw2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 04:10:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03846lE6014068;
        Wed, 8 Apr 2020 04:10:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3091kgfuww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 04:10:36 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0384AG4L025138;
        Wed, 8 Apr 2020 04:10:17 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 21:10:16 -0700
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
        darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        hannes@cmpxchg.org, khlebnikov@yandex-team.ru, ajay.joshi@wdc.com,
        bvanassche@acm.org, arnd@arndb.de, houtao1@huawei.com,
        asml.silence@gmail.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
        <20200402224124.GK10737@dread.disaster.area>
        <yq1imih4aj0.fsf@oracle.com>
        <20200403025757.GL10737@dread.disaster.area>
        <yq1a73t44h1.fsf@oracle.com>
        <20200407022705.GA24067@dread.disaster.area>
Date:   Wed, 08 Apr 2020 00:10:12 -0400
In-Reply-To: <20200407022705.GA24067@dread.disaster.area> (Dave Chinner's
        message of "Tue, 7 Apr 2020 12:27:05 +1000")
Message-ID: <yq1sghe1uu3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=962
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004080028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004080028
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hi Dave!

>> In the standards space, the allocation concept was mainly aimed at
>> protecting filesystem internals against out-of-space conditions on
>> devices that dedup identical blocks and where simply zeroing the blocks
>> therefore is ineffective.

> Um, so we're supposed to use space allocation before overwriting
> existing metadata in the filesystem?

Not before overwriting, no. Once you have allocated an LBA it remains
allocated until you discard it.

> So that the underlying storage can reserve space for it before we
> write it? Which would mean we have to issue a space allocation before
> we dirty the metadata, which means before we dirty any metadata in a
> transaction. Which means we'll basically have to redesign the
> filesystems from the ground up, yes?

My understanding is that this facility was aimed at filesystems that do
not dynamically allocate metadata. The intent was that mkfs would
preallocate the metadata LBA ranges, not the filesystem. For filesystems
that allocate metadata dynamically, then yes, an additional step is
required if you want to pin the LBAs.

> You might be talking about filesystem metadata and block devices,
> but this patchset ends up connecting ext4's user data fallocate() to
> the block device, thereby allowing users to reserve space directly
> in the underlying block device and directly exposing this issue to
> userspace.

I missed that Chaitanya's repost of this series included the ext4 patch.
Sorry!

>> How XFS decides to enforce space allocation policy and potentially
>> leverage this plumbing is entirely up to you.
>
> Do I understand this correctly? i.e. that it is the filesystem's
> responsibility to prevent users from preallocating more space than
> exists in an underlying storage pool that has been intentionally
> hidden from the filesystem so it can be underprovisioned?

No. But as an administrative policy it is useful to prevent runaway
applications from writing a petabyte of random garbage to media. My
point was that it is up to you and the other filesystem developers to
decide how you want to leverage the low-level allocation capability and
how you want to provide it to processes. And whether CAP_SYS_ADMIN,
ulimit, or something else is the appropriate policy interface for this.

In terms of thin provisioning and space management there are various
thresholds that may be reported by the device. In past discussions there
haven't been much interest in getting these exposed. It is also unclear
to me whether it is actually beneficial to send low space warnings to
hundreds or thousands of hosts attached to an array. In many cases the
individual server admins are not even the right audience. The most
common notification mechanism is a message to the storage array admin
saying "click here to buy more disk".

If you feel there is merit in having the kernel emit the threshold
warnings you could use as a feedback mechanism, I can absolutely look
into that.

-- 
Martin K. Petersen	Oracle Linux Engineering

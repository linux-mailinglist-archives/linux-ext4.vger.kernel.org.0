Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644D61B5174
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Apr 2020 02:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDWAkw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 20:40:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43620 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDWAkw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Apr 2020 20:40:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N0eHah139827;
        Thu, 23 Apr 2020 00:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=oOmHJafDHAiLr+hO/wYNXIjjzE6yoBtPTz0X9wOHrhM=;
 b=Jfxj0m+0g/BDEijGZkMF/w4raZLYKt2CEePPz2s+LXdGZnZ1iOvlgBWsKsdh4vAaadiY
 0SAk/4/G5e4mqtVllIPJ9RcTklVPtjgNPAp6hgilpdx9vKV2GAMfHTdF4gUU44es1QgO
 dFIDpVqjN8j+bjN6Baal9ZARWU5gK627WeEHD4ILA7ghtXPO21As3aZiBpyrpsP3rIE0
 bCzkyRZA0unLVnAY/SHkCS9GHlKBFeYOeVfax9ohvzRvO4pSzVrUUAUvo6r+UM+4p0Zf
 NZXJ+B+QNpf0KVypkTMf6iwIai7I0fyIHWii/YHxbzdhrTP72nnIZsUKATEuFyjzLEIU Pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30jhyc4nt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 00:40:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N0ckul015871;
        Thu, 23 Apr 2020 00:40:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30gbbjcaa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 00:40:16 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03N0e62P005519;
        Thu, 23 Apr 2020 00:40:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Apr 2020 17:40:06 -0700
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
        <yq1sghe1uu3.fsf@oracle.com>
        <20200419223646.GB9765@dread.disaster.area>
Date:   Wed, 22 Apr 2020 20:40:01 -0400
In-Reply-To: <20200419223646.GB9765@dread.disaster.area> (Dave Chinner's
        message of "Mon, 20 Apr 2020 08:36:46 +1000")
Message-ID: <yq11rofghlq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230001
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Dave,

>> Not before overwriting, no. Once you have allocated an LBA it remains
>> allocated until you discard it.

> Ok, so you are confirming what I thought: it's almost completely
> useless to us.
>
> i.e. this requires issuing IO to "reserve" space whilst preserving
> data before every metadata object goes from clean to dirty in memory.

You can only reserve the space prior to writing a block for the first
time. Once an LBA has been written ("Mapped" in the SCSI state machine),
it remains allocated until it is explicitly deallocated (via a
discard/Unmap operation).

This part of the SCSI spec was written eons ago under the assumption
that when a physical resource backing a given LBA had been established,
you could write the block over and over without having to allocate new
space.

This used to be true, but obviously the introduction of de-duplication
blew a major hole in that. I have been perusing the spec over and over
trying to understand how block provisioning state transitions are
defined when dedup is in the picture. However, much is left unexplained.

As a result, I reached out to various folks. Including the people who
worked on this feature in the standards way back. And the response that
I get from them is that allocation operation got irreparably broken when
support for de-duplication was added to the spec. Nobody attempted to
fix the state transitions since most vendors only cared about
deallocation. Consequently specifying the exact behavior of the
allocation operation in the context of dedup fell by the wayside.

The recommendation I got was that we should not rely on this feature
despite it being advertised as supported by the storage. I looked at
whether it was feasible to support it on non-dedup devices only, but it
does not look like it's worthwhile to pursue. And as a result there is
no need for block layer allocation operation to have parity with
SCSI. Although we may want to keep NVMe in mind when defining the
semantics.

-- 
Martin K. Petersen	Oracle Linux Engineering

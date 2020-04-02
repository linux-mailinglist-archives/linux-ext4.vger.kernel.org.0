Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A4C19BA52
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Apr 2020 04:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbgDBCcf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 22:32:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49856 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgDBCcf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Apr 2020 22:32:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0322Sk1B106362;
        Thu, 2 Apr 2020 02:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=C1sTv2mfdV+vS0lPpUAa1c5xsmzknrneWhl3ZOZXPZc=;
 b=qvibkPg0lqK/4Wblb53/3Nf4F5BPZl1OPZt56Qcw74Xd2QeSEZWCHBP1KTAxX8meRDtq
 1vLjNTHdTdYORG69ou7m+izgGSK8yOmFsuQPmUrGBh6I9qZReSGVk7LMoVQeLG4hSkw/
 /7gYvaCL1aSfARnob4BgySy11mvBPfNa0x5h4X+vLtd6kjge03+w1VyoTpNH2bDGDXXl
 lHHAGq/v7stHC/C1PCASocPmkdfLyCOM/KhE49K2+cq8kcZ/025xZ8zaV6HHFH3gU0Zh
 oFopk5+VtwC1SPzm6xzJI5vuBotK8604l4Us5W9GnDHgHdCqCcnB8F7DLBV3JkNfyP77 xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 303aqhs7fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 02:32:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0322S7Ix010425;
        Thu, 2 Apr 2020 02:30:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 302ga1j3ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 02:30:01 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0322TheE011819;
        Thu, 2 Apr 2020 02:29:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 19:29:42 -0700
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
        martin.petersen@oracle.com, darrick.wong@oracle.com,
        axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        ming.lei@redhat.com, jthumshirn@suse.de, minwoo.im.dev@gmail.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        ajay.joshi@wdc.com, bvanassche@acm.org, arnd@arndb.de,
        houtao1@huawei.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
        <bb7d7604-8ee5-97d8-1563-9140cd499f15@yandex-team.ru>
Date:   Wed, 01 Apr 2020 22:29:38 -0400
In-Reply-To: <bb7d7604-8ee5-97d8-1563-9140cd499f15@yandex-team.ru> (Konstantin
        Khlebnikov's message of "Wed, 1 Apr 2020 09:22:26 +0300")
Message-ID: <yq1v9mi4o31.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004020020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=18
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020020
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Konstantin,

>> The corresponding exported primitive is called
>> blkdev_issue_assign_range().
>
> What exact semantics of that?

REQ_OP_ALLOCATE will be used to compel a device to allocate a block
range. What a given block contains after successful allocation is
undefined (depends on the device implementation).

For block allocation with deterministic zeroing, one must keep using
REQ_OP_WRITE_ZEROES with the NOUNMAP flag set.

-- 
Martin K. Petersen	Oracle Linux Engineering

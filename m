Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD2131DEF
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 04:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgAGDYy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jan 2020 22:24:54 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47188 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgAGDYy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Jan 2020 22:24:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0073EXIE025855;
        Tue, 7 Jan 2020 03:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=eEDEB5cRiaDaMI401AFI3YVYzUZ8UFoQLMybywdErVQ=;
 b=QDSlbGupGflTHfqrIDNN0pRGV03FnSpuCfigptfoFqoaA1spKKkx9D4dFkT4G4dyADdK
 KTO58n7GOAw3kOHJ5OmGz/YSqQg9fDfUNSklRPcfXSCAqcfdiNi9SqY6ibt54v1OEe8o
 9PP/h4km77fvB47MLrijeXfen1XxOvm/ZX15n+BOWpB/H+l1LbMKKx86T6uoq04LxhhH
 +rbvtc5p71h5DvFiZfvaDTlRYtzajq18gFUJdRJa1d47RvZshe2sbcrWXL8ZETcIHDyY
 Q3PgPRP0rHuCR0C+zmXK685klXj7A+DIwARvEDZYW2EhGqLzHOLmRyOBpZWxc9UyXaoV ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xajnpts86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 03:24:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0073EOoh192221;
        Tue, 7 Jan 2020 03:24:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xb4uq6njs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 03:24:22 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0073ODw1027853;
        Tue, 7 Jan 2020 03:24:14 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 19:24:13 -0800
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE operation
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
        <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
        <yq1woatc8zd.fsf@oracle.com>
        <3f2e341b-dea4-c5d0-8eb0-568b6ad2f17b@virtuozzo.com>
        <yq1a77oc56s.fsf@oracle.com>
        <625c9ee4-bedb-ff60-845e-2d440c4f58aa@virtuozzo.com>
        <yq1pngh7blx.fsf@oracle.com>
        <405b9106-0a97-0821-c41d-58ab8d0e2d09@virtuozzo.com>
Date:   Mon, 06 Jan 2020 22:24:09 -0500
In-Reply-To: <405b9106-0a97-0821-c41d-58ab8d0e2d09@virtuozzo.com> (Kirill
        Tkhai's message of "Mon, 23 Dec 2019 11:51:34 +0300")
Message-ID: <yq1o8vg2bl2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070025
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Kirill,

Sorry, the holiday break got in the way.

> But I also worry about NOFALLBACK case. There are possible block
> devices, which support write zeroes, but they can't allocate blocks
> (block allocation are just not appliable for them, say, these are all
> ordinary hdd).

Correct. We shouldn't go down this path unless a device is thinly
provisioned (i.e. max_discard_sectors > 0).

> But won't it be a good thing to return EOPNOTSUPP right from
> __blkdev_issue_write_zeroes() in case of block device can't allocate
> blocks (q->limits.write_zeroes_can_allocate in the patch below)? Here
> is just a way to underline block devices, which support write zeroes,
> but allocation of blocks is meant nothing for them (wasting of time).

I don't like "write_zeroes_can_allocate" because that makes assumptions
about WRITE ZEROES being the command of choice. I suggest we call it
"max_allocate_sectors" to mirror "max_discard_sectors". I.e. put
emphasis on the semantic operation and not the plumbing.

-- 
Martin K. Petersen	Oracle Linux Engineering

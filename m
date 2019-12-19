Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2751D1259CC
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2019 04:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLSDEU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Dec 2019 22:04:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40492 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSDET (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Dec 2019 22:04:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ2xiPR058087;
        Thu, 19 Dec 2019 03:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=cdxYY44jNJqlprPyo2O9QUPx1Qi/xcVZ/t3x9qspneU=;
 b=aCIK+kSNQFpBbsOLnWXLh+CBVkP6h9MgQAB4U6wa3KL1k3WS9MFm3hUT4nnE7+AJA06j
 9kLEVwIKMSm5JZB7JELCW7S7t0qrTatOWDRxv7sBSbVFjIDjpDO0svO7K29fXA9x+kN4
 MchVN3Pww0WSWtbp8syVu2OZX3/N5wAQiOhi1Dmw1UmGk3QyfDTEjyS56O9MHYoJRGEC
 vKWnJrmDo2GNMMQH9z3eGACrvo95Xqni2SHWyrw0iLFPpgjyHFQm//ESA5S+vnS/ZfJ8
 I2kMFZaWp5X6eDTKHnYiHGXQv61yhj1WPuiqcSl9vpRcjWpte9uLO/kiHjrK9piMTwO9 Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wvrcrhb9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 03:03:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ2xj2Z075954;
        Thu, 19 Dec 2019 03:03:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wyxqgwtq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 03:03:45 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJ33dg7026575;
        Thu, 19 Dec 2019 03:03:39 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Dec 2019 19:03:38 -0800
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, axboe@kernel.dk, tytso@mit.edu,
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
Date:   Wed, 18 Dec 2019 22:03:34 -0500
In-Reply-To: <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
        (Kirill Tkhai's message of "Tue, 10 Dec 2019 19:56:08 +0300")
Message-ID: <yq1woatc8zd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190023
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hi Kirill!

> The patch adds a new blkdev_issue_assign_range() primitive, which is
> rather similar to existing blkdev_issue_{*} api.  Also, a new queue
> limit.max_assign_range_sectors is added.

I am not so keen on the assign_range name. What's wrong with "allocate"?

But why introduce a completely new operation? Isn't this essentially a
write zeroes with BLKDEV_ZERO_NOUNMAP flag set?

If the zeroing aspect is perceived to be a problem we could add a
BLKDEV_ZERO_ALLOCATE flag (or BLKDEV_ZERO_ANCHOR since that's the
terminology used in SCSI).

-- 
Martin K. Petersen	Oracle Linux Engineering

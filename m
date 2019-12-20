Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37176127312
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2019 02:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLTBzW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Dec 2019 20:55:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34658 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLTBzW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Dec 2019 20:55:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK1YQvW178885;
        Fri, 20 Dec 2019 01:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=yvWe495ldICiygqOjZaczcPhEGKNXC0rTc5IDLPnmg0=;
 b=TQC1fmettNcpPG+K0+r5uCWd4QbxtaXxHbLeXWr6uYZR0w8qvXec9nz2V3nqd/rsA7G0
 +840JBvsu6VKJK0saZjQckAjjnp3kM4dblPfYXGbEs6kOTqCsU7OW8wjY5CnXpL2LVer
 Lmz0GdGblAcbt2Tlx9FAhFLBvNgeNw/RSenBOGDSPlfRZLnmki+NxIsW8YFZwIy6GZZK
 hlPDQBNnE4+QSs86PfkG+PE3xqR9RW6pxgXerp5yENFxo/3DxiR0GA3F0q17n3+WbNMY
 pqBf0lTcc0y/yuvaL051enyPxjy0h7i1rmPaa5WviRThLmxMKt2VRj5MnaWWhMKGJBst 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2x01jae617-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 01:54:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK1sfDV073498;
        Fri, 20 Dec 2019 01:54:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2x04mst1n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 01:54:47 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBK1rgwj030477;
        Fri, 20 Dec 2019 01:53:44 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 17:53:41 -0800
Date:   Thu, 19 Dec 2019 17:53:39 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE
 operation
Message-ID: <20191220015338.GB7473@magnolia>
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
 <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
 <yq1woatc8zd.fsf@oracle.com>
 <3f2e341b-dea4-c5d0-8eb0-568b6ad2f17b@virtuozzo.com>
 <yq1a77oc56s.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1a77oc56s.fsf@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200010
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 19, 2019 at 05:37:47PM -0500, Martin K. Petersen wrote:
> 
> Kirill,
> 
> > Hm. BLKDEV_ZERO_NOUNMAP is used in __blkdev_issue_write_zeroes() only.
> > So, do I understand right that we should the below two?:
> >
> > 1) Introduce a new flag BLKDEV_ZERO_ALLOCATE for
> > blkdev_issue_write_zeroes().
> 
> > 2) Introduce a new flag REQ_NOZERO in enum req_opf.
> 
> Something like that. If zeroing is a problem for you.
> 
> Right now we offer the following semantics:
> 
> 	Deallocate, no zeroing (discard)
> 
> 	Optionally deallocate, zeroing (zeroout)
> 
> 	Allocate, zeroing (zeroout + NOUNMAP)
> 
> Some devices also implement a fourth option which would be:
> 
> 	Anchor: Allocate, no zeroing

What happens if you anchor and then try to read the results?  IO error?

(Yeah, I'm being lazy and not digging through SBC-3, sorry...)

--D

> > Won't this confuse a reader that we have blkdev_issue_write_zeroes(),
> > which does not write zeroes sometimes? Maybe we should rename
> > blkdev_issue_write_zeroes() in some more generic name?
> 
> Maybe. The naming is what it is for hysterical raisins and reflects how
> things are implemented in the storage protocols. I wouldn't worry too
> much about that. We can rename things if need be but we shouldn't plumb
> an essentially identical operation through the block stack just to
> expose a different name at the top.
> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering

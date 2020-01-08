Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D59133946
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2020 03:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgAHCt5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 21:49:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42490 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHCt5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jan 2020 21:49:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0082j3hT168191;
        Wed, 8 Jan 2020 02:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=djsuFW26Q10VIQY8oPGzjzhEBcz7rw2ZOk6sov2Cj8E=;
 b=CpY2JxsmSQUXu2lhWgt9naNTsGQ0eMZAc4f3C6/IESgXByDk8Ph5TgE1fgDcxUjEp/i8
 O5s2MGYclWkXADBFV6fDbb4veOL6D54loaNmCFzP5AUw/jKKeaj6WKY5+a79RzIHQJ6v
 dVxjaOEl5NHKmLelbpOykQiX2KdwrjKk206vX+FaWU6+6ieKGG39fR+cRqwo6z5VOy1a
 i5Gim2LeWZufJ82J6XTOXatsE3lPqJsoghEoVrWSDNj3ZGp51werLN27KX3YAD/6aQof
 pU1g9Mx5vZtX6XrfTMUBlSVL5V+4Twh58m5b9z/nuoW4P/IHn4DC/ChY9t7maY8fRSk9 vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xakbqs4g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 02:49:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0082nGxq110505;
        Wed, 8 Jan 2020 02:49:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xcpcrmmqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 02:49:20 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0082nBS7020174;
        Wed, 8 Jan 2020 02:49:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 18:49:11 -0800
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "axboe\@kernel.dk" <axboe@kernel.dk>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4\@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso\@mit.edu" <tytso@mit.edu>,
        "adilger.kernel\@dilger.ca" <adilger.kernel@dilger.ca>,
        "ming.lei\@redhat.com" <ming.lei@redhat.com>,
        "osandov\@fb.com" <osandov@fb.com>,
        "jthumshirn\@suse.de" <jthumshirn@suse.de>,
        "minwoo.im.dev\@gmail.com" <minwoo.im.dev@gmail.com>,
        "damien.lemoal\@wdc.com" <damien.lemoal@wdc.com>,
        "andrea.parri\@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "hare\@suse.com" <hare@suse.com>, "tj\@kernel.org" <tj@kernel.org>,
        "ajay.joshi\@wdc.com" <ajay.joshi@wdc.com>,
        "sagi\@grimberg.me" <sagi@grimberg.me>,
        "dsterba\@suse.com" <dsterba@suse.com>,
        "chaitanya.kulkarni\@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "bvanassche\@acm.org" <bvanassche@acm.org>,
        "dhowells\@redhat.com" <dhowells@redhat.com>,
        "asml.silence\@gmail.com" <asml.silence@gmail.com>
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
        <yq1o8vg2bl2.fsf@oracle.com>
        <d2835bd2-9579-74b5-4339-b576df79a9d5@virtuozzo.com>
Date:   Tue, 07 Jan 2020 21:49:06 -0500
In-Reply-To: <d2835bd2-9579-74b5-4339-b576df79a9d5@virtuozzo.com> (Kirill
        Tkhai's message of "Tue, 7 Jan 2020 13:59:10 +0000")
Message-ID: <yq1k1621x3x.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080022
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Kirill,

>> Correct. We shouldn't go down this path unless a device is thinly
>> provisioned (i.e. max_discard_sectors > 0).
>
> (I assumed it is a typo, and you mean max_allocate_sectors like bellow).

No, this was in the context of not having an explicit queue limit for
allocation. If a device does not have max_discard_sectors > 0 then it is
not thinly provisioned and therefore attempting allocation makes no
sense.

>> I don't like "write_zeroes_can_allocate" because that makes assumptions
>> about WRITE ZEROES being the command of choice. I suggest we call it
>> "max_allocate_sectors" to mirror "max_discard_sectors". I.e. put
>> emphasis on the semantic operation and not the plumbing.
>  
> Hm. Do you mean "bool max_allocate_sectors" or "unsigned int max_allocate_sectors"?

unsigned int. At least for SCSI we could have a device which would use
UNMAP for discards and WRITE SAME for allocates. And therefore the range
limit could be different for the two operations. Sadly.

I have a patch in the pipeline which deals with some problems in this
department because some devices have a split brain wrt. their discard
limits.

> In the second case we should make all the
> q->limits.max_write_zeroes_sectors dereferencing as switches like the
> below (this is a partial patch and only several of places are
> converted to switches as examples):

Something like that, yes.

This is getting a bit messy :( However, I am not sure that scattering
REQ_OP_ALLOCATE all over the I/O stack is particularly attractive
either.

Both REQ_OP_DISCARD and REQ_OP_WRITE_SAME come with some storage
protocol baggage that forces us to have special handling all over the
stack. But REQ_OP_WRITE_ZEROES is fairly clean and simple and, except
for the potentially different block count limit, an allocate operation
would be a carbon copy of the plumbing for write zeroes. A lot of
duplication.

So even through I'm increasingly torn on whether introducing separate
REQ_OP_ALLOCATE plumbing throughout the stack or having a REQ_ALLOCATE
flag for REQ_OP_WRITE_ZEROES is best, I still think I'm leaning towards
the latter. That will also make it easier for me in the SCSI disk
driver.

-- 
Martin K. Petersen	Oracle Linux Engineering

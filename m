Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37674127A4F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2019 12:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfLTL4P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Dec 2019 06:56:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:41354 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfLTL4P (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Dec 2019 06:56:15 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iiGs9-0006Sg-TL; Fri, 20 Dec 2019 14:55:10 +0300
Subject: Re: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE
 operation
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, ming.lei@redhat.com,
        osandov@fb.com, jthumshirn@suse.de, minwoo.im.dev@gmail.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, ajay.joshi@wdc.com, sagi@grimberg.me,
        dsterba@suse.com, chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
 <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
 <yq1woatc8zd.fsf@oracle.com>
 <3f2e341b-dea4-c5d0-8eb0-568b6ad2f17b@virtuozzo.com>
 <yq1a77oc56s.fsf@oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <625c9ee4-bedb-ff60-845e-2d440c4f58aa@virtuozzo.com>
Date:   Fri, 20 Dec 2019 14:55:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <yq1a77oc56s.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Martin,

On 20.12.2019 01:37, Martin K. Petersen wrote:
> 
> Kirill,
> 
>> Hm. BLKDEV_ZERO_NOUNMAP is used in __blkdev_issue_write_zeroes() only.
>> So, do I understand right that we should the below two?:
>>
>> 1) Introduce a new flag BLKDEV_ZERO_ALLOCATE for
>> blkdev_issue_write_zeroes().
> 
>> 2) Introduce a new flag REQ_NOZERO in enum req_opf.
> 
> Something like that. If zeroing is a problem for you.

My intention is to use this in fs allocators to notify virtual block devices
about allocated blocks (like in patch [3/3]). Filesystems allocators know about
written and unwritten extents, and they don't need a zeroing of allocated blocks.

Since a block range allocation action is less complicated (and faster), than
operation of allocation + zeroing of allocated blocks (at least for some devices),
we just choose it as the fastest. This is the reason we avoid zeroing.

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
> 
>> Won't this confuse a reader that we have blkdev_issue_write_zeroes(),
>> which does not write zeroes sometimes? Maybe we should rename
>> blkdev_issue_write_zeroes() in some more generic name?
> 
> Maybe. The naming is what it is for hysterical raisins and reflects how
> things are implemented in the storage protocols. I wouldn't worry too
> much about that. We can rename things if need be but we shouldn't plumb
> an essentially identical operation through the block stack just to
> expose a different name at the top.

Not introduction a new operation is a good thing. Especially, since we don't
need a specific max_xxx_xxx_sectors != max_write_zeroes_sectors for it.

I'll rework the patch in this way (it seems it will become pretty small
after that).

One more thing to discuss. The new REQ_NOZERO flag won't be supported
by many block devices (their number will be even less, than number of
REQ_OP_WRITE_ZEROES supporters). Will this be a good thing, in case
of we will be completing BLKDEV_ZERO_ALLOCATE bios in __blkdev_issue_write_zeroes()
before splitting? I mean introduction of some flag in struct request_queue::limits.
Completion of them with -EOPNOTSUPP in block devices drivers looks
suboptimal for me.

Thanks,
Kirill

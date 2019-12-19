Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3456126080
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2019 12:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfLSLI0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Dec 2019 06:08:26 -0500
Received: from relay.sw.ru ([185.231.240.75]:47626 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfLSLI0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Dec 2019 06:08:26 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ihteG-0005CI-NY; Thu, 19 Dec 2019 14:07:16 +0300
Subject: Re: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE
 operation
To:     "Martin K. Petersen" <martin.petersen@oracle.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
 <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
 <yq1woatc8zd.fsf@oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3f2e341b-dea4-c5d0-8eb0-568b6ad2f17b@virtuozzo.com>
Date:   Thu, 19 Dec 2019 14:07:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <yq1woatc8zd.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Martin!

On 19.12.2019 06:03, Martin K. Petersen wrote:
> 
> Hi Kirill!
> 
>> The patch adds a new blkdev_issue_assign_range() primitive, which is
>> rather similar to existing blkdev_issue_{*} api.  Also, a new queue
>> limit.max_assign_range_sectors is added.
> 
> I am not so keen on the assign_range name. What's wrong with "allocate"?

REQ_OP_ALLOCATE_RANGE seemed for me as looking very long for the reviewers.
And I found that there is no an abbreviation of operations name in enum req_opf,
so REQ_OP_ALLOC_RANGE won't look good. Thus, I found a replacement.

But in case of REQ_OP_ALLOCATE_RANGE length is OK for people, there is no
a problem to choose it.

> But why introduce a completely new operation? Isn't this essentially a
> write zeroes with BLKDEV_ZERO_NOUNMAP flag set?
> 
> If the zeroing aspect is perceived to be a problem we could add a
> BLKDEV_ZERO_ALLOCATE flag (or BLKDEV_ZERO_ANCHOR since that's the
> terminology used in SCSI).

Hm. BLKDEV_ZERO_NOUNMAP is used in __blkdev_issue_write_zeroes() only.
So, do I understand right that we should the below two?:

1)Introduce a new flag BLKDEV_ZERO_ALLOCATE for blkdev_issue_write_zeroes().
2)Introduce a new flag REQ_NOZERO in enum req_opf.

Won't this confuse a reader that we have blkdev_issue_write_zeroes(),
which does not write zeroes sometimes? Maybe we should rename
blkdev_issue_write_zeroes() in some more generic name?

Thanks,
Kirill


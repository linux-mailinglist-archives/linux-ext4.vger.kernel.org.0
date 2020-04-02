Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4814719BEE6
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Apr 2020 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbgDBJtW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Apr 2020 05:49:22 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:52850 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgDBJtW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Apr 2020 05:49:22 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D3BA62E1265;
        Thu,  2 Apr 2020 12:49:18 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id vrs95Mzv0O-nGN0qAIi;
        Thu, 02 Apr 2020 12:49:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585820958; bh=8qGtLajpajgQeO52XlnOyzpq0mVSyJ0nBQMIBhnX7Mo=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=GdhMe6K1GB1Cm0lqto4XDJStvjnzsCYuv7+T9I2K1YsGwEED1x6Q9eGvt3eN45RPc
         NowBnR5yl7MNyNWREHJPWUUSv5g9h/k+oBptD6da97vi6eH63QHqKdm3hcJz+LRc8F
         Nn31PYKJc97nL601CRWds7TSsIIYcN5fZD3OH1M0=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6404::1:b])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id FSN3Lw54Th-nFW8XYMv;
        Thu, 02 Apr 2020 12:49:16 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
        darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        hannes@cmpxchg.org, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
 <bb7d7604-8ee5-97d8-1563-9140cd499f15@yandex-team.ru>
 <yq1v9mi4o31.fsf@oracle.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <9b88f077-616a-64f4-287a-77f5c3b8b07a@yandex-team.ru>
Date:   Thu, 2 Apr 2020 12:49:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <yq1v9mi4o31.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 02/04/2020 05.29, Martin K. Petersen wrote:
> 
> Konstantin,
> 
>>> The corresponding exported primitive is called
>>> blkdev_issue_assign_range().
>>
>> What exact semantics of that?
> 
> REQ_OP_ALLOCATE will be used to compel a device to allocate a block
> range. What a given block contains after successful allocation is
> undefined (depends on the device implementation).

Ok. Then REQ_OP_ALLOCATE should be accounted as discard rather than write.
That's decided by helper op_is_discard() which is used only by statistics.
It seems REQ_OP_SECURE_ERASE also should be accounted in this way.

> 
> For block allocation with deterministic zeroing, one must keep using
> REQ_OP_WRITE_ZEROES with the NOUNMAP flag set.
> 

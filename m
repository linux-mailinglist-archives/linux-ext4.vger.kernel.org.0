Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDEC380680
	for <lists+linux-ext4@lfdr.de>; Fri, 14 May 2021 11:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhENJwM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 May 2021 05:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36676 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232268AbhENJwK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 14 May 2021 05:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620985858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0v2WTfoTYYFvI5g3TxNROF/jrQek1EySSdju9KXEFoA=;
        b=PG6dlv+kcGF4BYU8kCgNxFC/2VLAWWk9jiKXDFgiGHIYZkZcr2b16biC02wSKHQQbQ5kea
        rSsgxnNh9EagftB/KRZE8DACjhRGdbc9NXqetcgJ4C2RG2+dr/9R82cdw4NruUlyEZs2Ow
        M0sNqoBQqth03LeFJPSEe/kvfwSy7n8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-i_GH1KlpNd-xW5uWh3gvOQ-1; Fri, 14 May 2021 05:50:57 -0400
X-MC-Unique: i_GH1KlpNd-xW5uWh3gvOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC9C38042A9;
        Fri, 14 May 2021 09:50:54 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2C986788A;
        Fri, 14 May 2021 09:50:41 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 14E9of0U023228;
        Fri, 14 May 2021 05:50:41 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 14E9oebu023224;
        Fri, 14 May 2021 05:50:40 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 14 May 2021 05:50:40 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Milan Broz <gmazyland@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Changheun Lee <nanich.lee@samsung.com>
cc:     alex_y_xu@yahoo.ca, axboe@kernel.dk, bgoncalv@redhat.com,
        dm-crypt@saout.de, hch@lst.de, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        ming.lei@redhat.com, yi.zhang@redhat.com, dm-devel@redhat.com
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
In-Reply-To: <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2105140544010.22439@file01.intranet.prod.int.rdu2.redhat.com>
References: <a01ab479-69e8-9395-7d24-9de1eec28aff@acm.org> <0e7b0b6e-e78c-f22d-af8d-d7bdcb597bea@gmail.com> <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 5/13/21 7:15 AM, Theodore Ts'o wrote:
> On Thu, May 13, 2021 at 06:42:22PM +0900, Changheun Lee wrote:
>>
>> Problem might be casued by exhausting of memory. And memory exhausting
>> would be caused by setting of small bio_max_size. Actually it was not
>> reproduced in my VM environment at first. But, I reproduced same problem
>> when bio_max_size is set with 8KB forced. Too many bio allocation would
>> be occurred by setting of 8KB bio_max_size.
> 
> Hmm... I'm not sure how to align your diagnosis with the symptoms in
> the bug report.  If we were limited by memory, that should slow down
> the I/O, but we should still be making forward progress, no?  And a
> forced reboot should not result in data corruption, unless maybe there

If you use data=writeback, data writes and journal writes are not 
synchronized. So, it may be possible that a journal write made it through, 
a data write didn't - the end result would be a file containing random 
contents that was on the disk.

Changheun - do you use data=writeback? Did the corruption happen only in 
newly created files? Or did it corrupt existing files?

> was a missing check for a failed memory allocation, causing data to be
> written to the wrong location, a missing error check leading to the
> block or file system layer not noticing that a write had failed
> (although again, memory exhaustion should not lead to failed writes;
> it might slow us down, sure, but if writes are being failed, something
> is Badly Going Wrong --- things like writes to the swap device or
> writes by the page cleaner must succeed, or else Things Would Go Bad
> In A Hurry).

Mikulas


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4DE37FDFB
	for <lists+linux-ext4@lfdr.de>; Thu, 13 May 2021 21:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhEMTX4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 May 2021 15:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232259AbhEMTX4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 May 2021 15:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620933765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UChYrtJTiYVZT+Wv2GpTYs4oyHUTct1kWqfb8kWb1Kc=;
        b=KcKwkTfTPLd5qQso4iOoIGQ6o8i/cYLVYgSE0Qx0VEcJ+zL4ZcDcaV5RkURErm9y3mpIl2
        e+jb+59bvh6wv1IR0KvdgoBi8URpENcCsq/EQp8qbwnpzv6pTHRgH7svbUzxI2V/9PeLPS
        RcaWNBbPy7YwGTCy8Y6EAQWSqpFOyCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-oFdgpTWIM7yVaYjq-cClig-1; Thu, 13 May 2021 15:22:44 -0400
X-MC-Unique: oFdgpTWIM7yVaYjq-cClig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE173CC623;
        Thu, 13 May 2021 19:22:40 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2EAF19172;
        Thu, 13 May 2021 19:22:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 14DJMTP4022674;
        Thu, 13 May 2021 15:22:29 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 14DJMPNw022669;
        Thu, 13 May 2021 15:22:25 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 13 May 2021 15:22:25 -0400 (EDT)
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
In-Reply-To: <0e7b0b6e-e78c-f22d-af8d-d7bdcb597bea@gmail.com>
Message-ID: <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
References: <a01ab479-69e8-9395-7d24-9de1eec28aff@acm.org> <0e7b0b6e-e78c-f22d-af8d-d7bdcb597bea@gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On 5/13/21 7:15 AM, Theodore Ts'o wrote:
> > On Thu, May 13, 2021 at 06:42:22PM +0900, Changheun Lee wrote:
> >>
> >> Problem might be casued by exhausting of memory. And memory exhausting
> >> would be caused by setting of small bio_max_size. Actually it was not
> >> reproduced in my VM environment at first. But, I reproduced same problem
> >> when bio_max_size is set with 8KB forced. Too many bio allocation would
> >> be occurred by setting of 8KB bio_max_size.
> > 
> > Hmm... I'm not sure how to align your diagnosis with the symptoms in
> > the bug report.  If we were limited by memory, that should slow down
> > the I/O, but we should still be making forward progress, no?  And a
> > forced reboot should not result in data corruption, unless maybe there
> > was a missing check for a failed memory allocation, causing data to be
> > written to the wrong location, a missing error check leading to the
> > block or file system layer not noticing that a write had failed
> > (although again, memory exhaustion should not lead to failed writes;
> > it might slow us down, sure, but if writes are being failed, something
> > is Badly Going Wrong --- things like writes to the swap device or
> > writes by the page cleaner must succeed, or else Things Would Go Bad
> > In A Hurry).
> 
> After the LUKS data corruption issue was reported I decided to take a
> look at the dm-crypt code. In that code I found the following:
> 
> static void clone_init(struct dm_crypt_io *io, struct bio *clone)
> {
> 	struct crypt_config *cc = io->cc;
> 
> 	clone->bi_private = io;
> 	clone->bi_end_io  = crypt_endio;
> 	bio_set_dev(clone, cc->dev->bdev);
> 	clone->bi_opf	  = io->base_bio->bi_opf;
> }
> [ ... ]
> static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
> {
> 	[ ... ]
> 	clone = bio_alloc_bioset(GFP_NOIO, nr_iovecs, &cc->bs);
> 	[ ... ]
> 	clone_init(io, clone);
> 	[ ... ]
> 	for (i = 0; i < nr_iovecs; i++) {
> 		[ ... ]
> 		bio_add_page(clone, page, len, 0);
> 
> 		remaining_size -= len;
> 	}
> 	[ ... ]
> }
> 
> My interpretation is that crypt_alloc_buffer() allocates a bio,
> associates it with the underlying device and clones a bio. The input bio
> may have a size up to UINT_MAX while the new limit for the size of the
> cloned bio is max_sectors * 512. That causes bio_add_page() to fail if
> the input bio is larger than max_sectors * 512, hence the data
> corruption. Please note that this is a guess only and that I'm not
> familiar with the dm-crypt code.
> 
> Bart.

We already had problems with too large bios in dm-crypt and we fixed it by 
adding this piece of code:

        /*
         * Check if bio is too large, split as needed.
         */
        if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_VECS << PAGE_SHIFT)) &&
            (bio_data_dir(bio) == WRITE || cc->on_disk_tag_size))
                dm_accept_partial_bio(bio, ((BIO_MAX_VECS << PAGE_SHIFT) >> SECTOR_SHIFT));

It will ask the device mapper to split the bio if it is too large. So, 
crypt_alloc_buffer can't receive a bio that is larger than BIO_MAX_VECS << 
PAGE_SHIFT.

Mikulas


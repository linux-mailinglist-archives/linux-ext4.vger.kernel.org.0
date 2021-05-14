Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4A38066D
	for <lists+linux-ext4@lfdr.de>; Fri, 14 May 2021 11:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhENJpG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 May 2021 05:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230236AbhENJpF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 14 May 2021 05:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620985433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=05Af3bVZXrGJRy2+GfagSd6JI7OZwal3JL9/7JcdoT8=;
        b=ZkdaEcxcldo0XiLP+unIZ62NBCaLEv6wBqZ1GjXYiHrW67WGpKIiTXqxajOOcw1Y7H6+oI
        tLzPq58Lzpnnwcbs8gJW636TYgHaOKr+rgvWBsTk4EckMMEm13fe8buvsxfOZfqQqM9IFs
        e7k/PpR5ZxxS8rdKRuUE43ofWL+dyYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-WqmhRHU7PHCcJPYyjHCMaA-1; Fri, 14 May 2021 05:43:52 -0400
X-MC-Unique: WqmhRHU7PHCcJPYyjHCMaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 203D61007480;
        Fri, 14 May 2021 09:43:50 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A507F1971B;
        Fri, 14 May 2021 09:43:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 14E9hd7S022799;
        Fri, 14 May 2021 05:43:39 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 14E9haED022795;
        Fri, 14 May 2021 05:43:36 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 14 May 2021 05:43:36 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Bart Van Assche <bvanassche@acm.org>
cc:     Milan Broz <gmazyland@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Changheun Lee <nanich.lee@samsung.com>, alex_y_xu@yahoo.ca,
        axboe@kernel.dk, bgoncalv@redhat.com, dm-crypt@saout.de,
        hch@lst.de, jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, ming.lei@redhat.com,
        yi.zhang@redhat.com, dm-devel@redhat.com
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
In-Reply-To: <fdee795d-7a4b-9506-b9ca-359b9bcbec34@acm.org>
Message-ID: <alpine.LRH.2.02.2105140514560.20018@file01.intranet.prod.int.rdu2.redhat.com>
References: <a01ab479-69e8-9395-7d24-9de1eec28aff@acm.org> <0e7b0b6e-e78c-f22d-af8d-d7bdcb597bea@gmail.com> <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com> <fdee795d-7a4b-9506-b9ca-359b9bcbec34@acm.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On Thu, 13 May 2021, Bart Van Assche wrote:

> On 5/13/21 12:22 PM, Mikulas Patocka wrote:
> > We already had problems with too large bios in dm-crypt and we fixed it by 
> > adding this piece of code:
> > 
> >         /*
> >          * Check if bio is too large, split as needed.
> >          */
> >         if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_VECS << PAGE_SHIFT)) &&
> >             (bio_data_dir(bio) == WRITE || cc->on_disk_tag_size))
> >                 dm_accept_partial_bio(bio, ((BIO_MAX_VECS << PAGE_SHIFT) >> SECTOR_SHIFT));
> > 
> > It will ask the device mapper to split the bio if it is too large. So, 
> > crypt_alloc_buffer can't receive a bio that is larger than BIO_MAX_VECS << 
> > PAGE_SHIFT.
> 
> Hi Mikulas,
> 
> Are you perhaps referring to commit 4e870e948fba ("dm crypt: fix error
> with too large bios")? Did that commit go upstream before multi-page
> bvec support?

Yes. It's from 2016.

> Can larger bios be supported in case of two or more
> contiguous pages now that multi-page bvec support is upstream?

No - we need to allocate a buffer for the written data. The buffer size is 
limited to PAGE_SIZE * BIO_MAX_VECS.

> Thanks,
> 
> Bart.

Mikulas


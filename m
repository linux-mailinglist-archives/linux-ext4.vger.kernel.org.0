Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE732E786
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 13:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhCEMAJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 07:00:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhCEMAG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 07:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614945605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbRuqCLJ0qutCRyPJA4haV3cGk8yCCE3pYrj3olV3RY=;
        b=Y6qDVpW+yiFv1bKgJFlFt5oeO3xdri0cUL4MPrOtNyl/8ZSAf67ZZJMgL806etOreNeb8e
        m/IycsENTsLr8OmJmxaV9PMCHRzMgcH71JcZAvG+QzfNZUtIBfKvT+jWlao8gxh59kfV8s
        dJZe1yj8qpP42jOJ53uKTG6rA6cG6l0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-pbvOxdsvOpeeu291v_adzQ-1; Fri, 05 Mar 2021 07:00:02 -0500
X-MC-Unique: pbvOxdsvOpeeu291v_adzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FE2A108BD11;
        Fri,  5 Mar 2021 12:00:01 +0000 (UTC)
Received: from work (unknown [10.40.193.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5407100164C;
        Fri,  5 Mar 2021 12:00:00 +0000 (UTC)
Date:   Fri, 5 Mar 2021 12:59:57 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: badblocks from e2fsprogs
Message-ID: <20210305115957.x4gbppxpzxuvn2kd@work>
References: <CA+icZUXzjAniVZMzS5ePNa6HrjWL6ZrpAgzWufy74zHSyN+urQ@mail.gmail.com>
 <YD0DaqIbAf0T2tw2@mit.edu>
 <CA+icZUXJpEEO4GS1fy9ANXCXJ2BtD_rd1tAtXLun++i0taZwSA@mail.gmail.com>
 <YD0JfjnMtXzGguZ6@mit.edu>
 <CA+icZUUruS8h=CiUwuSsbL9NmCXCvdfV-XFfV=Z=qOpR9b83XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUruS8h=CiUwuSsbL9NmCXCvdfV-XFfV=Z=qOpR9b83XA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 01, 2021 at 04:42:26PM +0100, Sedat Dilek wrote:
> On Mon, Mar 1, 2021 at 4:34 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Mon, Mar 01, 2021 at 04:12:03PM +0100, Sedat Dilek wrote:
> > >
> > > OK, I see.
> > > So I misunderstood the -o option.
> >
> > It was clearly documented in the man page:
> >
> >        -o output_file
> >               Write the list of bad blocks to the specified file.
> >               Without this option, badblocks displays the list on
> >               its standard output.  The format of this file is
> >               suitable for use by the -l option in e2fsck(8) or
> >               mke2fs(8).
> >
> 
> RTFM.
> 
> > I will say that for modern disks, the usefulness of badblocks has
> > decreased significantly over time.  That's because for modern-sized
> > disks, it can often take more than 24 hours to do a full read on the
> > entire disk surface --- and the factory testing done by HDD
> > manufacturers is far more comprehensive.
> >
> > In addition, SMART (see the smartctl package) is a much more reliable
> > and efficient way of judging disk health.
> >
> > The badblocks program was written over two decades ago, before the
> > days of SATA, and even IDE disks, when disk controlls and HDD's were
> > far more primitive.  These days, modern HDD and SSD will do their own
> > bad block redirection from a built-in bad block sparing pool, and the
> > usefulness of using badblocks has been significantly decreased.
> >
> 
> Thanks for the clarification on badblocks usage and usefulness.
> 
> OK, I ran before badblocks:
> 
> 1. smartctl -a /dev/sdc (shell)
> 2. gsmartcontrol (GUI)
> 
> The results showed me "this disk is healthy".
> As you said: Both gave a very quick overview.
> 
> - Sedat -

Just note that not even the device firmware can't really know whether the
block is good/bad unless it tries to read/write it. In that way I still
find the badblocks useful because it can "force" the device to notice
that there is something wrong and try to fix it (perhaps by remapping
the bad block to spare one). Of course you could use dd for that, but
there are several reasons why badblocks is still more convenient tool to
do that.

That said you should also check the SMART data _after_ you run the
badblocks to see if it encountered any read errors and/or remapped some
blocks.

-Lukas

> 
> [1] https://superuser.com/questions/171195/how-to-check-the-health-of-a-hard-drive
> 


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437FA58A73F
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Aug 2022 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiHEHiy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Aug 2022 03:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbiHEHiw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Aug 2022 03:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 257B85F11F
        for <linux-ext4@vger.kernel.org>; Fri,  5 Aug 2022 00:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659685130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZAhMRyLdMoOA8LK72SEkVGSLxA97jhStA5RfvPd2TQQ=;
        b=ZVpc3BnpQaMPiUvsPjgF3nwXcCLSxnqo5dbAhpdFlX/YVb6Omh4ohF3PyVevfvogFSUs9n
        cpvJPYVzGMj/UNs8Q9EZhe0TUtwy/sF276HQhKqZpNpZtq8bZZZ3kSSx1RdI/+YtXP0Aao
        T+g/uw3+uRN9RNgdNZ1tRr1EO2SVGqE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-Ex--Jxs7OjuPMXGk7eve1A-1; Fri, 05 Aug 2022 03:38:33 -0400
X-MC-Unique: Ex--Jxs7OjuPMXGk7eve1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0DD585A584;
        Fri,  5 Aug 2022 07:38:32 +0000 (UTC)
Received: from fedora (unknown [10.40.193.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 000ACC202C5;
        Fri,  5 Aug 2022 07:38:31 +0000 (UTC)
Date:   Fri, 5 Aug 2022 09:38:29 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Daniel Ng <danielng@google.com>
Cc:     linux-ext4@vger.kernel.org,
        Sarthak Kukreti <sarthakkukreti@google.com>
Subject: Re: [BUG] fsck unable to resolve filenames that include '='
Message-ID: <20220805073829.dcwhe3dizlk5hz5n@fedora>
References: <CANFuW3eGgyeWba-2GjDtdhYvX2fV7-dcrHn-4O8QAeHDERAbqw@mail.gmail.com>
 <20220803143113.frmayykhlhvcqkxg@fedora>
 <CANFuW3d5e=0qs+8mQmy+Gd5zJK9NcnJETZ1PAgTgS8E33qG5ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANFuW3d5e=0qs+8mQmy+Gd5zJK9NcnJETZ1PAgTgS8E33qG5ng@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Daniel,

On Fri, Aug 05, 2022 at 03:32:14PM +1000, Daniel Ng wrote:
> Hey Lukas,
> 
> that aligns with our observations; I also ran into this when running
> tune2fs on the file too.
> 
> I'm not very familiar with blkid_get_devname(), but that sounds sensible to me.
> 
> Alternatively, my colleague (sarthak@) was suggesting that we could
> add a stat() check for the file in the conditional that checks if
> there is a '=' character in the
> token - which would work for us at least. I suppose it just depends on
> what we should prioritize finding. It might make more sense to
> prioritize finding
> a regular file, before trying to parse the expression. In your
> example, the 'LABEL=volume-label' file couldn't ever be selected if
> there is also a
> device with 'volume-label' (it also seems more likely that in that
> situation, the file should be interacted with, over interpreting the
> token as an expression).
> 
> What are your thoughts behind the ordering (and alluded exploits)?

I think this is a bad approach. It means that a file in a working
directory from where the e2fsc/tune2fs is invoked can effectively
prevent user/admin to work with the file system with LABEL= or UUID=
without user/admin ever having any clue what it is going on.

You can always acces the file with the name LABEL=volume-label just by
specifying ./LABEL=volume-label or a full path, not a big deal and it
makes it very clear what the intentional target is.

I've got a patch that I plan to send out soon, in which I just check for
the collision and prefer the device found by blkid_get_devname(). Will
send it out soon, so let's move the discussion there.

Thanks!
-Lukas


> 
> Kind regards,
> Daniel
> 
> On Thu, Aug 4, 2022 at 12:31 AM Lukas Czerner <lczerner@redhat.com> wrote:
> >
> > On Tue, Aug 02, 2022 at 06:21:56PM +1000, Daniel Ng wrote:
> > > Hi,
> > >
> > > I've run into an issue when trying to use fsck with an ext4 image when
> > > it has '=' in its name.
> > >
> > > Repro steps:
> > > 1. fallocate -l 1G test=.img
> > > 2. mkfs.ext4 test=.img
> > > 3. fsck test=.img
> > >
> > > Response:
> > > 'fsck.ext4: Unable to resolve '<path>/test=.img'
> > >
> > > Expected:
> > > fsck to do it's thing.
> > >
> > > Observations:
> > > Originally I wasn't sure what the source was, I thought that maybe
> > > mkfs wasn't creating the image appropriately.
> > > However, I've tried:
> > > - renaming the image
> > > - creating a hard-link to the image
> > >
> > > Running fsck on either the renamed image, or the hard-link, works as expected.
> > >
> > > Kernel version: Linux version 4.19.251-13516-ga0bcf8d80077
> > > Environment: Running on a Chromebook
> > >
> > > Kind regards,
> > > Daniel
> >
> > Hi Daniel,
> >
> > yeah, that's a good catch. The problem is that various e2fsprogs tools
> > (at least tune2fs and e2fsck) are using blkid_get_devname() to get the
> > device name without ever checking if we already got the actual existing
> > device name.
> >
> > The reason to call blkid_get_devname() at all is to get device in the
> > form of NAME=value (like for example UUID=uuid, or LABEL=volume-label).
> > However if we blindly pass in the device (or in this case regular file)
> > name with an equal sign in it, the blkid_get_devname just returns whatever
> > it can find by that tag. Which is likely nothing.
> >
> > Unless of course, you're trying to use e2fsck, or tune2fs on a file with
> > an actual filename LABEL=volume-label and you have actual file system
> > with 'volume-label' LABEL ;) That's a problematic behavior and depending
> > on how we go about fixing it it could be potentialy exploitable...
> >
> > Maybe something like this:
> >
> >         1. look for the actual block device first
> >         2. if none is found call blkid_get_devname()
> >         3. if that didn't return anything maybe see if have a regular
> >            file and work with that
> >         4. if we still get nothing, then we're "Unable to resolve..."
> >
> > Thoughts?
> >
> > -Lukas
> >
> 


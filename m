Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029094546FF
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Nov 2021 14:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbhKQNQN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Nov 2021 08:16:13 -0500
Received: from disco.pogo.org.uk ([93.93.128.62]:65163 "EHLO disco.pogo.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237331AbhKQNQN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 17 Nov 2021 08:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
        ; s=swing; h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
        Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5qH8nCO3miNcPE8qZyojRHOvxf56dQALttHPP5Wbc1s=; b=E8wyGIzzFwkOvXqIoWrj3Lx80z
        5i+LGfeOZba77U0EXUlOV18EZp54/AMEIzuoMVBBQ1D1I1FGYWBxdj5TUVB0fwuBVrAS/YldUzI2B
        +lS+e/84EkuHLKy/+lNEzhZHElGVMIwEf8TvIzmmhdQNbX8GNYTv0WBFwy+O34Seo2Fs=;
Received: from [2001:470:1d21:0:428d:5cff:fe1b:f3e5] (helo=stax)
        by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <mark@xwax.org>)
        id 1mnKkR-0003vN-Gq; Wed, 17 Nov 2021 13:13:11 +0000
Received: from localhost (stax.localdomain [local])
        by stax.localdomain (OpenSMTPD) with ESMTPA id b83089f1;
        Wed, 17 Nov 2021 13:13:10 +0000 (UTC)
Date:   Wed, 17 Nov 2021 13:13:10 +0000 (GMT)
From:   Mark Hills <mark@xwax.org>
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: Maildir quickly hitting max htree
In-Reply-To: <YZSROKrWcazsRuXk@mit.edu>
Message-ID: <2111171038160.31152@stax.localdomain>
References: <2111121900560.16086@stax.localdomain> <36FABD31-B636-4D94-B14D-93F3D2B4C148@dilger.ca> <d1f5c468-4afa-accc-7843-83b484dc081@xwax.org> <YZFK56zBKXpnIncI@mit.edu> <2111161753010.26337@stax.localdomain> <YZSROKrWcazsRuXk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ted, I can't speak for everyone, but perhaps I can give some insight:

> There are a bunch of anti-patterns that I've seen with users using VM's.  
> And I'm trying to understand them, so we can better document why folks 
> shouldn't be doing things like that.

I wouldn't be so negative :) My default position is 'cloud sceptic', but 
dynamic resources changes the trade-offs between layers of abstraction. I 
wouldn't expect to always be correct about someone's overall business when 
saying "don't do that".

> For example, one of the anti-patterns that I see on Cloud systems (e.g., 
> at Amazon, Google Cloud, Azure, etc.) is people who start with a 
> super-tiny file system, say, 10GB,

It sounds interesting that hosting VMs has renewed interest in smaller 
file systems -- more, smaller hosts. 10GB seems a lot to me ;)

> and then let it grow until it's 99 full, and then they grow it by 
> another GB, so it's now 11GB, and then they fill it until it's 99% full, 
> and then they grow it by another GB.  That's because (for example) 
> Google's PD Standard is 4 cents per GB per month, and they are trying to 
> cheap out by not wanting to spend that extra 4 cents per month until 
> they absolutely, positively have to.

One reason: people are rarely working with single hosts. Small costs are 
multipled up. 4 cents is not a lot per-host, but everything is a % 
increase to overall costs.

Cloud providers sold for many years on a "use only what you need" so it 
would not be surprising for people to be tightly optimising that.

[...] 
> > I haven't looked at resize2fs code, so this comes just from a user's 
> > point-of-view but... if it is already reading mke2fs.conf, it could make 
> > comparisons using an equivalent new filesystem as benchmark.
> 
> Resize2fs doens't read mke2fs.conf, and my point was that the system
> where resize2fs is run is not necessary same as the system where
> mke2fs is run, especially when it comes to cloud images for the root
> file system.

Totally understood your point, and sounds like maybe I wasn't clear in 
mine (which got trimmed):

There's no need to worry about the state of mke2fs.conf on the host which 
originally created the filesystem -- that system is no longer relevant.

At the point of expanding you have the all the relevant information for an 
appropriate warning.

> > I imagine it's not a panacea, but it would be good to be more concrete 
> > on what the gotchas are; "bad performance" is vague, and since the 
> > tool exists it must be possible to use it properly.
> 
> Well, we can document the issues in much greater detail in a man page, 
> or in LWN article, but we need it's a bit complicated to explain it all 
> warning messages built into resize2fs.  There's the failure mode of 
> starting with a 100MB file system containing a root file system, 
> dropping it on a 10TB disk, or even worse, a 100TB raid array, and 
> trying to blow it up the 100MB file system to 100TB.  There's the 
> failure mode of waiting until the file system is 99% full, and then 
> expanding it one GB at a time, repeatedly, until it's several hundred GB 
> or TB, and then users wonder why performance is crap.
> 
> There are so many different ways one can shoot one's foot off, and
> until I understand why people are desining their own particular
> foot-guns, it's hard to write a man page warning about all of the
> particular bad ways one can be a system administrator.  Unfortunately,
> my imagination is not necessarily up to the task of figuring them all
> out

Neithers your imagination, nor mine, nor anyone else's :) People will do 
cranky things.

But also nobody reasonable is expecting you to do their job for them.

You haven't really said what are the major underlying properties of the 
filesystem that are inflexible when re-sizing, and so I'm keen for 
more detail.

It's the sort of information makes for better reasoning; at least a hint 
of the appropriate trade-offs; and not having to keep explaining on 
mailing lists ;)

But saying "performance is crap" or "failure mode" is vague and so I can 
understand why people persevere (either knowingly or unknowingly) -- in my 
experience, many people work on the basis that something 'seems' to work 
ok.

Trying to be tangible here, I made a start on a section for the resize2fs 
man page. Would it be worthwhile to flesh this out and would you consider 
helping to do that?

  CAVEATS

    Re-sizing a filesystem should not be assumed to result in a filesystem 
    with identifical specification to one created at the new size. More 
    often this is not the case.

    Specifically, enlarging or shrinking a filesystem does not resize 
    these resources:

        * block size, which impacts directory indexes and the upper limit 
          on number of files in a directory;

        * journal size which affects [write performance?]

        * files which have become fragmented due to space constraints;
          see e2freefrag(8) and e4defrag(8)

        * [any more? or is this even comprehensive? Only
           the major contributors needed to begin with]

It really doesn't need to be very long; just a signpost in the right 
direction.

In my case, I have some knowledge of filesystem internals (much less than 
you, but probably more than most) but had completely forgotten this was a 
resized filesystem (as well as resized more than the original image ever 
intended). It just takes a nudge/reminder in the direction, not much more.

The tiny patch to dmesg (elsewhere in the thread) would have indicated the 
revelance of the block size; reminding me of the resize, and a tiny 
addition to the man page to help decide what action to take -- reformat, 
or not.

> For example...
> 
> > For info, our use case here is the base image used to deploy persistent 
> > VMs which use very different disk sizes. The base image is build using 
> > packer+QEMU managed as code. Then written using "dd" and LVM partitions 
> > expanded without needing to go single-user or take the system offline. 
> > This method is appealling because it allows to pre-populate /home with 
> > some small amount of data; SSH keys etc.
> 
> May I suggest using a tar.gz file instead and unpacking it onto a
> freshly created file sysetem?  It's easier to inspect and update the
> contents of the tarball, and it's actually going to be smaller than
> using a file system iamge and then trying to expand it using
> resize2fs....
> 
> To be honest, that particular use case didn't even *occur* to me,
> since there are so many more efficient ways it can be done.

But, this considers 'efficiency' in context of the filesystem performance 
only.

Unpacking a tar.gz requires custom scripting, is slow, extra 'one off' 
steps on boot up introduce complexity. These are the 'installers' that 
everyone hates :)

Also I presume there is COW at the image level on some infrastructure.

And none of this covers changing a size of an online system.

> I take it that you're trying to do this before the VM is launched, as 
> opposed to unpacking it as part of the VM boot process?

Yes; and I think that's really the spirit of an "image", right?
 
> If you're using qemu/KVM, perhaps you could drop the tar.gz file in a
> directory on the host, and launch the VM using a virtio-9p.  This can
> be done by launching qemu with arguments like this:
> 
> qemu ... \
[...]

We use qemu+Makefile to build the images, but for running on 
infrastructure most cloud providers are limited; controls like this are 
not available.

> If you are using Google Cloud Platform or AWS, you could use Google 
> Cloud Storage or Amazon S3, respectively, and then just copy the tar.gz 
> file into /run and unpack it.

We're not using Google nor AWS. In general I can envisage extra work to 
construct the secured side-channel to distribute supplementary .tar.gz 
files.

I don't think you should be disheartened by people resizing in these ways. 
I'm not an advocate, and understand your points.

But it sounds like it is allowing people to achieve things, and it _is_ a 
positive sign that the abstractions are well designed -- leaving users 
unaware of the caveats, which are hidden from them until they bite.

A rhethorical question, and with no prior knowledge, but: if there is 
benefits to these extreme resizes then rather than say "don't do that" 
could it be possible to generalise the maintaining of any filesystem as 
creating a 'zero-sized' one, and resizing it upwards? ie. the real code 
exists in resize, not in creation.

Thanks

-- 
Mark

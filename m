Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD4453A2E
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Nov 2021 20:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbhKPTeL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Nov 2021 14:34:11 -0500
Received: from disco.pogo.org.uk ([93.93.128.62]:29810 "EHLO disco.pogo.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhKPTeL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 16 Nov 2021 14:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
        ; s=swing; h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:
        Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=90Oq9fPA/R7e4NJ8b2t+UkekRnB6c+OM9TYzriGx1Qg=; b=MHvdzBNAK4g19ejDao+j4CoAbX
        djleMcXDwzXcme31NkyULsg/jP8gM6zfq+ijjlRO4fCfKSTYm9Y0fpmO5mK3Vio+inYbS31vnO6bz
        yAqzIxM4Qqn4ViOV3W+jNCmL2PJyiTc+wmXLVDOK7cCJeNd55mKTlfhTSSRRwhduDxko=;
Received: from [2001:470:1d21:0:428d:5cff:fe1b:f3e5] (helo=stax)
        by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <mark@xwax.org>)
        id 1mn4Ah-000FzR-D7; Tue, 16 Nov 2021 19:31:11 +0000
Received: from localhost (stax.localdomain [local])
        by stax.localdomain (OpenSMTPD) with ESMTPA id 9cd23a6f;
        Tue, 16 Nov 2021 19:31:10 +0000 (UTC)
Date:   Tue, 16 Nov 2021 19:31:10 +0000 (GMT)
From:   Mark Hills <mark@xwax.org>
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: Maildir quickly hitting max htree
In-Reply-To: <YZFK56zBKXpnIncI@mit.edu>
Message-ID: <2111161753010.26337@stax.localdomain>
References: <2111121900560.16086@stax.localdomain> <36FABD31-B636-4D94-B14D-93F3D2B4C148@dilger.ca> <d1f5c468-4afa-accc-7843-83b484dc081@xwax.org> <YZFK56zBKXpnIncI@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, 14 Nov 2021, Theodore Ts'o wrote:

> On Sat, Nov 13, 2021 at 12:05:07PM +0000, Mark Hills wrote:
> > 
> > Interesting! The 1Kb block size was not explicitly chosen. There was no 
> > plan other than using the defaults.
> > 
> > However I did forget that this is a VM installed from a base image. The 
> > root cause is likely to be that the /home partition has been enlarged from 
> > a small size to 32Gb.
> 
> How small was the base image?

/home was created with 256Mb, never shrunk.

> As documented in the man page for mke2fs.conf, for file systems that are 
> smaller than 3mb, mke2fs use the parameters in /etc/mke2fs.conf for type 
> "floppy" (back when 3.5 inch floppies were either 1.44MB or 2.88MB).  
> So it must have been a really tiny base image to begin with.

Small, but not microscopic :)

I see a definition in mke2fs.conf for "small" which uses 1024 blocksize, 
and I assume it originated there and not "floppy".

> > These days I think VMs make it more common to enlarge a filesystem from a 
> > small size. We could have picked this up earlier with a warning from 
> > resize2fs; eg. if the block size will no longer match the one that would 
> > be chosen by default. That would pick it up before anyone puts 1Kb block 
> > size into production.
> 
> It's would be a bit tricky for resize2fs to do that, since it doesn't
> know what might be in the mke2fs.conf file at the time when the file
> system when the file system was creaeted.  Distributions or individual
> system adminsitrators are free to modify that config file.

No need to time travel back -- it's complicated, and actually less 
relevant?

I haven't looked at resize2fs code, so this comes just from a user's 
point-of-view but... if it is already reading mke2fs.conf, it could make 
comparisons using an equivalent new filesystem as benchmark.

In the spirit of eg. "your resized filesystem will have a block size of 
1024, but a new filesystem of this size would use 4096"

Then you can compare any absolute metric of the filesystem that way.

The advantage being...

> It is a good idea for resize2fs to give a warning, though.  What I'm 
> thinking that what might sense is if resize2fs is expanding the file 
> system by more than, say a factor of 10x (e.g., expanding a file system 
> from 10mb to 100mb, or 3mb to 20gb)

... that the benchmark gives you a comparison that won't drift. eg. if you 
resize by +90% several times.

And reflects any desires that may be in the configuration.

> to give a warning that inflating file systems is an anti-pattern that 
> will not necessarily result in the best file system performance.

I imagine it's not a panacea, but it would be good to be more concrete on 
what the gotchas are; "bad performance" is vague, and since the tool 
exists it must be possible to use it properly.

I'll need to consult the docs, but so far have been made aware of:

* block size
  (which has knock-on effect to file limits per directory)

* journal size
  (not in configuration file -- can this be adjusted?)

* files get fragmented when shrinking a filesystem
  (but this is similar to any full file system?)

These are all things I'm generally aware of and their implications, just 
easy to miss when you're busy and focused on other aspects (completely 
escaped me that the filesystem had been enlarged when I began this 
thread!)

That's why the patch in the other thread is not a bad idea; just reminding 
that block size is relevant.

For info, our use case here is the base image used to deploy persistent 
VMs which use very different disk sizes. The base image is build using 
packer+QEMU managed as code. Then written using "dd" and LVM partitions 
expanded without needing to go single-user or take the system offline. 
This method is appealling because it allows to pre-populate /home with 
some small amount of data; SSH keys etc.

For the case that started this thread, we just wiped the filesystem and 
made a new one at the target size of 32Gb.

> Even if the blocksize isn't 1k, when a file system is shrunk
[...more on shrinking]

Many thanks,

-- 
Mark

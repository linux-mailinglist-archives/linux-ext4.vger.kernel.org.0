Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D7741EEAB
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 15:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhJANhZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Oct 2021 09:37:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33891 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231416AbhJANhZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Oct 2021 09:37:25 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 191DZaq2027635
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Oct 2021 09:35:36 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1691B15C34A8; Fri,  1 Oct 2021 09:35:36 -0400 (EDT)
Date:   Fri, 1 Oct 2021 09:35:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Alok Jain <jain.alok103@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: Issue with extension of ext4 filesystem on Rhel7
Message-ID: <YVcOqNktN4GgFFab@mit.edu>
References: <CAG-6nk9DKKw2RHiXx_kWN1B5xcTrctTCypUPaicaaW1Ag0jDzw@mail.gmail.com>
 <81899623-90FE-4AFA-AAB6-5ABB21903CBB@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81899623-90FE-4AFA-AAB6-5ABB21903CBB@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 30, 2021 at 11:52:20PM -0600, Andreas Dilger wrote:
> On Sep 30, 2021, at 23:43, Alok Jain <jain.alok103@gmail.com> wrote:
> > 
> > I have a problem while extending the ext4 filesystem on my block
> > device which was 12Tb now extended to 32tb. I uses growpart then
> > e2fsck followed by resize which failed, Any idea how to address
> > this?
> > 
> > [root@prod-dev1 ~]# resize2fs /dev/sdj1
> > 
> > resize2fs 1.42.9 (28-Dec-2013)
> > 
> > resize2fs: New size too large to be expressed in 32 bits
> > 
> 
> Firstly, you should run with a newer version of e2fsprogs. That version
> is 8 years old and is missing a lot of bug fixes. 
> 
> Secondly, I don't think it is possibly to resize over 16TiB for a filesystem that
> started life smaller than 16TiB due to missing the "64-bit" feature, among
> others.

More modern versions of resize2fs do have the -b option, which will
reorganize the file system to support the 64-bit feature.  HOWEVER,
this feature is not used very often, and may have bugs, and many
companies who support Enterprise Linux Distributions do not support
changing file system features using resize2fs or tune2fs on existing
file systems, simply because the quality control efforts they would
need to do before they would be willing to stand behind that feature
is more than they think it is worth.

In addition, you will tend to get much better performance if you
create a freshly formatted file system with the modern features that
are needed, and then copy the data over.

Finally, in addtion to e2fsprogs 1.42.9 being Very, Very Old, if you
are using such a prehistoric version of e2fsprogs, it's likely that
the Linux kernel, and other portions of your Linux userspace, are
antedeluvian as well.  That means not only are you missing bug fixes,
you are likely missing many security bug fixes as well.

So I'd strongly suggest that you upgrade your entire Linux
distribution to something more modern, and not just e2fsprogs.  In
particular, there have been many resize2fs bugs that were fixed since
1.42.9, and so I would not recommend any resize operation until you've
upgraded your software (especially off-line resizes such as that which
would be required to use resize2fs -b).

> Given that you have 20TB of free space, you should copy your 12TB
> of data to a newly-formatted 20TB filesystem, and then resize that once
> the original one is no longer needed. Not only does that avoid the resize
> issue, but also gives you a backup of the original data for a while.

And if you think it's too expensive to have the swing space necessary
to do the backup, I'd gently ask you to consider how much your 12TB of
data is worth to you....  and how much your time might be worth if you
have to reconstruct it if it were to get lost.  Which is why regular
backups is always a good idea.

					- Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C4C287EAF
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgJHW2O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 18:28:14 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:53841 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgJHW2O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 18:28:14 -0400
Received: from localhost (unknown [67.5.25.97])
        (Authenticated sender: josh@joshtriplett.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 755C5100006;
        Thu,  8 Oct 2020 22:28:07 +0000 (UTC)
Date:   Thu, 8 Oct 2020 15:28:05 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201008222805.GB45658@localhost>
References: <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <F9799E9E-6AC8-4C66-B6C6-31CDFA8F55A6@dilger.ca>
 <20201008191231.GA44285@localhost>
 <FEB46ECD-BE83-41E7-B765-ACD310823BB3@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FEB46ECD-BE83-41E7-B765-ACD310823BB3@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 08, 2020 at 01:25:57PM -0600, Andreas Dilger wrote:
> On Oct 8, 2020, at 1:12 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > On Wed, Oct 07, 2020 at 08:57:12PM -0600, Andreas Dilger wrote:
> >> I *do* think that inline_data is an under-appreciated feature that I
> >> would be happy to see some improvements with.  I don't think that small
> >> files are a niche use case, and if we can clean up the inline_data code
> >> to work with 128-byte inodes I'm not against that, even though I'm not
> >> going to use that combination of features myself.
> > 
> > I'd love to see that happen. At the time, it seemed like too large of a
> > change to block on, which is why I ended up deciding to switch to
> > 256-byte inodes.
> 
> Does that mean you are using inline_data with 256-byte inodes?

I am, yes, and it mostly works great. I've hit zero issues with it in
the filesystems I'm generating.

> That would also be good to know, since there haven't been any
> well-known users of this feature so far (AFAIK).  Since you are using
> this in a read-only manner, you won't hit the one know issue when an
> inline_data inode is extended to use an external block that may
> temporarily leave the inode in an inconsistent state.

I've run into a few other issues with it in other tools, as well. mke2fs
with inline_data generates invalid files given xattrs:
https://lore.kernel.org/linux-ext4/20200926102512.GA11386@localhost/T/#u

And extlinux doesn't like inline_data at all:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=971002

I'll report any other issues I run into using inline_data. I agree that
it's deeply underappreciated.

- Josh

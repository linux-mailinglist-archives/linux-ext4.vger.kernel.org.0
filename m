Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA137287C20
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Oct 2020 21:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgJHTMk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Oct 2020 15:12:40 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:43797 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJHTMk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Oct 2020 15:12:40 -0400
Received: from localhost (unknown [67.5.25.97])
        (Authenticated sender: josh@joshtriplett.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4603110000B;
        Thu,  8 Oct 2020 19:12:34 +0000 (UTC)
Date:   Thu, 8 Oct 2020 12:12:31 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201008191231.GA44285@localhost>
References: <20201005173639.GA2311765@magnolia>
 <20201006003216.GB6553@localhost>
 <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <F9799E9E-6AC8-4C66-B6C6-31CDFA8F55A6@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F9799E9E-6AC8-4C66-B6C6-31CDFA8F55A6@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 07, 2020 at 08:57:12PM -0600, Andreas Dilger wrote:
> On Oct 7, 2020, at 2:14 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > If those aren't the right way to express that, I could potentially
> > adapt. I had a similar such conversation on linux-ext4 already (about
> > inline data with 128-bit inodes), which led to me choosing to abandon
> > 128-byte inodes rather than try to get ext4 to support what I wanted
> > with them, because I didn't want to be disruptive to ext4 for a niche
> > use case. In the particular case that motivated this thread, what I was
> > doing already worked in previous kernels, and it seemed reasonable to
> > ask for it to continue to work in new kernels, while preserving the
> > newly added checks in the new kernels.
> 
> This was discussed in the "Inline data with 128-byte inodes?" thread
> back in May.  While Jan was not necessarily in favour of this, I was
> actually OK with improving the ext4 code to handle this case better,
> since it would (at minimum) clean up ext4 to make a clear separation
> of how it is detecting data in the i_block[] array and the system.data
> xattr, and I don't think it added any complexity to the code.
> 
> I even posted a WIP patch to that effect, but didn't get a response back:
> https://marc.info/?l=linux-ext4&m=158863275019187

My apologies, I thought I responded to that. It looks promising to me,
though I wouldn't have the bandwidth to take it to completion anytime
soon.

> I *do* think that inline_data is an under-appreciated feature that I
> would be happy to see some improvements with.  I don't think that small
> files are a niche use case, and if we can clean up the inline_data code
> to work with 128-byte inodes I'm not against that, even though I'm not
> going to use that combination of features myself.

I'd love to see that happen. At the time, it seemed like too large of a
change to block on, which is why I ended up deciding to switch to
256-byte inodes.

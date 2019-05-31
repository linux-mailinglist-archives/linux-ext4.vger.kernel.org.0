Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E64230FAC
	for <lists+linux-ext4@lfdr.de>; Fri, 31 May 2019 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfEaOLh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 May 2019 10:11:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53830 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726386AbfEaOLh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 May 2019 10:11:37 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4VEAJWw020207
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 May 2019 10:10:20 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C20DD420481; Fri, 31 May 2019 10:10:19 -0400 (EDT)
Date:   Fri, 31 May 2019 10:10:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: How to package e2scrub
Message-ID: <20190531141019.GC8123@mit.edu>
References: <20190529120603.xuet53xgs6ahfvpl@work>
 <20190529235948.GB3671@mit.edu>
 <20190530095907.GA29237@quack2.suse.cz>
 <20190530135155.GD2751@mit.edu>
 <20190531100713.GA14773@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531100713.GA14773@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 31, 2019 at 12:07:13PM +0200, Jan Kara wrote:
> On Thu 30-05-19 09:51:55, Theodore Ts'o wrote:
> > On Thu, May 30, 2019 at 11:59:07AM +0200, Jan Kara wrote:
> > > Yeah, my plan is to just not package cron bits at all since openSUSE / SLES
> > > support only systemd init anyway these days (and in fact our distro people
> > > want to deprecate cron in favor of systemd). I guess I'll split off the
> > > scrub bits into a separate sub-package (likely e2fsprogs will suggest
> > > installation of this sub-package) and the service will be disabled by
> > > default.
> > 
> > I'm not super-fond of extra sub-packages for their own sake, and the
> > extra e2scrub bits are small enough (about 32k?) that I don't believe
> > it justifies an extra sub-package; but that's a distribution-level
> > packaging decision, so it's certainly fine if we're not completely aligned.
> 
> Yes, size is not a big concern but the scrub bits require util-linux, lvm,
> and mailer to work correctly and I don't want to add these dependencies to
> stock e2fsprogs package because some minimal installations do not want e.g.
> lvm at all. Granted these are just scripts so I could get away with not
> requiring e.g. lvm at all but it seems user-unfriendly to leave it up to
> user to determine that his systemd-service fails due to missing packages.

So you're using an extra package to force the installation of the
necessary prerequisite packages, instead of the current approach where
we don't require them, but we just skip running the scrub if lvm and
util-linux are not present.  I think both approaches makes sense.

It's also a good point that we need to handle the case of a missing
sendmail intelligently.  It looks like we currently skip sending mail
at all in the cron case, and in the case systemd case, we'll spew a
warning (which won't get mailed since there's no sendmail, but it does
mean some extra lines in the logfile).  All of this being said, it's
not _completely_ useless to scrub without an mailer; we still mark the
file system as needing to be checked on the next boot.  But it's
another argument that we shouldn't enable the service by default.

For that reason, I'm not sure I'd want to force the installation of a
mailer, since someone might want to run e2scrub by hand, and
e2scrub_all every week w/o isn't a completely insane thing.  But we
certainly should handle that case gracefully.

     	     	      	      		- Ted

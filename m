Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D707D32CDF
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2019 11:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfFCJag (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 05:30:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:44646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbfFCJaf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 3 Jun 2019 05:30:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC46FAE5A;
        Mon,  3 Jun 2019 09:30:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5F31F1E3C24; Mon,  3 Jun 2019 11:30:32 +0200 (CEST)
Date:   Mon, 3 Jun 2019 11:30:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: How to package e2scrub
Message-ID: <20190603093032.GA27933@quack2.suse.cz>
References: <20190529120603.xuet53xgs6ahfvpl@work>
 <20190529235948.GB3671@mit.edu>
 <20190530095907.GA29237@quack2.suse.cz>
 <20190530135155.GD2751@mit.edu>
 <20190531100713.GA14773@quack2.suse.cz>
 <20190531141019.GC8123@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531141019.GC8123@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 31-05-19 10:10:19, Theodore Ts'o wrote:
> On Fri, May 31, 2019 at 12:07:13PM +0200, Jan Kara wrote:
> > On Thu 30-05-19 09:51:55, Theodore Ts'o wrote:
> > > On Thu, May 30, 2019 at 11:59:07AM +0200, Jan Kara wrote:
> > > > Yeah, my plan is to just not package cron bits at all since openSUSE / SLES
> > > > support only systemd init anyway these days (and in fact our distro people
> > > > want to deprecate cron in favor of systemd). I guess I'll split off the
> > > > scrub bits into a separate sub-package (likely e2fsprogs will suggest
> > > > installation of this sub-package) and the service will be disabled by
> > > > default.
> > > 
> > > I'm not super-fond of extra sub-packages for their own sake, and the
> > > extra e2scrub bits are small enough (about 32k?) that I don't believe
> > > it justifies an extra sub-package; but that's a distribution-level
> > > packaging decision, so it's certainly fine if we're not completely aligned.
> > 
> > Yes, size is not a big concern but the scrub bits require util-linux, lvm,
> > and mailer to work correctly and I don't want to add these dependencies to
> > stock e2fsprogs package because some minimal installations do not want e.g.
> > lvm at all. Granted these are just scripts so I could get away with not
> > requiring e.g. lvm at all but it seems user-unfriendly to leave it up to
> > user to determine that his systemd-service fails due to missing packages.
> 
> So you're using an extra package to force the installation of the
> necessary prerequisite packages, instead of the current approach where
> we don't require them, but we just skip running the scrub if lvm and
> util-linux are not present.  I think both approaches makes sense.
> 
> It's also a good point that we need to handle the case of a missing
> sendmail intelligently.  It looks like we currently skip sending mail
> at all in the cron case, and in the case systemd case, we'll spew a
> warning (which won't get mailed since there's no sendmail, but it does
> mean some extra lines in the logfile).  All of this being said, it's
> not _completely_ useless to scrub without an mailer; we still mark the
> file system as needing to be checked on the next boot.  But it's
> another argument that we shouldn't enable the service by default.
> 
> For that reason, I'm not sure I'd want to force the installation of a
> mailer, since someone might want to run e2scrub by hand, and
> e2scrub_all every week w/o isn't a completely insane thing.  But we
> certainly should handle that case gracefully.

Yeah, if the scripts can handle missing mailer and do something useful in
that case, I think I will switch the RPM dependency on postfix to just
Recommends and not Requires.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

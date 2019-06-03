Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4EAA32FB2
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2019 14:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFCMck (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 08:32:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCMcj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 3 Jun 2019 08:32:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C535D309266E;
        Mon,  3 Jun 2019 12:32:39 +0000 (UTC)
Received: from work (ovpn-204-95.brq.redhat.com [10.40.204.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 981A366845;
        Mon,  3 Jun 2019 12:32:38 +0000 (UTC)
Date:   Mon, 3 Jun 2019 14:32:35 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: How to package e2scrub
Message-ID: <20190603123235.ajoa4b54w75xvppu@work>
References: <20190529120603.xuet53xgs6ahfvpl@work>
 <20190529235948.GB3671@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529235948.GB3671@mit.edu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 03 Jun 2019 12:32:39 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 29, 2019 at 07:59:48PM -0400, Theodore Ts'o wrote:
> On Wed, May 29, 2019 at 02:06:03PM +0200, Lukas Czerner wrote:
> > Hi guys,
> > 
> > I am about to release 1.45.2 for Fedora rawhide, but I was thinking
> > about how to package the e2scrub cron job/systemd service.
> > 
> > I really do not like the idea of installing cron job and/or the service as
> > a part of regular e2fsprogs package. This can potentially really surprise
> > people in a bad way.
> > 
> > Note that I've already heard some complaints from debian users about the
> > systemd service being installed on their system after the e2fsprogs
> > update.
> 
> One of the reasons I deliberately decided to enable it for Debian
> Unstable was it was the best way to flush out the bugs.  :-)
> 
> Yeah, Debian Unstable users are my guinea pigs. :-)   Doesn't it work
> that way with Fedora and RHEL?  :-)
> 
> BTW, The complaints were mostly from e2scrub_all not working correctly
> if certain packages weren't installed, or if the LVM package was
> installed, but there were no LVM volumes present, etc.  The other
> complaint I got was when there was no free space for the snapshot.
> I'm kind of hopeful that I've gotten them all at this point, but we'll
> see....

Yeah, I've heard from two people and it was all about the service being
enabled by default when installing/updating e2fsprogs which for them was
very much unexpected. They were the types of people what want to have as
much controll as they can so they were annoyed by that and immediatelly
disabled the service :)

> 
> > What I am going to do is to split the systemd service into a separate
> > package and I'd like to come to some agreement about the name of the
> > package so that we can have the same name across distributions (at least
> > Fedora/Debian/Suse).
> 
> Hmm.... what keeping the service as part of the e2fsprogs package, but
> then not enabling out of the box.  That is, require that user run:
> 
> systemctl enable e2scrub_all.timer
> 
> in order to actually get the feature?  (They can also disable it using
> "systemctl disable e2scrub_all.timer".)

That's the suggestion for rpm packages in fedora - not enabling services by
default. I am still not decided about this since installing separate service
package is strong enough of a hint that user probably want to enable it.

> 
> As far as the cron job is concerned, we could just leave the crontab
> entry commented out by default, and require that the user go in and
> edit the /etc/cron.d/e2scrub_all file if they want to enable it.  Not
> packaging it also seems fine; Debian's support for non-systemd
> configurations is at best marginal at this point, and while I'm not a
> fan of systemd, I'm also a realist...

Yeah, commenting out the crontab entry sounds like a good way to go
about it.

> 
> What do folks think?
> 
> 					- Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 479842E996
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2019 02:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfE3AAQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 May 2019 20:00:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47928 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726628AbfE3AAQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 May 2019 20:00:16 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4TNxn3B030108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 19:59:50 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C1401420481; Wed, 29 May 2019 19:59:48 -0400 (EDT)
Date:   Wed, 29 May 2019 19:59:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: How to package e2scrub
Message-ID: <20190529235948.GB3671@mit.edu>
References: <20190529120603.xuet53xgs6ahfvpl@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529120603.xuet53xgs6ahfvpl@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 29, 2019 at 02:06:03PM +0200, Lukas Czerner wrote:
> Hi guys,
> 
> I am about to release 1.45.2 for Fedora rawhide, but I was thinking
> about how to package the e2scrub cron job/systemd service.
> 
> I really do not like the idea of installing cron job and/or the service as
> a part of regular e2fsprogs package. This can potentially really surprise
> people in a bad way.
> 
> Note that I've already heard some complaints from debian users about the
> systemd service being installed on their system after the e2fsprogs
> update.

One of the reasons I deliberately decided to enable it for Debian
Unstable was it was the best way to flush out the bugs.  :-)

Yeah, Debian Unstable users are my guinea pigs. :-)   Doesn't it work
that way with Fedora and RHEL?  :-)

BTW, The complaints were mostly from e2scrub_all not working correctly
if certain packages weren't installed, or if the LVM package was
installed, but there were no LVM volumes present, etc.  The other
complaint I got was when there was no free space for the snapshot.
I'm kind of hopeful that I've gotten them all at this point, but we'll
see....

> What I am going to do is to split the systemd service into a separate
> package and I'd like to come to some agreement about the name of the
> package so that we can have the same name across distributions (at least
> Fedora/Debian/Suse).

Hmm.... what keeping the service as part of the e2fsprogs package, but
then not enabling out of the box.  That is, require that user run:

systemctl enable e2scrub_all.timer

in order to actually get the feature?  (They can also disable it using
"systemctl disable e2scrub_all.timer".)

As far as the cron job is concerned, we could just leave the crontab
entry commented out by default, and require that the user go in and
edit the /etc/cron.d/e2scrub_all file if they want to enable it.  Not
packaging it also seems fine; Debian's support for non-systemd
configurations is at best marginal at this point, and while I'm not a
fan of systemd, I'm also a realist...

What do folks think?

					- Ted

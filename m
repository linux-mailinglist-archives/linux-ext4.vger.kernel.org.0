Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7684C2F9EA
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2019 11:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfE3J7L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 May 2019 05:59:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:44128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfE3J7K (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 May 2019 05:59:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AFF7DAF59;
        Thu, 30 May 2019 09:59:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 346BC1E3C08; Thu, 30 May 2019 11:59:07 +0200 (CEST)
Date:   Thu, 30 May 2019 11:59:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: How to package e2scrub
Message-ID: <20190530095907.GA29237@quack2.suse.cz>
References: <20190529120603.xuet53xgs6ahfvpl@work>
 <20190529235948.GB3671@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529235948.GB3671@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 29-05-19 19:59:48, Theodore Ts'o wrote:
> On Wed, May 29, 2019 at 02:06:03PM +0200, Lukas Czerner wrote:
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
> 
> As far as the cron job is concerned, we could just leave the crontab
> entry commented out by default, and require that the user go in and
> edit the /etc/cron.d/e2scrub_all file if they want to enable it.  Not
> packaging it also seems fine; Debian's support for non-systemd
> configurations is at best marginal at this point, and while I'm not a
> fan of systemd, I'm also a realist...
> 
> What do folks think?

Yeah, my plan is to just not package cron bits at all since openSUSE / SLES
support only systemd init anyway these days (and in fact our distro people
want to deprecate cron in favor of systemd). I guess I'll split off the
scrub bits into a separate sub-package (likely e2fsprogs will suggest
installation of this sub-package) and the service will be disabled by
default.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

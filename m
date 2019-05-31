Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0367730C54
	for <lists+linux-ext4@lfdr.de>; Fri, 31 May 2019 12:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfEaKHP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 May 2019 06:07:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfEaKHP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 31 May 2019 06:07:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0C14AF4C;
        Fri, 31 May 2019 10:07:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5E5EE1E3C08; Fri, 31 May 2019 12:07:13 +0200 (CEST)
Date:   Fri, 31 May 2019 12:07:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: How to package e2scrub
Message-ID: <20190531100713.GA14773@quack2.suse.cz>
References: <20190529120603.xuet53xgs6ahfvpl@work>
 <20190529235948.GB3671@mit.edu>
 <20190530095907.GA29237@quack2.suse.cz>
 <20190530135155.GD2751@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530135155.GD2751@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 30-05-19 09:51:55, Theodore Ts'o wrote:
> On Thu, May 30, 2019 at 11:59:07AM +0200, Jan Kara wrote:
> > Yeah, my plan is to just not package cron bits at all since openSUSE / SLES
> > support only systemd init anyway these days (and in fact our distro people
> > want to deprecate cron in favor of systemd). I guess I'll split off the
> > scrub bits into a separate sub-package (likely e2fsprogs will suggest
> > installation of this sub-package) and the service will be disabled by
> > default.
> 
> I'm not super-fond of extra sub-packages for their own sake, and the
> extra e2scrub bits are small enough (about 32k?) that I don't believe
> it justifies an extra sub-package; but that's a distribution-level
> packaging decision, so it's certainly fine if we're not completely aligned.

Yes, size is not a big concern but the scrub bits require util-linux, lvm,
and mailer to work correctly and I don't want to add these dependencies to
stock e2fsprogs package because some minimal installations do not want e.g.
lvm at all. Granted these are just scripts so I could get away with not
requiring e.g. lvm at all but it seems user-unfriendly to leave it up to
user to determine that his systemd-service fails due to missing packages.

> Out of curiosity, were any of the complaints that you've heard gone
> beyond people who ran into the various e2scrub/e2scrub_all bugs?  I'm
> curious what their concerns were.

I didn't hear any complaints so far. But I have my doubts anyone actually
run that code so far - openSUSE Tumbleweed has limited userbase, we do
installs to btrfs by default, we don't propose LVM by default, and I didn't
enable the service files to run by default.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

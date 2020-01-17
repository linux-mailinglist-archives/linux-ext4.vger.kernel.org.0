Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D0141330
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2020 22:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgAQVeL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jan 2020 16:34:11 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59947 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726587AbgAQVeK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jan 2020 16:34:10 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00HLXq7b017717
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jan 2020 16:33:53 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 696124207DF; Fri, 17 Jan 2020 16:33:52 -0500 (EST)
Date:   Fri, 17 Jan 2020 16:33:52 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, adilger@dilger.ca,
        LTP List <ltp@lists.linux.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, chrubis <chrubis@suse.cz>,
        linux-ext4@vger.kernel.org
Subject: Re: LTP: statx06: FAIL: Birth time < before time
Message-ID: <20200117213352.GA481935@mit.edu>
References: <CA+G9fYuBdcZvE6VPm9i2=F0mK5u3j6Z+RHbFBQ1zh9qbN_4kaw@mail.gmail.com>
 <1555311261.2497849.1579281887353.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555311261.2497849.1579281887353.JavaMail.zimbra@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 17, 2020 at 12:24:47PM -0500, Jan Stancek wrote:
> > LTP syscalls statx06 test case getting failed from linux next 20200115
> > tag onwards on all x86_64, i386, arm and arm64 devices
> > 
> > Test output:
> > statx06.c:152: FAIL: Birth time < before time
> 
> [CC Theo & linux-ext4]
> 
> It's returning '0' in stx_btime for STATX_ALL or STATX_BTIME.
> 
> Looking at changes, I suspect:
>   commit 927353987d503b24e1813245563cde0c6167af6e
>   Author: Theodore Ts'o <tytso@mit.edu>
>   Date:   Thu Nov 28 22:26:51 2019 -0500
>     ext4: avoid fetching btime in ext4_getattr() unless requested
> 
> and that perhaps it should be instead...
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c8355f022e6e..6d76eb6d2e7f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5398,7 +5398,7 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
>         struct ext4_inode_info *ei = EXT4_I(inode);
>         unsigned int flags;
> 
> -       if ((query_flags & STATX_BTIME) &&
> +       if ((request_mask & STATX_BTIME) &&
>             EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime)) {
>                 stat->result_mask |= STATX_BTIME;
>                 stat->btime.tv_sec = ei->i_crtime.tv_sec;

Yep, nice catch!  Unfortunately we don't have a test like this in
xfstests, or I would have caught this sooner.

I've fixed this in the dev branch, so it will hopefully be fixed in
the future linux-next tgs.

							- Ted

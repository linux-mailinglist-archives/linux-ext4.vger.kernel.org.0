Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F828164A1D
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2020 17:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgBSQWt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Feb 2020 11:22:49 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45090 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbgBSQWt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Feb 2020 11:22:49 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01JGMg0M026172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 11:22:44 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 865C64211EF; Wed, 19 Feb 2020 11:22:42 -0500 (EST)
Date:   Wed, 19 Feb 2020 11:22:42 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] ext4: fix handling mount -o remount,nolazytime
Message-ID: <20200219162242.GI330201@mit.edu>
References: <158210399258.5335.3994877510070204710.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158210399258.5335.3994877510070204710.stgit@buzz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 19, 2020 at 12:19:52PM +0300, Konstantin Khlebnikov wrote:
> Tool "mount" from util-linux >= 2.27 knows about flag MS_LAZYTIME and
> handles options "lazytime" and "nolazytime" as fs-independent.
> 
> For ext4 it works for enabling lazytime: mount(MS_REMOUNT | MS_LAZYTIME),
> but does not work for disabling: mount(MS_REMOUNT).
> 
> Currently ext4 has performance issue in lazytime implementation caused by
> contention around inode_hash_lock in ext4_update_other_inodes_time().
> 
> Fortunately lazytime still could be disabled without unmounting by passing
> "nolazytime" as fs-specific mount option: mount(MS_REMOUNT, "nolazytime").
> But modern versions of tool "mount" cannot do that.
> 
> This patch fixes remount for modern tool and keeps backward compatibility.

Actually, if you are using ancient versions of mount that don't know
about MS_LAZYTIME, then when you do something like mount -o
remount,usrquota /dev/sdb" with your patch, it will disable
MS_LAZYTIME, which would be a backwards incompatible change.

So if we make this change, and there is someone who wants to use
lazytime on some ancient enterprise linux system which is still using
an old version of util-linux, and then take a kernel with this change,
then it will result in a change in the behavior they will see.  The
good news is that RHEL 8 is using util-linux 2.32, but RHEL 7 is still
using util-linux 2.23.

Lazytime is not enabled by default, so this issue is really only a
problem for someone which explicitly enables lazytime using a newer
version of util-linux, and then disables lazytime with a newer version
of util-linux.  So the behaviour of a2fd66d069d8 ("ext4: set lazytime
on remount if MS_LAZYTIME is set by mount") was in fact an explicit
decision to do things in that way.

So maybe we might want to change things, assuming that it's unlikely
users will try to be running new kernels on ancient distros.  But I
really wouldn't want to add a Fixes tag, and I would want to make sure
this doesn't get backported to older kernels, since the change does
*not* keep backwards compatibility.

Unfortunately, it's not possible to do this without breaking
compatibility for at least some systems.  The question is whether or
not we think systems running util-linux less than 2.27 is something we
care about for new kernels.  Times may have changed since
a2fd66d069d8.

So I might be willing to take this patch (I invite comments from
others), but there will need to be a DO NOT BACKPORT warning in the
commit description.

Cheers,

						- Ted

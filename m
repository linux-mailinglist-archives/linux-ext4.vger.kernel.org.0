Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F52012300A
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2019 16:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfLQPUP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Dec 2019 10:20:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46490 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfLQPUO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Dec 2019 10:20:14 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihEdw-0005lt-Cj; Tue, 17 Dec 2019 15:20:12 +0000
Date:   Tue, 17 Dec 2019 15:20:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 02/17] ext4: Add fs parameter description
Message-ID: <20191217152012.GY4203@ZenIV.linux.org.uk>
References: <20191106101457.11237-1-lczerner@redhat.com>
 <20191106101457.11237-3-lczerner@redhat.com>
 <20191217004419.GA6833@ZenIV.linux.org.uk>
 <20191217121956.amsymslmuoy6kzu4@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217121956.amsymslmuoy6kzu4@work>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 17, 2019 at 01:19:56PM +0100, Lukas Czerner wrote:
> On Tue, Dec 17, 2019 at 12:44:19AM +0000, Al Viro wrote:
> > On Wed, Nov 06, 2019 at 11:14:42AM +0100, Lukas Czerner wrote:
> > > +	fsparam_string_empty
> > > +			("usrjquota",		Opt_usrjquota),
> > > +	fsparam_string_empty
> > > +			("grpjquota",		Opt_grpjquota),
> > 
> > Umm...  That makes ...,usrjquota,... equivalent to ...,usrjquota=,...
> > unless I'm misreading the series.  Different from mainline, right?
> 
> Unfortunatelly yes, I do not think this is a problem, but if you have a
> solution within the new mount api framework I am happy to use it.

Er...  Dump the fsparam_string_empty() use and instead of your
+       if (token == Opt_usrjquota) {
+               if (result.negated)
+                       return clear_qf_name(sb, USRQUOTA);
+               else
+                       return set_qf_name(sb, USRQUOTA, param);
do
+       if (token == Opt_usrjquota) {
+               if (!param->string[0])
+                       return clear_qf_name(sb, USRQUOTA);
+               else
+                       return set_qf_name(sb, USRQUOTA, param);
with the same for grpjquota?

> > > +	fsparam_bool	("barrier",		Opt_barrier),
> > > +	fsparam_flag	("nobarrier",		Opt_nobarrier),
> > 
> > That's even more interesting.  Current mainline:
> > 		barrier		OK, sets EXT4_MOUNT_BARRIER
> > 		barrier=0	OK, sets EXT4_MOUNT_BARRIER
> > 		barrier=42	OK, sets EXT4_MOUNT_BARRIER
> > 		barrier=yes	error
> > 		barrier=no	error
> > 		nobarrier	OK, clears EXT4_MOUNT_BARRIER
> > Unless I'm misreading your series, you get
> > 		barrier		error
> 
> Not really, this seems to be working as expected. Assuming that this
> didn't change since 5.4.0-rc6. I does make sense to me that specifying
> bool type parameter without any options would express "true".
> 
> 
> > 		barrier=0	OK, sets EXT4_MOUNT_BARRIER
> 
> 
> > 		barrier=42	error
> > 		barrier=yes	OK, sets EXT4_MOUNT_BARRIER
> > 		barrier=no	OK, sets EXT4_MOUNT_BARRIER
> 
> Those three are different, just because of how param_book() work. I do
> not really see a problem with it, but if we want to keep it exactly the
> same as current mainline it would be difficult with how the current api
> works. Any suggestions ?

If fsparam_bool() doesn't do the right thing, perhaps it shouldn't be
used in the first place?  Or changed, for that matter - it's not as if
we had many users of that thing and the only in-tree one is definitely
breaking userland ABI.

In case of ext4, after rereading that code (and getting some sleep) the
current behaviour is, AFAICS to accept barrier | nobarrier | barrier=<number>
with the last case being equialent to nobarrier when number is 0 and barrier
in all other cases.  Is that an accurate description?

If so, I would prefer
	fsparam_flag_no("barrier", Opt_barrier),	// barrier | nobarrier
	fsparam_u32("barrier", Opt_barrier),		// barrier=<number>
as the solution, with fs_parse() having been taught to allow argument-bearing
and argument-less options with the same name, picking the right one.  That
way Opt_nobarrier gets removed as well...

I'll push a branch with that stuff later today; will post when it's out...

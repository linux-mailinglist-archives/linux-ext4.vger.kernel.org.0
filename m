Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B2112A355
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 18:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfLXRSV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 12:18:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47708 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfLXRSV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 12:18:21 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ijnp4-0004I4-Q7; Tue, 24 Dec 2019 17:18:18 +0000
Date:   Tue, 24 Dec 2019 17:18:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 02/17] ext4: Add fs parameter description
Message-ID: <20191224171818.GO4203@ZenIV.linux.org.uk>
References: <20191106101457.11237-1-lczerner@redhat.com>
 <20191106101457.11237-3-lczerner@redhat.com>
 <20191217004419.GA6833@ZenIV.linux.org.uk>
 <20191217121956.amsymslmuoy6kzu4@work>
 <20191217152012.GY4203@ZenIV.linux.org.uk>
 <20191217163432.diborehdrfkmfqxp@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217163432.diborehdrfkmfqxp@work>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 17, 2019 at 05:34:32PM +0100, Lukas Czerner wrote:

> > If so, I would prefer
> > 	fsparam_flag_no("barrier", Opt_barrier),	// barrier | nobarrier
> > 	fsparam_u32("barrier", Opt_barrier),		// barrier=<number>
> > as the solution, with fs_parse() having been taught to allow argument-bearing
> > and argument-less options with the same name, picking the right one.  That
> > way Opt_nobarrier gets removed as well...
> > 
> > I'll push a branch with that stuff later today; will post when it's out...
> 
> That would be great, thanks.

It took longer than I hoped, sorry ;-/  The current patchset is in
#untested.fs_parse; the really interesting part is up to
"turn fs_param_is_... into functions".

One surprising source of PITA around your patchset is ext4_show_options().
It pretty much forces you into keeping "no..." forms separate, even though
normally you could just say
	fsparam_flag_no("quota",               Opt_quota),
and get rid of Opt_noquota, etc.

If you keep that dependency, it'll need to be documented - right in
fs/ext4/super.c, to make sure we don't get "optimizing" followups breaking
the hell out of things.

Said that, I really doubt that token2str() is a good idea.  It might make
more sense to start with separating _ext4_show_options() from that
machinery.

Another thing is that all fsparam_bool() users are modifying user-visible
ABI; use fparam_flag_no() + fsparam_u32() with the same name and same
opt - that'll give you the existing behaviour.

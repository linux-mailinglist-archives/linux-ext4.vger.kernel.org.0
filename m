Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AD03F4791
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhHWJcX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 05:32:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48090 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhHWJcW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 05:32:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A4BE01FF95;
        Mon, 23 Aug 2021 09:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629711099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVBVWVcXjZICXYpFagpS5X9qD8aBwMKd+AGpsz6aB9g=;
        b=j7+upi4zVoE8VTBn6OE+Tah3eRozJ1I3PSuxZnIwsO7fezEQYtrIg+8t3kl46HhWw0x1Vy
        Am5drk4XziMt5PyUd3Z5E/9VvO7fjqSvykv2WygC6gChIdMhQbpCEGBim5qVNO0gNw8sx8
        a3MtslBZFVOKEJZkfGqfNj8/6C530NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629711099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVBVWVcXjZICXYpFagpS5X9qD8aBwMKd+AGpsz6aB9g=;
        b=CIcn6lD09PCRAkXaWW8UEg+PI8iPMj1336bPuaRJzuSfYB9CHVDYRxpXm3zoMCj72cyK4a
        zvKXkhNr29BqdVCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 90CA3A3B85;
        Mon, 23 Aug 2021 09:31:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 604411E3B01; Mon, 23 Aug 2021 11:31:39 +0200 (CEST)
Date:   Mon, 23 Aug 2021 11:31:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] libss: add newer libreadline.so.8 to dlopen path
Message-ID: <20210823093139.GA21467@quack2.suse.cz>
References: <20210820161502.8497-1-jack@suse.cz>
 <YSAZm8XAkXmW2VMC@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSAZm8XAkXmW2VMC@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 20-08-21 17:07:39, Theodore Ts'o wrote:
> On Fri, Aug 20, 2021 at 06:15:02PM +0200, Jan Kara wrote:
> > OpenSUSE Tumbleweed now has libreadline.so.8. Add it to the list of libs
> > to look for.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  lib/ss/get_readline.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Hum, why don't we look for libreadline.so BTW? That way we could save adding
> > now so version whenever one appears?
> 
> We do actually look for libreadline.so; it's right after
> libreadline.so.4:
> 
> > -#define DEFAULT_LIBPATH "libreadline.so.7:libreadline.so.6:libreadline.so.5:libreadline.so.4:libreadline.so:libedit.so.2:libedit.so:libeditline.so.0:libeditline.so"
> 
> However, we still need the libreadline.so.N in the path because at
> least for some distributions, they only install libreadline.so if you
> install the -dev package.  For example, in Debian, libreadline.so.8 is
> installed from the libreadline8 package, while libreadline.so is
> installed from the libreadline-dev package (and it's not guaranteed to
> be installed).

Oh, right. I've just checked and on my openSUSE machine libreadline.so is
also only provided by readline-devel package (which I have installed so I
didn't originally noticed). Thanks for explanation. I'm just wondering if
there isn't a better way to search for a suitable library...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656203F35E4
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 23:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbhHTVIZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 17:08:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46635 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239000AbhHTVIZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 17:08:25 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17KL7emg021755
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 17:07:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F1DF415C3DBB; Fri, 20 Aug 2021 17:07:39 -0400 (EDT)
Date:   Fri, 20 Aug 2021 17:07:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] libss: add newer libreadline.so.8 to dlopen path
Message-ID: <YSAZm8XAkXmW2VMC@mit.edu>
References: <20210820161502.8497-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820161502.8497-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 20, 2021 at 06:15:02PM +0200, Jan Kara wrote:
> OpenSUSE Tumbleweed now has libreadline.so.8. Add it to the list of libs
> to look for.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  lib/ss/get_readline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hum, why don't we look for libreadline.so BTW? That way we could save adding
> now so version whenever one appears?

We do actually look for libreadline.so; it's right after
libreadline.so.4:

> -#define DEFAULT_LIBPATH "libreadline.so.7:libreadline.so.6:libreadline.so.5:libreadline.so.4:libreadline.so:libedit.so.2:libedit.so:libeditline.so.0:libeditline.so"

However, we still need the libreadline.so.N in the path because at
least for some distributions, they only install libreadline.so if you
install the -dev package.  For example, in Debian, libreadline.so.8 is
installed from the libreadline8 package, while libreadline.so is
installed from the libreadline-dev package (and it's not guaranteed to
be installed).

Fortunately for Debian users, openssh-client depends on libedit2,
which means that even if they don't have libreadline-dev installed, we
fall back to using libedit.so.2, which does work.  So apparently no
one noticed that a problem with debugfs on Debian Bullseye (which
ships libreadline.so.8).

But I agree that we should add libreadline.so.8 to the search path.

Thanks, applied.

      	    	    	       			- Ted

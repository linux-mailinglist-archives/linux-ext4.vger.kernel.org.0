Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9390A3D2FA9
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jul 2021 00:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhGVVgw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Jul 2021 17:36:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39787 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232024AbhGVVgv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Jul 2021 17:36:51 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16MMHGMV021590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 18:17:16 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3A54115C37C0; Thu, 22 Jul 2021 18:17:16 -0400 (EDT)
Date:   Thu, 22 Jul 2021 18:17:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Remy Card <card@masi.ibp.fr>,
        "David S. Miller" <davem@caip.rutgers.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] fs: ext4: namei: trivial: Fix a couple of small
 whitespace issues
Message-ID: <YPnubECqbX47V3TK@mit.edu>
References: <20210520125558.3476318-1-lee.jones@linaro.org>
 <YPlYD1BXyjIgh++K@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPlYD1BXyjIgh++K@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 22, 2021 at 12:35:43PM +0100, Lee Jones wrote:
> On Thu, 20 May 2021, Lee Jones wrote:
> 
> > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > Cc: Remy Card <card@masi.ibp.fr>
> > Cc: "David S. Miller" <davem@caip.rutgers.edu>
> > Cc: linux-ext4@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  fs/ext4/namei.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Any news on this please?
> 
> Would you like me to submit a [RESEND]?

Please don't send "checkpatch.pl --file" patches for the ext4 file
system; if you must, please focus on files in the drivers directory,
where they are more welcome.  If developers are making changes to a
file, fixing some checkpatch.pl whines is fine, but white-sapace only
changes just obfuscates "git blame" code archology, and so the costs
far outwieghs the costs.  "Fix" is also not the right verb to use.
For more information please see [1].

[1] https://gist.github.com/17twenty/8154928

If you are looking for subtantive ways of contributing to the ext4
file system, feel free to look at various syzbot warnings[2] and try
to figure out what is going on there.

[2] https://syzkaller.appspot.com/upstream

(In some cases, the syzbot complaint has already been fixed, and it's
just a matter of letting syzbot knoww that it has since been fixed by
a particular commit.  See [3] for more details.)

[3] https://github.com/google/syzkaller/blob/master/docs/syzbot.md

Cheers,

						- Ted

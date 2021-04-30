Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D191E36F498
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Apr 2021 05:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhD3Dpn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 23:45:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35789 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229591AbhD3Dpm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 23:45:42 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13U3iX2U017640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 23:44:33 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 00C4215C39C4; Thu, 29 Apr 2021 23:44:32 -0400 (EDT)
Date:   Thu, 29 Apr 2021 23:44:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        akpm@linux-foundation.org, peterz@infradead.org, axboe@kernel.dk,
        pmladek@suse.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fill_super
Message-ID: <YIt9IFY4Xsf5K+eZ@mit.edu>
References: <20210428172828.12589-1-paskripkin@gmail.com>
 <3c3877a4-fef2-9e24-f99f-2ecc46deb7e4@oracle.com>
 <20210429143354.418248a7@gmail.com>
 <YIrnPXJo/n68NrQs@mit.edu>
 <20210429230956.6ad23897@gmail.com>
 <YIsn+JToAkPqDPq5@mit.edu>
 <20210430010547.38f27e39@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430010547.38f27e39@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 30, 2021 at 01:05:47AM +0300, Pavel Skripkin wrote:
> > out of the thread function.  That means hanging struct mmpd_data off
> > the struct ext4_sb_info structure, and then adding a function like
> > this to fs/ext4/mmp.c
> > 
> > static void ext4_stop_mmpd(struct ext4_sb_info *sbi)

That should "extern void ...", since it will be called from
fs/ext4/super.c.  I had originally was thinking to put this function
in fs/ext4/super.c, but from the perspective of keeping the MMP code
in the same source file, it probably makes sense to keep this function
with the other MMP functions.

> > {
> > 	if (sbi->s_mmp_tsk) {
> > 		kthread_stop(sbi->s_mmp_tsk);
> > 		brelse(sbi->s_mmp_data->bh);
> > 		kfree(sbi->s_mmp_data);
> > 		sbi->s_mmp_data = NULL;
> > 		sbi->s_mmp_tsk = NULL;
> > 	}
> > }
> > 
> > Basically, just move all of the cleanup so it is done after the
> > kthread is stopped, so we don't have to do any fancy error checking.
> > We just do it unconditionally.

Cheers,

						- Ted
						

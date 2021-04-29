Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B400E36F234
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 23:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhD2VmW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 17:42:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55614 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237191AbhD2VmW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 17:42:22 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13TLfCYp030461
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 17:41:13 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B3F0815C39C4; Thu, 29 Apr 2021 17:41:12 -0400 (EDT)
Date:   Thu, 29 Apr 2021 17:41:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        akpm@linux-foundation.org, peterz@infradead.org, axboe@kernel.dk,
        pmladek@suse.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fill_super
Message-ID: <YIsn+JToAkPqDPq5@mit.edu>
References: <20210428172828.12589-1-paskripkin@gmail.com>
 <3c3877a4-fef2-9e24-f99f-2ecc46deb7e4@oracle.com>
 <20210429143354.418248a7@gmail.com>
 <YIrnPXJo/n68NrQs@mit.edu>
 <20210429230956.6ad23897@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429230956.6ad23897@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 29, 2021 at 11:09:56PM +0300, Pavel Skripkin wrote:
> > we will exit with -ENOMEM.  So at the very least all callers of
> > kthread_stop() also need to check for -ENOMEM as well as -EINTR ---
> > or, be somehow sure that the thread function was successfully called
> > and started.  In this particular case, the ext4 mount code had just
> > started the kmmpd thread, and then detected that something else had
> > gone wrong, and failed the mount before the kmmpd thread ever had a
> > chance to run.
> 
> There is a small problem about -ENOMEM...

What I'd suggest is that we simply move

> exit_thread:
> 	EXT4_SB(sb)->s_mmp_tsk = NULL;
> 	kfree(data);
> 	brelse(bh);
> 	return retval;
> }

out of the thread function.  That means hanging struct mmpd_data off
the struct ext4_sb_info structure, and then adding a function like
this to fs/ext4/mmp.c

static void ext4_stop_mmpd(struct ext4_sb_info *sbi)
{
	if (sbi->s_mmp_tsk) {
		kthread_stop(sbi->s_mmp_tsk);
		brelse(sbi->s_mmp_data->bh);
		kfree(sbi->s_mmp_data);
		sbi->s_mmp_data = NULL;
		sbi->s_mmp_tsk = NULL;
	}
}

Basically, just move all of the cleanup so it is done after the
kthread is stopped, so we don't have to do any fancy error checking.
We just do it unconditionally.

					- Ted

P.S.  Actually, we could drop the struct mmpd_data altogether, and
just hang the buffer head as sbi->s_mmp_bh.  Then we can just pass the
struct super * as the private pointer to kmmpd().


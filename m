Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9AE3FC1B7
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Aug 2021 06:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhHaEB2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Aug 2021 00:01:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57788 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229524AbhHaEB2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Aug 2021 00:01:28 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17V40Nop011278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Aug 2021 00:00:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7D3C815C3E7E; Tue, 31 Aug 2021 00:00:23 -0400 (EDT)
Date:   Tue, 31 Aug 2021 00:00:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, guoqing.jiang@linux.dev,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH V4 4/5] ext4: get discard out of jbd2 commit kthread
 contex
Message-ID: <YS2pV1L/MM4jvlVf@mit.edu>
References: <20210830075246.12516-1-jianchao.wan9@gmail.com>
 <20210830075246.12516-5-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830075246.12516-5-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 30, 2021 at 03:52:45PM +0800, Wang Jianchao wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> Right now, discard is issued and waited to be completed in jbd2
> commit kthread context after the logs are committed. When large
> amount of files are deleted and discard is flooding, jbd2 commit
> kthread can be blocked for long time. Then all of the metadata
> operations can be blocked to wait the log space.
> 
> One case is the page fault path with read mm->mmap_sem held, which
> wants to update the file time but has to wait for the log space.
> When other threads in the task wants to do mmap, then write mmap_sem
> is blocked. Finally all of the following read mmap_sem requirements
> are blocked, even the ps command which need to read the /proc/pid/
> -cmdline. Our monitor service which needs to read /proc/pid/cmdline
> used to be blocked for 5 mins.
> 
> This patch frees the blocks back to buddy after commit and then do
> discard in a async kworker context in fstrim fashion, namely,
>  - mark blocks to be discarded as used if they have not been allocated
>  - do discard
>  - mark them free
> After this, jbd2 commit kthread won't be blocked any more by discard
> and we won't get NOSPC even if the discard is slow or throttled.
> 
> Link: https://marc.info/?l=linux-kernel&m=162143690731901&w=2
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

I had applied the V3 version of this patch series for testing
purposes, and then accidentally included in the dev branch.  So an
earlier version of this patch series has been in the ext4 git tree for
a while.  I've done a comparison between the V3 and V4 patches, and
aside from a minor whitespace change in patch #1, the only patch that
had any real changes was this one (#4).  Patch #5 was also added in
the V4 series.

So I've edited the ext4 git tree using rebase magic, replacing patch
#4 and adding patch #5.

In other words, this is a slightly more complicated, "Thanks,
applied".  :-)

					- Ted

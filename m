Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64587386BB3
	for <lists+linux-ext4@lfdr.de>; Mon, 17 May 2021 22:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbhEQUxd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 May 2021 16:53:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60428 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237148AbhEQUxd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 May 2021 16:53:33 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 14HKqATe012357
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 May 2021 16:52:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 650BB420119; Mon, 17 May 2021 16:52:10 -0400 (EDT)
Date:   Mon, 17 May 2021 16:52:10 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: get discard out of jbd2 commit kthread
Message-ID: <YKLXev4cjeRuGRqd@mit.edu>
References: <53146e54-af36-0c32-cad8-433460461237@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53146e54-af36-0c32-cad8-433460461237@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 17, 2021 at 11:57:09AM +0800, Wang Jianchao wrote:
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
> This patch moves the discard out of jbd2 kthread context and do it
> in kworker. And drain the kwork when cannot get space in mb buddy.
> This is done out of jbd2 handle and won't block the commit process.
> After that, we could use blk-wbt or other method to throttle the
> discard and needn't to worry it block the jbd2 commit kthread any
> more.

Wouldn't be much simpler to do something like this?

		if (discard_bio) {
-			submit_bio_wait(discard_bio);
-			bio_put(discard_bio);
+			submit_bio(discard_bio);
		}


We're throwing away the return value from submit_bio_wait(), so
there's no real need to wait for I/O to complete so we can fetch the
I/O status.

That way we don't need to move all of this to a kworker context.

     	    	       	       	   - Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6703BDADA
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhGFQGp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 12:06:45 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41982 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229811AbhGFQGn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 12:06:43 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 166G3mOc032309
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jul 2021 12:03:49 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3C2CD15C3CC6; Tue,  6 Jul 2021 12:03:48 -0400 (EDT)
Date:   Tue, 6 Jul 2021 12:03:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ye Bin <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: Fix use-after-free about sbi->s_mmp_tsk
Message-ID: <YOR+5AY2owcnhrgy@mit.edu>
References: <20210629143603.2166962-1-yebin10@huawei.com>
 <20210629143603.2166962-2-yebin10@huawei.com>
 <20210705111548.GD15373@quack2.suse.cz>
 <YONtEGojq7LcXnuC@mit.edu>
 <20210706111137.GA7922@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706111137.GA7922@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 06, 2021 at 01:11:37PM +0200, Jan Kara wrote:
> > --- a/fs/ext4/mmp.c
> > +++ b/fs/ext4/mmp.c
> > @@ -157,6 +157,17 @@ static int kmmpd(void *data)
> >  	       sizeof(mmp->mmp_nodename));
> >  
> >  	while (!kthread_should_stop()) {
> > +		if (!(le32_to_cpu(es->s_feature_incompat) &
> > +		    EXT4_FEATURE_INCOMPAT_MMP)) {
> 
> We can probably use ext4_has_feature_mmp() macro when changing this?

Ack, I'll make that change.

> > +		if (sb_rdonly(sb)) {
> > +			if (!kthread_should_stop())
> > +				schedule_timeout_interruptible(HZ);
> 
> Cannot this effectively block remount RO for 1s when we wait for kmmpd to
> exit? I think doing 'break' when we detected RO super is fine. We'll write
> the mmp block and then wait for kthread_should_stop() condition as in any
> other abort case. Am I missing something?

Yeah, we do want to update the mmp block when remounting the file
system read-only.  So breaking out to exit is the right thing to do
here.

> > +wait_to_exit:
> > +	while (!kthread_should_stop())
> > +		schedule();
> 
> This makes me a bit nervous that we could unnecessarily burn CPU for
> potentially a long time (e.g. if somebody uses tune2fs to disable MMP, we
> would be sitting in this loop until the fs in remounted / unmounted). So
> maybe we should have something like:
> 
> 	while (!kthread_should_stop()) {
> 		set_task_state(TASK_INTERRUPTIBLE);
> 		if (!kthread_should_stop())
> 			schedule();
> 	}
> 
> This should safely synchronize with (and not miss wakeup from)
> kthread_stop() since that first sets KTHREAD_SHOULD_STOP and after that
> calls wake_up_process().

Yep, good catch.  I'll fix this and send out revised patch.

     	  	       	   	    - Ted

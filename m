Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0013A511CEC
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Apr 2022 20:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbiD0Q1u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Apr 2022 12:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242936AbiD0Q1B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Apr 2022 12:27:01 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9D266DB7
        for <linux-ext4@vger.kernel.org>; Wed, 27 Apr 2022 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1651076512; x=1682612512;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=Cbg75PUlXZajnRxt3xMCnhVcFuPLrtdlN4tn+AcY6xI=;
  b=c1HLNC1wvUEKlQgmJVyjh9Miw02XPBzl1FqX8bxGqWbr9Nq6syTmXXlN
   PCU9qfS4qgTj1PyKRF0jp/Yq2Yu7S3lQd7sB9p/ZGXUAm+jCuJ/0FILzl
   9V/9PGQxZlPCJqJ+RkffWDcvYblhDIk/Ao4Enm6OJC95Wk2u7fLYsque+
   Y=;
X-IronPort-AV: E=Sophos;i="5.90,293,1643673600"; 
   d="scan'208";a="196791255"
Subject: Re: [PATCH] jbd2: Fix use-after-free of transaction_t race
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 27 Apr 2022 16:21:48 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-2d7489a4.us-east-1.amazon.com (Postfix) with ESMTPS id 57982951B2;
        Wed, 27 Apr 2022 16:21:47 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Wed, 27 Apr 2022 16:21:47 +0000
Received: from localhost (10.43.161.193) by EX13d01UWA002.ant.amazon.com
 (10.43.160.74) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 27 Apr
 2022 16:21:46 +0000
Date:   Wed, 27 Apr 2022 09:21:46 -0700
From:   Samuel Mendoza-Jonas <samjonas@amazon.com>
To:     Jan Kara <jack@suse.cz>
CC:     Ritesh Harjani <riteshh@linux.ibm.com>,
        <linux-ext4@vger.kernel.org>,
        <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>
Message-ID: <20220427162146.3nj3czri4krdpy3c@u46989501580c5c.ant.amazon.com>
References: <948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com>
 <20220426183124.phrwsl77bch5uljx@u46989501580c5c.ant.amazon.com>
 <20220427111726.3wdyxbqoxs7skdzf@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220427111726.3wdyxbqoxs7skdzf@quack3.lan>
X-Originating-IP: [10.43.161.193]
X-ClientProxiedBy: EX13D10UWA003.ant.amazon.com (10.43.160.248) To
 EX13d01UWA002.ant.amazon.com (10.43.160.74)
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 27, 2022 at 01:17:26PM +0200, Jan Kara wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Tue 26-04-22 11:31:24, Samuel Mendoza-Jonas wrote:
> > On Thu, Feb 10, 2022 at 09:07:11PM +0530, Ritesh Harjani wrote:
> > > jbd2_journal_wait_updates() is called with j_state_lock held. But if
> > > there is a commit in progress, then this transaction might get committed
> > > and freed via jbd2_journal_commit_transaction() ->
> > > jbd2_journal_free_transaction(), when we release j_state_lock.
> > > So check for journal->j_running_transaction everytime we release and
> > > acquire j_state_lock to avoid use-after-free issue.
> > >
> > > Fixes: 4f98186848707f53 ("jbd2: refactor wait logic for transaction updates into a common function")
> > > Reported-and-tested-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> >
> > Hi Ritesh,
> >
> > Looking at the refactor in the commit this fixes, I believe the same
> > issue is present prior to the refactor, so this would apply before 5.17
> > as well.
> > I've posted a backport for 4.9-4.19 and 5.4-5.16 to stable here:
> > https://lore.kernel.org/stable/20220426182702.716304-1-samjonas@amazon.com/T/#t
> >
> > Please have a look and let me know if you agree.
> 
> Actually the refactor was indeed the cause for use-after-free. The original
> code in jbd2_journal_lock_updates() was like:
> 
>        /* Wait until there are no running updates */
>        while (1) {
>                transaction_t *transaction = journal->j_running_transaction;
> 
>                if (!transaction)
>                        break;
>                spin_lock(&transaction->t_handle_lock);
>                prepare_to_wait(&journal->j_wait_updates, &wait,
>                                TASK_UNINTERRUPTIBLE);
>                if (!atomic_read(&transaction->t_updates)) {
>                        spin_unlock(&transaction->t_handle_lock);
>                        finish_wait(&journal->j_wait_updates, &wait);
>                        break;
>                }
>                spin_unlock(&transaction->t_handle_lock);
>                write_unlock(&journal->j_state_lock);
>                schedule();
>                finish_wait(&journal->j_wait_updates, &wait);
>                write_lock(&journal->j_state_lock);
>        }
> 
> So you can see the code was indeed careful enough to not touch
> t_handle_lock after sleeping. The code in jbd2_journal_commit_transaction()
> did touch t_handle_lock but there it didn't matter because nobody else
> besides the task running jbd2_journal_commit_transaction() can free the
> transaction...
> 

Right you are, I misinterpreted the interaction with
jbd2_journal_commit_transaction(). Thanks for verifying, I'll follow up
stable to disregard those backports.

Cheers,
Sam

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

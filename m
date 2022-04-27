Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4F15115ED
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Apr 2022 13:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiD0LUj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Apr 2022 07:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiD0LUi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Apr 2022 07:20:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E234C2D1C8
        for <linux-ext4@vger.kernel.org>; Wed, 27 Apr 2022 04:17:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 955FD210EF;
        Wed, 27 Apr 2022 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651058246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xuh17dHNiLL0CJDY0S5w4/S2H5s6yyKw+CHfPIBYCmo=;
        b=IpzEq5e3ee2wvILTBbTgdKlSRhWfnmuvQ+MiGbmNYgZ7vTWZt4PNI4alyY6Xc/hR/HQgF/
        hNrLsB6vA1tujP2Hd5HPEIAUyzafPZcfG5UbJG0Idtvmi6yZLbuSQQF3yQEvNIFggd78Q4
        G5iTcLZ1TGpN0uudQUBDAKQvKegWTfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651058246;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xuh17dHNiLL0CJDY0S5w4/S2H5s6yyKw+CHfPIBYCmo=;
        b=o4IyC2KH+CGQNfbwRph7sNnPp3cmVlvfoFra8DdzWHYNipLhx53jHohukLCY0e8/Ag9KQ2
        CqjZnWimUVlf9GAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 816AC2C141;
        Wed, 27 Apr 2022 11:17:26 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 33558A0620; Wed, 27 Apr 2022 13:17:26 +0200 (CEST)
Date:   Wed, 27 Apr 2022 13:17:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Samuel Mendoza-Jonas <samjonas@amazon.com>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
Subject: Re: [PATCH] jbd2: Fix use-after-free of transaction_t race
Message-ID: <20220427111726.3wdyxbqoxs7skdzf@quack3.lan>
References: <948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com>
 <20220426183124.phrwsl77bch5uljx@u46989501580c5c.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426183124.phrwsl77bch5uljx@u46989501580c5c.ant.amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 26-04-22 11:31:24, Samuel Mendoza-Jonas wrote:
> On Thu, Feb 10, 2022 at 09:07:11PM +0530, Ritesh Harjani wrote:
> > jbd2_journal_wait_updates() is called with j_state_lock held. But if
> > there is a commit in progress, then this transaction might get committed
> > and freed via jbd2_journal_commit_transaction() ->
> > jbd2_journal_free_transaction(), when we release j_state_lock.
> > So check for journal->j_running_transaction everytime we release and
> > acquire j_state_lock to avoid use-after-free issue.
> > 
> > Fixes: 4f98186848707f53 ("jbd2: refactor wait logic for transaction updates into a common function")
> > Reported-and-tested-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
> Hi Ritesh,
> 
> Looking at the refactor in the commit this fixes, I believe the same
> issue is present prior to the refactor, so this would apply before 5.17
> as well.
> I've posted a backport for 4.9-4.19 and 5.4-5.16 to stable here:
> https://lore.kernel.org/stable/20220426182702.716304-1-samjonas@amazon.com/T/#t
> 
> Please have a look and let me know if you agree.

Actually the refactor was indeed the cause for use-after-free. The original
code in jbd2_journal_lock_updates() was like:

       /* Wait until there are no running updates */
       while (1) {
               transaction_t *transaction = journal->j_running_transaction;

               if (!transaction)
                       break;
               spin_lock(&transaction->t_handle_lock);
               prepare_to_wait(&journal->j_wait_updates, &wait,
                               TASK_UNINTERRUPTIBLE);
               if (!atomic_read(&transaction->t_updates)) {
                       spin_unlock(&transaction->t_handle_lock);
                       finish_wait(&journal->j_wait_updates, &wait);
                       break;
               }
               spin_unlock(&transaction->t_handle_lock);
               write_unlock(&journal->j_state_lock);
               schedule();
               finish_wait(&journal->j_wait_updates, &wait);
               write_lock(&journal->j_state_lock);
       }

So you can see the code was indeed careful enough to not touch
t_handle_lock after sleeping. The code in jbd2_journal_commit_transaction()
did touch t_handle_lock but there it didn't matter because nobody else
besides the task running jbd2_journal_commit_transaction() can free the
transaction...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

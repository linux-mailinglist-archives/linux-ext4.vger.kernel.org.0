Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98950B3E4
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Apr 2022 11:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387251AbiDVJTV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Apr 2022 05:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445937AbiDVJTN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Apr 2022 05:19:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F272DD7;
        Fri, 22 Apr 2022 02:14:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0ADBF1F37B;
        Fri, 22 Apr 2022 09:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650618896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/Us7RSSwCeAHIIfY1ScQOueScZTDL2ahZa2WlmjXkQ=;
        b=EY7t55bhLh/s6WPstIAtba0p2I4u5qaiE/BtrMeRYsZeogxp/XjuYBt/RLaphMNErAE/0e
        tVjGhFe/HfAGzrdWH7sRVkJuQ6V0PQvtBh4TLmeFLVx1lSC3CaWMkotppGNpbTzHCG54+1
        POTxsRQJsXjV4wL4JEfA/rJJrsh013I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650618896;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/Us7RSSwCeAHIIfY1ScQOueScZTDL2ahZa2WlmjXkQ=;
        b=AEYWSHTOVVsWQHvRtHFdzq1CBpQ5m7pmo2GPoAtrXvwK1B5GaOOgdraTZmXgvZ3PNtd+t9
        oyy86Q926hzNgmAQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D4FDD2C14F;
        Fri, 22 Apr 2022 09:14:55 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 16CDEA0620; Fri, 22 Apr 2022 11:14:55 +0200 (CEST)
Date:   Fri, 22 Apr 2022 11:14:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     cuibixuan <cuibixuan@linux.alibaba.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>, mingo <mingo@redhat.com>,
        "yi.zhang" <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVEM=?= =?utf-8?Q?H?= -next] jbd2: use
 the correct print format
Message-ID: <20220422091455.rzr265lcht46gub3@quack3.lan>
References: <1647619000-17758-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20220321092503.liyi6eqrar52cc5n@quack3.lan>
 <df9b8f54-274d-404c-a698-c88a18849810.cuibixuan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9b8f54-274d-404c-a698-c88a18849810.cuibixuan@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

thanks for noticing. It is probably because this patch was not CCed neither
to ext4 development mailing list, nor to the ext4 maintainer. Added now.
Ted, can you please pick up this patch? Lore has it so b4, can pick it up
just fine. Thanks!

								Honza

On Fri 22-04-22 10:42:51, cuibixuan wrote:
> Hi, 
> This patch doesn't seem to be merged into the next branch.  :-)
> 
> Thanks,
> Bixuan Cui
> 
> On Fri 18-03-22 23:56:40, Bixuan Cui wrote:
> 
> > The print format error was found when using ftrace event:
> >     <...>-1406 [000] .... 23599442.895823: jbd2_end_commit: dev 252,8 transaction -1866216965 sync 0 head -1866217368
> >     <...>-1406 [000] .... 23599442.896299: jbd2_start_commit: dev 252,8 transaction -1866216964 sync 0
> > 
> > Print transaction and head with the unsigned format "%u" instead.
> > 
> > Fixes: 879c5e6b7cb4 ('jbd2: convert instrumentation from markers to tracepoints')
> > Signed-off-by: Bixuan Cui <cuibixuan@linux.alibaba.com>
> 
> Makes sense. Thanks for the fix. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>         Honza
> 
> > ---
> >  include/trace/events/jbd2.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
> > index a4dfe005983d..5be1aa1691fb 100644
> > --- a/include/trace/events/jbd2.h
> > +++ b/include/trace/events/jbd2.h
> > @@ -40,7 +40,7 @@ DECLARE_EVENT_CLASS(jbd2_commit,
> >   TP_STRUCT__entry(
> >    __field( dev_t, dev   )
> >    __field( char, sync_commit    )
> > -  __field( int, transaction    )
> > +  __field( tid_t, transaction    )
> >   ),
> >  
> >   TP_fast_assign(
> > @@ -49,7 +49,7 @@ DECLARE_EVENT_CLASS(jbd2_commit,
> >    __entry->transaction = commit_transaction->t_tid;
> >   ),
> >  
> > - TP_printk("dev %d,%d transaction %d sync %d",
> > + TP_printk("dev %d,%d transaction %u sync %d",
> >      MAJOR(__entry->dev), MINOR(__entry->dev),
> >      __entry->transaction, __entry->sync_commit)
> >  );
> > @@ -97,8 +97,8 @@ TRACE_EVENT(jbd2_end_commit,
> >   TP_STRUCT__entry(
> >    __field( dev_t, dev   )
> >    __field( char, sync_commit    )
> > -  __field( int, transaction    )
> > -  __field( int, head       )
> > +  __field( tid_t, transaction    )
> > +  __field( tid_t, head       )
> >   ),
> >  
> >   TP_fast_assign(
> > @@ -108,7 +108,7 @@ TRACE_EVENT(jbd2_end_commit,
> >    __entry->head  = journal->j_tail_sequence;
> >   ),
> >  
> > - TP_printk("dev %d,%d transaction %d sync %d head %d",
> > + TP_printk("dev %d,%d transaction %u sync %d head %u",
> >      MAJOR(__entry->dev), MINOR(__entry->dev),
> >      __entry->transaction, __entry->sync_commit, __entry->head)
> >  );
> > -- 
> > 2.19.1.6.gb485710b
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

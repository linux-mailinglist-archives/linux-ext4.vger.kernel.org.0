Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EED66240E
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jan 2023 12:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjAILUh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Jan 2023 06:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjAILUg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Jan 2023 06:20:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A801F140EF;
        Mon,  9 Jan 2023 03:20:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 523AE76AF7;
        Mon,  9 Jan 2023 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673263233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8l2x8IYnc4mIIGKCD2KQ71esJRmtX/fZkchd0gq1xRU=;
        b=Vkrw9nGcuksswnHMzcFwE6rx2PlJf/GwdpKr6YX3QEmP7S905yN9mXlUGMkK6Khy2jxUOR
        04gUqzIK1G4sgfM+AqvdiJdiVoGPrZnE7cmu7dlX8mXlTNnqO5Xfw8OIY+wf3+OvHX6QtP
        MB+IcQsOcXWFbvkfTm5HcEmTFE5PW5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673263233;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8l2x8IYnc4mIIGKCD2KQ71esJRmtX/fZkchd0gq1xRU=;
        b=M2yYrBNgtQhx8MElF+7qx1epx+CkymT2k5hS1P/7+fIHiFyv5B/Gv/7ItgZCaClgrsPJXC
        fUe8V4qhx4MQrhAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45106134AD;
        Mon,  9 Jan 2023 11:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YdDTEIH4u2PwPQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Jan 2023 11:20:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D1A31A0749; Mon,  9 Jan 2023 12:20:32 +0100 (CET)
Date:   Mon, 9 Jan 2023 12:20:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, libaokun1@huawei.com, zhanchengbin1@huawei.com
Subject: Re: [PATCH v2] jbd2: Fix data missing when reusing bh which is ready
 to be checkpointed
Message-ID: <20230109112032.z4xratnwhyri74xj@quack3>
References: <20230106115603.2624644-1-chengzhihao1@huawei.com>
 <20230106142255.fqnzgw5tqr77mdzj@quack3>
 <09622c2f-6cf7-79c9-2624-c0c0835d125d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09622c2f-6cf7-79c9-2624-c0c0835d125d@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 07-01-23 17:16:10, Zhihao Cheng wrote:
> 在 2023/1/6 22:22, Jan Kara 写道:
> 
> Hi Jan, thanks for reviewing.Some discussions below:
> 
> 
> > > diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> > > index 6a404ac1c178..06a5e7961ef2 100644
> > > --- a/fs/jbd2/transaction.c
> > > +++ b/fs/jbd2/transaction.c
> > > @@ -1010,36 +1010,37 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
> > >   	 * ie. locked but not dirty) or tune2fs (which may actually have
> > >   	 * the buffer dirtied, ugh.)  */
> > > -	if (buffer_dirty(bh)) {
> > > +	if (buffer_dirty(bh) && jh->b_transaction) {
> > >   		/*
> > >   		 * First question: is this buffer already part of the current
> > >   		 * transaction or the existing committing transaction?
> > >   		 */
> > > -		if (jh->b_transaction) {
> > > -			J_ASSERT_JH(jh,
> > > -				jh->b_transaction == transaction ||
> > > -				jh->b_transaction ==
> > > -					journal->j_committing_transaction);
> > > -			if (jh->b_next_transaction)
> > > -				J_ASSERT_JH(jh, jh->b_next_transaction ==
> > > -							transaction);
> > > -			warn_dirty_buffer(bh);
> > > -		}
> > > +		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
> > > +			jh->b_transaction == journal->j_committing_transaction);
> > > +		if (jh->b_next_transaction)
> > > +			J_ASSERT_JH(jh, jh->b_next_transaction == transaction);
> > > +		warn_dirty_buffer(bh);
> > >   		/*
> > > -		 * In any case we need to clean the dirty flag and we must
> > > -		 * do it under the buffer lock to be sure we don't race
> > > -		 * with running write-out.
> > > +		 * We need to clean the dirty flag and we must do it under the
> > > +		 * buffer lock to be sure we don't race with running write-out.
> > >   		 */
> > >   		JBUFFER_TRACE(jh, "Journalling dirty buffer");
> > >   		clear_buffer_dirty(bh);
> > > +		/*
> > > +		 * Setting jbddirty after clearing buffer dirty is necessary.
> > > +		 * Function jbd2_journal_restart() could keep buffer on
> > > +		 * BJ_Reserved list until the transaction committing, then the
> > > +		 * buffer won't be dirtied by jbd2_journal_refile_buffer()
> > > +		 * after committing, the buffer couldn't fall on disk even
> > > +		 * last checkpoint finished, which may corrupt filesystem.
> > > +		 */
> > >   		set_buffer_jbddirty(bh);
> > >   	}
> > 
> > So I think the sequence:
> > 
> > 	if (buffer_dirty(bh)) {
> > 		warn_dirty_buffer(bh);
> > 		JBUFFER_TRACE(jh, "Journalling dirty buffer");
> > 		clear_buffer_dirty(bh);
> > 		set_buffer_jbddirty(bh);
> > 	}
> > 
> > can be moved into the branch
> > 
> >    	if (jh->b_transaction == transaction ||
> > 	    jh->b_next_transaction == transaction) {
> > 
> > below. That way you can drop the assertions as well because they happen
> > later in do_get_write_access() again anyway.
> 
> 1. If we move the squence:
>  	if (buffer_dirty(bh)) {
>  		warn_dirty_buffer(bh);
>  		JBUFFER_TRACE(jh, "Journalling dirty buffer");
>  		clear_buffer_dirty(bh);
>  		set_buffer_jbddirty(bh);
>  	}
> 
> into the branch
> 
>         if (jh->b_transaction == transaction ||
>  	    jh->b_next_transaction == transaction) {
> 
> , then we have a new situation(jh->b_transaction ==
> journal->j_committing_transaction) to clear buffer dirty, so we need to add
> an else-branch like(based on v2 patch):
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1092,6 +1092,10 @@ do_get_write_access(handle_t *handle, struct
> journal_head *jh,
>                 spin_unlock(&journal->j_list_lock);
>                 unlock_buffer(bh);
>                 goto done;
> +       } else if (test_clear_buffer_dirty(bh)) {
> +               warn_dirty_buffer(bh);
> +               JBUFFER_TRACE(jh, "Journalling dirty buffer");
> +               set_buffer_jbddirty(bh);
>         }
>         unlock_buffer(bh);
> 
> I think we'd better not to move the sequence?

Oh, you're right. So yeah, keep this sequence where it was.

> 2. I agree that the assertions in branch 'if (jh->b_transaction)' are
> redundant, I will remove them in v3. Thanks for pointing that.

OK, thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

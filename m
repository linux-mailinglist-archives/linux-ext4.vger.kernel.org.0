Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009096F694B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 12:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjEDKue (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 May 2023 06:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjEDKuc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 May 2023 06:50:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419EB3C1F
        for <linux-ext4@vger.kernel.org>; Thu,  4 May 2023 03:50:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3B2320A04;
        Thu,  4 May 2023 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683197430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YGkcY/Z/fvObTORyRf7XhotLzUb2DChADXCyEToWUs=;
        b=JXa50ItlAYvpJaq5CeaNo++Z9Q4UhCiMcqvp0wkNKibW00VchNgxEiVE8jjfkJxPyhzGPg
        sj9eqe6tE8bmvPG/j+Zcs39pYyqa5p6g39tVbK8zTZuDcIbiQVBlKHZFdb+NWHThsYt5ok
        0H/1xB/oKw+lAUrXuTO4GPzP2vyT+4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683197430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YGkcY/Z/fvObTORyRf7XhotLzUb2DChADXCyEToWUs=;
        b=TaUfxS5f+IaqrTGHFFprtMLEFiZvLTcko20Z+v9JkDGTBCrCUOEvNM9Fv0mB/1sgOVv2TA
        jnhUGz4xNRiQNXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6DD813444;
        Thu,  4 May 2023 10:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hiBaOPWNU2TzBgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 04 May 2023 10:50:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 79443A0722; Thu,  4 May 2023 12:50:29 +0200 (CEST)
Date:   Thu, 4 May 2023 12:50:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix data races when using cached status extents
Message-ID: <20230504105029.5sq7p6x3r6h7yjvw@quack3>
References: <20230503182128.14115-1-jack@suse.cz>
 <20230504024157.GB650928@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504024157.GB650928@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 03-05-23 22:41:57, Theodore Ts'o wrote:
> On Wed, May 03, 2023 at 08:21:28PM +0200, Jan Kara wrote:
> > When using cached extent stored in extent status tree in tree->cache_es
> > another process holding ei->i_es_lock for reading can be racing with us
> > setting new value of tree->cache_es. If the compiler would decide to
> > refetch tree->cache_es at an unfortunate moment, it could result in a
> > bogus in_range() check. Fix the possible race by using READ_ONCE() when
> > using tree->cache_es only under ei->i_es_lock for reading.
> > 
> > Reported-by: syzbot+4a03518df1e31b537066@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/all/000000000000d3b33905fa0fd4a6@google.com
> > Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Don't we also need a WRITE_ONCE here?

Right, we should do that as well. I'll update the patch.

								Honza

> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 7bc221038c6c..4694582cf255 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -293,7 +293,7 @@ static void __es_find_extent_range(struct inode *inode,
>  	}
>  
>  	if (es1 && matching_fn(es1)) {
> -		tree->cache_es = es1;
> +		WRITE_ONCE(tree->cache_es, es1);
>  		es->es_lblk = es1->es_lblk;
>  		es->es_len = es1->es_len;
>  		es->es_pblk = es1->es_pblk;
> 
> 					- Ted
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

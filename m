Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0463EDF4
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 11:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLAKff (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 05:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLAKfW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 05:35:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1D48DFC3
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 02:35:21 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 380741FD68;
        Thu,  1 Dec 2022 10:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669890920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iw729z/mg9DtUcEi1uZDIBmgflDFEE7/BxUca9FSJrA=;
        b=TNruWFo4Tnv7uHnUpPE6OUETqq7E8Ck1K+j+S+2gFwOWOCm8Yv1xSaB8eD4YmsrEMOI7b4
        wIQxW9JUTZXW+9hqXWzXi9SjHMzwymR4XITMRkg7/lkdlkpS523413jOPYSfNBI7mriG36
        TfuqhwiWj5nc+aSwghpnL9yA/RE2jnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669890920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iw729z/mg9DtUcEi1uZDIBmgflDFEE7/BxUca9FSJrA=;
        b=y+VAACzi4aXU9blRgflS7eah4iRTv1gGW9Vzd1Pa0T6IW7rPvf8pXmRj3SkJY9lSqt9PHB
        5NAWC+wJF5F9ImDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 19FAF13503;
        Thu,  1 Dec 2022 10:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1ihSBmiDiGPZMQAAGKfGzw
        (envelope-from <jack@suse.cz>); Thu, 01 Dec 2022 10:35:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A54AFA071F; Thu,  1 Dec 2022 11:35:19 +0100 (CET)
Date:   Thu, 1 Dec 2022 11:35:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/9] ext4: Drop pointless IO submission from
 ext4_bio_write_page()
Message-ID: <20221201103519.n32kes6llulr2mcx@quack3>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-4-jack@suse.cz>
 <20221201070655.cugep2fdrtntp67y@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201070655.cugep2fdrtntp67y@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 01-12-22 12:36:55, Ritesh Harjani (IBM) wrote:
> On 22/11/30 05:35PM, Jan Kara wrote:
> > We submit outstanding IO in ext4_bio_write_page() if we find a buffer we
> > are not going to write. This is however pointless because we already
> > handle submission of previous IO in case we detect newly added buffer
> > head is discontiguous. So just delete the pointless IO submission call.
> 
> Agreed. io_submit_add_bh() is anyway called at the end for submitting buffers.
> And io_submit_add_bh() also has the logic to:
> 1. submit a discontiguous bio
> 2. Also submit a bio if the bio gets full (submit_and_retry label).
> 
> Hence calling ext4_io_submit() early is not required.
> 
> I guess the same will also hold true for at this place.
> https://elixir.bootlin.com/linux/v6.1-rc7/source/fs/ext4/page-io.c#L524

So there the submission is needed because we are OOM and are going to wait
for some memory to free. If we have some bio accumulated, it is pinning
pages in writeback state and memory reclaim can be waiting on them. So if
we don't submit, it is a deadlock possibility or at least asking for
trouble.

> But this patch looks good to me. Feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for review!

								Honza
> 
> 
> 
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/page-io.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> > index 2bdfb8a046d9..beaec6d81074 100644
> > --- a/fs/ext4/page-io.c
> > +++ b/fs/ext4/page-io.c
> > @@ -489,8 +489,6 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
> >  					redirty_page_for_writepage(wbc, page);
> >  				keep_towrite = true;
> >  			}
> > -			if (io->io_bio)
> > -				ext4_io_submit(io);
> >  			continue;
> >  		}
> >  		if (buffer_new(bh))
> > --
> > 2.35.3
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

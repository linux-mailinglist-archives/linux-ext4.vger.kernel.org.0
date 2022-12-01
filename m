Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA94063EFDF
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 12:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiLALuY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 06:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiLALuX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 06:50:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB29BA13D0
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 03:50:21 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6977A21B6F;
        Thu,  1 Dec 2022 11:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669895420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVLVIuIBGcwg9+g8FjR/F3+y2zc8CVSZBK4L9XOOHkk=;
        b=OJHTbc2C8UWpSUEU6WnQSO1Vr16lmulU2C2U1IhPGTda86qeT5xtG5x0VIqz1CQnVmKWZS
        qv8apcwsFxhil2EPZsN0MWRN7aRjtrpIN/Gc/pbA081TGAkVvPJSTgmMaHFBMyfJvVMksY
        NQ0zSVU4UmQJ5SXZST7WWnNszXKPscc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669895420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVLVIuIBGcwg9+g8FjR/F3+y2zc8CVSZBK4L9XOOHkk=;
        b=oF1wnJ6SOsluKLLYE4zkm495gaTosjy1cn2HNPWy3UG9PWO8rCtHahYM7Ciusd1udyCpmF
        JoSgqfzL9gLJjsBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5E0A91320E;
        Thu,  1 Dec 2022 11:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id LErqFvyUiGNqWgAAGKfGzw
        (envelope-from <jack@suse.cz>); Thu, 01 Dec 2022 11:50:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E3713A06E4; Thu,  1 Dec 2022 12:50:19 +0100 (CET)
Date:   Thu, 1 Dec 2022 12:50:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/9] ext4: Add support for writepages calls that cannot
 map blocks
Message-ID: <20221201115019.jot525ry25gk4ggh@quack3>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-5-jack@suse.cz>
 <20221201111359.onr5edsaaxcr2ndh@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201111359.onr5edsaaxcr2ndh@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 01-12-22 16:43:59, Ritesh Harjani (IBM) wrote:
> On 22/11/30 05:35PM, Jan Kara wrote:
> > Add support for calls to ext4_writepages() than cannot map blocks. These
> > will be issued from jbd2 transaction commit code.
> 
> I guess we should expand the description of mpage_prepare_extent_to_map()
> function now. Other than that the patch looks good to me.
> 
> Please feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for review!

> >  /*
> >   * mpage_prepare_extent_to_map - find & lock contiguous range of dirty pages
> >   * 				 and underlying extent to map
> 
> Since we are overloading this function. this can be also called with can_map
> as 0. Maybe good to add some description around that?

Well, it was somewhat overloaded already before but you're right some
documentation update is in order :) I'll do that.

> > @@ -2651,14 +2665,30 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
> 
> 
> adding context of code so that it doesn't get missed in the discussion.
> 
> <...>
> 			/* If we can't merge this page, we are done. */
> 			if (mpd->map.m_len > 0 && mpd->next_page != page->index)
> 				goto out;
> 
> I guess this also will not hold for us given we will always have m_len to be 0.
> <...>

Correct.

> > +			/*
> > +			 * Writeout for transaction commit where we cannot
> > +			 * modify metadata is simple. Just submit the page.
> > +			 */
> > +			if (!mpd->can_map) {
> > +				if (ext4_page_nomap_can_writeout(page)) {
> > +					err = mpage_submit_page(mpd, page);
> > +					if (err < 0)
> > +						goto out;
> > +				} else {
> > +					unlock_page(page);
> > +					mpd->first_page++;
> 
> We anyway should always have mpd->map.m_len = 0.
> That means, we always set mpd->first_page = page->index above.
> So this might not be useful. But I guess for consistency of the code,
> or to avoid any future bugs, this isn't harmful to keep.

Yes, it is mostly for consistency but it is also needed so that once we
exit the loop, mpage_release_unused_pages() starts working from a correct
page.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

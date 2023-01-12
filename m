Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE3B666E5C
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jan 2023 10:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbjALJf1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Jan 2023 04:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbjALJek (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Jan 2023 04:34:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC25329A
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jan 2023 01:29:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 541773EE65;
        Thu, 12 Jan 2023 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673515746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Au5Y5lilpkftIEJcJmkAVkWWK4MwBRarZO0HiIlsDaY=;
        b=ZBntweEsOGOjmrpvxSFlY7uDxfHe2rre8qMcO2sfRBPjVFjmlhqnwm4Ba8lq4i3uxom08F
        GrSJEwHEckB9285yVFILRAi4XFIBcotxz4sFlC2LtVMNxGDJp9X/CB/mQ4Km3uYVBNsEP1
        c5NT1vocfiEHZzpVL0c2B6m19uuKbKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673515746;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Au5Y5lilpkftIEJcJmkAVkWWK4MwBRarZO0HiIlsDaY=;
        b=cIief3i6LjU5006LTjwD9v8XWnIIIj6xy1COcsPuJkS8mSYZwpRi9y2x0k2aIrPzvE44BC
        olh7M7Rcn3s7tuAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45D0113776;
        Thu, 12 Jan 2023 09:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7OMAEeLSv2P6FwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 12 Jan 2023 09:29:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 925B0A0744; Thu, 12 Jan 2023 10:29:05 +0100 (CET)
Date:   Thu, 12 Jan 2023 10:29:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/7] ext4: Mark page for delayed dirtying only if it is
 pinned
Message-ID: <20230112092905.chrxh6dlnxfakxz6@quack3>
References: <20230111152736.9608-1-jack@suse.cz>
 <20230111154338.392-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111154338.392-3-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 11-01-23 16:43:27, Jan Kara wrote:
> In data=journal mode, page should be dirtied only when it has buffers
> for checkpoint or it is writeably mapped. In the first case, we don't
> need to do anything special. In the second case, page was already added
> to the journal by ext4_page_mkwrite() and since transaction commit
> writeprotects mapped pages again, page should be writeable (and thus
> dirtied) only while it is part of the running transaction. So nothing
> needs to be done either. The only special case is when someone pins the
> page and uses this pin for modifying page data. So recognize this
> special case and only then mark the page as having data that needs
> adding to the journal.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
...
>  static bool ext4_journalled_dirty_folio(struct address_space *mapping,
>  		struct folio *folio)
>  {
>  	WARN_ON_ONCE(!folio_buffers(folio));
> -	folio_set_checked(folio);
> +	if (folio_may_be_dma_pinned(folio))

Bah, this should be folio_maybe_dma_pinned(). I had it there and that's
what I've tested with but before submission I was laboring whether I should
really keep this change or not, had it deleted for a while and then
restored the change, and while doing that I've introduced this bug. :-|

I'll resend with this bug fixed but before doing that I'll wait a few days
whether someone has more comments.

								Honza

> +		folio_set_checked(folio);
>  	return filemap_dirty_folio(mapping, folio);
>  }
>  
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

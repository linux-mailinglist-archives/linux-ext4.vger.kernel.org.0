Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95A1647459
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 17:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLHQdR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 11:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHQdQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 11:33:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3810D2ED72
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 08:33:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7C66337B1;
        Thu,  8 Dec 2022 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670517193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlizivNlUdY7lcIbCi995SkuvNaq7ceLEksVICLhX9s=;
        b=qQ7Om8A/u+BOymcJm5KX7QLD2eFS8PMTrSHFZeuXJSGrX6HxQdiHIIPu4vPEuzb41zss4L
        yIz00sbbV7KX/EXbbUcOGor+3dmEkKUK37torxha7uxbUKt/eotcBHG5PHacmB5vuGmif3
        u0ljjdGX7zKguHYyvdU3gmjNHHW9+N4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670517193;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlizivNlUdY7lcIbCi995SkuvNaq7ceLEksVICLhX9s=;
        b=q2GyPQuDkVMsMSfzFCFevpIKg7h4/J7Yem06pLEXR664JqeDF/HlYLm3ixnm18cpfQSTqv
        aKqa8fNpqKjskLBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A78013416;
        Thu,  8 Dec 2022 16:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YHUKFskRkmOkKQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Dec 2022 16:33:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8712CA0725; Thu,  8 Dec 2022 17:33:08 +0100 (CET)
Date:   Thu, 8 Dec 2022 17:33:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 10/13] ext4: Switch to using write_cache_pages() for
 data=journal writeout
Message-ID: <20221208163308.yljf2qd7rfxzyw5g@quack3>
References: <20221207112259.8143-1-jack@suse.cz>
 <20221207112722.22220-10-jack@suse.cz>
 <20221208154046.s6aub2mhqfzewhuk@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208154046.s6aub2mhqfzewhuk@riteshh-domain>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-12-22 21:10:46, Ritesh Harjani (IBM) wrote:
> On 22/12/07 12:27PM, Jan Kara wrote:
> > Instead of using generic_writepages(), let's use write_cache_pages() for
> > writeout of journalled data. It will allow us to stop providing
> > .writepage callback.
> 
> Ok. Just one quick query. I didn't look too deep for this and thought will
> directly check it here.
> What about marking an error via mapping_set_error() which earlier the
> __writepage() call was handling in case of any error during writeback?

So yes, I have noticed we loose that call and decided we'll stay compatible
(arguably bug-to-bug) with what we do for data=ordered mode. If error
happens in ext4_writepage() (i.e., during adding buffers to transaction) we
will propagate it back up to the ->writepages() caller. I agree we should
probably tweak ext4_writepages() to also do mapping_set_error() just in
case this is writeback from flush worker so that application can learn
about the problem.

I'll add this to the larger cleanup of our writepages path. Thanks for the
comment.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

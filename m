Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79469647357
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLHPk2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 10:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLHPkQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 10:40:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D92AD3
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 07:40:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D1EF337DC;
        Thu,  8 Dec 2022 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670514009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRtdfU5HXn0uiWZUijriezrr01wlTj8FXd1YfadKhQ8=;
        b=ggMY4xkJjQy7EMMs7wET3HpxOTfyhl+DjG+N7ndbEufKo+rueku64pER7UtF4ozvnG51B4
        39uAoBkdmY/5hAqaLgF8W395yfMTBDVoHK6xovtndT6I7e1uG5UYnA86wpIMXOnYNha28r
        kdRKQXsoe4Y3P/qPYUC2bt0bxcWZhyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670514009;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TRtdfU5HXn0uiWZUijriezrr01wlTj8FXd1YfadKhQ8=;
        b=c2a1BTbYPMniMUZLPEw4bDXsyu9iMHSpR+iGblsu/EUYF9ZeaCc/r5PZd7mrpc4MtImySD
        oKEnXzl+DuMjyaAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E2F7138E0;
        Thu,  8 Dec 2022 15:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TmiyIlkFkmOrDwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Dec 2022 15:40:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C308DA0725; Thu,  8 Dec 2022 16:40:07 +0100 (CET)
Date:   Thu, 8 Dec 2022 16:40:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 13/13] ext4: Remove ordered data support from
 ext4_writepage()
Message-ID: <20221208154007.xlqdib25finzyyt6@quack3>
References: <20221207112259.8143-1-jack@suse.cz>
 <20221207112722.22220-13-jack@suse.cz>
 <Y5HzfGolIoH5PTXn@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5HzfGolIoH5PTXn@mit.edu>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-12-22 09:23:56, Theodore Ts'o wrote:
> On Wed, Dec 07, 2022 at 12:27:16PM +0100, Jan Kara wrote:
> > ext4_writepage() should not be called for ordered data anymore. Remove
> > support for it from the function.
> > 
> > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> This commit (determined via bisection) is causing a large number of
> test failures for ext4/data_journal case:
> 
> ext4/data_journal: 521 tests, 33 failures, 98 skipped, 4248 seconds
>   Failures: ext4/004 generic/012 generic/016 generic/021 generic/022 
>     generic/029 generic/030 generic/031 generic/032 generic/058 
>     generic/060 generic/061 generic/063 generic/071 generic/075 
>     generic/098 generic/112 generic/127 generic/231 generic/393 
>     generic/397 generic/404 generic/439 generic/455 generic/477 
>     generic/491 generic/567 generic/572 generic/574 generic/577 
>     generic/634 generic/639 generic/679
> 
> Many/most of these failures appear to be data plane failures.  For
> example ext4/004 is a "dump | restore" followed by a "diff -r
> $DUMP_DIR $RESTORE_DIR".  The generic/012, generic/021, generic/022
> failures are md5sum checksum failures after testing the punch hole
> operation.  The generic/029 failure are hexdump mismatches after
> calling a combination of truncate, pwrites, and mmap'ed writes, etc.
> 
> Since this is the last patch in the series, and we've already dropped
> the writepage hook (which is one of the things Christoph was going
> for), so one approach might be drop this patch from the series at
> least for this upcoming merge window.
> 
> Jan, what do you think?

Yes, please drop it and I'm sorry for the breakage. I did only very limited
testing with data=journal mode (which passed) and apparently something
unexpected breaks. I suspect some path doing writeout of committed (but not
yet checkpointed) data pages breaks. I'll have a look.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

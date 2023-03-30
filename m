Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030416CFE25
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Mar 2023 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjC3IWp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Mar 2023 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjC3IWV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Mar 2023 04:22:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4E7ABC
        for <linux-ext4@vger.kernel.org>; Thu, 30 Mar 2023 01:21:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A3D01FE9F;
        Thu, 30 Mar 2023 08:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680164507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5HQ1hG3raYLBNlVMyGJg6RogG331RllJgBkkYFlNngE=;
        b=Izk9pP4dJn3kn+4t/3a7o5rZlSwqEN8ODOW8yEovoNgYY3lqQullYo6PHHZ7XNnkTuCRII
        xkRkTUT5IyNVcuO6suhLWUH+F4seicuvogtY/PLjcyTCms1cuqSi1Xxfgpjf3KMF5cH64O
        FfA44UOIMAiTOnoY539/zS72okAztAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680164507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5HQ1hG3raYLBNlVMyGJg6RogG331RllJgBkkYFlNngE=;
        b=OZbawG7q4y51Alm/3cJnXnIr8tg5Ia1Ybz4xDPNcuoRxL5JbNLtmy6C/DiX/8mK0k6cDqF
        ZSD/pCpXV4GKI+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44B51138FF;
        Thu, 30 Mar 2023 08:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wD4oEJtGJWRSFAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 30 Mar 2023 08:21:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A0283A071E; Thu, 30 Mar 2023 10:21:46 +0200 (CEST)
Date:   Thu, 30 Mar 2023 10:21:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 06/13] ext4: Drop special handling of journalled data
 from ext4_sync_file()
Message-ID: <20230330082146.muy4j4ehf3l7w3xi@quack3>
References: <20230329125740.4127-1-jack@suse.cz>
 <20230329154950.19720-6-jack@suse.cz>
 <ZCTSWQk+8jxQckXG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCTSWQk+8jxQckXG@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 29-03-23 17:05:45, Christoph Hellwig wrote:
> On Wed, Mar 29, 2023 at 05:49:37PM +0200, Jan Kara wrote:
> >  	/*
> > -	 * data=writeback,ordered:
> >  	 *  The caller's filemap_fdatawrite()/wait will sync the data.
> >  	 *  Metadata is in the journal, we wait for proper transaction to
> >  	 *  commit here.
> 
> Nit: without the list, the two space indent looks a bit weird here.
> 
> >  	if (!sbi->s_journal)
> >  		ret = ext4_fsync_nojournal(inode, datasync, &needs_barrier);
> > -	else if (ext4_should_journal_data(inode))
> > -		ret = ext4_force_commit(inode->i_sb);
> >  	else
> >  		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
> 
> Also if there is not journale the above comment doesn't make much sense.
> But I'm really not sure the comment adds any value to start with, so
> maybe just drop it entirely?

Hum, right. I'll just drop the whole comment. Thanks for the suggestion.

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697B863EFFA
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 12:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLALzN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 06:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiLALzH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 06:55:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A84EC0C
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 03:55:02 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D02B1F7AB;
        Thu,  1 Dec 2022 11:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669895701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIuShHQJX6ATEISDVtU+qPEVcr3dd3SVEuuk3k3nxoE=;
        b=DFPLAiT0o2QIEsN58j7Mri3eHbzhkRW1hO7jlELU+p8mYgYyFQr7EmUH72TBSlyPLpNkBi
        JDigwFYAZuwU4ou31TimLaK59Z8VDcal3JKCF6et7uQHLfPRUoHCIKGM5iv1aQfP9ep7fq
        esKGbDiWn8zcYmkEzP3lLcxslwoIS2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669895701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIuShHQJX6ATEISDVtU+qPEVcr3dd3SVEuuk3k3nxoE=;
        b=ET5XSBNvEULzDr+j2jCmzVAxXFV4QMldJkOkjvhp9EkMs0kkGcCDhMVzIidJlhpItYOO0H
        fHSZBSTZ9PIbB7CA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3F7CA1320E;
        Thu,  1 Dec 2022 11:55:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1mF6DxWWiGPdXAAAGKfGzw
        (envelope-from <jack@suse.cz>); Thu, 01 Dec 2022 11:55:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CCAA0A06E4; Thu,  1 Dec 2022 12:55:00 +0100 (CET)
Date:   Thu, 1 Dec 2022 12:55:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/9] ext4: Stop using ext4_writepage() for writeout of
 ordered data
Message-ID: <20221201115500.kbxtteft3v4pzqqx@quack3>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221201114205.mg6song3ulrqvt54@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201114205.mg6song3ulrqvt54@riteshh-domain>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 01-12-22 17:12:05, Ritesh Harjani (IBM) wrote:
> On 22/11/30 05:35PM, Jan Kara wrote:
> > Hello,
> >
> > this patch series modifies ext4 so that we stop using ext4_writepage() for
> > writeout of ordered data during transaction commit (through
> > generic_writepages() from jbd2_journal_submit_inode_data_buffers()). Instead we
> > directly call ext4_writepages() from the
> > ext4_journal_submit_inode_data_buffers().
> 
> Hello Jan,
> 
> Do you think we should add a WARN_ON_ONCE() or something in
> ext4_do_writepages() function where we might try to start a transaction
> at [J]. Since we can now enter into ext4_do_writepages() from two places:
> 1. writeback
> 2. jbd2_journal_commit_transaction()
> 	mpage_submit_page
> 	mpage_prepare_extent_to_map
> 	ext4_do_writepages
> 	ext4_normal_submit_inode_data_buffers
> 	ext4_journal_submit_inode_data_buffers
> 	journal_submit_data_buffers
> 	jbd2_journal_commit_transaction
> 	kjournald2
> 
> So IIUC, we will call mpage_submit_page() in the first call to
> mpage_prepare_extent_to_map() [1] itself. That may set mpd->scanned_until_end = 1
> at the end of it. So then we should never enter into the while loop where we
> start a journal txn.

Yes, correct. But I agree a WARN_ON_ONCE in the loop might be useful just
in case. I'll add it. Thanks for the idea.

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

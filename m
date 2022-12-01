Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD9B63F260
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 15:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiLAOLy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 09:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiLAOLv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 09:11:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E3CA7A9C
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 06:11:49 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29F7F21B60;
        Thu,  1 Dec 2022 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669903905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EPT5ByqQUHwA0qQcGDarLgd6WWernddmSAgAEtDSLmY=;
        b=iZ71Wn0+0g8wiVLaI8dYJ9TNJ62Q49S9tK0iSsylJxhBFmt4HaLkBBKFq33XyHBStkG/m/
        iqwIOADsCJ2JWveWEBuEqrUP2GHtVYtPKT7XeMgz7LtyQbDly3vdwuXK2nwZ49MnIzR/pH
        n3r5EY/JgVxDarBNcSHLxUWxQ3eMklk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669903905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EPT5ByqQUHwA0qQcGDarLgd6WWernddmSAgAEtDSLmY=;
        b=4XnR4EY84ncRoTghxO34ifnoEHU2BpjvSp+Ew781UMUECuwg7XhjhxfNdEVTMOtQhbEPci
        3IF2CVvatUSNniCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1BCA51320E;
        Thu,  1 Dec 2022 14:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id g4bEBiG2iGPcKQAAGKfGzw
        (envelope-from <jack@suse.cz>); Thu, 01 Dec 2022 14:11:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AAF1EA06E4; Thu,  1 Dec 2022 15:11:44 +0100 (CET)
Date:   Thu, 1 Dec 2022 15:11:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 9/9] ext4: Remove ordered data support from
 ext4_writepage()
Message-ID: <20221201141144.rgosvsixfkcyagbc@quack3>
References: <20221130162435.2324-1-jack@suse.cz>
 <20221130163608.29034-9-jack@suse.cz>
 <20221201112152.slnmx3u6jh7bhww5@riteshh-domain>
 <20221201133619.cov6ntr2fuceqhjs@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201133619.cov6ntr2fuceqhjs@riteshh-domain>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 01-12-22 19:06:19, Ritesh Harjani (IBM) wrote:
> On 22/12/01 04:51PM, Ritesh Harjani (IBM) wrote:
> > On 22/11/30 05:36PM, Jan Kara wrote:
> > > -	ext4_io_submit_init(&io_submit, wbc);
> > > -	io_submit.io_end = ext4_init_io_end(inode, GFP_NOFS);
> > > -	if (!io_submit.io_end) {
> > > -		redirty_page_for_writepage(wbc, page);
> > > +	WARN_ON_ONCE(!ext4_should_journal_data(inode));
> 
> Oh and one more thing, this will give a WARN_ON_ONCE(), until we change the pageout()
> function from reclaim path to not call ->writepage() method.
> This until then might cause random fstest to fail for sometime if it observes a
> kernel warning message while the test was running.
> 
> [ 5081.820019] WARNING: CPU: 3 PID: 125 at fs/ext4/inode.c:1994 ext4_writepage+0x380/0xb80
> [ 5081.822884] Modules linked in:
> [ 5081.824487] CPU: 3 PID: 125 Comm: kswapd0 Not tainted 6.1.0-rc4-00054-g969d94a2d4d6 #101
> [ 5081.825559] Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1200 0xf000005 of:SLOF,git-6b6c16 pSeries
> [ 5081.826743] NIP:  c00000000077a2c0 LR: c00000000077a2b4 CTR: c000000000779f40
> [ 5081.827547] REGS: c0000000073d72d0 TRAP: 0700   Not tainted  (6.1.0-rc4-00054-g969d94a2d4d6)
> <...>
> [ 5081.862838] NIP [c00000000077a2c0] ext4_writepage+0x380/0xb80
> [ 5081.864963] LR [c00000000077a2b4] ext4_writepage+0x374/0xb80
> [ 5081.865995] Call Trace:
> [ 5081.866510]  ext4_writepage+0x190/0xb80 (unreliable)
> [ 5081.867438]  pageout+0x1b0/0x550
> [ 5081.868110]  shrink_folio_list+0xb48/0x1400
> [ 5081.868803]  shrink_inactive_list+0x2ec/0x6b0
> [ 5081.869504]  shrink_lruvec+0x6f0/0x7b0
> [ 5081.870160]  shrink_node+0x5e4/0x980
> [ 5081.870801]  balance_pgdat+0x4cc/0x910
> [ 5081.871453]  kswapd+0x6e4/0x820
> [ 5081.872062]  kthread+0x168/0x170
> [ 5081.872691]  ret_from_kernel_thread+0x5c/0x64

Hum, right. It didn't trigger for me :). I'll see how to fix this.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD916A6CD2
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 14:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCANFQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 08:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCANFP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 08:05:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD081A649
        for <linux-ext4@vger.kernel.org>; Wed,  1 Mar 2023 05:05:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A5C71FE14;
        Wed,  1 Mar 2023 13:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677675913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Niid7aizgDV7sEvTabpy/cZP8xplrCOz/yUw8BIalrU=;
        b=MDX2BsOK7EyFrWYf1v291CUxPAhpNwYVXNWoVT5+TY5S2qx/hsCgCYUVPa+XStjCdDONvB
        hO2uPh9Ej+zGwaEFlDuCD0tx7kJuZTzfB4zbR4hr1jFrlsha7qWKl3bBvGWBPXJre1lqK4
        9Ib0TDyh++fNgDw2cHHyfC32yh/F8nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677675913;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Niid7aizgDV7sEvTabpy/cZP8xplrCOz/yUw8BIalrU=;
        b=41WM0hpPpswmZZImbA4MZSs7kJBwZ7yYARHbfhJlAI0S6ulYXKzvdLkOFPb8E93sbB5jTI
        sSYVXLAWmOGfsJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1756C13A3E;
        Wed,  1 Mar 2023 13:05:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7kE3BYlN/2OHBwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 01 Mar 2023 13:05:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8698FA06E5; Wed,  1 Mar 2023 14:05:12 +0100 (CET)
Date:   Wed, 1 Mar 2023 14:05:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] ext2: Check block size validity during mount
Message-ID: <20230301130512.2vunrj4mspbkwgah@quack3>
References: <20230301111026.15102-1-jack@suse.cz>
 <20230301111238.22856-2-jack@suse.cz>
 <d2a5be55-4bcb-da7e-fae5-9cc598223b17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a5be55-4bcb-da7e-fae5-9cc598223b17@linaro.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 01-03-23 11:37:20, Tudor Ambarus wrote:
> Hi!
> 
> On 3/1/23 11:12, Jan Kara wrote:
> > Check that log of block size stored in the superblock has sensible
> > value. Otherwise the shift computing the block size can overflow leading
> > to undefined behavior.
> > 
> > Reported-by: syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com
> 
> Would be helpful to also have:
> LINK: https://syzkaller.appspot.com/bug?extid=4fec412f59eba8c01b77
> a "Fixes:" tag and
> Cc: stable@vger.kernel.org

Well, Fixes tag doesn't really make sense here. The behavior is there since
forever... I've added the Link and CC tags. Thanks for the suggestion.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

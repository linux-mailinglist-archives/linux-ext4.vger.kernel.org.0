Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544B26A5A75
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 14:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjB1N67 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 08:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjB1N66 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 08:58:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C641C7E3
        for <linux-ext4@vger.kernel.org>; Tue, 28 Feb 2023 05:58:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44F881FDC1;
        Tue, 28 Feb 2023 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677592735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WiSvPHwfO/c7csa2iA2TV9D1N8Dacj2wfnfogopPI2E=;
        b=SJl7+kR8sZLQlBSP01ZumfvGqce6+ozGdDNcL4It5JTjkTWIcEBU48h21SEPXcXiVax50M
        imHRceJIAfk4yqyePuWKG/o5gLzHUkzi/XFb2+RM2droQYHXK6UpJXRXhmW2wvhQOuPd+w
        yNVhAsBRbivs+nlHTPk6fYK59PwIZ/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677592735;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WiSvPHwfO/c7csa2iA2TV9D1N8Dacj2wfnfogopPI2E=;
        b=xLwJOIo7Vu6DiH+JDXdefNGpQ95c8D/i8vI96QvGxR5C+eAIfAMJ7pilllZ/tpPzNBvgXW
        yqf+5zdXfDNgsWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31B8813440;
        Tue, 28 Feb 2023 13:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bBQgDJ8I/mOhRgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 28 Feb 2023 13:58:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 59166A06F2; Tue, 28 Feb 2023 14:58:54 +0100 (CET)
Date:   Tue, 28 Feb 2023 14:58:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH REBASED 0/7] ext4: Cleanup data=journal writeback path
Message-ID: <20230228135854.ky2zpwal7trz6yg3@quack3>
References: <20230228051319.4085470-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228051319.4085470-1-tytso@mit.edu>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted!

On Tue 28-02-23 00:13:12, Theodore Ts'o wrote:
> This is Jan's data=journal cleanup patch series, previously submitted
> here[1] rebased on top of Linus's patches to address merge conflicts
> with mm-stable, per this discussion[2].
> 
> [1] https://lore.kernel.org/r/20230111152736.9608-1-jack@suse.cz
> [2] https://lore.kernel.org/r/Y/k4Jvph15ugcY54@mit.edu
> 
> While retesting this patch series, I've noticed a potential regression
> which doesn't trigger before applying the last patch in this series
> (Convert data=journal writeback to use ext4_writepages), but which
> triggers a WARNING in generic/390 about half the time.  I've gone back
> and retested, and this was happening before the rebase.
> 
> Jan, could you take a look and (1) let me know what you think about my
> patch conflict resolutions and (2) what you think about this warning
> which is occasionally triggered by generic/390?  Many thanks!

I went through the patches and they look good to me. I have a side note
that obviously the code isn't quite going to work for folios larger than 1
page but for 1 page folios we should be fine.

Regarding the warning somehow there are dirty pages left after the
procedures freeze_super() goes through to flush all dirty data. That is not
too surprising since in data=journal mode pages get (as a surprise to
freezing code) dirtied when transaction commits. I thought we have this
covered by jbd2_journal_flush() call in ext4_freeze() but maybe there are
some stranded PageDirty bits left? It needs more debugging...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

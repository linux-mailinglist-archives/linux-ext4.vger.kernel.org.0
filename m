Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B5575E84
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 11:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiGOJ1k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 05:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiGOJ1j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 05:27:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E577A7F
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 02:27:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF74C340F3;
        Fri, 15 Jul 2022 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657877256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dFET3vQFMf8/baaEjROPAxr/9C50F1f+TI8Djd99y9w=;
        b=NlVvAoWhnvNlGGafLNiTPu3+qkqdEqCJUIzi3y8xX7Vfk4o+Q+L1/yfH96mVWLbExDiN3o
        XI69GwUs/JlMu2uT601Tp7N7SD3sEKXW8aSDuCOhXWgpDWFgBfsdFlZBhizZKuUkVVE/VO
        3lNUZhEWaOEVipbbVhiNToODdm/gYlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657877256;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dFET3vQFMf8/baaEjROPAxr/9C50F1f+TI8Djd99y9w=;
        b=NLknbgeWgkP5nVHL6bH1s/sH2oZGOEBBqqa3x+PMyruSBbQWmCbcYvi6/BSCQWsdts2Sv6
        OlmTnkIdRsou1NBg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BEE642C141;
        Fri, 15 Jul 2022 09:27:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 75A00A0657; Fri, 15 Jul 2022 11:27:36 +0200 (CEST)
Date:   Fri, 15 Jul 2022 11:27:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Kiselev, Oleg" <okiselev@amazon.com>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4: reduce computation of overhead during resize
Message-ID: <20220715092736.oa2tfcgh5a6dcpnf@quack3>
References: <D03FEE2D-DCAE-44A7-B0D3-0047808426BB@amazon.com>
 <20220714134645.r4gqax4au5el2pox@quack3>
 <63A35E4E-C7B9-4B2C-BBCC-F43BECDFEA6A@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63A35E4E-C7B9-4B2C-BBCC-F43BECDFEA6A@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 14-07-22 19:53:38, Kiselev, Oleg wrote:
> > 
> >> +       sbi->s_overhead += overhead;
> >> +       es->s_overhead_clusters = cpu_to_le32((unsigned long) sbi->s_overhead);
> >                                                ^^^ the typecast looks
> > bogus here...
> 
> This cast is the reverse of le32_to_cpu() cast done in fs/ext4/super.c:__ext4_fill_super():
>         sbi->s_overhead = le32_to_cpu(es->s_overhead_clusters);
> And follows the logic of casting done in fs/ext4/ioctl.c:set_overhead() and fs/ext4/ioctl.c:ext4_update_overhead(). 

I didn't mean the cpu_to_le32() call but rather the (unsigned long) part.
That is pointless because sbi->s_overhead is already 'unsigned long' and
even if it was not, I have hard time seeing a reason why would casting to
unsigned long make any difference here.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

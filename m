Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9865590DFB
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Aug 2022 11:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiHLJVr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiHLJVq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 05:21:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0240A347B;
        Fri, 12 Aug 2022 02:21:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 655581F924;
        Fri, 12 Aug 2022 09:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660296103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voPFxsueMeDDO9g9PxJff2XDO4Y129r5tBsuJySfB9c=;
        b=2QWChunj+2gm2tDWSX/2fBLWfM2Lr9wuQ85K7Paxel8P67JmP946yulVIRu/gCN3j/7LWU
        485WRSlEi3Bv87laCC/1OEisz/9w0GbSvxDNNDLX+mmWBF4hsA8XudedGXlUbJ86c3shU1
        eloTG8kZLvFCpkMLEKLBnHr3heEb8KU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660296103;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voPFxsueMeDDO9g9PxJff2XDO4Y129r5tBsuJySfB9c=;
        b=K/3gjHvcUALLi7588j2R/faOpw7Wt/ZjmqC67E16oiViIj9jeJRSP5GGkOK7W2trMzBtG7
        x3b3AHWaD5TVe6CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5AAE13AAE;
        Fri, 12 Aug 2022 09:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L5xYLaYb9mIZPQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 12 Aug 2022 09:21:42 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 2ddfc29e;
        Fri, 12 Aug 2022 09:22:29 +0000 (UTC)
Date:   Fri, 12 Aug 2022 10:22:29 +0100
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        wenqingliu0120@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        yebin10@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] ext4: fix bug in extents parsing when number of entries
 in header is zero
Message-ID: <YvYb1fgvGmdDRmKd@suse.de>
References: <bug-215941-13602@https.bugzilla.kernel.org/>
 <20220805140025.26295-1-lhenriques@suse.de>
 <e10617e8-1a21-a046-8256-66ffc6500ae9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e10617e8-1a21-a046-8256-66ffc6500ae9@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 12, 2022 at 10:33:20AM +0800, Baokun Li wrote:
> 在 2022/8/5 22:00, Luís Henriques 写道:
...
> > This bug is easily reproducible using the filesystem image provided --
> > it's just a matter of mounting it and run:
> > 
> >      $ cat /mnt/foo/bar/xattr
> 
> Hi Luís,
> yeah, that's a good catch!
> > Anyway, I hope my analysis of the bug is correct -- the root cause seems
> > to be an extent header with an invalid value for in eh_entries, which will
> > later cause the BUG_ON().
> > 
> > Cheers,
> > --
> > Luís
> But there's a little bit of a deviation in your understanding of the
> problem,
> so the patch doesn't look good.
> The issue is caused by the contradiction between eh_entries and eh_depth.

Ah! This makes a lot of sense and I can confirm this is exactly what
happens in both bugzilla images.  Thanks a lot for your feedback!

> Therefore, we need to check the contradiction instead of adding a judgment
> to ext4_ext_binsearch_idx.
> So the right fix is to add a check to __ext4_ext_check like:
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c148bb97b527..2dfd35f727cb 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -460,6 +460,10 @@ static int __ext4_ext_check(const char *function,
> unsigned int line,
>                 error_msg = "invalid eh_entries";
>                 goto corrupted;
>         }
> +       if (unlikely((eh->eh_entries == 0) && (depth > 0))) {
> +               error_msg = "contradictory eh_entries and eh_depth";
> +               goto corrupted;
> +       }
>         if (!ext4_valid_extent_entries(inode, eh, lblk, &pblk, depth)) {
>                 error_msg = "invalid extent entries";
>                 goto corrupted;
> 
> In this way, we can fix this issue and check for header exceptions before
> calling ext4_ext_binsearch_idx.

Awesome, I'll send out v2 with the suggested change.  It makes sense to
have this check and it should fix both bugs.

On the other hand, I still wonder wether the extra check in my original
patch is correct or not.  I spent a good amount of time trying to find out
if eh_entries can be 0 at that point (in ext4_ext_binsearch_idx()) and
couldn't find a situation where it could.  And running the fstests with
that check didn't show any problem.  But yeah, my understanding of the
whole code is far from perfect.

Cheers,
--
Luís

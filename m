Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C938591145
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Aug 2022 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiHLNUo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 09:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLNUm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 09:20:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271F647FF;
        Fri, 12 Aug 2022 06:20:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5CC5F220D3;
        Fri, 12 Aug 2022 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660310341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrV/CZutnVEuheBmsrDfoz1xY5zNxwT4oWMG9XvH6gk=;
        b=KgUG1FKhKBPOvlLn8+vTzPK00V9OCRXKg9lALwp7603QkynsCRtw8HXhP6vQX49o0J2rGc
        FgaXSYPo4AbIaQNtRccVcS3yquKQi9bXDNtngTSPXtj19K+B6k32E4fmC1DfnO1W5zo104
        8wQbwC6itiClUAtSHH5UOXHTO+1HYgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660310341;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrV/CZutnVEuheBmsrDfoz1xY5zNxwT4oWMG9XvH6gk=;
        b=f4d7mKy1ZXZ9Oom35Wu+jwErlJxCpaQwmRELqLNcYhrYziydneG/fGXeEEM86ra6qvlu/l
        xGB7YVuvjac05MBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C336E13305;
        Fri, 12 Aug 2022 13:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RUWXLERT9mIrKQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 12 Aug 2022 13:19:00 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 32d91cd2;
        Fri, 12 Aug 2022 13:19:47 +0000 (UTC)
Date:   Fri, 12 Aug 2022 14:19:47 +0100
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        wenqingliu0120@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        yebin10@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2] ext4: fix bug in extents parsing when eh_entries == 0
 and eh_depth > 0
Message-ID: <YvZTcxF2DdtVEybn@suse.de>
References: <20220812105347.2251-1-lhenriques@suse.de>
 <e32464ec-4c5b-dcad-cfe3-93727dab5f5b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e32464ec-4c5b-dcad-cfe3-93727dab5f5b@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Baokun!

On Fri, Aug 12, 2022 at 08:50:34PM +0800, Baokun Li wrote:
> Hi Luís,
...
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index 53cfe2c681c4..a5457ac1999c 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -460,6 +460,11 @@ static int __ext4_ext_check(const char *function, unsigned int line,
> >   		error_msg = "invalid eh_entries";
> >   		goto corrupted;
> >   	}
> > +	if (unlikely((le16_to_cpu(eh->eh_entries) == 0) &&
> > +		     (le16_to_cpu(eh->eh_depth > 0)))) {
> 
> The parentheses are misplaced,

I'm not sure I understand what you mean.  I want to have

	if (unlikely((CONDITION A) && (CONDITION B))) {
		/* ... */
	}

so they look correct.  Or is that a matter of style/alignment?  (Which
checkpatch.pl doesn't complains about, by the way.)

>and le16_to_cpu is not needed here.

OK, I guess that, since both conditions do a comparison against '0', the
le16_to_cpu() can be dropped.  And, if the parentheses problem you
mentioned above is a style problem, dropping it will also solve it because
that statement will become

	if (unlikely((eh->eh_entries == 0) && (eh->eh_depth > 0))) {
		/* ... */
	}

And once again, thanks for your review!

Cheers,
-- 
Luís

> 
> > +		error_msg = "eh_entries is 0 but eh_depth is > 0";
> > +		goto corrupted;
> > +	}
> >   	if (!ext4_valid_extent_entries(inode, eh, lblk, &pblk, depth)) {
> >   		error_msg = "invalid extent entries";
> >   		goto corrupted;
> > .
> 
> -- 
> With Best Regards,
> Baokun Li
> 

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5896D5A25A4
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Aug 2022 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245480AbiHZKPk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Aug 2022 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbiHZKP1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Aug 2022 06:15:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF39E2EB
        for <linux-ext4@vger.kernel.org>; Fri, 26 Aug 2022 03:15:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC9C433954;
        Fri, 26 Aug 2022 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661508923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWERBoby0y2fKMPOcYWqV3G22ZIXYss3CujGY4hKOxc=;
        b=LaJhEZ3xVYi+Lrib0wQNEOtZdrsXedyr+AiGpo2fxauNFYDUJrYkzOCLGa7qtffHDPGCId
        N7FHb6ZEVFv+vaE83TpDm+AzeMGrTO3FOC9hNNPhThXgDzcYtboeSAd87yF1azI5AoVAzt
        wd0fWMhcq3EP1XtRlIiiVCnuKdJ90kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661508923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWERBoby0y2fKMPOcYWqV3G22ZIXYss3CujGY4hKOxc=;
        b=fETtBrNJRVhEAFInfDTEWdmy2BeS/W5gfN9JyKBRQLdG6plzaKo3E1l37JCjfHDIWrX716
        C5X7pmx3oXRXQsBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8CE813A7E;
        Fri, 26 Aug 2022 10:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b/D7NDudCGNXVQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 26 Aug 2022 10:15:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3C9EFA0679; Fri, 26 Aug 2022 12:15:22 +0200 (CEST)
Date:   Fri, 26 Aug 2022 12:15:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Message-ID: <20220826101522.b552tn646qobrjdx@quack3>
References: <20220823134508.27854-1-jack@suse.cz>
 <8e164532-c436-241f-33be-4b41f7f67235@i2se.com>
 <20220824104010.4qvw46zmf42te53n@quack3>
 <743489b4-4f9d-3a4d-d87e-e6bf981027c4@i2se.com>
 <20220825091842.fybrfgdzd56xi53i@quack3>
 <0a01dfee-59bf-7a16-6272-683a886e1299@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a01dfee-59bf-7a16-6272-683a886e1299@i2se.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Stefan,

On Thu 25-08-22 18:57:08, Stefan Wahren wrote:
> > Perhaps if you just download the archive manually, call sync(1), and measure
> > how long it takes to (untar the archive + sync) in mb_optimize_scan=0/1 we
> > can see whether plain untar is indeed making the difference or there's
> > something else influencing the result as well (I have checked and
> > rpi-update does a lot of other deleting & copying as the part of the
> > update)? Thanks.
> 
> mb_optimize_scan=0 -> almost 5 minutes
> 
> mb_optimize_scan=1 -> almost 18 minutes
> 
> https://github.com/lategoodbye/mb_optimize_scan_regress/commit/3f3fe8f87881687bb654051942923a6b78f16dec

Thanks! So now the iostat data indeed looks substantially different.

			nooptimize	optimize
Total written		183.6 MB	190.5 MB
Time (recorded)		283 s		1040 s
Avg write request size	79 KB		41 KB

So indeed with mb_optimize_scan=1 we do submit substantially smaller
requests on average. So far I'm not sure why that is. Since Ojaswin can
reproduce as well, let's see what he can see from block location info.
Thanks again for help with debugging this and enjoy your vacation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

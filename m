Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B515C59FCF4
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Aug 2022 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiHXONm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Aug 2022 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiHXONl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Aug 2022 10:13:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A7F97B2E
        for <linux-ext4@vger.kernel.org>; Wed, 24 Aug 2022 07:13:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AE6F201F8;
        Wed, 24 Aug 2022 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661350419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3l3kiQ8H/uc3NhGrsLcqgpNmK117Wzq0oNygB9yvlEs=;
        b=B9cMqbU0d+6Iy1rPWUYQ2j+PgDsvXE4dqCIBz7pdocmUjn1PWR0BDm0LW+3e0WCWUn+vFb
        i+9LvIUC4qRukTGrGMhMIWRRmeYriPSTukrl/eS7GgGJlJBiBnpTCMyuOSC9coB8adogjo
        Bi244t7LdQe5UG+1axMWZYX63MmCZ+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661350419;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3l3kiQ8H/uc3NhGrsLcqgpNmK117Wzq0oNygB9yvlEs=;
        b=pUYKFlgpUBV+Bg7lHjV1swRx51fvyd4LRuumqmj+dXhFuF0/8M+1ZN5Y+quZNnYJt+CehG
        tuJGcfJ2gqdBuNDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76DCC13780;
        Wed, 24 Aug 2022 14:13:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a2zwHBMyBmPdfwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 24 Aug 2022 14:13:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9F578A0679; Wed, 24 Aug 2022 16:13:38 +0200 (CEST)
Date:   Wed, 24 Aug 2022 16:13:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Message-ID: <20220824141338.ailht7uzm6ihkofb@quack3>
References: <20220823134508.27854-1-jack@suse.cz>
 <8e164532-c436-241f-33be-4b41f7f67235@i2se.com>
 <20220824104010.4qvw46zmf42te53n@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824104010.4qvw46zmf42te53n@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 24-08-22 12:40:10, Jan Kara wrote:
> Hi Stefan!
> 
> On Wed 24-08-22 12:17:14, Stefan Wahren wrote:
> > Am 23.08.22 um 22:15 schrieb Jan Kara:
> > > Hello,
> > > 
> > > So I have implemented mballoc improvements to avoid spreading allocations
> > > even with mb_optimize_scan=1. It fixes the performance regression I was able
> > > to reproduce with reaim on my test machine:
> > > 
> > >                       mb_optimize_scan=0     mb_optimize_scan=1     patched
> > > Hmean     disk-1       2076.12 (   0.00%)     2099.37 (   1.12%)     2032.52 (  -2.10%)
> > > Hmean     disk-41     92481.20 (   0.00%)    83787.47 *  -9.40%*    90308.37 (  -2.35%)
> > > Hmean     disk-81    155073.39 (   0.00%)   135527.05 * -12.60%*   154285.71 (  -0.51%)
> > > Hmean     disk-121   185109.64 (   0.00%)   166284.93 * -10.17%*   185298.62 (   0.10%)
> > > Hmean     disk-161   229890.53 (   0.00%)   207563.39 *  -9.71%*   232883.32 *   1.30%*
> > > Hmean     disk-201   223333.33 (   0.00%)   203235.59 *  -9.00%*   221446.93 (  -0.84%)
> > > Hmean     disk-241   235735.25 (   0.00%)   217705.51 *  -7.65%*   239483.27 *   1.59%*
> > > Hmean     disk-281   266772.15 (   0.00%)   241132.72 *  -9.61%*   263108.62 (  -1.37%)
> > > Hmean     disk-321   265435.50 (   0.00%)   245412.84 *  -7.54%*   267277.27 (   0.69%)
> > > 
> > > Stefan, can you please test whether these patches fix the problem for you as
> > > well? Comments & review welcome.
> > 
> > i tested the whole series against 5.19 and 6.0.0-rc2. In both cases the
> > update process succeed which is a improvement, but the download + unpack
> > duration ( ~ 7 minutes ) is not as good as with mb_optimize_scan=0 ( ~ 1
> > minute ).
> 
> OK, thanks for testing! I'll try to check specifically untar whether I can
> still see some differences in the IO pattern on my test machine.

I have created the same tar archive as you've referenced (files with same
number of blocks) and looked at where blocks get allocated with
mb_optimize_scan=0 and with mb_optimize_scan=1 + my patches. And the
resulting IO pattern looks practically the same on my test machine. In
particular in both cases files get allocated only in 6 groups, if I look
at the number of erase blocks that are expected to be touched by file data
(for various erase block sizes from 512k to 4MB) I get practically same
numbers for both cases.

Ojaswin, I think you've also mentioned you were able to reproduce the issue
in your setup? Are you still able to reproduce it with the patched kernel?
Can you help debugging while Stefan is away?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

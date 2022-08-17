Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF5596D2B
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Aug 2022 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiHQK5n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Aug 2022 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiHQK5k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 Aug 2022 06:57:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A75647E8;
        Wed, 17 Aug 2022 03:57:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 14D1934113;
        Wed, 17 Aug 2022 10:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660733857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4BWyW9gcSvWB0CW6rgM7MC0oPUmiDldw9c6waIBSQio=;
        b=On9Oyz228ESgBHAU1IIcMJoE6XpeW8mVpZCkcbTHvIVSBzuW2BXspYa19nlWJvh6AC+rzG
        oxdq2eG26etvUrSiOF6KniDS2Xe9podZAuOcOjmE/9AI7KK2WJp0Yh6/49UVW2lpf25abJ
        ZvVZKijU7Kp2VzpXKi3aKFridGIoJQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660733857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4BWyW9gcSvWB0CW6rgM7MC0oPUmiDldw9c6waIBSQio=;
        b=YaPu5KAD4LQMXb64ACd6xRMVsd9ZnvCGjFxhIOH8jxIA/rEG//RILtQ5TqYMyo6Et+KVDB
        6/9dyfX8ykQuy4Bg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C429E2C178;
        Wed, 17 Aug 2022 10:57:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 13D2AA066B; Wed, 17 Aug 2022 12:57:36 +0200 (CEST)
Date:   Wed, 17 Aug 2022 12:57:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geetika.Moolchandani1@ibm.com, regressions@lists.linux.dev,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [Regression] ext4: changes to mb_optimize_scan cause issues on
 Raspberry Pi
Message-ID: <20220817105736.n22yopqcq7badhe7@quack3>
References: <0d81a7c2-46b7-6010-62a4-3e6cfc1628d6@i2se.com>
 <20220728100055.efbvaudwp3ofolpi@quack3>
 <64b7899f-d84d-93de-f9c5-49538bd080d0@i2se.com>
 <20220816093421.ok26tcyvf6bm3ngy@quack3>
 <b8a5e43a-4d1e-aede-e0f7-f731fd8acf1d@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a5e43a-4d1e-aede-e0f7-f731fd8acf1d@i2se.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Stefan!

On Tue 16-08-22 22:45:48, Stefan Wahren wrote:
> Am 16.08.22 um 11:34 schrieb Jan Kara:
> > Hi Stefan!
> > So this is interesting. We can see the card is 100% busy. The IO submitted
> > to the card is formed by small requests - 18-38 KB per request - and each
> > request takes 0.3-0.5s to complete. So the resulting throughput is horrible
> > - only tens of KB/s. Also we can see there are many IOs queued for the
> > device in parallel (aqu-sz columnt). This does not look like load I would
> > expect to be generated by download of a large file from the web.
> > 
> > You have mentioned in previous emails that with dd(1) you can do couple
> > MB/s writing to this card which is far more than these tens of KB/s. So the
> > file download must be doing something which really destroys the IO pattern
> > (and with mb_optimize_scan=0 ext4 happened to be better dealing with it and
> > generating better IO pattern). Can you perhaps strace the process doing the
> > download (or perhaps strace -f the whole rpi-update process) so that we can
> > see how does the load generated on the filesystem look like? Thanks!
> 
> i didn't create the strace yet, but i looked at the source of rpi-update. At
> the end the download phase is a curl call to download a tar archive and pipe
> it directly to tar.
> 
> You can find the content list of the tar file here:
> 
> https://raw.githubusercontent.com/lategoodbye/mb_optimize_scan_regress/main/rpi-firmware-tar-content-list.txt

Thanks for the details! This is indeed even better. Looking at the tar
archive I can see it consists of a lot of small files big part of them
is even below 10k. So this very much matches the workload I was examining
with reaim where I saw regression (although only ~8%) even on normal
rotating drive on x86 machine. In that case I have pretty much confirmed
that the problem is due to mb_optimize_scan=1 spreading small allocated
files more which is likely also harmful for the SD card because it requires
touching more erase blocks.

Thanks for help with debugging this, I will implement some of the
heuristics we discussed with other ext4 developers to avoid this behavior
and will send you patch for testing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

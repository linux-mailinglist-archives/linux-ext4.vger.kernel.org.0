Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD505B0214
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Sep 2022 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIGKuA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Sep 2022 06:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGKtw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Sep 2022 06:49:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77BD5F9C
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 03:49:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24C2D2031B;
        Wed,  7 Sep 2022 10:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662547788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3vJPxerbcYF/ubCf0lGlcHGu5/9sh31tXR509UEA/8=;
        b=HdX4Po53h7FR8IgJii6YFtOoH5BjqcjkNhFS2waNGrpaKz9bd9W3Ay9fmU8x4FvNMZ/oSf
        Sr2INGeVWN0Do5yTEsxrvsGGoHI/LpqigQ0k2bWHGqcDlM2eE0vlTru3bTqnUBNM6MbfDu
        /rSfPcv5sjz4cmSu4Ii5llpymPMMK8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662547788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3vJPxerbcYF/ubCf0lGlcHGu5/9sh31tXR509UEA/8=;
        b=rRux3cSejxMUnpY3qDiDy1xeQ3NQmGsxYQg5h0pL27p1iYME9PS/RLG607FCGk6l5DDL5X
        fe6yrWe4VDHtTXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C88213A66;
        Wed,  7 Sep 2022 10:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ecv6Akx3GGODUgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 07 Sep 2022 10:49:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5D77AA067E; Wed,  7 Sep 2022 12:49:47 +0200 (CEST)
Date:   Wed, 7 Sep 2022 12:49:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ted Tso <tytso@mit.edu>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 0/5 v2] ext4: Fix performance regression with mballoc
Message-ID: <20220907104947.fwbmewmgbnkug6dl@quack3>
References: <20220906150803.375-1-jack@suse.cz>
 <e4902794-9073-20eb-596a-5aa327adbabe@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4902794-9073-20eb-596a-5aa327adbabe@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Stefan!

On Tue 06-09-22 22:38:10, Stefan Wahren wrote:
> Am 06.09.22 um 17:29 schrieb Jan Kara:
> > Hello,
> > 
> > Here is a second version of my mballoc improvements to avoid spreading
> > allocations with mb_optimize_scan=1. The patches fix the performance
> > regression I was able to reproduce with reaim on my test machine:
> > 
> >                       mb_optimize_scan=0     mb_optimize_scan=1     patched
> > Hmean     disk-1       2076.12 (   0.00%)     2099.37 (   1.12%)     2032.52 (  -2.10%)
> > Hmean     disk-41     92481.20 (   0.00%)    83787.47 *  -9.40%*    90308.37 (  -2.35%)
> > Hmean     disk-81    155073.39 (   0.00%)   135527.05 * -12.60%*   154285.71 (  -0.51%)
> > Hmean     disk-121   185109.64 (   0.00%)   166284.93 * -10.17%*   185298.62 (   0.10%)
> > Hmean     disk-161   229890.53 (   0.00%)   207563.39 *  -9.71%*   232883.32 *   1.30%*
> > Hmean     disk-201   223333.33 (   0.00%)   203235.59 *  -9.00%*   221446.93 (  -0.84%)
> > Hmean     disk-241   235735.25 (   0.00%)   217705.51 *  -7.65%*   239483.27 *   1.59%*
> > Hmean     disk-281   266772.15 (   0.00%)   241132.72 *  -9.61%*   263108.62 (  -1.37%)
> > Hmean     disk-321   265435.50 (   0.00%)   245412.84 *  -7.54%*   267277.27 (   0.69%)
> > 
> > The changes also significanly reduce spreading of allocations for small /
> > moderately sized files. I'm not able to measure a performance difference
> > resulting from this but on eMMC storage this seems to be the main culprit
> > of reduced performance. Untarring of raspberry-pi archive touches following
> > numbers of groups:
> > 
> > 	mb_optimize_scan=0	mb_optimize_scan=1	patched
> > groups	4			22			7
> > 
> > To achieve this I have added two more changes on top of v1 - patches 4 and 5.
> > Patch 4 makes sure we use locality group preallocation even for files that are
> > not likely to grow anymore (previously we have disabled all preallocations for
> > such files, however locality group preallocation still makes a lot of sense for
> > such files). This patch reduced spread of a small file allocations but larger
> > file allocations were still spread significantly because they avoid locality
> > group preallocation and as they are not power-of-two in size, they also
> > immediately start with cr=1 scan. To address that I've changed the data
> > structure for looking up the best block group to allocate from (see patch 5
> > for details).
> > 
> > Stefan, can you please test whether these patches fix the problem for you as
> > well? Comments & review welcome.
> 
> this looks amazing \o/
> 
> With this patch v2 applied the untar with mb_optimize_scan=1 is now faster
> than mb_optimize_scan=0.
> 
> mb_optimize_scan=0 -> almost 5 minutes
> 
> mb_optimize_scan=1 -> almost 1 minute
> 
> The original scenario (firmware download) with mb_optimize_scan=1 is now
> fast as mb_optimize_scan=0.

Glad to hear that!

> Here the iostat as usual:
> 
> https://github.com/lategoodbye/mb_optimize_scan_regress/commit/f4ad188e0feee60bffa23a8e1ad254544768c3bd
> 
> There is just one thing, but not sure this if this comes from these patches.
> If i call
> 
> cat /proc/fs/ext4/mmcblk1p2/mb_structs_summary
> 
> The kernel throw a NULL pointer derefence in
> ext4_mb_seq_structs_summary_show

Yeah, likely a bug in my last patch. I didn't test my changes to the sysfs
interface. Thanks for testing this, I'll have a look.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

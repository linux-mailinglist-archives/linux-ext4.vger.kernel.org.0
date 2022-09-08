Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A18D5B1826
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiIHJMY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiIHJMX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:12:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A62FF50C
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:12:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD09122D91;
        Thu,  8 Sep 2022 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662628340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zO6f3K+IjCx3ZlNRm51AasV7xmzi4VmZ05qH8UdBhDY=;
        b=RtTeSHavegBA16WuQoYIIznwOoHza25JAoh/YxNyDGN9wOd3Y3W1pjhiiIosYjLAFUtPwj
        0QnwL6dLXKFpd7C7FKGLaZrwJJWHMj0xx0aUMI+94l3kjNKGgq9ovs8gEulN1mk7x45/vz
        cocjzRgzX815om0eNuycfzff3xaiLMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662628340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zO6f3K+IjCx3ZlNRm51AasV7xmzi4VmZ05qH8UdBhDY=;
        b=07VIxMsyhPcH2midxKmFp9o3Zwv7YH7u4N6fM1fl8vigcGS1A071cPXLOlApXc0DQ12R3D
        UtYiMQU+JGJ2FuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEDB913A6D;
        Thu,  8 Sep 2022 09:12:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UpWlKvSxGWO2QAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 09:12:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 49664A067E; Thu,  8 Sep 2022 11:12:20 +0200 (CEST)
Date:   Thu, 8 Sep 2022 11:12:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 0/5 v2] ext4: Fix performance regression with mballoc
Message-ID: <20220908091220.zgtbnlyvhu66s3xr@quack3>
References: <20220906150803.375-1-jack@suse.cz>
 <YxmlNPMu58l9LTXU@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxmlNPMu58l9LTXU@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-09-22 13:47:56, Ojaswin Mujoo wrote:
> On Tue, Sep 06, 2022 at 05:29:06PM +0200, Jan Kara wrote:
> > Hello,
> > 
> > Here is a second version of my mballoc improvements to avoid spreading
> > allocations with mb_optimize_scan=1. The patches fix the performance
> > regression I was able to reproduce with reaim on my test machine:
> > 
> >                      mb_optimize_scan=0     mb_optimize_scan=1     patched
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
> > 
> > 								Honza
> > Previous versions:
> > Link: http://lore.kernel.org/r/20220823134508.27854-1-jack@suse.cz # v1
> 
> Hi Jan,
> 
> Thanks for the patch. I tested this series on my raspberry pi and I can
> confirm that the regression is no longer present with both
> mb_optimize_scan=0 and =1 taking similar amount of time to untar. The
> allocation spread I'm seeing is as follows:
> mb_optimize_scan=0: 10
> mb_optimize_scan=1: 17 (Check graphs for more details)
> 
> For mb_optimize_scan=1, I also compared the spread of locality group PA
> eligible files (<64KB) and inode pa files. The results can be found
> here:
> 
> mb_optimize_scan=0:
> https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/patchv2-mbopt0.png
> mb_optimize_scan=1:
> https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/patchv2.png
> mb_optimize_scan=1 (lg pa only):
> https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/patchv2-lgs.png
> mb_optimize_scan=1 (inode pa only):
> https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/patchv2-i.png
> 
> The smaller files are now closer together due to the changes to
> locality group pa logic. Most of the spread is now coming from mid to
> large files.
> 
> To test this further, I created a tar of 2000 100KB files to see if
> there is any performance drop due to higher spread of these files and
> notcied that although the spread is slightly higher(5BGs vs 9), we don't
> see a performance drop while untarring with mb_optimize_scan=1.
> 
> Although we still have some spread, I think we have brought it down to a
> much more manageable level and that combined with improvements to CR1
> allocation have given us a good performance improvement.
> 
> Feel free to add:
> Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks a lot for the throughout testing!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

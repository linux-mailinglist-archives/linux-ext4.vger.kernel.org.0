Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DEF5B355F
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Sep 2022 12:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIIKkX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Sep 2022 06:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIIKkV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Sep 2022 06:40:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA5598582
        for <linux-ext4@vger.kernel.org>; Fri,  9 Sep 2022 03:40:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68BF222411;
        Fri,  9 Sep 2022 10:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662720019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGEBja5nbCxKU44u2UUYmpQVJ4PkdFaBYfpHPde8AfE=;
        b=EObJt+qxDCZNa+oqC651kYm9SJF10kLLAxWdL9PZu5o/mbweI6X9Fx8Z41KqcSOr/YGpTA
        ECDKFez8VHr4HFRyaGQONx/wHRwd/vcSDk0TmOXN+FjZTdtpgJ6OAu816S0OFwmiHjTLSl
        zucx7xakYl6vFsnI/hkh+ADqfmYwl44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662720019;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wGEBja5nbCxKU44u2UUYmpQVJ4PkdFaBYfpHPde8AfE=;
        b=XINvjx8FlwWw6KrmQvTlcrsqiRaUxHVLXewemO4+xOtg3bjlnQ2VuY4WpaoI+Y92NKI77f
        TYTYtg95G87GJeDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E9AB139D5;
        Fri,  9 Sep 2022 10:40:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FzNwBxMYG2PQfQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 09 Sep 2022 10:40:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B6E79A0684; Fri,  9 Sep 2022 12:40:14 +0200 (CEST)
Date:   Fri, 9 Sep 2022 12:40:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ted Tso <tytso@mit.edu>
Subject: Re: [PATCH 0/5 v3] ext4: Fix performance regression with mballoc
Message-ID: <20220909104014.xgzdlzem3f7mbccd@quack3>
References: <20220908091301.147-1-jack@suse.cz>
 <4826b1af-1264-3b3a-e71c-38937c75641c@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4826b1af-1264-3b3a-e71c-38937c75641c@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-09-22 12:36:10, Stefan Wahren wrote:
> Hi Jan,
> 
> Am 08.09.22 um 11:21 schrieb Jan Kara:
> > Hello,
> > 
> > Here is the third version of my mballoc improvements to avoid spreading
> > allocations with mb_optimize_scan=1. Since v2 there are only small changes and
> > fixes found during review and testing. Overall the series looks mostly ready to
> > go, I just didn't see any comments regarding patch 3 - a fix of metabg handling
> > in the Orlov allocator which is kind of independent, I've just found it when
> > reading the code. Also patch 5 needs final review after all the fixes.
> > 
> > Changes since v1:
> > - reworked data structure for CR 1 scan
> > - make small closed files use locality group preallocation
> > - fix metabg handling in the Orlov allocator
> > 
> > Changes since v2:
> > - whitespace fixes
> > - fix outdated comment
> > - fix handling of mb_structs_summary procfs file
> > - fix bad unlock on error recovery path
> 
> unfortunately the real patches doesn't have v3 which leads to confusion.

Yeah, OK, I've updated my scripting for posting patches to include version
in each posted patch :)

> Just a note: in case this series cannot be applied for stable (5.15), we
> need a second solution to fix the regression there.

My plan is to backport the current series. It is not that invasive so it
should be doable...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

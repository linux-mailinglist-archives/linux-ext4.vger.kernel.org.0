Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC5796F84
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Sep 2023 06:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjIGEMQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Sep 2023 00:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbjIGEMP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Sep 2023 00:12:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EFA199F;
        Wed,  6 Sep 2023 21:12:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2592AC433C7;
        Thu,  7 Sep 2023 04:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694059931;
        bh=p2L0hXlRPRMndQiTAhXGSapDao/Jejkqds1JRecNyMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kYyGCcAk/buIL48VKm9WFGqsAa/jXyI8kcaudUqP28atmub5aIkExAC/C+MBstnFS
         a745AhoxRHt1aQr7RqxcJvxCb0YY1t/FkndSNsQEeQz+aUAQXhgRYBNCYLOIUH/97A
         Iq1LFwbyduLmmxmtg7L2W6NXshPlRg2HiwDig8GvHbQ+J7Vm2oqx/M5p06VmyOBZQ7
         77R1pboRr4ASFygkiPsYkxK75wQkzFCMgl7W0USlb6E4VqU5GprbiIG+9pZP/Wfute
         6Lqn/BTW/YEcVF4xLQ/PcDPu8E/nqgAqaT8boYi0g/iP5eRG8r2J5/0p8UpWx6Hg8E
         PsaJbBmZFDy+Q==
Date:   Wed, 6 Sep 2023 21:12:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     fsverity@lists.linux.dev, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] fsverity: move sysctl registration out of signature.c
Message-ID: <20230907041209.GA37146@sol.localdomain>
References: <20230705212743.42180-1-ebiggers@kernel.org>
 <20230705212743.42180-3-ebiggers@kernel.org>
 <CGME20230906134906eucas1p18f20ec4bd1aa89ce9c8c6495255d442f@eucas1p1.samsung.com>
 <20230906134904.4zbqdldrq2k4rqfn@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906134904.4zbqdldrq2k4rqfn@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 06, 2023 at 03:49:04PM +0200, Joel Granados wrote:
> On Wed, Jul 05, 2023 at 02:27:43PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Currently the registration of the fsverity sysctls happens in
> > signature.c, which couples it to CONFIG_FS_VERITY_BUILTIN_SIGNATURES.
> > 
> > This makes it hard to add new sysctls unrelated to builtin signatures.
> > 
> > Also, some users have started checking whether the directory
> > /proc/sys/fs/verity exists as a way to tell whether fsverity is
> > supported.  This isn't the intended method; instead, the existence of
> > /sys/fs/$fstype/features/verity should be checked, or users should just
> > try to use the fsverity ioctls.  Regardlesss, it should be made to work
> > as expected without a dependency on CONFIG_FS_VERITY_BUILTIN_SIGNATURES.
> > 
> > Therefore, move the sysctl registration into init.c.  With
> > CONFIG_FS_VERITY_BUILTIN_SIGNATURES, nothing changes.  Without it, but
> > with CONFIG_FS_VERITY, an empty list of sysctls is now registered.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  fs/verity/fsverity_private.h |  1 +
> >  fs/verity/init.c             | 32 ++++++++++++++++++++++++++++++++
> >  fs/verity/signature.c        | 33 +--------------------------------
> >  3 files changed, 34 insertions(+), 32 deletions(-)
> > 
> > diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> > index c5ab9023dd2d3..d071a6e32581e 100644
> > --- a/fs/verity/fsverity_private.h
> > +++ b/fs/verity/fsverity_private.h
> > @@ -123,6 +123,7 @@ void __init fsverity_init_info_cache(void);
> >  /* signature.c */
> >  
> >  #ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> > +extern int fsverity_require_signatures;
> >  int fsverity_verify_signature(const struct fsverity_info *vi,
> >  			      const u8 *signature, size_t sig_size);
> >  
> > diff --git a/fs/verity/init.c b/fs/verity/init.c
> > index bcd11d63eb1ca..a29f062f6047b 100644
> > --- a/fs/verity/init.c
> > +++ b/fs/verity/init.c
> > @@ -9,6 +9,37 @@
> >  
> >  #include <linux/ratelimit.h>
> >  
> > +#ifdef CONFIG_SYSCTL
> > +static struct ctl_table_header *fsverity_sysctl_header;
> > +
> > +static struct ctl_table fsverity_sysctl_table[] = {
> > +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> > +	{
> > +		.procname       = "require_signatures",
> > +		.data           = &fsverity_require_signatures,
> > +		.maxlen         = sizeof(int),
> > +		.mode           = 0644,
> > +		.proc_handler   = proc_dointvec_minmax,
> > +		.extra1         = SYSCTL_ZERO,
> > +		.extra2         = SYSCTL_ONE,
> > +	},
> > +#endif
> > +	{ }
> > +};
> > +
> Just to double check: When CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not
> defined then you expect an empty directory under "fs/verity". right?

Yes, that's correct.

- Eric

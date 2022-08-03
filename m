Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312F5589275
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 20:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiHCSwl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236531AbiHCSwk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 14:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582794A80F;
        Wed,  3 Aug 2022 11:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1A386132C;
        Wed,  3 Aug 2022 18:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAB5C433D7;
        Wed,  3 Aug 2022 18:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659552758;
        bh=icIFDjn8ZFDiDZSJj06LtCvl/73AMs5IXgcud+vSgro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAWWPPypBN1qmCLTFtPzLpWO4YjKVmT8o3sVefWBH7P/g16x0ASp3Be1qsD4oCzqm
         mgvzeXhWd4O2VSZw/aOPZClsyv7XVtioId4hAQvYOQzL1s6Q0RqOcaY/hrdkMmcGAy
         eS3mPAh7DPzYeOIh988P80u5neH9YHnTqGZfvC9KkKuQYtvTSB+t6b+debEhI3InyN
         RCs/1iyqEO7Is77L3oj2mItN7dqa6CBop6zW/mYhzG/ZRnIxLVO7TgmnkmYdh5X0lG
         gV64ZV1mkmst8s7bPdd9/FqjCTRFUUz7+jt1w6aXCAvo0OcGb4+4v3LIVeEL2KLPEC
         HY21UfoiwoQKg==
Date:   Wed, 3 Aug 2022 11:52:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] common/ext4: provide custom ext4 scratch fs options
Message-ID: <YurD9cItB/yvfvL9@magnolia>
References: <165950050051.198922.13423077997881086438.stgit@magnolia>
 <165950051745.198922.6487109955066878945.stgit@magnolia>
 <20220803182843.mznuba2z7mbti4co@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803182843.mznuba2z7mbti4co@zlang-mailbox>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 04, 2022 at 02:28:43AM +0800, Zorro Lang wrote:
> On Tue, Aug 02, 2022 at 09:21:57PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a _scratch_options backend for ext* so that we can inject
> > pathnames to external log devices into the scratch fs mount options.
> > This enables common/dm* to install block device filters, e.g. dm-error
> > for stress testing.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  common/ext4 |   20 ++++++++++++++++++++
> >  common/rc   |    3 +++
> >  2 files changed, 23 insertions(+)
> > 
> > 
> > diff --git a/common/ext4 b/common/ext4
> > index 287705af..819f9786 100644
> > --- a/common/ext4
> > +++ b/common/ext4
> > @@ -154,3 +154,23 @@ _require_scratch_richacl_ext4()
> >  		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
> >  	_scratch_unmount
> >  }
> > +
> > +_scratch_ext4_options()
> > +{
> > +    local type=$1
> > +    local log_opt=""
> > +
> > +    case $type in
> > +    mkfs)
> > +        log_opt="-J device=$SCRATCH_LOGDEV"
> 
> In _scratch_mkfs_ext4, it deals with mkfs with SCRATCH_LOGDEV:
> 
>   [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
>      $mkfs_cmd -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV && \
>      mkfs_cmd="$mkfs_cmd -J device=$SCRATCH_LOGDEV"
> 
> So is there a conflict or duplication?

Nope, I simply missed that.  I'll respin the patch.

--D

> > +	;;
> > +    mount)
> > +	# As of kernel 5.19, the kernel mount option path parser only accepts
> > +	# direct paths to block devices--the final path component cannot be a
> > +	# symlink.
> > +        log_opt="-o journal_path=$(realpath $SCRATCH_LOGDEV)"
> > +	;;
> > +    esac
> > +    [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
> > +	SCRATCH_OPTIONS="$SCRATCH_OPTIONS ${log_opt}"
> > +}
> > diff --git a/common/rc b/common/rc
> > index dc1d65c3..b82bb36b 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -178,6 +178,9 @@ _scratch_options()
> >      "xfs")
> >  	_scratch_xfs_options "$@"
> >  	;;
> > +    ext2|ext3|ext4|ext4dev)
> > +	_scratch_ext4_options "$@"
> > +	;;
> >      esac
> >  }
> >  
> > 
> 

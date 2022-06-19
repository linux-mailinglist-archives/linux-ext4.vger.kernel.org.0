Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC54550C80
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Jun 2022 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiFSSSi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Jun 2022 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiFSSSh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Jun 2022 14:18:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9CA2BFF;
        Sun, 19 Jun 2022 11:18:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25JIIMqs002746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jun 2022 14:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655662704; bh=SyUfwc+bUGSM/MSdWqbj2kBmTS/hxf15FkYmwwbBpAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RcMcimfNR9ZLl5D7IJBNi/pYD6H8dwZOyJcIZLnrcdQDX5hd1U8Qo71yHsTabJ3Pe
         ED+SZS1Q5NmNgP0gzcp4ACtlEXOwJQPP/FULydujufs1D6a21JhyMV6N0PHFBUwQ7M
         gNHGeqF3VNSlh1vRYn4yvySN+EBz+HrqxhzUoBPbIKOTuUftdsF/iACifD1Exs3dsi
         qgT/0ORdYt8XS9AmnDxSiBoYVI453RdPuFuy/nnU1Y+IezObvF78dTYsFKK9vSlqmx
         W+GEXWRiWZrqNck5Imk+YQM+b64/S2E3jutRnWZmP68Aq6v/gSXLMRA+RZH/kF75Q/
         LZyCNGllPcGnw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4F65F15C431D; Sun, 19 Jun 2022 14:18:22 -0400 (EDT)
Date:   Sun, 19 Jun 2022 14:18:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Liu Peibao <liupeibao@163.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: page-io: use 'unsigned int' to bare use of
 'unsigned'
Message-ID: <Yq9obvFIv8LjAAvg@mit.edu>
References: <20220518120137.2544-1-liupeibao@163.com>
 <YqtDEfJd5uUxucaS@mit.edu>
 <c19b8c8f-7c0f-33e6-3f2c-3425dee7fa8d@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19b8c8f-7c0f-33e6-3f2c-3425dee7fa8d@163.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 19, 2022 at 11:21:27AM +0800, Liu Peibao wrote:
> 
> Thanks for your reply. What I want do to is rename some temporary variables
> in the patch2 and when I make the patch, there are the checkpatch warnings.
> From the point of view "one patch do one thing", I split the modification
> into two patches. Thanks!

I didn't really see the poiont of renaming the temporary variables,
either.

In this particular case basically only used to avoid line lengths from
exceeding ~72 characters, and requiring a line wrap, and bio_start and
bio_end is used only in one place in the code block below.

Is it _really_ all that confusing whether they are named
bio_{start,end} instead of bvec_{start,end}?

If I was writing that code from scratch, I might have just used start
and end without any prefixes.  And as far as "only have a patch do one
thing at a time", this doesn't apply to checkpatch fixes.

The basic motivation behind "no checkpatch-only fixes" is that it
tends to introduce code churn which makes interpreting information
from "git blame" more difficult; and so therefore the costs exceed the
extremely marginal benefits of fixing most checkpatch complaints.  So
making a _patch_ be checkpatch clean, whether it's modifying existing
code or writing new code, is fine, since you're making a subtantive
change to the code, so this is as good a time as any to fix up tiny
nits such as checkpatch complaints.

But the idea behind "no unnecessary code churn since it ruins git
blame and could potentially induce future patch conflicts" also
applies to renaming variables.  The benefits are very minor, and they
don't outweigh the costs.

						- Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89687523A64
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiEKQdr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 12:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiEKQdr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 12:33:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3932380CF;
        Wed, 11 May 2022 09:33:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BGXX7f009557
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652286817; bh=u4YJZkrwuA5TwAFYHV5X/DQbtQlicwtWK2DS81WD6i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dgsxiMXq70eE2Dqt2p2XSXNv1t+dqrJ9XkUY+ZxbspLF81wBf8+TD+tUDHP8/VpCx
         vGQpZ+52SIYtlplzvIpaHtsTUn9y28aJr+BND3lPah4kBKUEqW4XcIcMptMqBGH3LS
         gVypFI/T91iQyzBgO7b7JTGsP7YzUFJKl/ZJoAscnV5I7VGDEhkXKR680Kk7ZX+Kj8
         jlhQfsEDFEGPYT+Ab2b5DtGwc1GrQ1l5Cs2zS7Y1pz23hCCq0TKMU4go/HyUQiDxC9
         TMzgL+BanRwQg+xi9Ke8S1BbzignZWQXm015AiK8Z4kluHwEmJETW479oF+duV8Sf+
         o137FZ9EpGoaw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 436D515C3F0C; Wed, 11 May 2022 12:33:33 -0400 (EDT)
Date:   Wed, 11 May 2022 12:33:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Shaun Tancheff <shaun.tancheff@hpe.com>
Cc:     shaun@tancheff.com, Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Shrink fast commit buffer when not used
Message-ID: <YnvlXdkSsMwUE3Iy@mit.edu>
References: <20220407124244.2014497-1-shaun.tancheff@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407124244.2014497-1-shaun.tancheff@hpe.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 07, 2022 at 07:42:44PM +0700, Shaun Tancheff wrote:
> Shrink the fast-commit buffer when the feature is not
> enabled. By default the fast-commit buffer will allocate 256
> blocks if s_num_fc_blks is 0. Set s_num_fc_blks to a smaller
> value (> 0) to avoid allocating a large unused buffer, this
> also makes more journal credits available when fast commit
> is not used.
> 
> Signed-off-by: Shaun Tancheff <shaun.tancheff@hpe.com>

The journal->j_superblock data structure is stored on disk, so when
you make this change, it's can and will get written back to disk, at
which point the s_num_fc_blks is permanently strunk.  If the file
system might be mounted with the mount option data=journal mode,
fast_commit will be disabled; but it might be subsequently mounted
without this mount option.

Why do you believe this patch is necessary?  If there is a file system
which is only going to be mounted using data=journal, the file system
should simply not be formwatted with the fast_commit option.

       	      	     		     	 - Ted

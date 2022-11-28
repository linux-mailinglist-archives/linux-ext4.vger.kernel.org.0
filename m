Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B863B17E
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 19:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiK1Sjw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 13:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiK1Sjh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 13:39:37 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBD065FA
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 10:39:36 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ASIdVDq005100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 13:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669660773; bh=9tViFCqaBERlF/W5oHB1lpjBHEsRElfF9BLX7uDgZO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YDFPc/0rK6MGpumHB0IQVMdHlABkHWwumvjY5AedBMmfTkVxEz9/1Xf+jcWMkz8EN
         NpGTGea/xOkHC3kXhHN3eIFHiVcP6bgkg3NN6QHRRHPHD+ldzHhEDUgmCZOF6NHOD5
         Cj1mfqqbUw3vfG/6Wf8SM0jJ0MwxwL2gjOpptmKO0oX3cXsZi/kXIEvtIxPo8lDkVi
         hivF9zmU342SYTlwItWsijCM+1T+94wmd2PVTN5n/O4jMhulfDws3PSWKJP+rNbm0u
         sHuztZW93CrP0M60Ncp17JQfFlmy/KQpxqzLDbX4vTIt2D4n3yBxueDI/YfB4LQXIf
         yLKj+/P5UkLKA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CAE7315C3A9A; Mon, 28 Nov 2022 13:39:31 -0500 (EST)
Date:   Mon, 28 Nov 2022 13:39:31 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] test-appliance: force 4 KB block size for bigalloc,
 bigalloc_inline
Message-ID: <Y4UAY2dU799AGm1V@mit.edu>
References: <20221111230101.135830-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111230101.135830-1-enwlinux@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 11, 2022 at 06:01:01PM -0500, Eric Whitney wrote:
> The cfg file for the bigalloc test configuration does not explicitly
> define the file system block size as is done for the 4k configuration,
> although the intent is to test a file system with 4 KB blocks and 64 KB
> clusters.  At least one test, shared/298, runs with a block size of
> 1 KB instead under bigalloc because it creates a file system image less
> than 512 MB in size, a result of the mke2fs.conf block size rule
> for small files.
> 
> shared/298 currently fails when run under bigalloc with 1 KB blocks.
> When the block size is set to 4 KB for the test, it passes.
> 
> Explicitly defining the bigalloc block size will help avoid similar
> surprises in current or future tests written to use small test files.
> Make the same change to the bigalloc_inline config file while we're
> at it.
> 
> v2:  Modify the names of the bigalloc test configurations using 4 KB
> block sizes to explicitly reflect the block size.  Change the
> documentation and supporting files to reflect this.  Bring the
> bigalloc_4k_inline.exclude file up to date (and propagate a change to
> the other .exclude files).  Add a new test configuration for bigalloc
> with 64k blocks, but don't add this configuration to the default list
> of all tests to be run for now.
> 
> The bigalloc_64k and huge_bigalloc_4k configurations are untested.  The
> huge_bigalloc_4k.exclude file will likely need further work if used.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Thanks, applied.

						- Ted

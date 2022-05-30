Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0E85387A8
	for <lists+linux-ext4@lfdr.de>; Mon, 30 May 2022 21:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbiE3TIF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiE3TIE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 15:08:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E05D5D9;
        Mon, 30 May 2022 12:08:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24UJ7kMP004515
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 15:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653937668; bh=6sq+LUSf8RH77tIfsiNyZ2zkYvN0BDH1x63OuSAZ5B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ku7cZoQ1KfI+kzL/PKweTQljp6R5eaMGqUwrLjv292XMnGHD0q4gw/nINz17P/lsO
         25gTOMxy31fCzDugwwMdMciWFhB0b0l5aUBORBxuPP4ZMYmoL6DFHRIl5bqRZb1WtN
         gv8/KLbCLzihH1aau2arNEbfgguvcmqn7kw6oit5yIQ3JP/QqQbcS+ZexDW+ZqJ91b
         A4H2U5jmF0bl7qsADBy0eTW9L0oWFwoEadA3TvKCJlu/CHv4Qu9/v/4t8j+stDCc9t
         DE2xR39WsCrK1i7wn641nUM6qiEGjeMUU86xA/f7o4cZM7jp46MxkkL2hmENgLJLdv
         IdGzx3tty5MAQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9F29115C009C; Mon, 30 May 2022 15:07:46 -0400 (EDT)
Date:   Mon, 30 May 2022 15:07:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH v2] ext4/053: update the test_dummy_encryption tests
Message-ID: <YpUWAgDJAAnbbwqs@mit.edu>
References: <20220530173044.156375-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530173044.156375-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 30, 2022 at 10:30:44AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Kernel commit 5f41fdaea63d ("ext4: only allow test_dummy_encryption when
> supported") tightened the requirements on when the test_dummy_encryption
> mount option is accepted.  Update ext4/053 accordingly.
> 
> Move the test cases to later in the file to group them with the other
> test cases that use do_mkfs to add custom mkfs options instead of using
> the "default" filesystem that the test creates at the beginning.
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

I thought we were going to put in a kernel version check in so that
this won't break on pre-5.19 kernels?  The thinking was that we
wouldn't be backporting commit 5f41fdaea63d to LTS or distro kernels,
so the version number check would be reliable in this instance.

Otherwise people who are testing enterprise kernels, LTS kernels,
etc., will see this test fail.

					- Ted

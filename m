Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90B153C4A7
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jun 2022 07:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbiFCFtB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Jun 2022 01:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241473AbiFCFsu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Jun 2022 01:48:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837811151;
        Thu,  2 Jun 2022 22:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A873C61733;
        Fri,  3 Jun 2022 05:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F3BC385A9;
        Fri,  3 Jun 2022 05:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654235310;
        bh=+3tu2r8/VAwwnbGWUGevtxSRJMJsYrGR9U4GNcZLae0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UM0fQxXNgJIn4th9CV7HpWonc5yXht9hleN7xF5loZihnrAaJBFPGSDaHi7Chd4Mv
         K6Kw7aNUP1U//P5nV/n5xKWjnFdyB7ZKr5gdBd5VNCVB+EQgzBSkajrJVXizJExNAD
         2FbQPqaxTH28Mw/lZNhcALNSliXd/IuDLr76R7LaMbZccrZk3C/e5+ek4HWqK9VJF3
         xqZfWblHStFQGk7M+6pwL0aB0G1rNWVtphnQ1gtyD2hKadFalielnERGSE8FFjOgFd
         a3YaPkYTw3AL1dm+18+S8mrqzHEmY2Ni6e0ZTfgMxE0iSZq5wziEw7b+ruDUOK6WUt
         KBWg0DJMCv2Og==
Date:   Thu, 2 Jun 2022 22:48:28 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4/053: update the test_dummy_encryption tests
Message-ID: <YpmgrJHnrMR8BcOG@sol.localdomain>
References: <20220530173044.156375-1-ebiggers@kernel.org>
 <20220603053143.ud42tcsxrdkr3mj2@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603053143.ud42tcsxrdkr3mj2@zlang-mailbox>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 03, 2022 at 01:31:43PM +0800, Zorro Lang wrote:
> On Mon, May 30, 2022 at 10:30:44AM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Kernel commit 5f41fdaea63d ("ext4: only allow test_dummy_encryption when
> > supported") tightened the requirements on when the test_dummy_encryption
> > mount option is accepted.  Update ext4/053 accordingly.
> > 
> > Move the test cases to later in the file to group them with the other
> > test cases that use do_mkfs to add custom mkfs options instead of using
> > the "default" filesystem that the test creates at the beginning.
> > 
> > Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> > 
> > v2: mention the commit ID now that it is merged, and add a Reviewed-by
> 
> Hi Eric,
> 
> If I don't remember wrong, it was a patchset with 2 patches. Now you only
> send this patch out, do you hope to merge this one only, or merge both?
> 
> Thanks,
> Zorro
> 

Just this one for now.  The second patch would add a test for the bug fix
https://lore.kernel.org/linux-ext4/20220526040412.173025-1-ebiggers@kernel.org,
but that wasn't applied for 5.19 due to a cross-tree dependency.  I'll be
resending that test patch later.  One step at a time...

- Eric

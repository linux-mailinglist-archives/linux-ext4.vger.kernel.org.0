Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B45387DC
	for <lists+linux-ext4@lfdr.de>; Mon, 30 May 2022 21:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbiE3Trk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 15:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243084AbiE3Trk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 15:47:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8595159B;
        Mon, 30 May 2022 12:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDD9AB80CEF;
        Mon, 30 May 2022 19:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F36FC385B8;
        Mon, 30 May 2022 19:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653940056;
        bh=xQHykVT+NFFmoToRLusghXALQbX1yF3klT+Z1wOknpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JW7vNHhvXUyFLTmIFEhcX8j4EOV1F5n4NIYstvQh8KlEeJFL2ZBesecvxDxlfdHZZ
         JinAzFQsKyoa1BVevabTuqVnHOo5avqBJzAo3giVLPgRj1bKXgEA0CgeC4xjHQ9VUU
         ous4AAPU47mnKsyNzK3lGAsOrGGL53NNOIn+M2DbdcKQzH+a+0X/3pQ/cgBPDNPqkv
         i4Ho71+vOGQ6mIn9yrNKo+ofKarTZFyROqPEGfBsUjnjzednIZdi+0aM+1sAiTPE00
         ez41P2bIP+IXwajSAe886N2+gx+BNgD0RZDLMmaVLazbHioYl96C53YS3j0wSP0M4n
         4ezPXWiC1VdMA==
Date:   Mon, 30 May 2022 12:47:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH v2] ext4/053: update the test_dummy_encryption tests
Message-ID: <YpUfVyGkNfQNZA7r@sol.localdomain>
References: <20220530173044.156375-1-ebiggers@kernel.org>
 <YpUWAgDJAAnbbwqs@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpUWAgDJAAnbbwqs@mit.edu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 30, 2022 at 03:07:46PM -0400, Theodore Ts'o wrote:
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
> 
> I thought we were going to put in a kernel version check in so that
> this won't break on pre-5.19 kernels?  The thinking was that we
> wouldn't be backporting commit 5f41fdaea63d to LTS or distro kernels,
> so the version number check would be reliable in this instance.
> 
> Otherwise people who are testing enterprise kernels, LTS kernels,
> etc., will see this test fail.
> 
> 					- Ted

This was already discussed in the original thread.  IIUC, both Zorro and Lukas
prefer *not* having the kernel version check.

The whole test script is still gated on 5.12, so I'll only have to backport the
commit to 5.15 (unless the 5.12 version check gets removed).

- Eric

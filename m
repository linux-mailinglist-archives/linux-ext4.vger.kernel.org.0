Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3549565F484
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jan 2023 20:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjAETcg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Jan 2023 14:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbjAETcM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Jan 2023 14:32:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA47313D49
        for <linux-ext4@vger.kernel.org>; Thu,  5 Jan 2023 11:28:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E4E9B81B41
        for <linux-ext4@vger.kernel.org>; Thu,  5 Jan 2023 19:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070B2C433EF;
        Thu,  5 Jan 2023 19:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672946893;
        bh=wMKR4fbpOktA0sMY6En+Q/0bYctv8yQ4Lz++GdmfYsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwcSMcBvpw5utw62bxuapC5MwilH9Ml5lrbl0GeeC9bcbdfqXDq04JEMEdUpb4nLq
         lgT9R4ehyF67R0mIRHXC7ZYWdYu6NZpQz9SbUXmpOOBVqgS/tsdLtHNf1ag+Axvcmu
         KsXKQKYDx/RzWWuFq4QVhH4NuNEa+nIvWCkOuOW6AtDeamniIuPn773ZHhLB+I2zBc
         MkeNK/iZXtKoS7v81nqRqtiBKEAisLqE3l+/UAcHmZcnEUIRwpZNfJgYmRS9sMHV8F
         iiHdiGwWQBEFq2UwHAXTMZHUKB4erQbbDw4uHIaWTeA1CJawCmtDY+ea8u2COK0L5H
         LDq9WYusnD2hg==
Date:   Thu, 5 Jan 2023 19:28:11 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        Jeremy Bongio <bongiojp@gmail.com>,
        Jeremy Bongio <jbongio@google.com>
Subject: Re: [e2fsprogs PATCH] tune2fs: fix setting fsuuid::fsu_len
Message-ID: <Y7cky6nQUda8S9Dx@gmail.com>
References: <20230104090401.276188-1-ebiggers@kernel.org>
 <20230104103651.eaxele7amb5t7tpu@fedora>
 <CAOvQCn6r83snFOsX78F3BSV9GaNJ-mWPUgQmdrQ0_nA+nvHWVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOvQCn6r83snFOsX78F3BSV9GaNJ-mWPUgQmdrQ0_nA+nvHWVQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 05, 2023 at 10:53:07AM -0800, Jeremy Bongio wrote:
> Thanks for catching that!
> 
> Reviewed-by: Jeremy Bongio <bongiojp@gmail.com>
> 
> On Wed, Jan 4, 2023 at 2:39 AM Lukas Czerner <lczerner@redhat.com> wrote:
> 
> > On Wed, Jan 04, 2023 at 01:04:01AM -0800, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > >
> > > Minus does not mean equals.
> > >
> > > Besides fixing an obvious bug, this avoids the following compiler
> > > warning with clang -Wall:
> > >
> > > tune2fs.c:3625:20: warning: expression result unused [-Wunused-value]
> > >                         fsuuid->fsu_len - UUID_SIZE;
> > >                         ~~~~~~~~~~~~~~~ ^ ~~~~~~~~~

The real thanks goes to the compiler for warning about this.

Ted, considering the build warnings (some of which are caused by actual bugs)
and build errors that regularly show up in new e2fsprogs releases, have you
considered adding some sort of CI to upstream e2fsprogs?

These days, a very common practice for projects on GitHub is to have a ci.yml
file in .github/workflows/ci.yml that enables testing with GitHub Actions, and
require that it passes before accepting pull requests.  That can include
enforcing a clean build with -Wall -Werror with both gcc and clang; building for
Linux, macOS, and Windows; build and testing on non-x86 architectures; enforcing
that the tests pass with sanitization options like ASAN and UBSAN enabled, etc.
Here's the one I use for fscryptctl which is pretty basic but shows a few things:
https://github.com/google/fscryptctl/blob/master/.github/workflows/ci.yml

Now, presumably e2fsprogs development isn't about to move to GitHub.  However,
it's still possible to just push to a fork of the repo on GitHub after applying
patches, and get all the results from GitHub Actions.

And it looks like e2fsprogs is already being mirrored at
https://github.com/tytso/e2fsprogs.

Ted, would you be interested in a .github/workflows/ci.yml file for e2fsprogs so
that CI results will be available at https://github.com/tytso/e2fsprogs/actions?

- Eric

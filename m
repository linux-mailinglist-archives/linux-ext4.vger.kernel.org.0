Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4897D2079
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Oct 2023 01:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjJUXg0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Oct 2023 19:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJUXgZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Oct 2023 19:36:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DBAD76
        for <linux-ext4@vger.kernel.org>; Sat, 21 Oct 2023 16:36:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE04C433C8;
        Sat, 21 Oct 2023 23:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697931382;
        bh=ePJsVbVghIPpOSlBWXWL3Zpf8CxGc78DT241F9Znn6s=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Jes7izl8GIZDoZdhjcdKpFSDBNTYlqrZtRgp1KMFoTgz6Vv5Eg9lJrtxsgw+/Pd8k
         SCgmHgcw5X+ZY5Lx5o7GwzjY39xpPA+U3sDOGJZE+Ru6soJLTDHo/r5UVmYfmfz3NY
         ozD9uqdLam9a7jDUeLpi/XC3H8yV5WI3neuN/wWGYO3a+vVCAbxQBWKaA/8nURCTEk
         DAsVdxCchnhMtzBMEfwZx9HhMmYqcViHBYsFgLuv3pd3+AtEB03wR2aFJzxfDf/nta
         l5OzRTx3Tbnbysuqf6f4KlwSbKHQe9x6RVGDEgb2SPMwwVJd+CJugFtP4qfX21VsSf
         uyB5ST6KcupdA==
Date:   Sat, 21 Oct 2023 16:36:19 -0700
From:   Kees Cook <kees@kernel.org>
To:     andy.shevchenko@gmail.com, Jan Kara <jack@suse.cz>
CC:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Baokun Li <libaokun1@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <ZTLk1G0KCF7YNjRx@surfacebook.localdomain>
References: <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com> <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com> <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com> <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com> <ZTKUDzONVHXnWAJc@smile.fi.intel.com> <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com> <ZTLHBYv6wSUVD/DW@smile.fi.intel.com> <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com> <ZTLk1G0KCF7YNjRx@surfacebook.localdomain>
Message-ID: <BF6761C0-B813-4C98-9563-8323C208F67D@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On October 20, 2023 1:36:36 PM PDT, andy=2Eshevchenko@gmail=2Ecom wrote:
>That said, if you or anyone has ideas how to debug futher, I'm all ears!

I don't think this has been tried yet:

When I've had these kind of hard-to-find glitches I've used manual built-b=
inary bisection=2E Assuming you have a source tree that works when built wi=
th Clang and not with GCC:
- build the tree with Clang with, say, O=3Dbuild-clang
- build the tree with GCC, O=3Dbuild-gcc
- make a new tree for testing: cp -a build-clang build-test
- pick a suspect =2Eo file (or files) to copy from build-gcc into build-te=
st
- perform a relink: "make O=3Dbuild-test" should DTRT since the copied-in =
=2Eo files should be newer than the =2Ea and other targets
- test for failure, repeat

Once you've isolated it to (hopefully) a single =2Eo file, then comes the =
byte-by-byte analysis or something similar=2E=2E=2E

I hope that helps! These kinds of bugs are super frustrating=2E

-Kees

--=20
Kees Cook

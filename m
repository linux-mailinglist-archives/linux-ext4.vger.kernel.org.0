Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326D7755AA5
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jul 2023 06:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjGQEbk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jul 2023 00:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQEbj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jul 2023 00:31:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABDBE45
        for <linux-ext4@vger.kernel.org>; Sun, 16 Jul 2023 21:31:37 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36H4VBcW032431
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 00:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689568277; bh=DX2FGsc/zuGqEoYRVwpitWL4pzdwOUkjpH+YNkuzp2Y=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=RCVa30gNl9kM4D6VozHZDx8G+qwpIjmtX8cKPRiR6JHO3z3W3J0EtDhaj2LLCrDRD
         oWyiYVWAcW2y5/laImvSaxU87lBLs8X0tfgmKxOnAje0UwHB2eJc8NVxYKhgnG/WXL
         zPQ5Nu5zqPTRqYKwmxgMedqTYfbbEQL4BopvEyhmNT8LabWSYXc1u2F41Z3cZA9WmR
         U6wHj/lr5VHsJy4zJUO6UdYB2PdHGdSOHDZ7JNhExI1tYt0bCBrF8Xnd2InF34l2GJ
         4iM+9XdU88C45cRmSogzUJKXy+SSptbk25t4okb7dXiUNuB1dzMlOjwWTNTMm6vlQm
         9ubmeTTdfvQxg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7CB0315C0280; Mon, 17 Jul 2023 00:31:11 -0400 (EDT)
Date:   Mon, 17 Jul 2023 00:31:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: next: kernel BUG at fs/ext4/mballoc.c:4369!
Message-ID: <20230717043111.GA3842864@mit.edu>
References: <CA+G9fYv2FRpLqBZf34ZinR8bU2_ZRAUOjKAD3+tKRFaEQHtt8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYv2FRpLqBZf34ZinR8bU2_ZRAUOjKAD3+tKRFaEQHtt8Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jul 16, 2023 at 11:32:51AM +0530, Naresh Kamboju wrote:
> Following kernel BUG noticed while testing LTP fs testing on x86_64
> arch x86_64 on the Linux next-20230716 built with clang toolchain.

Hmm, I'm not seeing the next-20230716 tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/

or

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/

I see a tag for next-20230717 and for next-20230714, but not
next-20230716.  Was this a typo?  Does it reproduce on the
next-20230717 tree?

Also, since I don't use LTP, can you give me a trimmed-down
reproducer, to save me some time?

Thanks!!

					- Ted

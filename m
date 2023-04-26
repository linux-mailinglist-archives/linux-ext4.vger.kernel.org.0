Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E6F6EFAAF
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Apr 2023 21:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbjDZTLL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 15:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDZTLK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 15:11:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4562F133;
        Wed, 26 Apr 2023 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8Wb/P2xFQ0qJOYrnBz5Avm9fdE/pWEgv5HmuVSwHTpI=; b=V4rqb9GjOm4zKDRpmbAXaNJpjY
        VydQTVOOuTDmbvHN2RjHvHJD6cUB4bH2V3fKV5D2sPe8kh4pdOLzKjYVOlKhBidPuLBgnraL9ciHW
        3ngB9Re3osHIEHSxnnZ5VSo/5M/H0k+z3waSO4qYM93YXuL/XXpJZToTDFlqL7uUy0LRhw2H6TWSy
        9xzFUA0U1332eNelHwm7RiBcov8XC2n2PTOQYiRqloZKrpxHloYa4tw7p3DJgBifFvJDst97g7d7O
        RVFOFirHYd3dp9oCqWMpeC2SdOolVLuVceSHB9YJ3AlQ14IYNjtwV1PyCNb5sIngIpaVEq8XSEDaa
        9DkDLAng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prkXa-002lf7-NW; Wed, 26 Apr 2023 19:10:58 +0000
Date:   Wed, 26 Apr 2023 20:10:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Carpenter <error27@gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
Message-ID: <ZEl3QmF1PYXKaBTz@casper.infradead.org>
References: <20230425041838.GA150312@mit.edu>
 <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 26, 2023 at 10:03:37AM -0700, Linus Torvalds wrote:
> On Mon, Apr 24, 2023 at 9:18 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > Please note that after merging the mm and ext4 trees you will need to
> > apply the patch found here[1].
> >
> > [1] https://lore.kernel.org/r/20230419120923.3152939-1-willy@infradead.org
> >
> > This is due to a patch in the mm tree, "mm: return an ERR_PTR from
> > __filemap_get_folio" changing that function to returning an ERR_PTR
> > instead of returning NULL on an error.
> 
> Side note, itr would be wonderful if we could mark the places that
> return an error pointer as returning "nonnull", and catch things like
> this automatically at build time where people compare an error pointer
> to NULL.

This feels like something smatch could catch.  Adding Dan.

Unfortunately, I don't know that we have any buildbots that run smatch,
and most developers don't, so it'll always be an after-the-fact patch
to fix it rather than "anybody using W=1" or "anybody using C=1" will
catch it before it gets anywhere near a maintainer.

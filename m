Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5C6451F7
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 03:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLGCW5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 21:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLGCW4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 21:22:56 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA2823E88;
        Tue,  6 Dec 2022 18:22:54 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3c090251d59so172315607b3.4;
        Tue, 06 Dec 2022 18:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=87hK10glcNhHV4zXDkx3UM3r+PG7Ihr6tBkX6WXhAAs=;
        b=qltconEcysCUnspDzr69AWdD+WTITkmGJ/O9Gu6/NLZ2gSyt+up7KdtKj1FIg4ateY
         bX6cRHtwX39uHlNiNT+Lscfei3Oqvw3MhORzh14n57S9bK8ByM76VVHENrtYtO707pIT
         FrCYQ9A5vEUU61mxpgTfZ0kBqIUzMn2PtFWVxga7qHFXaemEpoOhp1jk/NiWjxXomb2k
         GXC9X+EZWGnOVFfPm9UPMnOWgJsqoNVVNZbhaD4unvDqyRHYbImrHbbHaEvEO9snEAQF
         /nTdRfGcrcpHdRSWHgXM1XhL+NWjcUsuE6NctOVt6SOLcyGGnDKi/Vu2SsQYkdrcjXfd
         reXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87hK10glcNhHV4zXDkx3UM3r+PG7Ihr6tBkX6WXhAAs=;
        b=fbzcNgKXFtXmZYzO1Gh/AZp8LBZwOBHNaUmN6FgODmP9XPCTdfJT9+i1zGuhS/V46o
         3QxlpOhfaeQjBhNLlhEbISKSS+/5nuTwOWfpLLYZlS+bqjPBFQSb/TrHGvJMOrN9KRLa
         /IYT4TYy+4RFqX5rucyTYcWC3vMZA6tauCls/glgsiiQONOHKGGljJerab+j8LdQpLuG
         +wemaIcluXKZ8hHIgyF87D4JrK1VespMTPT1P80oKaLltDBqEwnz0wbLXvzZ6xxZSKRM
         9kZz2S4SvhovsWOUeIxSTgQc4tqazddHSYg0SBNRkdkCeASHKOducXsXCFbxu6iWc5zR
         JNIA==
X-Gm-Message-State: ANoB5pmVvZX+zsMcxLpMiOVMR3Hk7NSAFEAKb9vGnoYe4uvafI9CZNyL
        4AUAMk0+rti4Xdvk2LCS7SP/NVLiTiJckfqGTHsdlMBj
X-Google-Smtp-Source: AA0mqf4I1wEjh5sgajMRo+CQcrClD/fT861+BuD2d2kayotVh0KVGoz2tHJ3VFd14XzvDDEF5d3Rxh71qvj3afQa16s=
X-Received: by 2002:a81:5243:0:b0:3d2:2098:c5fb with SMTP id
 g64-20020a815243000000b003d22098c5fbmr34140855ywb.121.1670379773652; Tue, 06
 Dec 2022 18:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20221206204115.35258-1-vishal.moola@gmail.com> <Y4+q+vYuqqM0RKOT@casper.infradead.org>
In-Reply-To: <Y4+q+vYuqqM0RKOT@casper.infradead.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Tue, 6 Dec 2022 18:22:42 -0800
Message-ID: <CAOzc2pzwzmXZPXj4M1aY5AUoKrSQvoDGAnVN6b3mXaw0i1TGaQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] ext4: Convert mext_page_double_lock() to mext_folio_double_lock()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Three are inline, which makes sense for the 146 bytes, but we're also
> removing out of line calls as well as the inline calls.
>
> Anyway, whether the description is updated or not, this looks good to me.

I seem to have miscounted. We can correct that part in the description
to "removes 6 calls to compound_head() and 2 calls to folio_file_page()."
Thanks for the review!

> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

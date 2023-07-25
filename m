Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694887609C9
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 07:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjGYFwJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 01:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjGYFwH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 01:52:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5AEE71
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 22:52:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so3990387f8f.3
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 22:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690264322; x=1690869122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/FtUwT9/spcMkR7VjrY/3W+93GEBxPQH5C64yCjsUNY=;
        b=hZhK8yqyPCU6gQ47eSs3rvl/+mzA8qnllaGcH0qKGak8vQIK2xkNdZmYGn4F662v4D
         DbkyxVQc76oGbjgTQUiiQJdA29vCjEWiQUVjxDGW6oxP6vbkf/CRQiNBgfjQ5hIOhbCu
         wC5Q+ui5DEBjrkSWJqoWFUDAMyBK6hLZnhrMbrIO3Y+idyH+TusqM1yZEq8qOCth/bvE
         0VbphYsweZ4co+3DpVFJE0YSHZC/0IcOG0p0Apo7EWLghuutJ9BB+SmnIVZp7gQUMZPE
         FCoZUVRuVq36NxMECr2LXfusmjiOjPG0l5xVQTULJuDN/lmCvlsZh6E+x73Y1x522Emk
         IhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690264322; x=1690869122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FtUwT9/spcMkR7VjrY/3W+93GEBxPQH5C64yCjsUNY=;
        b=dpLAkNvmHJsplYWvBfRqIovI4Z9FdqtTra9IUdZ3xlqctx63GNMTgHqmh3Z3wiVg64
         NzuKrMZIqElIXxkIf/ozjAv4uGyS9+4HLzjfc6F5IGbpfS8w8uHRupqAJROMffO/WHP3
         QOGi25v1Sdtwe4Bbn0jDbdx5vRm3waPq3LiftEY/sM0HcoNcSt8CX1aFHGS+dNHErpNl
         2wAQMfsHgj+Cd134dmPVw8LUe/+gwm+fbSqfkqT7AxsifFKRuvv02HPzS15cvSdMB8NW
         WWC1lcp1qYZYR89VA3Ign7cdL5uNxDUMqouSpC72iKMThMqC5Xw/aSUgtruwVARqT0gS
         QlJQ==
X-Gm-Message-State: ABy/qLbq5adYCZMitIYHV9MX4g5MWgSa9Jdlzlo0VyYsM1phUCuDgwEe
        iGnPoAZy/bnuaR8er5U+GQ/LFoChdllJmoa8SLs=
X-Google-Smtp-Source: APBJJlElsz/2zyU+FYNXdSTi2LIazd6Gy3hVBg2ghcAgs41QegFsOHKPfiW0sQ3QKl5hURjAv9x3ow==
X-Received: by 2002:a5d:5189:0:b0:317:636b:fcb1 with SMTP id k9-20020a5d5189000000b00317636bfcb1mr2648527wrv.27.1690264321883;
        Mon, 24 Jul 2023 22:52:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d60cd000000b0030ada01ca78sm15055816wrt.10.2023.07.24.22.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 22:52:01 -0700 (PDT)
Date:   Tue, 25 Jul 2023 07:33:37 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Su Hui <suhui@nfschina.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, nathan@kernel.org, trix@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: mballoc: avoid garbage value from err
Message-ID: <54fff30b-4662-48c7-8b87-2e8f74d2086b@kadam.mountain>
References: <20230724054538.163319-1-suhui@nfschina.com>
 <CAKwvOdk-fdJr9TcgUnOhCiU0LvD2Qe_c+6YOe-c1k0Ukm+negA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdk-fdJr9TcgUnOhCiU0LvD2Qe_c+6YOe-c1k0Ukm+negA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 24, 2023 at 10:19:02AM -0700, Nick Desaulniers wrote:
> On Sun, Jul 23, 2023 at 10:46 PM Su Hui <suhui@nfschina.com> wrote:
> >
> > clang warning: fs/ext4/mballoc.c, line 4178, column 6
> > Branch condition evaluates to a garbage value.
> 
> Specifically this is clang's static analysis; not the compiler itself.
> 
> >
> > err is uninitialized and will be judged when it enters the
> > loop first time and the condition "!ext4_sb_block_valid()"
> > is true. Although this can't make problems now, it's better
> > to correct it.
> >
> > Signed-off-by: Su Hui <suhui@nfschina.com>
> 
> Hi Su,
> Thanks for the patch!  I see what the warning is getting at;
> 
> If `len <= 0` then `err` is never initialized, then is used at line
> 4178 (that is UB).
> 
> Would you mind sending a v2 with the commit message updated to reflect
> the above points?  I'd be happy to sign-off on that.

The commit message talks about !ext4_sb_block_valid() on the first
iteration through the loop and not that len <= 0.

But either way, brelse(NULL) is a no-op.

regards,
dan carpenter


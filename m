Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BFD6EFB3A
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Apr 2023 21:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjDZTit (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 15:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjDZTis (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 15:38:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55F02684
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 12:38:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5068e99960fso13099993a12.1
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682537925; x=1685129925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFQA6ltmpMBru5G5YdgB88Q73RhVYiSbzEcgxUrcch8=;
        b=dxwkfVxax/XQN9pj1Ll3nTKdox1n0nRTq+qFYGFawVpzwp45IvmoIg1k8+kNw/6asZ
         UAVA71MfBQ079w/Y7xeUiZjAr0Ur8xxK+02OWLABSyYKbG8gKs7ootJDcoOVByLgWWD4
         /hVpSdv8zPyHMF/yfXWUGv0U1cLr+Uxmvv27s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682537925; x=1685129925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFQA6ltmpMBru5G5YdgB88Q73RhVYiSbzEcgxUrcch8=;
        b=B86Nv1+CuBIIlp51Qo8unIPy4Qr07Mm/d9TVQ383JMbrRNDTSbO1hNHpYzoy5HwXwB
         JdUv7IKnQ9iQ6T2shaTpADh2JNS69iJ47+43dYjqKVresVJkg7ax15amJETln4cgbY/q
         2FR2/QIDQaPuOib6LJ33WPV8lfAiJBgdhH1+GFTA1l9+SBNQ5Csz+OgntiZJKPT8Liln
         PZ19w7+Js8eLS/nDdUncESMziSG/V/orRWyNlVP27Tkv95S4TP7jlE5mtLbB4Ncu0CiN
         ++PNTsjjKh/NGti5rQYkcyyTquiJ4XD7UwOVsDGCPZ7enEDuDdIFraDo2xrMPJ4Ekjj5
         h/Qg==
X-Gm-Message-State: AAQBX9cA48vI/XPqrDLHduShr6Px4+QdN0w/MyxwXyidF1C7Ykv4Fqpp
        v0OIkz7RmsraChTdSYpatfnlXsLpwleQ5vCj9+4c8A==
X-Google-Smtp-Source: AKy350YmEohpqWdBjdyXaJ508ZgohcwHa0YJ9tPgfR4TMYUPOU6qGBUxv3iyhDOCIrcOlRmLpHeKZw==
X-Received: by 2002:a05:6402:5169:b0:506:6bd3:a53a with SMTP id d9-20020a056402516900b005066bd3a53amr18329238ede.0.1682537925137;
        Wed, 26 Apr 2023 12:38:45 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7c44f000000b00504a356b149sm7152035edr.25.2023.04.26.12.38.43
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 12:38:43 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9536df4b907so1419480466b.0
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 12:38:43 -0700 (PDT)
X-Received: by 2002:a17:906:c416:b0:953:37eb:7727 with SMTP id
 u22-20020a170906c41600b0095337eb7727mr17746802ejz.43.1682537923395; Wed, 26
 Apr 2023 12:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <ZEl3QmF1PYXKaBTz@casper.infradead.org>
In-Reply-To: <ZEl3QmF1PYXKaBTz@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Apr 2023 12:38:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOEAjUfjoL0UEv1uMV4YoE+3tEFktaBb51T_TUbSem2w@mail.gmail.com>
Message-ID: <CAHk-=wjOEAjUfjoL0UEv1uMV4YoE+3tEFktaBb51T_TUbSem2w@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 26, 2023 at 12:11=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> Unfortunately, I don't know that we have any buildbots that run smatch,
> and most developers don't, so it'll always be an after-the-fact patch

Yeah. The advantage of compiler warnings really is that they get
caught quicker and developers will react to them much better. They
might cause the code to be properly re-organized or rewritten to be
much nicer, for example.

The "trivial tree" kind of fixups for random other issues that get
noticed separately tend to be much more about "work around issue". It
might be the proper fix, of course, but it didn't end up being taken
into account when writing the code, so it often ends up being just a
"papering over the warning" kind of fix. Particularly since the person
trying to fix the problem generally isn't the main developer of that
code.

         Linus

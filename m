Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB686EFD27
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Apr 2023 00:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjDZWcC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 18:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjDZWcB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 18:32:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E478C3585
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 15:31:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-506c04dd879so13374322a12.3
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682548318; x=1685140318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVW5WV/KqwfqyBwNIu5H8m6OJfcQGZ/T7DvmWxmWHzc=;
        b=SK5WhvdhD+pFQAgeMnn+cxG4NVGIZi8UCWzoAoYEwd6MfKAHL4hGv9hryJHO6lbFKN
         3cNxiSH2NXz4vM4JDhm5QzJ8OtcUhZ8mZnUNXxzsxaOZmI40cIb6uVQ2OP4uhSsgnZ/5
         EkWDO8usQILfZAod62VsNHOEm6mbdk3qQCioM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682548318; x=1685140318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVW5WV/KqwfqyBwNIu5H8m6OJfcQGZ/T7DvmWxmWHzc=;
        b=gvl47FZ2arWxnArpFD0n9UnFz2x9qtAuY/MuNj7T2mt/8W0livfzXYZqvA8J/ZdAAO
         mMjArUlLKuDWgAT0fdY+hHnBuB2rli1b2XXfRWU4uM7JO6rC66Wu1lx5cPaGan4l+RIF
         2CeSl5ss+S6zP2R0RpLWo0p9RIiPEFHxI+M8hoBILrrZDN9N+IZ1COtCFofTWsWFuRxK
         DICcPlZAADuh2s0bXKax7a4X/m4+C7Wj9/ehdOPiW/Xc14/ygw78wv055r7VT1KOf1AN
         v2lQtFVzFrg28VzqxlemsgglJzOeeY7I+/jigZw2QSpX6tzstpA6kb+mWUno1pA2enqN
         xSfA==
X-Gm-Message-State: AAQBX9dmvmfCpdAZFca5FMvBzuSGRBtaR9yN1fSFbcz1VXPg/niseIkD
        O2ktr6LCPo5+8bVdY1jQ16LcIdAnYIwCp63EShtklA==
X-Google-Smtp-Source: AKy350Z4aYM8Tdalk1/1RAFyFDO8T1v+CJWkm4J5U0ZlqcE0Y8EwTZ/K0H4ZOyEB3iWZiXJbxh1Jyg==
X-Received: by 2002:a05:6402:110b:b0:4be:b39b:ea8f with SMTP id u11-20020a056402110b00b004beb39bea8fmr18329493edv.2.1682548318234;
        Wed, 26 Apr 2023 15:31:58 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id g24-20020a50ee18000000b0050690bc07a3sm7083068eds.18.2023.04.26.15.31.57
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 15:31:57 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-94f6c285d22so1451694266b.2
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 15:31:57 -0700 (PDT)
X-Received: by 2002:a17:906:224d:b0:94f:3eca:ab05 with SMTP id
 13-20020a170906224d00b0094f3ecaab05mr21379641ejr.59.1682548317009; Wed, 26
 Apr 2023 15:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
 <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
 <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
 <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com> <CAKwvOdn3Unm94UCiXygWTM_KyhATNsy68b_CFbqBDFXshd+34Q@mail.gmail.com>
In-Reply-To: <CAKwvOdn3Unm94UCiXygWTM_KyhATNsy68b_CFbqBDFXshd+34Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Apr 2023 15:31:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_=4EXm_FMYETDo-aETdWPBvJ0_bv+GaOMz2bu8UoWxA@mail.gmail.com>
Message-ID: <CAHk-=wi_=4EXm_FMYETDo-aETdWPBvJ0_bv+GaOMz2bu8UoWxA@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Wed, Apr 26, 2023 at 3:08=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Is this what you had in mind?
> ```
> void * _Nonnull foo (void)
> ...
> void bar (void) {
>     if (foo() =3D=3D NULL) // maybe should warn that foo() returns _Nonnu=
ll?
>         bar();
> ...
> linus.c:8:15: warning: comparison of _Nonnull function call 'foo'
> equal to a null pointer is always false

Yes.

HOWEVER.

I suspect you will find that it gets complicated for more indirect
uses, and that may be why people have punted on this.

For example, let's say that you instead have

   void *bar(void) { return foo(); }

and 'bar()' gets inlined.

The obvious reaction to that is "ok, clearly the result is still
_Nonnull, and should warn if it is tested.

But that obvious reaction is actually completely wrong, because it may
be that the real code looks something like

   void *bar(void) {
#if CONFIG_XYZ
    if (somecondition) return NULL;
#endif
    return foo(); }

and the caller really *should* check for NULL - it's just that the
compiler never saw that case.

So only testing the direct return value of a function should warn.

And even that "direct return value" is not trivial. What happens if
you have something like this:

   void bar(void) { do_something(foo()); }

and "do_something()" ends up being inlined - and checks for its
argument for being NULL? Again, that "test against NULL" may well be
absolutely required in that context - because *other* call-sites will
pass in pointers that might be NULL.

Now, I don't know how clang works internally, but I suspect based just
on the size of your patch that your patch would get all of this
horribly wrong.

So doing a naked

    void *ptr =3D foo();
    if (!ptr) ...

should warn.

But doing the exact same thing, except the test for NULL came in some
other context that just got inlined, cannot warn.

I _suspect_ that the reason clang does what it does is that this is
just very complicated to do well.

It sounds easy to a human, but ...

          Linus

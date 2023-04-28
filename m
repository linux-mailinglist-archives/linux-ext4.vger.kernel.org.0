Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AFD6F2009
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 23:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjD1VTL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjD1VTK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 17:19:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A1C1FF7
        for <linux-ext4@vger.kernel.org>; Fri, 28 Apr 2023 14:19:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94a342f7c4cso52334866b.0
        for <linux-ext4@vger.kernel.org>; Fri, 28 Apr 2023 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682716747; x=1685308747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61ueAZnI+VUsri6o/4rA392h46Og1UAC3oGSqW4xW/E=;
        b=GqN4m+5oDpAvN0PtaOsqULNsTSUSenPjy/O2JJIWrG1stZeQNQLkuJbbnUkn6/ef6I
         fEQ+TmDjjQCjzlCG0CSfMC8MPnUfzacTyvSvop4gjuciyB+S3hpEXPGGC6n1hQjbcW+J
         xMTIp/zt/bGRAk76AZSamtjwgm1xlqCNi+7AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682716747; x=1685308747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61ueAZnI+VUsri6o/4rA392h46Og1UAC3oGSqW4xW/E=;
        b=ixmz7JEHcvHGkb+C/rZrweoRprcy517b8WNqNmmZsutYnouF3wfF6us42vY+9naNwO
         8+/OiVcT4thhyJv/wctZvrkWQzdiSfNlSC84fFpDMTEFEPd+yq8mgVVrytcWEm5PAfCB
         PVMmgr8ZNsCWMifqAd+uPXrUEvhy2oXdUvcSivMsmljba2xHRYZ/dNeiKI99548xyzOM
         3N9rjSbVogYwPYF9/T0g8Z/GeZJXHuS5srwMgE2V2aRyAb4o4VOJ82r8bOXtklWEy7ZT
         jdt8+bRNMpvLTStpdl0NiRcaCrxuzVFEm2lczbo3JEsFhY5gDDkuCIhGxZhEGSpAmC3G
         0hWQ==
X-Gm-Message-State: AC+VfDyFcEVKoBTli/P7xDlvcTiV+6QLJ1ssMveQ9WtIYcfgUZjldEjE
        ALT8357q0L04B9nY2gW7+bYGN0ew/t7awaVE3QLXJQ==
X-Google-Smtp-Source: ACHHUZ7xbrQnb9Wma17PZRuulQFhMcINfd6OM0bjh4UPXQ1GlG4IE8LACj8hJTN/bW/XMjteeARK2g==
X-Received: by 2002:a17:907:7245:b0:94f:36a0:da45 with SMTP id ds5-20020a170907724500b0094f36a0da45mr5889661ejc.29.1682716746915;
        Fri, 28 Apr 2023 14:19:06 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id ox6-20020a170907100600b008f89953b761sm11699089ejb.3.2023.04.28.14.19.06
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 14:19:06 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso318124a12.0
        for <linux-ext4@vger.kernel.org>; Fri, 28 Apr 2023 14:19:06 -0700 (PDT)
X-Received: by 2002:a05:6402:114c:b0:508:4808:b62b with SMTP id
 g12-20020a056402114c00b005084808b62bmr180566edw.22.1682716745923; Fri, 28 Apr
 2023 14:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
 <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
 <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
 <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com>
 <CAKwvOdn3Unm94UCiXygWTM_KyhATNsy68b_CFbqBDFXshd+34Q@mail.gmail.com>
 <CAHk-=wi_=4EXm_FMYETDo-aETdWPBvJ0_bv+GaOMz2bu8UoWxA@mail.gmail.com> <CAKwvOd=mgAMuMODXTapt8JRqEFLS1j-hfssZE0YjJNjPhH=H5A@mail.gmail.com>
In-Reply-To: <CAKwvOd=mgAMuMODXTapt8JRqEFLS1j-hfssZE0YjJNjPhH=H5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 14:18:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwMaS5=J7UgEPuoP_=01O9Ti62JVF-c=a6v3g2YAwzKQ@mail.gmail.com>
Message-ID: <CAHk-=wjwMaS5=J7UgEPuoP_=01O9Ti62JVF-c=a6v3g2YAwzKQ@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kees Cook <keescook@chromium.org>
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

On Fri, Apr 28, 2023 at 2:03=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> >
> >    void *bar(void) {
> > #if CONFIG_XYZ
> >     if (somecondition) return NULL;
> > #endif
> >     return foo(); }
> >
> > and the caller really *should* check for NULL - it's just that the
> > compiler never saw that case.
>
> I think having a return value be conditionally _Nonnull is "garbage
> in; garbage out."

No, no, you misunderstand.

"foo()" is the one that is unconditionally _Nonnull. It never returns NULL.

But *bar()* is not. There's no _Nonnull about 'bar()'. Never was, never wil=
l be.

We are *not* looking to statically mark everything that never returns
NULL as _Nonnull. Only some core helper functions.

If "bar()" is a complicated function that can under some circumstances
return NULL, then it's clearly not _Nonnull.

It does not matter one whit that maybe in some simplified config,
bar() might never return NULL. That simply does *not* make it
_Nonnull.

But my point is that for a *compiler*, this is not actually easy at all.

Because a compiler might inline 'bar()' entirely (it's a trivial
function that only calls 'foo()', after all, so it *should* be
inlined.

But now that 'bar()' has been inlined into some other call-site, that
*other* call site will have a test for "is the result NULL?"

And that other call site *should* have that test. Because it didn't
call "foo()", it called "bar()".

But with the inlining, the compiler will likely see just the call to
foo(), and I suspect your patch would make it then complain about how
the result is tested for NULL.

So it would need to have that special logic of "only warn if the test
is at the same level".

> Thinking more about this, I really think _Nonnull should behave like a
> qualifier (const, restrict, volatile). So the above example would be:
>
> void * _Nonnull ptr =3D foo();
> if (!ptr) // warning: tautology

That would solve the problem, yes. But I suspect it would be very
inconvenient for users.

In particular, it would have made it totally pointless for the issue
at hand: finding *existing* users of  __filemap_get_folio() (that used
to return NULL for errors), and finding the cases where the NULL check
still exists now that it's no longer the right thign to do.

So I think it would largely defeat the use-case. It would only warn
for cases that have already been annotated.

So to be useful, I think it would have to be a "does automagically the
right thing" kind of feature.

                 Linus

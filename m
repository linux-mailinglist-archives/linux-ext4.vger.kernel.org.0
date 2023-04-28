Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA16F1FEE
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 23:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjD1VDL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 17:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjD1VDK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 17:03:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1BC1BF1
        for <linux-ext4@vger.kernel.org>; Fri, 28 Apr 2023 14:03:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52160f75920so178850a12.2
        for <linux-ext4@vger.kernel.org>; Fri, 28 Apr 2023 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682715788; x=1685307788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPmTyVp46+VWPrLDPm2VDU5lMS2dX+ng5TIucBI1L2w=;
        b=YY4CcWGwj+xp3d9e0icFRi21jnpkEdqvx15VgL+ZUOzwriuWYZrsNgWXm6YjPzy6Nl
         GxtWeH4SiguJNxWBA2L0nvqZNww1snQmbbfUHc4whZ7bp7Nhxk/dqpPkjjGrzw5jDBpO
         0o1NkovuBkTp0OFgtRuY7CiyEzdLFqBXtzLHiZ6iT3AezHEv9qM45ZYBKi2Cpw5LFxS+
         tS9MdBYkaBynbJwNvJGBt1y1QAOFT6EJRC/WsxEdAcsByLyp/4e0PQ+Nd2hW4G2TgKLd
         Jxrjj0vwiSMXnRYHN78bNlyjr80g7lmEi8P6w6qmv6m0fuq34mABq534LA1TqNTlk8+I
         Ugzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682715788; x=1685307788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPmTyVp46+VWPrLDPm2VDU5lMS2dX+ng5TIucBI1L2w=;
        b=gDGjIG7Nh+7nMOfB+L5dXw2Ighb5hz6IP8OQSLnb6t2SbQ8FSBtVZ0JFerkAWFA7f+
         jtHCVOgoAHBU/4lRqpAOUDyCcb/UWScJc3kMF4guhNTD946Hzo+snyvlbTJidAB71718
         vFfxlXs3Y7ybSuXwcEp5HZLkFPGBQj9YH5QjVle0VsJ+0E7O98iKyAEF395PcM3yd9dz
         3ltuWTGKDNLaqEwomrhn0SZdVAaPbir7l1o4fyeoJ/Mxog3p5PsPkpkCDQM85v3VO5Uy
         nmonTHiChxJQGrEm96ZdZlY6pARgGzC24QCNO+fWYtZwFD40xxhlJxb50fV0i78DIaVE
         lyMg==
X-Gm-Message-State: AC+VfDwzuSGh/FTxqXjXjz+vuRTYql7KQngv7gjlNcpIiUbz0tEzW1b3
        uQN+CJPHxxo3muWEomJga9L6t1DFydlRewiixTI13w==
X-Google-Smtp-Source: ACHHUZ4/C+pcsGR45h3MfmotqGCbxqb7IuQVuzmvPi6rcbjzi2na6M/HMJEKu7VHxwuDV9/E3+xIKeVnwVdZrqTl+OA=
X-Received: by 2002:a17:90a:fb53:b0:240:7f0d:9235 with SMTP id
 iq19-20020a17090afb5300b002407f0d9235mr6465444pjb.22.1682715788129; Fri, 28
 Apr 2023 14:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
 <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
 <CAHk-=wjXDzU1j-cCB28Pxt-=NV5VTbnLimY3HG4uF0HPP7us_Q@mail.gmail.com>
 <CAKwvOdm3gkAufWcWBqDMQNRXVqJjooFQ4Bi5YPHndWFCPScG+g@mail.gmail.com>
 <CAHk-=wib1T7HzHOhZBATast=nKPT+hkRRqgaFT9osahB08zNRg@mail.gmail.com>
 <CAKwvOdn3Unm94UCiXygWTM_KyhATNsy68b_CFbqBDFXshd+34Q@mail.gmail.com> <CAHk-=wi_=4EXm_FMYETDo-aETdWPBvJ0_bv+GaOMz2bu8UoWxA@mail.gmail.com>
In-Reply-To: <CAHk-=wi_=4EXm_FMYETDo-aETdWPBvJ0_bv+GaOMz2bu8UoWxA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 28 Apr 2023 14:02:56 -0700
Message-ID: <CAKwvOd=mgAMuMODXTapt8JRqEFLS1j-hfssZE0YjJNjPhH=H5A@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 26, 2023 at 3:31=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Apr 26, 2023 at 3:08=E2=80=AFPM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Is this what you had in mind?
> > ```
> > void * _Nonnull foo (void)
> > ...
> > void bar (void) {
> >     if (foo() =3D=3D NULL) // maybe should warn that foo() returns _Non=
null?
> >         bar();
> > ...
> > linus.c:8:15: warning: comparison of _Nonnull function call 'foo'
> > equal to a null pointer is always false
>
> Yes.
>
> HOWEVER.
>
> I suspect you will find that it gets complicated for more indirect
> uses, and that may be why people have punted on this.
>
> For example, let's say that you instead have
>
>    void *bar(void) { return foo(); }
>
> and 'bar()' gets inlined.
>
> The obvious reaction to that is "ok, clearly the result is still
> _Nonnull, and should warn if it is tested.
>
> But that obvious reaction is actually completely wrong, because it may
> be that the real code looks something like
>
>    void *bar(void) {
> #if CONFIG_XYZ
>     if (somecondition) return NULL;
> #endif
>     return foo(); }
>
> and the caller really *should* check for NULL - it's just that the
> compiler never saw that case.

I think having a return value be conditionally _Nonnull is "garbage
in; garbage out."  The straightforward case would be to have `bar` be
conditionally _Nonnull on the same preprocessor condition.

void *
#ifndef CONFIG_XYZ
_Nonnull
#endif
bar (void) {
#ifdef CONFIG_XYZ
  if (somecondition) return NULL;
#endif
  return foo(); }

Then code reviewers could go: "yikes; please make bar unconditionally
_Nonnull, or simply don't use _Nonnull here."

>
> So only testing the direct return value of a function should warn.
>
> And even that "direct return value" is not trivial. What happens if
> you have something like this:
>
>    void bar(void) { do_something(foo()); }
>
> and "do_something()" ends up being inlined - and checks for its
> argument for being NULL? Again, that "test against NULL" may well be
> absolutely required in that context - because *other* call-sites will
> pass in pointers that might be NULL.
>
> Now, I don't know how clang works internally, but I suspect based just
> on the size of your patch that your patch would get all of this
> horribly wrong.

Of course, it was a quick hack.

>
> So doing a naked
>
>     void *ptr =3D foo();
>     if (!ptr) ...
>
> should warn.
>
> But doing the exact same thing, except the test for NULL came in some
> other context that just got inlined, cannot warn.

Thinking more about this, I really think _Nonnull should behave like a
qualifier (const, restrict, volatile). So the above example would be:

void * _Nonnull ptr =3D foo();
if (!ptr) // warning: tautology

That would require changes to the variables that calls to functions
that return ERR_PTR's were stored in.  That simplifies the semantic
analysis, since the compiler can simply look at the declaration of
`ptr` and not try to see that `ptr`'s value at some point in the
control flow graph was something returned from calling a _Nonnull
returning function.

Because _Nonnull isn't modeled as a qualifier in clang today, this doesn't =
warn:
```
void foo(void* _Nonnull);
void *bar(void);

void baz (void) {
  void *x =3D bar();
  foo(x);
}
```
It would be nice to say that "baz calls foo which expects its
parameter to be _Nonnull, but you passed a pointer that could be
null".  I also wonder if casting works...

Rust got this right; pretty sure they have NonNull and NonZero types.


>
> I _suspect_ that the reason clang does what it does is that this is
> just very complicated to do well.
>
> It sounds easy to a human, but ...

The bones are there; we could finish the damned thing if it sounds
like something that would be useful/usable in the kernel?  I guess the
impetus is that ERR_PTR checks should be comparing against < 0 rather
than =3D=3D NULL, since that's a tautology?

--=20
Thanks,
~Nick Desaulniers

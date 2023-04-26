Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399506EF97B
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Apr 2023 19:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjDZRey (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Apr 2023 13:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjDZRes (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Apr 2023 13:34:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F217122
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 10:34:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2496863c2c7so6238654a91.1
        for <linux-ext4@vger.kernel.org>; Wed, 26 Apr 2023 10:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682530479; x=1685122479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnP+eYqDIqeo8coo+95vLR95RWSg/j9f2g7CwZiAsuk=;
        b=Fyjcy32wygKCr5y70MunVl9V2XGmo1U4DuwDAi607v9Ue3C97nr4LlUZi7qsUGpZls
         ImvvYnA1qdVf91ZJo94qSFXVBumEwweYQcl7BPptk5az7VEGNGJHpipdMG93RdOrZY5t
         e4KeI8MvLdhMuBCIs2CiGEvQTcrsc2mpPdU3tv9/XNsTxaNTvHb0g0nHPeEPRV3VAyy0
         QbhIgET9Xed6qIOKqD/yigU3Bx2Uh2uxHjTKcVBQOxeGov1bcaD9hHb+jVia/CS1i2Cf
         Y2FRbRdwkpbBrbyvnjDKPkBUHOtdOLk2B5au8ovifGxma1TGCRiHAHnQWp5O9sebpsIz
         tnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682530479; x=1685122479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnP+eYqDIqeo8coo+95vLR95RWSg/j9f2g7CwZiAsuk=;
        b=XxAIhlhbrWRQfg1e5xadHkRrvURdhvs4RZLhRmlXFnzjWTawq2lCPF7pFBjGHBjLSd
         up+aTtekBhJm+nSECDQP4ujaXz7YxBnNxq4pojZCudemOzu7FIQVs7G1u4J7QuNOju1Q
         BujGoOsMUmNr5+6CDvtdwU5vrZiVkg2eBhhpQl/fLwPmHz/P2wUOTsCUcpQDNdLYzgsZ
         KYCTjITK+Dv8YBUGCSoMh/SN1mXkopsTr87U/f4s3RJ9Td4TMOoM/H6qwPElL7Kr07lK
         62b+Xfcydw0fXirujbXRvtoO6fOduQYwqL7pU08ML9aNN9d8GYCeortFXm1uRc5kaLxM
         aXdQ==
X-Gm-Message-State: AAQBX9cS5Pfb5qpcsd26Ai3mdDYwj7/TxtkIUpmg5RWxjc9vj6Sd+LqZ
        Ex+NrayGjkm03C/BkHXEFkSiM9PqK6qIR16wSmu0ghR4j+7g9fPoMDqAHQ==
X-Google-Smtp-Source: AKy350apifD2OfEFPqhuCMgz9gIY1LT3xl9XDOoAx73C6Vc4BsIQZEoD5WNsc/ODLfUz0nURi9u2HoT+e0XXD1q9hns=
X-Received: by 2002:a17:90b:a0c:b0:246:5f9e:e4cd with SMTP id
 gg12-20020a17090b0a0c00b002465f9ee4cdmr21508551pjb.10.1682530478741; Wed, 26
 Apr 2023 10:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230425041838.GA150312@mit.edu> <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiP0983VQYvhgJQgvk-VOwSfwNQUiy5RLr_ipz8tbaK4Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Apr 2023 10:34:27 -0700
Message-ID: <CAKwvOdmXgThxzBaaL_Lt+gpc7yT1T-e7YgM8vU=c7sUita6aaw@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 changes for the 6.4 merge window
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 26, 2023 at 10:03=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 24, 2023 at 9:18=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wro=
te:
> >
> > Please note that after merging the mm and ext4 trees you will need to
> > apply the patch found here[1].
> >
> > [1] https://lore.kernel.org/r/20230419120923.3152939-1-willy@infradead.=
org
> >
> > This is due to a patch in the mm tree, "mm: return an ERR_PTR from
> > __filemap_get_folio" changing that function to returning an ERR_PTR
> > instead of returning NULL on an error.
>
> Side note, itr would be wonderful if we could mark the places that
> return an error pointer as returning "nonnull", and catch things like
> this automatically at build time where people compare an error pointer
> to NULL.

That's what clang's _Nonnull attribute does (with -Wnullability-extension).
https://godbolt.org/z/6jo1zbMd9
But it's not toolchain portable, at the moment.  Would require changes
to clang to use the GNU C __attribute__ syntax, too (which I'm not
against adding support for).

>
> Howeder, it sadly turns out that compilers have gotten this completely wr=
ong.
>
> gcc apparently completely screwed things up, and "nonnull" is not a
> warning aid, it's a "you can remove tests against NULL silently".
>
> And clang does seem to have taken the same approach with
> "returns_nonnull", which is really really sad, considering that
> apparently they got it right for "_Nonnull" for function arguments
> (where it's documented to cause a warning if you pass in a NULL
> argument, rather than cause the compiler to generate sh*t buggy code)

Heh, I just had this conversation maybe within the past month with
Bionic (Android's libc) developers.

Yeah, the nonnull attributes !=3D _Nonnull "attributes." (Quotes because
IIUC _Nonnull doesn't use the __attribute__ GNU C extension syntax).
My understanding (which may be wrong) is that nonnull is implemented
for compatibility with GCC, while _Nonnull was likely implemented by
Apple (my guess; did not check) (so compatibility with GNU C
__attribute__ syntax probably wasn't considered in code review).

https://clang.llvm.org/docs/AttributeReference.html#nullability-attributes

The Bionic developers are deploying _Nonnull throughout the codebase
and intentionally not using nonnull which is dangerous (a teammate
used the term "Developer Hostile Behavior"). nonnull has implications
on codegen, _Nonnull only affects diagnostics.

https://android-review.googlesource.com/q/owner:zijunzhao@google.com+Nullab=
ility

For examples. Works on return types, too.  So _Nonnull can be used on
return types rather than returns_nonnull.

>
> Compiler people who think that "undefined behavior is a good way to
> implement optimizations" are a menace, and should be shunned. They are
> paste-eaters of the worst kind.

Thanks! :-*

>
> Is there any chance that somebody could hit compiler people with a big
> clue-bat, and say "undefined behavior is not a feature, it's a bug",
> and try to make them grow up?

Good. I can feel your anger. Strike me down with all of your hatred,
and your journey to the dark side will be complete.  Your hate has
made you powerful.  Let the hate flow through you!

>
> Adding some clang people to the participants, since they at least seem
> to have *almost* gotten it right.
>
>             Linus



--=20
Thanks,
~Nick Desaulniers

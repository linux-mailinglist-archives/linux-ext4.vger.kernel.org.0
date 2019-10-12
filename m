Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6EED4C29
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Oct 2019 04:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfJLCit (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Oct 2019 22:38:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36154 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfJLCit (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Oct 2019 22:38:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id y189so10744360qkc.3
        for <linux-ext4@vger.kernel.org>; Fri, 11 Oct 2019 19:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaK9BR67+rhFLFX97PHmVHQTwSBBZcyj4RtQnRsDFkM=;
        b=MbkFX3Sd/BlbojJ3jgUxhaRW7hljwgdnEIv0NIRVzYnPAk+zQA0Kd6nINOJLu54Jk5
         ghhq1zUNeZrL5IWWGrQC6Qt5Orjz53Kbu358bC7yqnjww06WJeLw15GLMA03Spxtpt84
         9uqC2dp6yxsWnXyKukK//uuVrD4gacza8QAQTdgLqzgX0qSFjiPT6sAq5JivrTtp9VMc
         CCIiK63+d7u13gpkcMFiVHpA7gSMkfLA6BkdqLmjQiH9ozsWvQXlhJVcRxFanhk3ig62
         G8963/LOrog8VBDu7vF/3jLMyTjIgWXozO3B3cTRytASO/J07Uqq7dmPqiMXZDsqfTNm
         DTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaK9BR67+rhFLFX97PHmVHQTwSBBZcyj4RtQnRsDFkM=;
        b=ZGlJHQF9ZLfs/HBmRq3rD1ZZr7Fh3G2Aw62C27HMLSrnVxudfytLoauMxjLWnVuAL7
         4dKMKFaUfZ0XJGuWaXCH5qgwdiY5Bg6bKTWQ1cvNQZ6B+Y2ErMyNYX5G8UlDYEYfdcQZ
         mEYeBbiSKLk8QxlE8itPd8KJldv1uuvmHm8M7gbY/qkwlZp1PJ7oBdzq8VSDyrzuln7v
         r9i4EHc8x/M5iCI5Ly+VvvHLdpWIW5SYoSIehp8g3JG4FV1E5w5NnxvbV8/bG21ISCHk
         +aIrBrEVErS6YMbf4mX5pnskDNxRovynv5FvaFHqABhrTBjaOR4Y2uZ33+tGYl6cgyuO
         ZTFA==
X-Gm-Message-State: APjAAAVw9zv+DkxrdK+hIXVAVmYOhHdflh76qLKQ54Fd2zUFY4YU/RS6
        3/LK84DvIuAuT03evmY+qtA8bljhaNmXtBcnDxNS
X-Google-Smtp-Source: APXvYqxfMCB4N8W/giogVA/8Ew2r6bABddogG6i9QTyaQO1MXsaS7fXL2+Swz8v66X3FLn5+V/OacC3uCzP0oAutec4=
X-Received: by 2002:a05:620a:2193:: with SMTP id g19mr19601821qka.184.1570847926389;
 Fri, 11 Oct 2019 19:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com> <20191011131902.GC16225@mit.edu>
In-Reply-To: <20191011131902.GC16225@mit.edu>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Fri, 11 Oct 2019 19:38:10 -0700
Message-ID: <CAAXuY3rPV7Gz=QhTKnkHS3nJFytAB5HkVWsTkR+KRo0mw-epsQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 11, 2019 at 6:19 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Oct 11, 2019 at 03:05:43AM -0700, Brendan Higgins wrote:
> > That's an interesting point. Should we try to establish a pattern for
> > how tests should be configured? My *very long term* goal is to
> > eventually have tests able to be built and run without any kind of
> > kernel of any kind, but I don't think that having a single config for
> > all tests in a subsystem gets in the way of that, so I don't think I
> > have a strong preference in terms of what I want to do.
> >
> > Nevertheless, I think establishing patterns is good. Do we want to try
> > to follow Ted's preference as a general rule from now on?
>
> As I suggested on another thread (started on kunit-dev, but Brendan
> has cc'ed in linux-kselftest), I think it might really work well if
> "make kunit" runs all of the kunit tests automatically.  As we add
> more kunit tests, finding all of the CONFIG options so they can be
> added to the kunitconfig file is going to be hard, so kunit.py really
> needs an --allconfig which does this automatically.
>
> Along these lines, perhaps we should state that as a general rule the
> CONFIG option for Kunit tests should only depend on KUINIT, and use
> select to enable other dependencies.  i.e., for the ext4 kunit tests,
> it should look like this:
>
> config EXT4_KUNIT_TESTS
>         bool "KUnit test for ext4 inode"
>         select EXT4_FS
>         depends on KUNIT
> ...
Done

> In the current patch, we use "depends on EXT4_FS", which meant that
> when I first added "CONFIG_EXT4_KUNIT_TESTS=y" to the kunitconfig
> file, I got the following confusing error message:
>
> % ./tools/testing/kunit/kunit.py  run
> Regenerating .config ...
> ERROR:root:Provided Kconfig is not contained in validated .config!
>
> Using "select EXT4_FS" makes it much easier to enable the ext4 kunit
> tests in kunitconfig.  At the moment requiring that we two lines to
> kunitconfig to enable ext4 isn't _that_ bad:
>
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_KUNIT_TESTS=y
>
> but over time, if many subsystems start adding unit tests, the
> overhead of managing the kunitconfig file is going to get unwieldy.
> Hence my suggestion that we just make all Kunit CONFIG options depend
> only on CONFIG_KUNIT.
>
> > I agree with Iurii. I don't think that this example alone warrants
> > adding support for being able to read test data in from a separate
> > file (I would also like some clarification here on what is meant by
> > reading in from a separate file). I can imagine some scenarios where
> > that might make sense, but I think it would be better to get more
> > examples before trying to support that use case.
>
> So what I was thinking might happen is that for some of the largest
> unit tests before I would transition to deciding that xfstests was the
> better way to go, I *might* have a small, 100k ext4 file system which
> would checked into the kernel sources as fs/ext4/kunit_test.img, and
> there would be a makefile rule that would turn that into
> fs/ext4/kunit_test_img.c file that might look something like:
>
> const ext4_kunit_test_img[] = {
>       0xde, ...
>
> But I'm not sure I actually want to go down that path.  It would
> certainly better from a test design perspective to create test mocks
> at a higher layer, such as ext4_iget() and ext4_read_block_bitmap().
>
> The problem is that quite a bit of code in ext4 would have to be
> *extensively* refactored in order to allow for easy test mocking,
> since we have calls to sb_bread, ext4_bread(), submit_bh(), etc.,
> sprinkled alongside the code logic that we would want to test.
>
> So using a small test image and making the cut line be at the buffer
> cache layer is going to be much, *much* simpler at least in the short
> term.  So the big question is how much of an investment (or technical
> debt paydown) do I want to do right away, versus taking a shortcut to
> get better unit test coverage more quickly, and then do further tech
> debt reduction later?
>
>                                        - Ted

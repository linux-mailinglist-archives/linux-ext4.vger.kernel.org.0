Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13644432452
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Oct 2021 18:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhJRQ6n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Oct 2021 12:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbhJRQ6h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Oct 2021 12:58:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E97C061765
        for <linux-ext4@vger.kernel.org>; Mon, 18 Oct 2021 09:56:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ec8so1700588edb.6
        for <linux-ext4@vger.kernel.org>; Mon, 18 Oct 2021 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deitcher-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vB7K9gwOKYUCAd9Ao2mvg3c3InKlIoXhZetYs+ZShwU=;
        b=ON9ph9CsgqJW2g91qE6I9Pi++fc8ML5uq+6kIEwjYPo1owBAzYAIrusUzRQh0EPNrt
         BfwM31vtD9IZmJkqiUatWo56uNGLmLTlB4tZMuxISd5P5YxCtsUDUGRXSdfX8sf1L6bv
         xvZPlsLTpJrhP3FXNsf98AV1rjdFDaEIs2VtEglOBP2zd8E/PnwGIrtmIvFsgdbmwdOg
         1U2mbYef2qWjHF4hrrmYN8xxFU7lz5yEAkRx7YevUYh4GyqkYF1D2W/L4NedIk/bwYQN
         shSYgGbpCEAhvtwnnUMwG5lo+rwEquP2r3bqDjeklM+IUrjgvNEPPAJPEDjjXmQDcAY2
         l42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vB7K9gwOKYUCAd9Ao2mvg3c3InKlIoXhZetYs+ZShwU=;
        b=TliWTDYkoS2EaoKmCdufRzbUEBsvu/gHESqIew6BMUpghz+Iqpm6vaVItuZESQhqXA
         t6VhmRgsPlBsvflJh42rGrKNStlgsTF0naI8SbOENB5yiCMWLWYc0CK83b34kU08D0Ff
         ss5xm2yCZ2BszdzgU43Kdv4GKesTVK/PKABwOJCfwjrLMiX36cJGEPIRmWd9i0EiNk9t
         u0nyJCSNqCHijSnMKENJ2E7uNPPayJfEBxSJhhnO/hF5wd7VdpwdQt4vIE35+XK5N1UO
         lUTNOd5CYLEK3AqlQUygnL6ymvS0T6LG7Gh4QRPmC8Xl7VBFZQ1JOoX+LocBwso0qsr2
         oXxw==
X-Gm-Message-State: AOAM530xYFgPrHCVsanVLBeri7euqfB0fXc2eiC0aHg8NitPsrQzK0Rx
        uRWNygBa4C37al8I5YJQWxadGb1RikU1rrNHTVmOCvWItZVVhQ==
X-Google-Smtp-Source: ABdhPJwBWmZAe//KLGZws+LtLna9YYnCfXsC40Vrph9SlR5f/6Hpj7k1g++SNIEKucjQ3Ggky8KbpdqBddwG5LV7mGU=
X-Received: by 2002:a50:e0c3:: with SMTP id j3mr45348577edl.97.1634576184229;
 Mon, 18 Oct 2021 09:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca> <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
 <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com>
 <YWSck57bsX/LqAKr@mit.edu> <CAF1vpkiKx3jArgjNBrid9-MSHBweGsFL0zu0UgDX_dq_hrkUgw@mail.gmail.com>
 <YWXGRgfxJZMe9iut@mit.edu> <CAF1vpkggQpYrg7Z2VVK69pPBo0rSjDUsm8nB8dyES27cmDEf2g@mail.gmail.com>
 <YWnSMXcR5anaYTEU@mit.edu> <YWnbjI9Fo0gKmwS5@mit.edu>
In-Reply-To: <YWnbjI9Fo0gKmwS5@mit.edu>
From:   Avi Deitcher <avi@deitcher.net>
Date:   Mon, 18 Oct 2021 19:56:13 +0300
Message-ID: <CAF1vpkiK6=gvqD27sLaDnB79ekjKzYjwEP5=u9+D_mQi_5oJwA@mail.gmail.com>
Subject: Re: algorithm for half-md4 used in htree directories
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Yes, it definitely was my silly use of sizeof() instead of strlen().
Switch to strlen(), and my test program's output (using little-endian
for each u32) gives the exact same output.

Looks like I owe you that beer (and happy to share it with you) next
time we are in the same place!

On Fri, Oct 15, 2021 at 10:50 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> Oh, and taking a quick look at your program, here's at least one of
> the bugs:
>
> static void calculate(char *name) {
>                       ^^^^^^^^^^
> ...
>     __ext4fs_dirhash(name, sizeof(name), &hinfo);
>                            ^^^^^^^^^^^^
>
> With apologies to the movie "The Princess Bride"[1]:
>
>     You fell victim to one of the classic blunders!  The most famous
>     is to never get involved in a land war in Asia, but only slightly
>     less well-known is this: 'taking the size of a C pointer is
>     generally not what you had wanted to do'!  :-)
>
> [1] https://www.youtube.com/watch?v=R7TFPQqglb4
>
>                                - Ted



-- 
Avi Deitcher
avi@deitcher.net
Follow me http://twitter.com/avideitcher
Read me http://blog.atomicinc.com

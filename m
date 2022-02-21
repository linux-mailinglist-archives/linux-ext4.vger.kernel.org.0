Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C74BE20A
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Feb 2022 18:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245617AbiBUJsm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Feb 2022 04:48:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352479AbiBUJra (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Feb 2022 04:47:30 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F74533E02;
        Mon, 21 Feb 2022 01:20:01 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qx21so31442706ejb.13;
        Mon, 21 Feb 2022 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nladtAWSGfIEpu5O+FocZlQ5Lb3McwqCnviWTlH63PY=;
        b=hCAvZq1q9rvDQIAinwZNWy1eHYJbbZcOw25JKBwH1DI9uYddGYjLg5d7Z7eMJggKk9
         th7Dbr4lzakNCn6ejdn6ZWIK0PWx53MckJtBLuig92+GHsNcIuDpSYd/zAtL9eChTUml
         i2D8B7RaiLzRbVM/rChjSfQXr4if3LSt55ej25LJOHf95eCeI5dExlG09N+e4Uli+ilN
         DlCnC/JIi6fip97qb8JUsdPP8DGcWfGOXBx7WsoAwnJ4kptF1+EovIYMHcAz/jnh7Vi/
         9386oqzv/7nGsEingoubgs6cF8FPMSbR0FGdLHhfxIA/eZXVI38W27dnRnpAUjy3fCzV
         LlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nladtAWSGfIEpu5O+FocZlQ5Lb3McwqCnviWTlH63PY=;
        b=Ety4B5So7co4Czfya3Ep+CfhuJejAOWNROjWYaSFtn0fFRx7Lr831zpfpP2W9NAXU4
         rMrXSzqkRUr8jdH9wj9rXo3GeIE8/imtyzHCGb4SQLU6d45XJJ7DbAxSMkzDOMj9BhHo
         ScgqxQc9Vjg2VeSWGxrMF4KE4/7ydUc7/uIQSDP2/a/bZ7r9WEHDDBlagU7ypRUW1XzO
         Tl4MmGeS+8PmpAdm4IunzIgivRrfnO6oyzJgiyfsbNnBMaJdUbOzelROtXuCs7Sg+PP1
         iS8Xhxppg+HzJk+WERoBHL4k0ywmj7cYKzbS2ycjxVemX4FcnMtbkWFABYwZdvlONaov
         BcAQ==
X-Gm-Message-State: AOAM532NA6KQ0NrAMBHVBX+XDNNlsp2irm2gq30oFUbbjQpkbFsbLQOI
        5tLSAggTMym8tiB+bl1EcwmlnvBxTZrCUbFpT7hy+sJ3W9Q=
X-Google-Smtp-Source: ABdhPJy+f16PQ6M285QqSUEom5ax4WTP2i+LhU9jtsxTlgt9hbTt/s8knrEPPHPkx3JwzyBrJocp9bRlflT/s0Z3TdQ=
X-Received: by 2002:a17:906:aad7:b0:6cc:c9aa:d9ad with SMTP id
 kt23-20020a170906aad700b006ccc9aad9admr15408603ejb.726.1645435199386; Mon, 21
 Feb 2022 01:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20220220213131.GA3754799@rfd.leadboat.com>
In-Reply-To: <20220220213131.GA3754799@rfd.leadboat.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 21 Feb 2022 12:19:48 +0300
Message-ID: <CADxRZqzFip4C_nMN0rZ8bTj44pCyW0Q5nsiLTbQjRsZSOtJRpg@mail.gmail.com>
Subject: Re: [ext4+sparc64] reads see zeros w/ simultaneous write
To:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Noah Misch <noah@leadboat.com>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 21, 2022 at 2:56 AM Noah Misch <noah@leadboat.com> wrote:
>
> Hello,
>
> I originally reported this to Debian
> (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1006157), which
> advised me to re-report it upstream.  The context is an ext4
> filesystem on a sparc64 host.  I've observed this with each of the
> three sparc64 Debian kernels that I've tested.  Those kernels were
> 5.16.0-1-sparc64-smp, 5.15.0-2-sparc64-smp, and 4.9.0-13-sparc64-smp.

Tested on sparc64 5.17.0-rc5 , still the same behaviour.

PS: added linux-ext4@ as well , for the test program see the original
email https://lore.kernel.org/sparclinux/20220220213131.GA3754799@rfd.leadboat.com/



>
>    * What exactly did you do (or not do) that was effective (or
>      ineffective)?
>
> See the included file for a minimal test program.  It creates two
> processes, each of which loops indefinitely.  One opens a file, writes
> 0x1 to a 256-byte region, and closes the file.  The other process
> opens the same file, reads the same region, and prints a message if
> any byte is not 0x1.
>
> This thread has more discussion and a more-configurable test program:
> https://postgr.es/m/flat/20220116071210.GA735692@rfd.leadboat.com
>
>    * What was the outcome of this action?
>
> The program prints messages, at least ten per second.  The mismatch
> always appears at an offset divisible by eight.  Some offsets are more
> common than others.  Here's output from 300s of runtime, filtered
> through "sort -nk3 | uniq -c":
>
>    1729 mismatch at 8: got 0, want 1
>    1878 mismatch at 16: got 0, want 1
>    1030 mismatch at 24: got 0, want 1
>      41 mismatch at 40: got 0, want 1
>     373 mismatch at 48: got 0, want 1
>      24 mismatch at 56: got 0, want 1
>     349 mismatch at 64: got 0, want 1
>   13525 mismatch at 72: got 0, want 1
>     401 mismatch at 80: got 0, want 1
>     365 mismatch at 88: got 0, want 1
>       1 mismatch at 96: got 0, want 1
>      32 mismatch at 104: got 0, want 1
>      34 mismatch at 112: got 0, want 1
>      19 mismatch at 120: got 0, want 1
>      34 mismatch at 128: got 0, want 1
>     253 mismatch at 136: got 0, want 1
>     149 mismatch at 144: got 0, want 1
>     138 mismatch at 152: got 0, want 1
>       1 mismatch at 160: got 0, want 1
>       4 mismatch at 168: got 0, want 1
>       7 mismatch at 176: got 0, want 1
>       4 mismatch at 184: got 0, want 1
>       1 mismatch at 192: got 0, want 1
>      83 mismatch at 200: got 0, want 1
>      58 mismatch at 208: got 0, want 1
>    3301 mismatch at 216: got 0, want 1
>       2 mismatch at 232: got 0, want 1
>       1 mismatch at 248: got 0, want 1
>
> If I run the program atop an xfs filesystem (still with sparc64), it
> prints nothing.  If I run it with x86_64 or powerpc64 (atop ext4), it
> prints nothing.
>
>    * What outcome did you expect instead?
>
> I expected the program to print nothing, indicating that the reader
> process observes only 0x1 bytes.  That is how x86_64+ext4 behaves.
>
> POSIX is stricter, requiring read() and write() implementations such
> that "each call shall either see all of the specified effects of the
> other call, or none of them"
> (https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_09_07).
> ext4 does not conform, which may be pragmatic.  However, with x86_64
> and powerpc64, readers see each byte as either its before-write value
> or its after-write value.  They don't see a zero in an offset that
> will have been nonzero both before and after the ongoing write().
>
>
> === sparc64-ext4-zeros.c
> /*
>  * Stress-test read(), and write() to detect a problem seen with sparc64+ext4.
>  * Readers see zeros when they read concurrently with a write, even if the
>  * file had no zero at that offset before or after the write.  This program
>  * runs indefinitely and will print "mismatch ..." each time that happens.
>  */

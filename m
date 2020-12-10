Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF12A2D5526
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 09:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbgLJIKx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 03:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387712AbgLJIKs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 03:10:48 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D8FC0613D6
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 00:10:04 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 1so4026969qka.0
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 00:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vYDAWamrgtXENPLy0KNGY/iAQYLlOTlQsd1JUCvYlbQ=;
        b=X340a6vYLIu9nk5jTRrIBU/GTygftmL4lzB0insa31P5NBCcQ9mew06GhG9yH7/x5A
         huwQ9lMfEF1FN2qaEb5mpVXhIOJO+zql+pjTcYnrrvot2PDIByuOqkpnWzwFSgLecdsn
         X4X+aMHpPT9deedqHAd0AgI4ce7aPCDdi9CTUBhpUW2MXfEEUgyzoYbNssEe9ZJflXWp
         fWejdmw6qGhIt0/y5L5FqpCWc1OMXRxs8s8KWUsVs5cA1K5Yj2IWxH7F4D4PBxhbGzC2
         2uh2vqnWRZN/hNhJSpT47aEtaYBdXTkLTPm8tBSn9aEDpRD7/ffttwSxnpFbRF1lcV93
         J6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vYDAWamrgtXENPLy0KNGY/iAQYLlOTlQsd1JUCvYlbQ=;
        b=gqS4Xf/zVfybji6tB49h74R7LJVEw6uqKtGoYrBdSqAh9nVJBkLtygmFABMW2plRFv
         HjkN2u0BeRZV0o7FnmhmJvJW1H/2nu9/VdZNrrqO6Rg6GMXtb2+nG0hpN8o+1NkhwKkV
         E32Fpi+2m4fdXEtc7X18PH+o5aQxcKEnDibpPLa8lK60czllcS7/61MwWhvLd8pXp5Ep
         e3JV1SKbwloJOBZSkSwR79yZ5WR1NzUu29Ox72ClOYVUlD7zYryUal7SqlJZsg7aQvqK
         qe1qztem4KORp++hgRujdD00EY2DKN2gD3j30OKw/sFncxG/M7QqfMGI6/RetRFR75A/
         /qPw==
X-Gm-Message-State: AOAM532cA83Lo6ZLZN7j9IUX5L8SjgCI7pdx93X37g5DN4iZuiFTwuRr
        HsOTHJY89BJqbR5QgS7Le33MAs9tSLRCU/ab3Qjcvg==
X-Google-Smtp-Source: ABdhPJy7H6zGDswBAbu4+krX/7B3/ty90plQHmoQqsVqam3x/bggZ04bAtBdiovS1q67/5ehktng/KUBnnTiKYZcPm8=
X-Received: by 2002:a37:56c6:: with SMTP id k189mr7380186qkb.501.1607587803237;
 Thu, 10 Dec 2020 00:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20201210023638.GP52960@mit.edu> <00000000000024030c05b61412e6@google.com>
In-Reply-To: <00000000000024030c05b61412e6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Dec 2020 09:09:51 +0100
Message-ID: <CACT4Y+bkaVq1RzONGuPJxu-pSyCSRrEs7xV0sa2n0oLNkicHQQ@mail.gmail.com>
Subject: Re: UBSAN: shift-out-of-bounds in ext4_fill_super
To:     syzbot <syzbot+345b75652b1d24227443@syzkaller.appspotmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 10, 2020 at 4:50 AM syzbot
<syzbot+345b75652b1d24227443@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git on commit e360ba58d067a30a4e3e7d55ebdd919885a058d6: failed to run ["git" "fetch" "--tags" "d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8"]: exit status 1
> From git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
>  * [new branch]                bisect-test-ext4-035     -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/bisect-test-ext4-035
>  * [new branch]                bisect-test-generic-307  -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/bisect-test-generic-307
>  * [new branch]                dev                      -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/dev
>  * [new branch]                ext4-3.18                -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-3.18
>  * [new branch]                ext4-4.1                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.1
>  * [new branch]                ext4-4.4                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.4
>  * [new branch]                ext4-4.9                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-4.9
>  * [new branch]                ext4-dax                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-dax
>  * [new branch]                ext4-tools               -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/ext4-tools
>  * [new branch]                fix-bz-206443            -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/fix-bz-206443
>  * [new branch]                for-stable               -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/for-stable
>  * [new branch]                fsverity                 -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/fsverity
>  * [new branch]                lazy_journal             -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/lazy_journal
>  * [new branch]                master                   -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/master
>  * [new branch]                origin                   -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/origin
>  * [new branch]                pu                       -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/pu
>  * [new branch]                test                     -> d06f7b29746c7f0a52f349ff7fbf2a3f22d27cf8/test
>  * [new tag]                   ext4-for-linus-5.8-rc1-2 -> ext4-for-linus-5.8-rc1-2
>  ! [rejected]                  ext4_for_linus           -> ext4_for_linus  (would clobber existing tag)

Interesting. First time I see this. Should syzkaller use 'git fetch
--tags --force"?...
StackOverflow suggests it should help:
https://stackoverflow.com/questions/58031165/how-to-get-rid-of-would-clobber-existing-tag


>  * [new tag]                   ext4_for_linus_bugfixes  -> ext4_for_linus_bugfixes
>  * [new tag]                   ext4_for_linus_cleanups  -> ext4_for_linus_cleanups
>  * [new tag]                   ext4_for_linus_fixes     -> ext4_for_linus_fixes
>  * [new tag]                   ext4_for_linus_fixes2    -> ext4_for_linus_fixes2
>
>
>
> Tested on:
>
> commit:         [unknown
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git e360ba58d067a30a4e3e7d55ebdd919885a058d6
> dashboard link: https://syzkaller.appspot.com/bug?extid=345b75652b1d24227443
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1499c287500000

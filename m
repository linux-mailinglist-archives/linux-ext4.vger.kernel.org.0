Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09B373087C
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjFNTiy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 15:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbjFNTik (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 15:38:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D422D41
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 12:38:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so9076515e9.1
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jun 2023 12:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686771482; x=1689363482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+xB9OKljBiTSaYOVy/0MEH4gZEhc//WwEiXHagUOYg=;
        b=d6g96ZaCcC14dZVryqZUJKcbH0UhvECgVnx9bOrrcQA1cZlAnTy7jLIogeUM5eGmFD
         T1SFYhOXEk2Pw9/zuHchRZEHTknyvjz0yGF3vXbhUyjwnTgmhsCFTdPouUJ6BW1Arly1
         tICdk5yyfUR4GZuUjqxnh14BTmspUQ0ZQBQeIXwE/xWAQtt6j9Muou2Q61r8NKBAzmDj
         uBolZDEITwC01InDm8PR+SBVoffRV62Zjwuzxsm+9joCTubPusQ/MzUCdzYGHH1VPS/u
         fQ/V6i9WCJYHx8f6X0Hdxdo1pQVC/KobRMgcTY/PKqamUusl4NhriNVzLd0bKbCihWI7
         RUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686771482; x=1689363482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+xB9OKljBiTSaYOVy/0MEH4gZEhc//WwEiXHagUOYg=;
        b=RRywejAHBiBaSZPa3KbQDLMzyNNFTtb8yJ8DGgbUfE1jcXYY+Qx45le+JiDKQXfFvN
         lSCaWaEo3ajZmm74KlCvytqUo9PLVXlQAUf0iJ1LluNzxKWU8WcRqar51aD+M6KPULdp
         fxa7KBKQ5v8Yev0JWqZz6JpMhpRlYMwFUKBfgPooeGJMZVSr0aM/s73g4ZIAaaG+pqAP
         0HunqO7BCM49Z5Wyi2BjdoPuiBE97SaSk6ENQxwdwOOUQJRwBUHyGwWCWh/JMGRHOf2O
         KXfgy7lSCohyUH8bYGR8s/bsvt3QUyV8MNOxSFFnFx0ws8duPGzxktjElEI9+nwzaYRk
         8yHQ==
X-Gm-Message-State: AC+VfDwKMNiQbGnH0Y7SVH7ZaMa3V9NDE/3MT8b2YyrxfRBil9IWDQ18
        FyY6TWuviakJhHEwEU1U6ow=
X-Google-Smtp-Source: ACHHUZ4Y9FqCnYmTu+45PQsOp24iozfAdAsYwyfffo5b6/xABXT0jPiVbEsk8jB7RSftItB5czWY7g==
X-Received: by 2002:a1c:7713:0:b0:3f6:784:9617 with SMTP id t19-20020a1c7713000000b003f607849617mr10344083wmi.11.1686771482159;
        Wed, 14 Jun 2023 12:38:02 -0700 (PDT)
Received: from suse.localnet (host-79-26-32-1.retail.telecomitalia.it. [79.26.32.1])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f819dfa0ddsm11102373wmd.28.2023.06.14.12.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:38:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid context in
 ext4_update_super
Date:   Wed, 14 Jun 2023 21:38:00 +0200
Message-ID: <1830721.atdPhlSkOF@suse>
In-Reply-To: <20230612001921.GG1436857@mit.edu>
References: <20230611131829.GA1584772@mit.edu> <7741416.gsGJI6kyIV@suse>
 <20230612001921.GG1436857@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On luned=EC 12 giugno 2023 02:19:21 CEST Theodore Ts'o wrote:
> On Sun, Jun 11, 2023 at 09:15:56PM +0200, Fabio M. De Francesco wrote:
> > Thanks!
> >=20
> > Let me summarize, just to be sure we don't misunderstand each other...
> >=20
> > To start off, I'll send out _only_ the patch for the bug reported by=20
Syzbot,
> > the one about dropping the call to ext_error() in ext4_get_group_info().
> >=20
> > I'll do this by Tuesday. (Sorry, I cannot do it by Monday because I must
> > pass
> > an exam and an interview for a job).

Ted,

Sorry, I sent the patch this morning (local time), that is one day later :-(

It's at https://lore.kernel.org/lkml/20230614100446.14337-1-fmdefrancesco@g=
mail.com/

> Sure, that'll be fine.
>=20
> > However, on the other problems with ext4_grp_locked_error() that you=20
noticed
> > in the final part of your first message in this thread I'll need some d=
ays
> > more to better understand the context I'm working in.
>=20
> Um, I'm not sure what problems you're referring to.  What I said is
> that it works, but you just have to be careful in how you use it (and
> the current callers in mballoc.c are careful).

My poor English made me misunderstanding what you wrote in the final part o=
f=20
you first email. My fault, again sorry.

> And similarly, I don't think it's a problem that you need to be
> careful not to call ext4_error() from an atomic context.  You need to
> be careful, and sometimes we screw up.  But in this particular case,
> it's pretty obvious how to fix it, and we don't even need a syzkaller
> reproducer.  :-)

Sure.

> > > I would strongly recommend that you use gce-xfstests or kvm-xfstests
> > > before submitting ext4 patches.

I'll surely do next time, but this was too trivial to necessitate any test.=
 Do=20
you agree with me?

> > > In this particular case, it's a
> > > relatively simple patch, but it's a good habit to get into.  See [1]
> > > for more details.
> > >=20
> > > [1] https://thunk.org/gce-xfstests
> >=20
> > Thanks also for these information.
> >=20

Well, I think that this means that you indeed agree for this particular cas=
e=20
:-)

> > I'm still in search of a reliable way to let atomic context
> > run idle waiting for a status change.

[...]

> So the question is not how to find a "reliable way to let atomic
> context run > idle waiting for a status change".  That's the wrong
> question.  The better question is: "how do you restructure code
> running in an atomic context so it doesn't need to wait for a status
> change"?
>=20
> Cheers,
>=20
> 					- Ted

Very interesting discussion.=20
I skipped the details only for shortening this email.

Again thanks for your precious help,

=46abio




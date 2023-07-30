Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F23768405
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Jul 2023 08:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjG3GXt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Jul 2023 02:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3GXt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Jul 2023 02:23:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A2319B3;
        Sat, 29 Jul 2023 23:23:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31765aee31bso3175951f8f.1;
        Sat, 29 Jul 2023 23:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690698225; x=1691303025;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hAwu8YQvUJjAfR2ntWTYDBgNwgSTjmFjAliYK5tvjp4=;
        b=F70tl6g+Q71Q+vjtkC2wHAwO7os/Jwn9BRSGR0aLpvY5L+QYHVwQr5OkWhPB51dM1F
         P+A6WBdFxfmMAlIqv8HBHkyrSg2t6i61y94huKDDAIstff65bq0wuaPMxRwb+8Rh+jBE
         7IsJUwszpq26ayIvX+KM3hT+iEdt7ZNY9qFABrtQGD4YKjkXwLXPP09NHGVEEGCcfmBX
         7Ao6j4mW5GYp0DNF9wrXSpO1wteH5PIwXi6ZeIvXOVtx3Fi7E2I96tCmnxJKe3hS/tmR
         6jQsR03ysPz7z8asa8JSAdKs090gkIlhbuq40CI/ULci+aLlokq1uLfqAyZwsbmVA8w+
         m1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690698225; x=1691303025;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAwu8YQvUJjAfR2ntWTYDBgNwgSTjmFjAliYK5tvjp4=;
        b=eQpP/uFqtznjBHdw6HXUOR/zdwFwlBz1m/xoVkTlpsWyYioSYIvpHWLTMy3oXGawZw
         BSNNP9OrGVZUJZy1HhW6Us2iyFMbSeOeuS/zGEj5GRUBf7a1bh9/qyBXN9dNPCMepe0v
         kvAu0nL5gChgUMxf7Lw61N05qDCDXZvGowSac4zJ+vzzMP/wLCbLZyzkNhueXjzS9m7l
         JMJqoot34o6wzrcrQrZpW7p5WoFGoSmebiwTP6OoaKowR30CpZkuIGS9KzRtIT9P/YJG
         EKdJtfb8M06qui3ZCck/m2CHZ4H1STVh4zEKjj0IJsuQDaKNOdualBwYfwibpfW1OIyA
         98aQ==
X-Gm-Message-State: ABy/qLZ/LONJn+13lowtq7iW+ouwZYGiPh0jouFKj9+QCM0olTOlY9Hy
        6mQjUgQaF48r35YwRbXKjAjiwR+nDTloDgA7
X-Google-Smtp-Source: APBJJlF/1X/ObkTub7H3yDT3WQsUDq5C1+2mD09rDYcwbzSEM6KG95vAqMC0ReAZET/celq4OpyV6g==
X-Received: by 2002:a7b:c8c6:0:b0:3fd:2e6b:10c8 with SMTP id f6-20020a7bc8c6000000b003fd2e6b10c8mr4599118wml.23.1690698225435;
        Sat, 29 Jul 2023 23:23:45 -0700 (PDT)
Received: from torreasustufgamingpro (209.pool90-77-130.dynamic.orange.es. [90.77.130.209])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b003fd2e898aa3sm13457149wmq.0.2023.07.29.23.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 23:23:44 -0700 (PDT)
From:   =?utf-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Contributing subsequent patch versions
References: <877cqlmdpg.fsf@gmail.com>
        <8ef54195-4102-0c6c-e14d-efc9bc45cddc@web.de> <877cqk5zdt.fsf@gmail.com>
        <20230728181014.GA607743@mit.edu>
Date:   Sun, 30 Jul 2023 08:23:40 +0200
In-Reply-To: <20230728181014.GA607743@mit.edu> (Theodore Ts'o's message of
        "Fri, 28 Jul 2023 14:10:14 -0400")
Message-ID: <87tttlncib.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Fri, Jul 28, 2023 at 08:22:22AM +0200, Oscar Megia L=C3=B3pez wrote:
>> Yes, I read
>> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
>> yesterday and more online documentation and I didn't find any describing=
 the
>> correct way to send next patch version.
>>=20
>> Today I found this
>> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>> but I still have some doubts.
>
> What you're running into is the fact that there are multiple ways that
> people will prepare patch versions, and so the process documentation
> merely specify what the patch series should look like.
>
>> Yes, I know, but I want to know how an expert programmer send
>> next version (create new branch for each patch's version?, create new
>> directory outgoing for each patch's version?, run git pull on patch's
>> branch?, add --in-reply-to=3D to previous patch's version email?
>> =C2=BFcover letter or 1/1?, etc.).
>
> Not only do many experienced programmers might have different
> perferred workflows, they might use different procedures depending on
> how complex the patch series would be.  For example, for the case for
> a single patch, I'd probably just use "git format-patch -1 ...",
> meaning "just format the top-most patch on the current branch".
>
> For a really simple patch, I might just use "git commit --amend" to
> make changes, and I might not bother rebasing unless it was necessary
> to make sure it would apply on the top of the development branch.  If
> it was necessary to rebase, assuming that you have the local branch
> "origin_<topic>" which points as the base to your patch or patch
> series, then what *I* typically do is just do:
>
> git branch -f orgin_<topic> origin/master
> git rebase origin_<topic>
>
> Now the topic branch is rebased on the tip of the upstream development
> branch, and now I might just do:
>
> git format-patch -o /tmp/p origin_<topic>..
>
> For a single patch, I might not bother with cover letter, and most of
> the time, I'll just manually copy the cover letter from the previous
> version into the current cover letter, append the description of what
> changed from the last version, and then I'll send it out.
>
> This just uses all basic git commands.  There *are* more sophisticated
> systems that will automate things, and it's completely up to you
> whether or not you want to use them.  Sometimes, the simpler methods
> are best and systems which try to "automate" things can just confuse
> you.
>
> If you want to see an example of a much more sophistcated system, take
> a look at the b4's "prep" command[1].  I don't use it, my self,
> although I do use "b4 am" and "b4 ty" for my maintenance work.  So
> don't feel like you have to use "b4 prep"; try it out, and see if it
> makes your life easier.  If so, use it!  If not, just let it go, and
> try something else.
>
> [1] https://b4.docs.kernel.org/en/latest/contributor/prep.html
>

Thank you very much, Ted. That's what I was asking. I don't see the
point in bothering to send the second version (which I've never done) if
there's someone who knows how to do it and is willing to help. I tried
it by myself and searching the internet and I didn't find the right way.

Thanks for your time, Ted.

I really apreciate your help.

> Finally, with respect to your original patch.  My apologies for not
> looking at it eariler.  I'm pretty swamped these days, which means
> that I'm prioritizing which patches get my attention.  As far as this
> particular patch, I don't think it's actively harmful, but I also
> don't quite see the point.  If you want to see how full a file system
> might be, and it's disappearing too quickly because shortly after fsck
> finishes, the graphical login has come up, you can always use the "df"
> command, right?
>
> 						- Ted

Ok, if you don't think it's necessary, I won't send the v2.

Yesterday I realized that I made a *BIG* mistake: I sent the email to the
wrong list. I wanted to send the email to the list linux-kernel-mentees
because I think it is the right place to ask these questions and not
bother the kernel developers, but no harm comes from good. In this way
Markus has told me tasks that I can do to start help the community.

Thanks Markus!

Sorry for sending the message several times with the subject: "I know
you are busy, but have you found time to look at my patch?" to the
linux-ext4 mailing list, but the first time I sent it from web site
https://mail.google.com and I got this response: "Content-Policy reject
msg: The message contains HTML subpart, therefore we consider it SPAM or
Outlook Virus. TEXT/PLAIN is accepted.!", so I tried to send the message
with other mail clients and I didn't see the message in
https://www.spinics.net/lists/linux-ext4/maillist.html looking for
megia.oscar or Oscar Megia L=C3=B3pez, so I tried several times believing
that you did not receive it. On Friday I realized that you did receive
it. I have seen it in https://lore.kernel.org/linux-ext4/?q=3Dmegia.oscar

I apologize for repeatedly sending that email inadvertently. It was not
my intention.

--=20
Regards
Oscar Megia L=C3=B3pez

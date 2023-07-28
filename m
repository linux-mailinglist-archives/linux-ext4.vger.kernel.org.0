Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A2766413
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jul 2023 08:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjG1GWe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jul 2023 02:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjG1GWd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jul 2023 02:22:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD0013D;
        Thu, 27 Jul 2023 23:22:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31768ce2e81so1832209f8f.1;
        Thu, 27 Jul 2023 23:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690525350; x=1691130150;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5AXK0Ni3D8/7s0A80t4cTIWv2xD52KLhJj4n6BOIgqE=;
        b=eV6CAthNEL7hgH6desoxudrSYZbnBC/Q6RMzgg6rzNJMOx7aZRSA57S4gZqOu+rh29
         tqJ9utpnLxqA/a/VIn7ZmUdNFhUM2cLP3VCv69D/6DkM+BDkEPmfDhJca1RVCj6vMz4Q
         OOSLDf+IBQu2Aa5XKWDlQ9Y1gPhfxJM4rpo1sb03Bp4OALqpWWCQ16fOb305Ty8zucvB
         rPMY3CdG2lqysd5MIDFLcBtIUOrdurLQ6A7vaiUqxNO1qp2rp+Ztkt+lJuBr6Vy8ZfWh
         GBOZ/A0OZZudaoErDAwnkIPpWoR0ZxwLzIhyyFWIe+RHkIAZYy0GZfETaTgoCiSXhTnB
         PlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690525350; x=1691130150;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5AXK0Ni3D8/7s0A80t4cTIWv2xD52KLhJj4n6BOIgqE=;
        b=IC4TWkjEbcFw4ljInWq/b5+3vuTOFiCMqfmCKybQJQAelC/+V087mTMf4Z/u6a4Wea
         shVw82adLKED2byAuQ7fltDVEtZtQr/h/4C16ynUUk3ZT8yXzxutX+f/yZnjCjzwm8En
         H6ZWkGz06jhswvaPAFLtxoLqxtGP4S65UE9EKFbzVVlhE/HYycV2e4vEUA8BuCpIJfmi
         +hE4bcGI5gC+LkwLbj1qPcgS3ryqckEjMWtUQZKMohZOGiYt7IJq0n/17KuOiykwxpaB
         PBWMuQ088ZFpHIRiVzHwqbHgh0kVrTsMn/9nyV2kRCepOAoxLcj4aMFiXq561THL0p6S
         4isQ==
X-Gm-Message-State: ABy/qLbyxZ4P2LlUhEgnk7OqjEtlKnlZ2trc8JfBlVqS2SPcGFpoAezG
        9YfXfxMWdVFds6qgh/v4xz1whxk+Sk76qg==
X-Google-Smtp-Source: APBJJlFTDm+O4jPKZ1QEtORAuSSXOUSXhXzmBL0hGdWwpffR9/7DWNRdCtim5K52OVVDHjCXzzheQA==
X-Received: by 2002:a5d:5312:0:b0:313:ee73:cc9a with SMTP id e18-20020a5d5312000000b00313ee73cc9amr882516wrv.70.1690525349996;
        Thu, 27 Jul 2023 23:22:29 -0700 (PDT)
Received: from torreasustufgamingpro (209.pool90-77-130.dynamic.orange.es. [90.77.130.209])
        by smtp.gmail.com with ESMTPSA id bf10-20020a0560001cca00b0031432f1528csm3930939wrb.45.2023.07.27.23.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 23:22:29 -0700 (PDT)
From:   =?utf-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Contributing subsequent patch versions
References: <877cqlmdpg.fsf@gmail.com>
        <8ef54195-4102-0c6c-e14d-efc9bc45cddc@web.de>
Date:   Fri, 28 Jul 2023 08:22:22 +0200
In-Reply-To: <8ef54195-4102-0c6c-e14d-efc9bc45cddc@web.de> (Markus Elfring's
        message of "Thu, 27 Jul 2023 21:40:59 +0200")
Message-ID: <877cqk5zdt.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Markus Elfring <Markus.Elfring@web.de> writes:

>> I have submitted a patch to linux-ext4 at vger.kernel.org mailing list
>> and they have responded with whatever changes they think are necessary.
>
> Do you refer to your change approach =E2=80=9Ce2fsck: Add percent to files
> and blocks feature=E2=80=9D (from 2023-04-23) here?
> https://lore.kernel.org/linux-ext4/20230423082349.53474-2-megia.oscar@gma=
il.com/
>

Yes

>
>> Can someone help me by telling me the steps I need to take to send v2?
>> I don't know where ask it.
>
> Did you become more familiar with available development documentation
> and further information sources?

Yes, I read
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
yesterday and more online documentation and I didn't find any describing the
correct way to send next patch version.

Today I found this
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
but I still have some doubts.

>
>
>> Do I have to create a new branch?
>
> Probably, yes.
>
> You can manage as many topic or development branches as needed,
> can't you?

Yes, I know, but I want to know how an expert programmer send
next version (create new branch for each patch's version?, create new
directory outgoing for each patch's version?, run git pull on patch's
branch?, add --in-reply-to=3D to previous patch's version email?
=C2=BFcover letter or 1/1?, etc.).

>
> See also:
> https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell
>
>
>> Do I have to do a git pull on the patch branch before the changes?
>
> You can recheck if your development basis is still recent enough
> for your ideas.
>

Yesterday I did git pull on patch develop branch, commit v2 changes and I g=
ot this error:

$ LC_ALL=3DC git format-patch --base=3Dauto --in-reply-to=3D20230423082349.=
53474-1-megia.oscar@gmail.com --cover-letter -o outgoing/ master
fatal: base commit should be the ancestor of revision list

I searched on the internet and found no solution.

That's why I asked about how send patch version v2. This command is similar
than v1 (only added --in-reply-to=3D because I read it on the internet to s=
end
next versions).

>
>> Do I have to to commit the changes before running
>> git format-patch =E2=80=A6
>
> Yes, of course.
>
> See also:
> https://git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project#=
_project_over_email
>

I asked this because the above error.

>
>> Please, is my first time to send a patch version's v2 and I didn't find
>> any place where explain step by step how to do it.
>
> Is the guidance usable by the document =E2=80=9CSubmitting patches:
> the essential guide to getting your code into the kernel=E2=80=9D?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n3
>
>

As I said before, I read this web page and much more,
but I didn't find the correct steps to submit next version.

I can do this on my way, but sure that I will make mistakes
(I'm not perfect and is my first time) and I don't want to disturb mantaine=
rs.

I search on e2fsprogs repository directory and I didn't find
any information about how send next patch's version.

I'm sure that this help to send next versions will be also good for all
newbies.

Here https://ext4.wiki.kernel.org/index.php/Ext4_Contributing I found
enought information to send first patch, but not for next version. The
page is quite old (2014) and I cannot contact with Djwong user.

>> I tried several steps, but I get errors or resend v1 patch too.
>
> Learning approaches will evolve as usual.
>

I create new branch and reseted to my v1 patch's commit and commited v2
changes. And when I ran:

$ git format-patch --base=3Dauto --in-reply-to=3D20230423082349.53474-1-meg=
ia.oscar@gmail.com --cover-letter -o outgoing/ master=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
outgoing/0000-cover-letter.patch=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
outgoing/0001-e2fsck-Add-percent-to-files-and-blocks-feature.patch
outgoing/0002-e2fsck-Add-percent-to-files-and-blocks-feature.patch=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
$

It didn't return previous error and also saved the previous patch and
I don't know if is correct to send previous patch's version.
I didn't see any v2 on ext4 maillist
https://www.spinics.net/lists/linux-ext4/maillist.html
sending previous version.

So I doubt I'm doing it correctly because git send-email will send
previous patch that I sent. I can delete this file but for me is not
correct way.

As I said before, if one of the lines I have changed has been changed
later, it would tell the maintainer that there is a conflict and
I don't want send wrong patch to maintaners.

I think it would be good to document how to send the next versions of
the patch. I am facing different problems and doubts, but I imagine that
the same will happen to other newbies like me.

I would like to have detailed documentation that tells me the correct
way to send the following versions of the patch. When there was no
internet you used to read the manuals when you wanted to learn new
things. Without manuals it is almost impossible to do something new
correctly without making serious mistakes. I learned MSX BASIC,
assembler, Turbo Pascal, Delphi, C, C++, linux, etc. reading manuals.

How am I going to learn without manuals?

It is beyond my imagination to read the mind of the one who created
those languages or OS. There are instructions that can be guessed,
but others cannot. Everything I have learned has been with manuals.

The same to send the following versions of the patch. If there isn't a
manual that says how to do it, I can try and I'm sure I'll make mistakes.
I send the patch and they don't accept it because it has errors, I try
again and I send it again with other errors and they won't accept it
because it has other errors, like this until all the maintainers block
me (with good reason).

I know you are very busy, so I offer to add this to the documentation
(for newbies) if someone tells me the correct steps in any case (if the
same lines have been modified since the previous version, if a link
needs to be added to the previous version(s) or if all versions are
shipped each time, etc.). I need all the steps to follow with the
example commands.

What I want is that nobody bothers you like me again, and if it bothers
you, you will only have to send them the link with the documentation
that I will create.

> Regards,
> Markus

--=20
Regards
Oscar Megia L=C3=B3pez

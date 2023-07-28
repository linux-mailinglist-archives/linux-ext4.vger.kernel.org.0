Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF8C76758C
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jul 2023 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjG1ShA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jul 2023 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjG1Sg7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jul 2023 14:36:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80FB4233;
        Fri, 28 Jul 2023 11:36:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31765aee31bso2454249f8f.1;
        Fri, 28 Jul 2023 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690569416; x=1691174216;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NaIeSiUSjb8fketmDNvRtwhYw5l03NwE0c/80G9ErnE=;
        b=Sbh1ekRScmCW+hqU5miVuk2EfWCRaLjPM05h3zlG/2NkbtHqFR/VjJq2V3YeLUJQnT
         Ucga4YM2Ib7Fbm4flwG9o2izid7S9Rx/VPhSxXJeA/6/YU1oz7/W/LQTBGxhD6I6Siqb
         JKu5avs7aCz1Y+nFhu2TEquktfNBey8hzgjSqNcu7qkn/OBrRi1rTYn1/iq3ZQbmhsgQ
         +sNcGndrfI94jo4syWoyO7grFcUOXTWjJQl1157tv2H/rdScDyeMHDxU4qDsSBjkZidz
         8hB9+Q4QKUw2gMp95HKqRj78l/JfC2hfGgL0juAbLze0eZgJl4LYIpqQAJ7t/6z0/0Dd
         j5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690569416; x=1691174216;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NaIeSiUSjb8fketmDNvRtwhYw5l03NwE0c/80G9ErnE=;
        b=G7ikZs+p+JeDYhrCstiPTyqOMIWGKIHQCwMWuAEIqLk4gIi2O6ctgHs9HDaBiHJ2+x
         fYy2lO9tB+Cd/3MFq0O8otySDk9YxFJweNp4dh48CEeUx3u5KsN6II7O3cLCJl6KUI+f
         S872nRHblVhw/Uq3jP7/ZNw8j02V7MKM+OOf9U2ZQozSwM5Cc+Ts3zPbgE7bpYNCbcP8
         jBokqta2v3Rd0yAL08miA51ZPHCRK0KUqglVl0yHO5CU5Gg0C5fVhstzONMmtXPFdZrA
         PSSZF7w99kXnn/SgBB7NlqKM/+4x+5oi6WPU/DkIfEbj/cfM9yJ8kCepKtNApEcEUwCK
         1QtQ==
X-Gm-Message-State: ABy/qLavEPIKXqUBRq8o3ER/L8zAhk53z2cDZBmnlkev+v072e/Bm8Pl
        fT77+4F7F82b6sBSgH/MhdiIti8Dkz4IINtm
X-Google-Smtp-Source: APBJJlF2bLApUZuxjE1tMAtdtFPFDaejA0MlVSujfTtSepI6qvibNa4/vHm0z0KrB7aRtvwxKojA2Q==
X-Received: by 2002:adf:d4c3:0:b0:313:e8bf:a77 with SMTP id w3-20020adfd4c3000000b00313e8bf0a77mr2684917wrk.5.1690569415854;
        Fri, 28 Jul 2023 11:36:55 -0700 (PDT)
Received: from torreasustufgamingpro (209.pool90-77-130.dynamic.orange.es. [90.77.130.209])
        by smtp.gmail.com with ESMTPSA id f13-20020adfdb4d000000b003141e9e2f81sm5544207wrj.4.2023.07.28.11.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:36:55 -0700 (PDT)
From:   =?utf-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: Contributing subsequent patch versions
References: <877cqlmdpg.fsf@gmail.com>
        <8ef54195-4102-0c6c-e14d-efc9bc45cddc@web.de> <877cqk5zdt.fsf@gmail.com>
        <61a79836-3981-b6e0-cbbf-fe03507dbea4@web.de>
Date:   Fri, 28 Jul 2023 20:36:50 +0200
In-Reply-To: <61a79836-3981-b6e0-cbbf-fe03507dbea4@web.de> (Markus Elfring's
        message of "Fri, 28 Jul 2023 11:30:35 +0200")
Message-ID: <87tttnhohp.fsf@gmail.com>
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

>> Yes, I read
>> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
>> yesterday and more online documentation and I didn't find any describing=
 the
>> correct way to send next patch version.
>
> Would you like to adjust this view any further?
>

I mean I haven't found the steps to submit v2 (and later) of a patch (as
v1 in https://ext4.wiki.kernel.org/index.php/Ext4_Contributing).

For instance (as far as I learned, but sure there are mistakes):

   1. Create a new branch from the v1 branch branch:
          Run git checkout patch_v1
          Run git checkout -b patch_v2
   2. Modify the sources for version v2.
   3. Commit the modified files with -s to add Signed-off-by: Your name
          <your email> at end.
   4. Run make to build or whatever.
   5. Test your changes.
   6. If everything is fine,
      Run git format-patch --base=3Dauto --in-reply-to=3D[email id from
          patch_v1 (0/1 cover letter? or 1/1?)] [--cover-letter]? -o
          outgoing_v2/ master
      This will create three files (if you added --cover-letter
          parameter). I don't know if in patch's v2 is neccesary cover
          letter. The file starting by 0001- is patch's v1 (I am not
          sure if is necessary send patch's v1 or only link is enougth) and=
 file
          starting by 0002- is patch's v2. You need to edit these files
          and add version changes after --- line (they are only
          information won't be on commit) from version to version.

   7. Run your patches through the kernel's style checker in scripts/checkp=
atch.pl
   8. Run path/kernel/linux/scripts/get_maintainer.pl path/yourPatch_v2/out=
going_v2/0002-patchSubject.patch
   9. Run git send-email --to=3D"mailing list email" --cc=3D"[emails from s=
tep 8 separated by commas (if any)], [other emails you want to send patch v=
2 separated by commas]" outgoing_v2/

At this point you will have sent the v2 patch to the --to and --cc
emails. If you don't use git send-email, note that emails to be sent to
mailing lists must be in plain text
(https://www.kernel.org/doc/html/latest/process/email-clients.html).

>
>> Today I found this
>> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
>
> Such advices by Dan Carpenter are also helpful.
>
>
>> but I still have some doubts.
>
> Which concerns will need clarifications?
>

I don't know correct steps to send patch's v2 as above instance. Sorry,
but I need step by step instructions, if not I think that I can make
mistakes and I don't want. Sorry, but my experience says that is very
easy make mistakes when I am newbie.

>
>>> You can manage as many topic or development branches as needed,
>>> can't you?
>>
>> Yes, I know, but I want to know how an expert programmer send
>> next version
>
> Are you looking for more advanced development tools?
>

No, I just want to know how an expert programmer will do the task that I
need to do. I can try it myself with trial/error, but I'm not alone, am I?

>
>>               create new directory outgoing for each patch's version?,
>
> Corresponding name selections are influenced by some case distinctions.
>

I apologize if I said anything that was confusing (English is not my
native tongue). My question was if expert developers create a different
name for outgoing directory for each patch's version on
git format-patch ... -o outgoing/ master command.
For instance: -o outgoing_v1 for v1, -o outgoing_v2 for v2 and so on.
I ask this because you can lost patch files from previous
patches if you run this command several times (it makes backup ending
with ~, but usually last backup is lost after update). Or not?

>
>>               run git pull on patch's branch?,
>
> Software evolution (and their time ranges) can occasionally trigger speci=
al consequences.
>

So I undertand that is not neccesary. Right?

>
>>               add --in-reply-to=3D to previous patch's version email?
>
> Replies can generally be attempted according to previous messages
> (by different communication tools).
>
>

I apologize if I said anything that was confusing (English is not my
native tongue). My question was if is necessary add this parameter (--in-re=
ply-to).

>
>> I create new branch and reseted to my v1 patch's commit
>
> I suggest to reconsider your imaginations around the need for =E2=80=9Cre=
setting=E2=80=9D.
>

I apologize if I said anything that was confusing (English is not my
native tongue). I wanted to say that I created new branch from branch
for patch v1 to run git reset or whatever without modify branch patch
v1. If I make any mistake or something harmful I can checkout to
original branch for patch v1 and delete this test branch.

I think that is secure. Right?

>
>> and commited v2 changes. And when I ran:
>>
>> $ git format-patch --base=3Dauto --in-reply-to=3D20230423082349.53474-1-=
megia.oscar@gmail.com --cover-letter -o outgoing/ master
>> outgoing/0000-cover-letter.patch
>> outgoing/0001-e2fsck-Add-percent-to-files-and-blocks-feature.patch
>> outgoing/0002-e2fsck-Add-percent-to-files-and-blocks-feature.patch
>> $
>>
>> It didn't return previous error and also saved the previous patch and
>> I don't know if is correct to send previous patch's version.
>
> You would probably like to present only improved information.
> Did a patch series become relevant then?
>

I apologize if I said anything that was confusing (English is not my
native tongue). I wanted to say that is not necessary send previous
patch v1 because I sent it before. For instance, if I send v20, is
necessary send 19 previous versions to mailing list? How usually is
managed? As format-patch do?, sending only last version with links to
previous versions? Sorry for my question, but I think that send again
the previous versions is not necessary and will saturate the mailing
list, but it is only my modest opinion, the important thing is how it is
usually done.

>
>> So I doubt I'm doing it correctly because git send-email will send
>> previous patch that I sent.
>
> Please reconsider the selection of desired data.
>

Sorry, could you explain me deeper what you mean?

>
>> How am I going to learn without manuals?
>
> Will any observations and experiments help to improve the understanding
> for desired activities?
>

Yes if I am doing something for me, but send patch to e2fsprog or
whatever involve more people and I don't want make many mistakes and
disturb others (I know you are very busy).

I learned sometimes without manuals and is very hard. I don't mind if
my mistakes are private. For instance, if learning something in my PC I
made a big mistake is my problem and my time to solve it, but if I made
a big mistake sending patches I will feel very bad because I made lost
time to others.

>
>> The same to send the following versions of the patch. If there isn't a
>> manual that says how to do it, I can try and I'm sure I'll make mistakes.
>
> Would you get into the mood to become also a technical writer?
> https://forum.linuxfoundation.org/discussion/863417/introduction-oscar-me=
gia-lopez
>

Yes, I am interested in becoming a technical writer. I think I could be
a good technical writer because I want to explain everything thinking
that the people reading are newbies. Explain things in such a way that
no one has doubts. I know it is very difficult, but I like difficult
challenges. English is not my native language, so I will need someone
with English as a native language to verify my documentation.

I will surely make mistakes. I am only human.

This way I can improve my linux developer level and my English level, so
I would like (on my limited spare time).

>
>> I know you are very busy, so I offer to add this to the documentation
>> (for newbies) if someone tells me the correct steps in any case (if the
>> same lines have been modified since the previous version, if a link
>> needs to be added to the previous version(s) or if all versions are
>> shipped each time, etc.).
>
> How do you think about to extend another information source?
>
> Examples:
> * https://kernelnewbies.org/
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/
>

I would like very much. I would need someone to clear up my doubts or
correct my contributions. I think it's a good way to help the community
that I'm so grateful for and at the same time I would learn a lot of new
things about Linux and how to be a kernel developer. I think it's the
best way to start and we'll see how far I can go. My wish is to become a
kernel developer, but if I'm not good enough, I'll learn a lot of new
things, which is good too.

>
>> I need all the steps to follow with the example commands.
>
> This can be more convenient.
> Which of your experiences can you reuse already?
>

Above I wrote an example with 9 steps that I learned. I am not sure of
them and still I have some doubts.

>
>> What I want is that nobody bothers you like me again,
>
> We came along similar learning difficulties.
>

Thanks. I though that I was worse than the others.

>
>> and if it bothers you, you will only have to send them
>> the link with the documentation that I will create.
>
> This sounds promising.
>

Thanks.

> Regards,
> Markus

--=20
Regards
Oscar Megia L=C3=B3pez

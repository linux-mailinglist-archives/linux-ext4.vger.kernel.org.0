Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF3362F5D7
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 14:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbiKRNVI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Nov 2022 08:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiKRNVA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Nov 2022 08:21:00 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37D467F40
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:20:57 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so3033451otg.6
        for <linux-ext4@vger.kernel.org>; Fri, 18 Nov 2022 05:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXa/KqsWUx3LunXpns38Xz9CP5g3bIDgcegqXBexaR0=;
        b=rWu5hzNnF25rLZATEON3a0L1rGQvcrMTYTugURvQltpAJFZWhkDwlLFtKpp8SG4ffh
         V4FC3iJb0zlCWTOq/lzby6aWArhjR/GoFISYVJAIuK3c84vBV60RVluDxxQ30kPvS39H
         2qoxRdsTUr36CJZoqWim4bpfvp5bPnHtfumcwWPgCgtHfR69VDuV2YsRJz/DRkzj5NOF
         o+yHj625weo3j2mqi45xVQh/Q9557I05Q7wd3KH1O/vSJJqV52e4mSxFl3cmDo+V5hpe
         lKUs04zBDmFrisvQToCWgAwEgy9Dho2uj1kLYK6mqvdGr+vlhQlTIAJx07EUiZzemgY8
         7LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXa/KqsWUx3LunXpns38Xz9CP5g3bIDgcegqXBexaR0=;
        b=O68rrMCUbw78es45ZX/9Zrznsx6e2KD7Ae+Lj102QG1hLdP6lABpjSl1S5I3Ue45vB
         GgguXvCMBSAtZx+nvooztib+fISgdKf/1ouX0zkr66DGJRmyuqfHxIR1gcBQo1gER9/L
         plhLie+Qgu2Ld8WuBivwINRh/dP8LVODuG4Q6IDpGZohwrBYT6s+HjSXcw93U1dLRhDB
         yHt0VEComCgkb8xehvxZdAePlb0QOG8qKZCE3AnZmcyfuLbk2JSHukR+ztx74EednduK
         wEZen4y52wRygXFCoISDD1rb2/2o/Z8RARrS1CUQz8Ble4bqWt1MF1ms+ECHaTKH4+WL
         Ix7g==
X-Gm-Message-State: ANoB5pmr06d+9/EkVDRhlDovcYUfjNe4eKGoLDqYDXS/CiIoh+WB/ozq
        gZbQK6WKtfA3939C/kxCwlx9I3a6DUvdxrsP
X-Google-Smtp-Source: AA0mqf7/anqsXemwLofFD8+KfMT36RNURhk+fO24ZVyM/DXV0MBsBwqg77DyzR7EuDMkB/UNbUNnFA==
X-Received: by 2002:a9d:7687:0:b0:66c:2bb3:f2ab with SMTP id j7-20020a9d7687000000b0066c2bb3f2abmr3622441otl.354.1668777656688;
        Fri, 18 Nov 2022 05:20:56 -0800 (PST)
Received: from smtpclient.apple ([205.169.26.81])
        by smtp.gmail.com with ESMTPSA id i11-20020a9d53cb000000b00667ff6b7e9esm1550378oth.40.2022.11.18.05.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 05:20:56 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFCv1 01/72] e2fsck: Fix unbalanced mutex unlock for BOUNCE_MTX
Date:   Fri, 18 Nov 2022 07:20:55 -0600
Message-Id: <1BEDD834-2D4A-4E8E-936C-90DB5E322F9C@dilger.ca>
References: <20221118113711.qby7gtky5k36f7vd@riteshh-domain>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Li Xi <lixi@ddn.com>
In-Reply-To: <20221118113711.qby7gtky5k36f7vd@riteshh-domain>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: iPhone Mail (19H12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Nov 18, 2022, at 05:37, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrot=
e:
>=20
> =EF=BB=BFOn 22/11/18 04:34AM, Andreas Dilger wrote:
>>> On Nov 7, 2022, at 06:22, Ritesh Harjani (IBM) <ritesh.list@gmail.com> w=
rote:
>>>=20
>>> f_crashdisk test failed with UNIX_IO_FORCE_BOUNCE=3Dyes due to unbalance=
d
>>> mutex unlock in below path.
>>>=20
>>> This patch fixes it.
>>>=20
>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> ---
>>> lib/ext2fs/unix_io.c | 1 -
>>> 1 file changed, 1 deletion(-)
>>>=20
>>> diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
>>> index e53db333..5b894826 100644
>>> --- a/lib/ext2fs/unix_io.c
>>> +++ b/lib/ext2fs/unix_io.c
>>> @@ -305,7 +305,6 @@ bounce_read:
>>>   while (size > 0) {
>>>       actual =3D read(data->dev, data->bounce, align_size);
>>>       if (actual !=3D align_size) {
>>> -            mutex_unlock(data, BOUNCE_MTX);
>>=20
>> This patch doesn't show enough context, but AFAIK this is jumping before m=
utex_down()
>> is called, so this *should* be correct as is?
>=20
> Thanks for the review, Andreas.
>=20
> Yeah, the patch diff above is not sufficient since it doesn't share enuf
> context.
> But essentially when "actual" is not equal to "align_size", then in this i=
f
> condition it goes to label "short_read:", which always goto error_unlock,
> where we anyways call mutex_unlock()
>=20
> Looking at a lot of labels in this function, this definitely looks like=20=

> something which can be cleaned up ("raw_read_blk()").=20
> I will add that to my list of todos.=20

You are correct, and it means this code is just not very clear to the reader=
. I think it
would make more sense to move the "short_read:" label to the end of the code=
:

                  actual =3D read(...);
                  if (actual !=3D size)
                          goto error_short_read;
                  goto success_unlock;
        :
                 actual =3D read(...);
                 if (actual !=3D align_size) {
                           actual =3D really_read;
                           buf -=3D really_read;
                           size +=3D really_read;
                           goto error_short_read;
                 }
        :
success_unlock:
        mutex_unlock(...);
        return 0;

error_short_read:
        if (actual < 0) {
                 retval =3D errno;
                 actual =3D 0;
        } else {
                 retval =3D EXT2_ET_SHORT_READ;
        }
error_unlock:
        mutex_unlock(...);

That way the code follows the normal error handling convention and is less l=
ikely to be
surprising to the reader.=20

Cheers, Andreas=

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0A764892
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 09:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjG0H0s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jul 2023 03:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjG0HZi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jul 2023 03:25:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237A26A58
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 00:15:45 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so8743751fa.1
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690442143; x=1691046943;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zPB0nHDKB2MY9/V0kyarS8eAvSvUMRhf8sIhD0usjI4=;
        b=qo4tqhEspDDtjnCz32t8XTrfteKhrIlZBunjCAvzvfGDL20CXoQPabvFXcVt6OST9q
         PlAF9/fQWWDDr9ueU0l4Qis6wTJRDUGkwcERVoh6Y00Y4AHWeiBUZvwwv30dVk0ZT5nr
         42K+WtJfzyC15kttd6S4iJS5JlvFX11OKKmT5AnLxbNbOvNeqXUGS+Yutmt6uWzRqsQF
         5WRiTW/j4xOdSLXS4RYBERrs58uAxET3k4BWLUsK1cEJHSsn0gFync2kofM/rhwK4eKu
         fWPWYUaexiCyCXDhd0hRtO22p4JHpGMLowRyLNae2idAmE2EIhEkVSo7xatSsUbBZfSw
         4gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690442143; x=1691046943;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPB0nHDKB2MY9/V0kyarS8eAvSvUMRhf8sIhD0usjI4=;
        b=OA01dtLVd4PSuynM6E2HTG7seDp4UZbUIvEp0QOJxvtwbqxlzGIeguZrJushSY25uC
         hrqNooXzJFh5VE7YzxqBqRNBsCl9UIb78DjmXXSvwulUUNzytqErCovgO7B6RamtZ9zL
         LIh7xxsUgWfpVfoyoBGm5m2IFCV6o0qs1xARV3bKjXQYGRJh1pCs936WfDVfO+ludBTZ
         HqHmIEeskK+R5iY4U0f5bGvgC5NJKjuj/n8Fse0W0vRtvxGa3tjnbpJrs4qYkUxwbi8y
         yTWc8R2sPfbb2BRHi1u2Nz4LN6yfKpd/PTwgYOj8L0h5qWnop0DB0RlHbYRXFkHItWW4
         y4Bg==
X-Gm-Message-State: ABy/qLaFF7LQO9jiSNaw+TraoxruWljq2WAjhfzj73Vt4+6wYxy6+wcu
        qA1HjV5t9UTXWd35IAAGzh3+NKBY3Kgljg==
X-Google-Smtp-Source: APBJJlGAtHAJpwvQ2Q6sWZhS2HJ7sxaFR3aW3a/aFAwU8b7c9hPbaKvm+npe/N2KtYOMgOfmlZX1zA==
X-Received: by 2002:a2e:99c7:0:b0:2b6:e9e6:b50b with SMTP id l7-20020a2e99c7000000b002b6e9e6b50bmr1075313ljj.25.1690442142502;
        Thu, 27 Jul 2023 00:15:42 -0700 (PDT)
Received: from torreasustufgamingpro (209.pool90-77-130.dynamic.orange.es. [90.77.130.209])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c225400b003fbe791a0e8sm1080053wmm.0.2023.07.27.00.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:15:41 -0700 (PDT)
From:   =?utf-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] e2fsck: Add percent to files and blocks feature
References: <20230423082349.53474-2-megia.oscar@gmail.com>
        <7023297C-8D10-4903-A0E2-7ED8B8BFA043@dilger.ca>
Date:   Thu, 27 Jul 2023 09:15:14 +0200
In-Reply-To: <7023297C-8D10-4903-A0E2-7ED8B8BFA043@dilger.ca> (Andreas
        Dilger's message of "Wed, 26 Jul 2023 10:15:26 -0600")
Message-ID: <878rb17rlp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> writes:

> On Apr 23, 2023, at 02:25, Oscar Megia L=C3=B3pez <megia.oscar@gmail.com>=
 wrote:
>>=20
>> =EF=BB=BFI need percentages to see how disk is occupied.
>> Used and maximum are good, but humans work better with percentages.
>>=20
>> When my linux boots,
>> I haven't enough time to remember numbers and calculate.
>>=20
>> My PC is very fast. I can only see the message for one or two seconds.
>>=20
>> If also I would see percentages for me would be perfect.
>>=20
>> I think that this feature is going to be good for everyone.
>>=20
>> Signed-off-by: Oscar Megia L=C3=B3pez <megia.oscar@gmail.com>
>> ---
>> e2fsck/unix.c | 25 +++++++++++++++++++++++--
>> 1 file changed, 23 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
>> index e5b672a2..b820ca8d 100644
>> --- a/e2fsck/unix.c
>> +++ b/e2fsck/unix.c
>> @@ -350,6 +350,8 @@ static void check_if_skip(e2fsck_t ctx)
>>    int defer_check_on_battery;
>>    int broken_system_clock;
>>    time_t lastcheck;
>> +    char percent_files[9];
>> +    char percent_blocks[9];
>>=20
>>    if (ctx->flags & E2F_FLAG_PROBLEMS_FIXED)
>>        return;
>> @@ -442,14 +444,33 @@ static void check_if_skip(e2fsck_t ctx)
>>        ext2fs_mark_super_dirty(fs);
>>    }
>>=20
>> +    /* Calculate percentages */
>> +    if (fs->super->s_inodes_count > 0) {
>> +        snprintf(percent_files, sizeof(percent_files), " (%u%%) ",
>> +        ((fs->super->s_inodes_count - fs->super->s_free_inodes_count) *=
 100) /
>> +        fs->super->s_inodes_count);
>> +    } else {
>> +        snprintf(percent_files, sizeof(percent_files), " ");
>> +    }
>
> Instead of snprintf() this could just be initialized at variable declarat=
ion time:
>
>         char percent_files[8] =3D "";
>
> That avoids extra runtime overhead and is no less safe. (This is adjusted=
 to compensate
> for the format change below.)
>

Thanks for your advice, I will apply it.

>> +    if (ext2fs_blocks_count(fs->super) > 0) {
>> +        snprintf(percent_blocks, sizeof(percent_blocks), " (%llu%%) ",
>> +        (unsigned long long) ((ext2fs_blocks_count(fs->super) -
>> +        ext2fs_free_blocks_count(fs->super)) * 100) / ext2fs_blocks_cou=
nt(fs->super));
>> +    } else {
>> +        snprintf(percent_blocks, sizeof(percent_blocks), " ");
>> +    }
>
> This could similarly be set at initialization:
>
>         char percent_blocks[8] =3D "";
>

Thanks for your advice, I will apply it.

>>    /* Print the summary message when we're skipping a full check */
>> -    log_out(ctx, _("%s: clean, %u/%u files, %llu/%llu blocks"),
>> +    log_out(ctx, _("%s: clean, %u/%u%sfiles, %llu/%llu%sblocks"),
>
> This would be more readable if it left one space after each "%s" and then=
 didn't
> include the trailing space in each string:
>
>     log_out(ctx, _("%s: clean, %u/%u%s files, %llu/%llu%s blocks"),
>

You are right. I will apply it.

> Cheers, Andreas
>

Very thanks Andreas for your advices and your time.

I will apply these changes to my patch.

Regards
Oscar

>>        ctx->device_name,
>>        fs->super->s_inodes_count - fs->super->s_free_inodes_count,
>>        fs->super->s_inodes_count,
>> +        percent_files,
>>        (unsigned long long) ext2fs_blocks_count(fs->super) -
>>        ext2fs_free_blocks_count(fs->super),
>> -        (unsigned long long) ext2fs_blocks_count(fs->super));
>> +        (unsigned long long) ext2fs_blocks_count(fs->super),
>> +        percent_blocks);
>>    next_check =3D 100000;
>>    if (fs->super->s_max_mnt_count > 0) {
>>        next_check =3D fs->super->s_max_mnt_count - fs->super->s_mnt_coun=
t;
>> --=20
>> 2.40.0
>>=20

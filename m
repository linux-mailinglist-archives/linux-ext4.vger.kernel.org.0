Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329E75997AB
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Aug 2022 10:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347701AbiHSIhH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Aug 2022 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347222AbiHSIgr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Aug 2022 04:36:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFC252801;
        Fri, 19 Aug 2022 01:34:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 2so3604898pll.0;
        Fri, 19 Aug 2022 01:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=jnKcopMVpJ1ujZZ1JOt5IM3P6FS7UvXDlx9XIFw0IK0=;
        b=R4uAZOJM8pW+RKOydL4zQmNBIkcKVwdY2q9AApJFTE6YMgMaqRPJb7BKvMDNYXhxyX
         RDesuGNKz+NLwFlprQQqzdMPXZqWbN4WGscVqnu2k8wY2lDyWR9mVdVk4ruMshrfVdSv
         v25ZeM6wKu+3Wbzsmizzw2NGAlSRtJ2uXytLGIAHxzNqdK22AOPT2qnXU77TNCho1IgV
         zOLr7LcvrCltREIPFM8uKh961AiKiOd09/bAVzLeAFi5xwqT/x+3t/9prUq3etS6Rybx
         MIi/5P3jkXG69yZirrWkYdsNmbgt3nTAFUKRsccX3RhyGmcFSyvWIrRfmirMCpZxqFeW
         i7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=jnKcopMVpJ1ujZZ1JOt5IM3P6FS7UvXDlx9XIFw0IK0=;
        b=bJcfJknx/Uo2oYsZEejxJO1+L3UMTi1D5A7a7BfiC7lzDQBObMJ/YEJar71hAT+ETa
         Ywt0/4VVNwgb+V6Jd6+xpRsi7+VdbypR55Wl89VHUIyHIOgNrW9oixa9LyxOduyFC7Cz
         qZXms3BL5ImohKYYmdQOpRdEzX8Va/oeYLR5j2kstvVDn+DUIox1/Ft04JvvIsrElySA
         JnECZ3Zxelwb5n90dtreM1IIPWwbi+h2CbCZj8ZguxeE249JaQ9+E3+yyOx+K9vC4O8l
         AMZBGdA2J6quL55M3Um/5swDD9foyw5XbuJt4THwQxYbm/hH2Exwly4zNj3ykYFaN8cX
         W6uw==
X-Gm-Message-State: ACgBeo2K5M63mTc/uCwKGGPAE0Ffj0zUSGvsvFbFOV29wDW6w2zYrVQ9
        jap0F7p+ZaLohHONT82hTwCV04Asp3vjrQ==
X-Google-Smtp-Source: AA6agR50l+1rM1GLTAv/4/qfnBkeE8RlgJN68Ec+GzsTmciohw49K/WfRNdWoVC6imB/rbLS1f4ikg==
X-Received: by 2002:a17:902:eccb:b0:16f:9355:c117 with SMTP id a11-20020a170902eccb00b0016f9355c117mr6277060plh.167.1660898072946;
        Fri, 19 Aug 2022 01:34:32 -0700 (PDT)
Received: from smtpclient.apple ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id u125-20020a626083000000b0052f3b2a8ee5sm2957215pfb.81.2022.08.19.01.34.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:34:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH RFC] jbd2: detect old record when do journal scan
From:   fengnan chang <fengnanchang@gmail.com>
In-Reply-To: <62FF430D.9040405@huawei.com>
Date:   Fri, 19 Aug 2022 16:34:28 +0800
Cc:     "tytso@mit.edu" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Content-Transfer-Encoding: quoted-printable
Message-Id: <A602BE93-1AE5-43D7-B42B-D991E24AC933@gmail.com>
References: <20220810013442.3474533-1-yebin10@huawei.com>
 <62FF430D.9040405@huawei.com>
To:     yebin <yebin10@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If there has system time calibration, system time has become smaller, =
what will be happen?
the journal maybe thought as corrupt?


> 2022=E5=B9=B48=E6=9C=8819=E6=97=A5 16:00=EF=BC=8Cyebin =
<yebin10@huawei.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> ping...
>=20
> On 2022/8/10 9:34, Ye Bin wrote:
>> As https://github.com/tytso/e2fsprogs/issues/120 describe tune2fs do =
not update
>> j_tail_sequence when do journal recovery. This maybe recover old =
journal record,
>> then will lead to file system corruption.
>> To avoid file system corruption in this case, if detect current =
transaction's
>> commit time earlier than previous transaction's commit time when do =
journal
>> scan, just return error.
>>=20
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>  fs/jbd2/recovery.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
>> index f548479615c6..f3def21a96a5 100644
>> --- a/fs/jbd2/recovery.c
>> +++ b/fs/jbd2/recovery.c
>> @@ -812,8 +812,17 @@ static int do_one_pass(journal_t *journal,
>>  					break;
>>  				}
>>  			}
>> -			if (pass =3D=3D PASS_SCAN)
>> +			if (pass =3D=3D PASS_SCAN) {
>> +				if (commit_time < =
last_trans_commit_time) {
>> +					pr_err("JBD2: old journal record =
found "
>> +					       "in transaction %u\n",
>> +					       next_commit_ID);
>> +					err =3D -EFSBADCRC;
>> +					brelse(bh);
>> +					goto failed;
>> +				}
>>  				last_trans_commit_time =3D commit_time;
>> +			}
>>  			brelse(bh);
>>  			next_commit_ID++;
>>  			continue;
>=20


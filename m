Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBAC5B16CC
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIHIWF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiIHIWE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:22:04 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55AA3123D
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:22:03 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id by6so18948615ljb.11
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=FEVbeJLU4ZxjTXcOBdx0iHNnTD7fkugL+PIDVfUXbUo=;
        b=bxfcecMWqo7/3INJotiD4uNF243seN/X6yjx88jYAC4n3maKMEDkuf+pze8vUNB/ya
         eW5uIsY6XsYNrznVue5nBmlamNH0s0y4BMz/0Z6wrNiVliawinTpJNqaCi0kdQGAr6Px
         KSvHeeTLg4qYWPSgpJwbCmB+EuZyJsSRMxfBWXNdg1h/XFQM7FyhCIRKYv71pu1SfbQG
         jyvu62FomCyRCUbhGDkUsuRqpYzknoK+X4RSm+dgTMgKUCYy238rbNwQtTtl31ymDhTT
         02a6ClCnSEo/+tdmWBfwO9em5b38S//E/FcM1Vi3ou3JCcTMl0d4OaiB0yaLwwjujIcf
         T7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FEVbeJLU4ZxjTXcOBdx0iHNnTD7fkugL+PIDVfUXbUo=;
        b=2eg6pUgYZ+yXNj8Sftb6JwCY5yr0fb4zOLD1yjWsuVP5oZusZlV7EE6ilbpkuuqqck
         +ud90xzHZL/IqkypQzEGdfJbcXEScSba2sKSQEnONcyx6pFL2wvVrr351qP6Oitmf0N8
         9qWVwplrPkgXMhMdw8GU4Ry7rBbLMcWuA+oTy0V4Wy5iiSdq1KoEDsoR0qbRgF1ey1aw
         /csg3AhRDeNQcN/pHrcW2UjE8YPj9NMImExE+nvPbGprcLgGeykkZX5Xhd2zEj+fqwFo
         Dteb/IK251uGcuafuMblUmk1L8NrdiZ5qn6iC7tOfDvE3T42GCEu70lfE60oN+16fUre
         Mx4w==
X-Gm-Message-State: ACgBeo2nFrD/9HMghLI43EPRQGSurXUucNlxJSgJ2xYXxQ5ObEfPplt9
        zzmugVJ9vsNmQWROlZeu/BiwwortmaS+6Q==
X-Google-Smtp-Source: AA6agR7+UB38QS64O4PnVzrT9H0C8B0Vpbw8nmnNTtkJjtLAE2282XIdWKm2WimzMspWJBUx9Nr3lg==
X-Received: by 2002:a2e:9946:0:b0:268:8415:444a with SMTP id r6-20020a2e9946000000b002688415444amr2038016ljj.62.1662625322240;
        Thu, 08 Sep 2022 01:22:02 -0700 (PDT)
Received: from smtpclient.apple ([46.246.26.67])
        by smtp.gmail.com with ESMTPSA id g3-20020a056512118300b00494903a1f5dsm2936724lfr.187.2022.09.08.01.22.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2022 01:22:01 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] jbd2: wake up journal waiters in FIFO order, not  LIFO
From:   Alexey Lyahkov <alexey.lyashkov@gmail.com>
In-Reply-To: <20220908061153.dflgx7fjjav7pxyn@riteshh-domain>
Date:   Thu, 8 Sep 2022 11:21:59 +0300
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Andrew Perepechko <anserper@ya.ru>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C1AAACF-5878-4812-8334-29A328B57A77@gmail.com>
References: <20220907165959.1137482-1-alexey.lyashkov@gmail.com>
 <20220908054611.vjcb27wmq4dggqmv@riteshh-domain>
 <B32B956C-E851-42A2-9419-2947C442E2AA@gmail.com>
 <20220908061153.dflgx7fjjav7pxyn@riteshh-domain>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On 8 Sep 2022, at 09:11, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> On 22/09/08 08:51AM, Alexey Lyahkov wrote:
>> Hi Ritesh,
>>=20
>> This was hit on the Lustre OSS node when we have ton=E2=80=99s of =
short write with sync/(journal commit) in parallel.
>> Each write was done from own thread (like 1k-2k threads in parallel).
>> It caused a situation when only few/some threads make a wakeup and =
enter to the transaction until it will be T_LOCKED.
>> In our=E2=80=99s observation all handles from head was waked and =
it=E2=80=99s handles added recently, while old handles still in list and
>=20
> Thanks Alexey for providing the details.
>=20
>> It caused a soft lockup messages on console.
>=20
> Did you mean hung task timeout? I was wondering why will there be soft =
lockup
> warning, because these old handles are anyway in a waiting state =
right.
> Am I missing something?
>=20
Oh. I asked a colleges about details. It was internal lustre hung =
detector not a kernel side

[ 2221.036503] Lustre: ll_ost_io04_080: service thread pid 55122 was =
inactive for 80.284 seconds. The thread might be hung, or it might only =
be slow and will resume later. Dumping the stack trace for debugging =
purposes:
[ 2221.036677] Pid: 55212, comm: ll_ost_io05_074 =
4.18.0-305.10.2.x6.1.010.19.x86_64 #1 SMP Thu Jun 30 13:42:51 MDT 2022
[ 2221.056673] Lustre: Skipped 2 previous similar messages
[ 2221.067821] Call Trace TBD:
[ 2221.067855] [<0>] wait_transaction_locked+0x89/0xc0 [jbd2]
[ 2221.099175] [<0>] add_transaction_credits+0xd4/0x290 [jbd2]
[ 2221.105266] [<0>] start_this_handle+0x10a/0x520 [jbd2]
[ 2221.110904] [<0>] jbd2__journal_start+0xea/0x1f0 [jbd2]
[ 2221.116679] [<0>] __ldiskfs_journal_start_sb+0x6e/0x130 [ldiskfs]
[ 2221.123316] [<0>] osd_trans_start+0x13b/0x4f0 [osd_ldiskfs]
[ 2221.129417] [<0>] ofd_commitrw_write+0x620/0x1830 [ofd]
[ 2221.135147] [<0>] ofd_commitrw+0x731/0xd80 [ofd]
[ 2221.140420] [<0>] obd_commitrw+0x1ac/0x370 [ptlrpc]
[ 2221.145858] [<0>] tgt_brw_write+0x1913/0x1d50 [ptlrpc]
[ 2221.151561] [<0>] tgt_request_handle+0xc93/0x1a40 [ptlrpc]
[ 2221.157622] [<0>] ptlrpc_server_handle_request+0x323/0xbd0 [ptlrpc]
[ 2221.164454] [<0>] ptlrpc_main+0xc06/0x1560 [ptlrpc]
[ 2221.169860] [<0>] kthread+0x116/0x130
[ 2221.174033] [<0>] ret_from_fork+0x1f/0x40


Other logs have shown this thread can=E2=80=99t take a handle, but other =
threads able to do it many times.
Kernel detector don=E2=80=99t hit because thread have wakeup many times =
but it have seen T_LOCKED and go to sleep again.

Alex



> -ritesh


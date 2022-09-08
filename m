Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBFD5B1821
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiIHJLg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiIHJL3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:11:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6E8FF510
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:11:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j12so4840610pfi.11
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=cpcAAbT7uyGFa69o2ftGc2hZ/w20KpVWUL+huVvVg0M=;
        b=eqYjov3Tr1F5cRHzRKxJYv8o3lp6ZyGukd5aWZo52l7HJrzLu0JgYIAdu42MdAECfk
         d1fvt+gSmpcS9MEHMgQIwuwakxPVL1d3rtwngQFhNLxMncJiGm9Tv1bqC5yJ4ooNb0zY
         HxTV2y7wT0uTPnQMZaR2PEzo23cNLreDEgOk63X87Dx7MLuunEg+yCmJE6IldSdCsmNO
         CAPhA/eXIl6Jmq5OMwvk0bQLdZZKUEHYmK609wqI9ojJhoH7vy0M4QS3+TCCpiU1Bpog
         grmzrvHfUPxETX540mQG4358NyjlVYaeUN5GhO/8dzl5f7uwHDz8wUlTqrBn/nAQmwyn
         AmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cpcAAbT7uyGFa69o2ftGc2hZ/w20KpVWUL+huVvVg0M=;
        b=35VhqztID78EQc8+bDhh3T78EPuJx/CYdN+uya2O+9pL14UL/znHRbPp7bzzMc0PPc
         GCx2o9KyIFcYdiabxHtqs0mVBQEiIWqGeLYkoKNgk1pEkUAPQf6qstPswcjnhwu8dIvR
         PNQpoBq5zQuzGz59+SEIE3s2p7eg3AepFem4t98GBgq9Mq32ookYq6XeB+zcNTFB2rSM
         6Kd9lJfm34w5/7HCSXFgtWUpcBk6qqUA8gUOrcKYWHm/WYc4RScMRaKesQd45v7cB8g2
         FiXy1zRDVwCSB4WJzb7/iOcr8fGb4P3ZLtaIe6/qIruZYEd16oIA9paaHe0KJHcrhfZF
         9J5A==
X-Gm-Message-State: ACgBeo0/odxrifSgP56KFXg3m/LIjqimKLaZt+pADs/7eMAl3qhB/szg
        fvBtJxY+Nw1FOmk6uoyE5hdMgK5ZVTk=
X-Google-Smtp-Source: AA6agR5D++VayyHFfku1Q3nOfha0hZok6sRSs9Y1f4ZNQLnHwZgAjnqhHf0WOqfMGeYOjyMvQ5t7wQ==
X-Received: by 2002:a63:5353:0:b0:434:8606:ce94 with SMTP id t19-20020a635353000000b004348606ce94mr6879949pgl.345.1662628282194;
        Thu, 08 Sep 2022 02:11:22 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id jn5-20020a170903050500b00176e2fa216csm4021761plb.52.2022.09.08.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:11:21 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:41:16 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Alexey Lyahkov <alexey.lyashkov@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Andrew Perepechko <anserper@ya.ru>
Subject: Re: [PATCH] jbd2: wake up journal waiters in FIFO order, not  LIFO
Message-ID: <20220908091116.zvsfttb6dhz57d52@riteshh-domain>
References: <20220907165959.1137482-1-alexey.lyashkov@gmail.com>
 <20220908054611.vjcb27wmq4dggqmv@riteshh-domain>
 <B32B956C-E851-42A2-9419-2947C442E2AA@gmail.com>
 <20220908061153.dflgx7fjjav7pxyn@riteshh-domain>
 <5C1AAACF-5878-4812-8334-29A328B57A77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5C1AAACF-5878-4812-8334-29A328B57A77@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/08 11:21AM, Alexey Lyahkov wrote:
> 
> 
> > On 8 Sep 2022, at 09:11, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> > 
> > On 22/09/08 08:51AM, Alexey Lyahkov wrote:
> >> Hi Ritesh,
> >> 
> >> This was hit on the Lustre OSS node when we have ton’s of short write with sync/(journal commit) in parallel.
> >> Each write was done from own thread (like 1k-2k threads in parallel).
> >> It caused a situation when only few/some threads make a wakeup and enter to the transaction until it will be T_LOCKED.
> >> In our’s observation all handles from head was waked and it’s handles added recently, while old handles still in list and
> > 
> > Thanks Alexey for providing the details.
> > 
> >> It caused a soft lockup messages on console.
> > 
> > Did you mean hung task timeout? I was wondering why will there be soft lockup
> > warning, because these old handles are anyway in a waiting state right.
> > Am I missing something?
> > 
> Oh. I asked a colleges about details. It was internal lustre hung detector not a kernel side

Thanks again for sharing the details. This indeed looks like a task handle can
remain in wait state for long due to wrong wakeup order in case of many threads. 

-ritesh

> 
> [ 2221.036503] Lustre: ll_ost_io04_080: service thread pid 55122 was inactive for 80.284 seconds. The thread might be hung, or it might only be slow and will resume later. Dumping the stack trace for debugging purposes:
> [ 2221.036677] Pid: 55212, comm: ll_ost_io05_074 4.18.0-305.10.2.x6.1.010.19.x86_64 #1 SMP Thu Jun 30 13:42:51 MDT 2022
> [ 2221.056673] Lustre: Skipped 2 previous similar messages
> [ 2221.067821] Call Trace TBD:
> [ 2221.067855] [<0>] wait_transaction_locked+0x89/0xc0 [jbd2]
> [ 2221.099175] [<0>] add_transaction_credits+0xd4/0x290 [jbd2]
> [ 2221.105266] [<0>] start_this_handle+0x10a/0x520 [jbd2]
> [ 2221.110904] [<0>] jbd2__journal_start+0xea/0x1f0 [jbd2]
> [ 2221.116679] [<0>] __ldiskfs_journal_start_sb+0x6e/0x130 [ldiskfs]
> [ 2221.123316] [<0>] osd_trans_start+0x13b/0x4f0 [osd_ldiskfs]
> [ 2221.129417] [<0>] ofd_commitrw_write+0x620/0x1830 [ofd]
> [ 2221.135147] [<0>] ofd_commitrw+0x731/0xd80 [ofd]
> [ 2221.140420] [<0>] obd_commitrw+0x1ac/0x370 [ptlrpc]
> [ 2221.145858] [<0>] tgt_brw_write+0x1913/0x1d50 [ptlrpc]
> [ 2221.151561] [<0>] tgt_request_handle+0xc93/0x1a40 [ptlrpc]
> [ 2221.157622] [<0>] ptlrpc_server_handle_request+0x323/0xbd0 [ptlrpc]
> [ 2221.164454] [<0>] ptlrpc_main+0xc06/0x1560 [ptlrpc]
> [ 2221.169860] [<0>] kthread+0x116/0x130
> [ 2221.174033] [<0>] ret_from_fork+0x1f/0x40
> 
> 
> Other logs have shown this thread can’t take a handle, but other threads able to do it many times.
> Kernel detector don’t hit because thread have wakeup many times but it have seen T_LOCKED and go to sleep again.
> 
> Alex
> 
> 
> 
> > -ritesh
> 

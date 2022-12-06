Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1583644DAD
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 22:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLFVCY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 16:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLFVCV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 16:02:21 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1AD45EC3
        for <linux-ext4@vger.kernel.org>; Tue,  6 Dec 2022 13:02:21 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B6L1s5x001532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 16:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670360517; bh=RE08JzHgRayJdGe4tDQIqekPfzDjh3mlI+z+5l1uNQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eG+aeD8CUlu/Sqfq1Qe1haFCUi0vPW2dNEvIniZBy98VUFNxeTTLHOrO1kr9/KO7z
         FiulKxpI50ZZgMOYf10Z6B+8y9amQledms3ZnOBgZfj1d9EBi7pNJ5E+I5ac+86iZn
         cAMXhVCbmttOSJ0zzfH+NZuzjwQQLmy0htYHQP1N2VynhjyspfSB33Rqp2LIDqu5PW
         q9KTUzhHtXaiY0A3CGOrHmY4zQFPTVW1yNSw9thM3MfDGHPQz07oFmTA97+APXd5YG
         n5Acd8M0rholD6ffPfd/At5HgRaLHp4gVLug6hibjUOGPNWjubYD5ZrNafnx4nejIS
         uee8dmIGavsUA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D28B315C3489; Tue,  6 Dec 2022 16:01:54 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, cmaiolino@redhat.com,
        adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix undefined behavior in bit shift for ext4_check_flag_values
Date:   Tue,  6 Dec 2022 16:01:47 -0500
Message-Id: <167036049592.156498.2455997966584803257.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221031055833.3966222-1-cuigaosheng1@huawei.com>
References: <20221031055833.3966222-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 31 Oct 2022 13:58:33 +0800, Gaosheng Cui wrote:
> Shifting signed 32-bit value by 31 bits is undefined, so changing
> significant bit to unsigned. The UBSAN warning calltrace like below:
> 
> UBSAN: shift-out-of-bounds in fs/ext4/ext4.h:591:2
> left shift of 1 by 31 places cannot be represented in type 'int'
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x7d/0xa5
>  dump_stack+0x15/0x1b
>  ubsan_epilogue+0xe/0x4e
>  __ubsan_handle_shift_out_of_bounds+0x1e7/0x20c
>  ext4_init_fs+0x5a/0x277
>  do_one_initcall+0x76/0x430
>  kernel_init_freeable+0x3b3/0x422
>  kernel_init+0x24/0x1e0
>  ret_from_fork+0x1f/0x30
>  </TASK>
> 
> [...]

Applied, thanks!

[1/1] ext4: fix undefined behavior in bit shift for ext4_check_flag_values
      commit: 0cd464d06ba0b9941dd285042909dc4d94adb373

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

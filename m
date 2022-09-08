Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2995B1739
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiIHIgh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIHIgd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:36:33 -0400
X-Greylist: delayed 443 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 01:36:31 PDT
Received: from forward107j.mail.yandex.net (forward107j.mail.yandex.net [5.45.198.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF74CDFF67
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:36:31 -0700 (PDT)
Received: from forward503j.mail.yandex.net (forward503j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::113])
        by forward107j.mail.yandex.net (Yandex) with ESMTP id BC6BF887600;
        Thu,  8 Sep 2022 11:28:35 +0300 (MSK)
Received: from vla1-b7b6154c4cfd.qloud-c.yandex.net (vla1-b7b6154c4cfd.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3495:0:640:b7b6:154c])
        by forward503j.mail.yandex.net (Yandex) with ESMTP id 851291DAEF93;
        Thu,  8 Sep 2022 11:28:35 +0300 (MSK)
Received: by vla1-b7b6154c4cfd.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id lcmUcd9y5j-SXhq3kDm;
        Thu, 08 Sep 2022 11:28:35 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1662625715;
        bh=SR28xl9TqG4sh99CnRD+CmQIr/ApB1Bmm4ByGm5C2b8=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=reuNp+lLBN8mo7vsvboOao24yPThnisLtpARlors6+zExuM9d4AfyJHR8LS1XDqsJ
         rPuXHIaXaFqC3yAx31fnNcxcSIda6y3EWCCZA2Oh4KGW7dkivmwwMJUH0wgY3T2Ycf
         HUAdIop7PBthImY0kkicoyutfqUatc3W+GyotBzc=
Authentication-Results: vla1-b7b6154c4cfd.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <a6343e6d-00a9-3546-2182-6058150602b0@ya.ru>
Date:   Thu, 8 Sep 2022 11:28:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] jbd2: wake up journal waiters in FIFO order, not LIFO
Content-Language: en-US
To:     Alexey Lyahkov <alexey.lyashkov@gmail.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
References: <20220907165959.1137482-1-alexey.lyashkov@gmail.com>
 <20220908054611.vjcb27wmq4dggqmv@riteshh-domain>
 <B32B956C-E851-42A2-9419-2947C442E2AA@gmail.com>
 <20220908061153.dflgx7fjjav7pxyn@riteshh-domain>
 <5C1AAACF-5878-4812-8334-29A328B57A77@gmail.com>
From:   Andrew <anserper@ya.ru>
In-Reply-To: <5C1AAACF-5878-4812-8334-29A328B57A77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Other logs have shown this thread can’t take a handle, but other threads able to do it many times.
> Kernel detector don’t hit because thread have wakeup many times but it have seen T_LOCKED and go to sleep again.
Also, the transactions are small because the workload is sync writes.

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3457D5B1473
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 08:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiIHGMD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 02:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiIHGMA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 02:12:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147ABAE239
        for <linux-ext4@vger.kernel.org>; Wed,  7 Sep 2022 23:12:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so1300516pjm.1
        for <linux-ext4@vger.kernel.org>; Wed, 07 Sep 2022 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=/RyCXIrRuZulELrnZ5IZnyPdECYYhHtey3K8+I4/oTA=;
        b=ZNR6hrHAH3/AWOSda+hhRWRiGd9kmAKmat4r+dOAFPhxJNOLi3s/pIhA0A0qWW246o
         qAqFbRvameQ9J4Z6YAcJB162x5TjMgcRb97RUmJmQoBjzxbk14QZAnZN90ckwEtjPoVZ
         jS3jpSN/ej+keiQm9Zm1EK84AhtmCjbjc6eaCxW5fAR7s9iqbNXxMNQ+dAZod8rcedtI
         PqIiLoMyq0ZJj/SFCK6tmNeSWkSthQQQbhmaI1eNYf2jJm8He5T/mjb4DShc2xNzy3ok
         hQxJeLwUm2WwyVM3RgqjwsdJtEkhZ4pNIkKnNSpURbUWvs6iN83utXm8uSqqRMemRqyy
         XTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/RyCXIrRuZulELrnZ5IZnyPdECYYhHtey3K8+I4/oTA=;
        b=OnB21Hngh5xktvY+hvZfNFenhb5JLW0+Pfmuqgfkktda9ShoLhPrqtMUgRb/ebpzON
         AnHKQm5Q74z9CmIfQJ582F5LPH4PTlPY64Vi6MOkzH5LZBilDF6WS5Mey015JFjBj9vH
         Sox/rrYj+weG7KbbGScTzrYhqM92odFENhhW8YzNeIzSdaWb+St1qNNLC/jQQ72o8txN
         HnA8wwC3sqXW9C7vxiy4pabFaQTk0exA1fw3Jc1nJlDr10QwyAp/0wD/LV4CpKfQ6r5h
         Zm6OTQJUnSksEZ52bHAkrrQIgNk4oCcYK7OMFanUk277X6Qcu/5ZaeA1KdSW+e5+TFUl
         CHfw==
X-Gm-Message-State: ACgBeo0CADv31BYSO1irgZkaWUklPqSOYzQheQJi865ugukhHEx+FtRR
        USc0rRojN6KQT313RiWmpec=
X-Google-Smtp-Source: AA6agR5JvQY7A8tkGlK2u5bBiWsdK/RUJGQE4YmEzQerVPc5ZsfwcyOGCu06zF07QCyBR8XHHFPHeg==
X-Received: by 2002:a17:902:d48a:b0:16f:c31:7005 with SMTP id c10-20020a170902d48a00b0016f0c317005mr7507111plg.173.1662617519536;
        Wed, 07 Sep 2022 23:11:59 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id p68-20020a625b47000000b0053e93aa8fb9sm1867722pfb.71.2022.09.07.23.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 23:11:59 -0700 (PDT)
Date:   Thu, 8 Sep 2022 11:41:53 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Alexey Lyahkov <alexey.lyashkov@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        Andrew Perepechko <anserper@ya.ru>
Subject: Re: [PATCH] jbd2: wake up journal waiters in FIFO order, not  LIFO
Message-ID: <20220908061153.dflgx7fjjav7pxyn@riteshh-domain>
References: <20220907165959.1137482-1-alexey.lyashkov@gmail.com>
 <20220908054611.vjcb27wmq4dggqmv@riteshh-domain>
 <B32B956C-E851-42A2-9419-2947C442E2AA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B32B956C-E851-42A2-9419-2947C442E2AA@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/08 08:51AM, Alexey Lyahkov wrote:
> Hi Ritesh,
> 
> This was hit on the Lustre OSS node when we have ton’s of short write with sync/(journal commit) in parallel.
> Each write was done from own thread (like 1k-2k threads in parallel).
> It caused a situation when only few/some threads make a wakeup and enter to the transaction until it will be T_LOCKED.
> In our’s observation all handles from head was waked and it’s handles added recently, while old handles still in list and

Thanks Alexey for providing the details.

> It caused a soft lockup messages on console.

Did you mean hung task timeout? I was wondering why will there be soft lockup
warning, because these old handles are anyway in a waiting state right.
Am I missing something?

-ritesh

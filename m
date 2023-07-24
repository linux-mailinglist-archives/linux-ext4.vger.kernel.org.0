Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7260175E9FF
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 05:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjGXDQh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jul 2023 23:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXDQd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Jul 2023 23:16:33 -0400
Received: from out-56.mta1.migadu.com (out-56.mta1.migadu.com [IPv6:2001:41d0:203:375::38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F713D
        for <linux-ext4@vger.kernel.org>; Sun, 23 Jul 2023 20:16:31 -0700 (PDT)
Message-ID: <7aec48ca-c7fa-df42-8a09-5dea9c762c2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690168589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v/Nl3T+zbR1N0EUfB+uQS1FDwMxXn+Dh9icyREntaZY=;
        b=nLLshSjzI7nE1PlZC8F67Hrmg30odfdLqYIEgTqgpgDjFrnUg/f5rZDDnfI45iPep1Cc7d
        tjXUtoHff/YA6KJ0CkUBCvfAv7MFsbMbrMiLqu/Zoh7zGLWPf7MAr7ujQMQwUta6mOSlfp
        GarrZIfkf2DwEyIZWQzSNPl2KudAEds=
Date:   Mon, 24 Jul 2023 11:16:20 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] ext4: improve discard efficiency
To:     Fengnan Chang <changfengnan@bytedance.com>,
        adilger.kernel@dilger.ca, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <20230719093633.34141-1-changfengnan@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20230719093633.34141-1-changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On 7/19/23 17:36, Fengnan Chang wrote:
> In commit a015434480dc("ext4: send parallel discards on commit
> completions"), issue all discard commands in parallel make all
> bios could merged into one request, so lowlevel drive can issue
> multi segments in one time which is more efficiency, but commit
> 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> seems broke this way, let's fix it.
> In my test, the time of fstrim fs with multi big sparse file
> reduce from 6.7s to 1.3s.

I tried with a 20T sparse file with latest kernel (6.5-rc2+ commit 
f7e3a1baf).

truncate -s 20T sparse1.img
mkfs.ext4 sparse1.img
mount -o discard sparse1.img /mnt/
time fstrim /mnt

1. without the patch

[root@localhost ~]# time fstrim /mnt

real    0m13.496s
user    0m0.002s
sys     0m5.202s

2. with the patch

[root@localhost ~]# time fstrim /mnt

real    0m15.956s
user    0m0.000s
sys     0m7.251s

The result is different from your side, could you share your test?

Thanks,
Guoqing

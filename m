Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AA06074F3
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Oct 2022 12:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJUKXr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Oct 2022 06:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJUKXq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Oct 2022 06:23:46 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29A2D25C2DB
        for <linux-ext4@vger.kernel.org>; Fri, 21 Oct 2022 03:23:46 -0700 (PDT)
Received: from [10.254.254.111] (ip5b408877.dynamic.kabel-deutschland.de [91.64.136.119])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5EC5220FEB53;
        Fri, 21 Oct 2022 03:23:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5EC5220FEB53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666347825;
        bh=zD7MG+p2kLAq0wDLc5QO2iFHcQBFf6zBmvywWecCrsc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lEG22XT4bZtwQ8x/3tyGFYyuAd4ynDQ/U9GbR616FPhgL1RlF2yUmSRdXbwJKpPwo
         hledyivdaunGwCClDlYM7mNJebdv8VT3NYP6xa23Rs+t0kW6MQu707issWp6mo17ca
         ywmAKTD8VRtL5JzrCD4kjvrUj+IM8rC1qXb9QGIo=
Message-ID: <d30f4e74-aa75-743d-3c89-80ec61d67c6c@linux.microsoft.com>
Date:   Fri, 21 Oct 2022 12:23:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
To:     Jan Kara <jack@suse.cz>
Cc:     Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
References: <20220824100652.227m7eq4zqq7luir@quack3>
 <c77bf00f-4618-7149-56f1-b8d1664b9d07@linux.microsoft.com>
 <20220929082716.5urzcfk4hnapd3cr@quack3>
 <d8b18ba8-ea12-b617-6b5e-455a1d7b5e21@linux.microsoft.com>
 <20221004063807.GA30205@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221004091035.idjgo2xyscf6ovnv@quack3>
 <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
 <20221005151053.7jjgc7uhvquo6a5n@quack3>
 <20221010142410.GA1689@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
 <20221014132543.i3aiyx4ent4qwy4i@quack3>
Content-Language: en-US
From:   Thilo Fromm <t-lo@linux.microsoft.com>
In-Reply-To: <20221014132543.i3aiyx4ent4qwy4i@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Honza,

>> Just want to make sure this does not get lost - as mentioned earlier,
>> reverting 51ae846cff5 leads to a kernel build that does not have this issue.
> 
> Yes, I'm aware of this and still cannot quite wrap my head how it could be
> given the stacktraces I see :) They do not seem to come anywhere near that
> code...

Just reaching out to let folks know that we see more reports on this 
issue coming in for kernels >=5.15.63, see 
https://github.com/flatcar/Flatcar/issues/847#issuecomment-1286523602.

Best regards,
Thilo

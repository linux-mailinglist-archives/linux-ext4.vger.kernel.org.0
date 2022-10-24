Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14F960B678
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Oct 2022 20:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJXS7a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Oct 2022 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiJXS61 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Oct 2022 14:58:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59B5C2347B8
        for <linux-ext4@vger.kernel.org>; Mon, 24 Oct 2022 10:38:27 -0700 (PDT)
Received: from [10.254.254.111] (ip5b408877.dynamic.kabel-deutschland.de [91.64.136.119])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4B4D9204B53A;
        Mon, 24 Oct 2022 09:32:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B4D9204B53A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666629174;
        bh=GfElR9udXiQf3guZiHJL3KQoGri3nokfNdchhJSXkq0=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=sIIW+RgpIOOlNve3I28qgl1AvrcH63U+NDMr3zJmfZVi9t/Cj/mZ1lC6RPCo8yaCn
         XM8fXlKk/+w3uSsYoBgI9bB4X58Tu8QOlTheaTTwlAECoWkzM+NdVkZ5YA2wIhTwVi
         S41i/jv+iO4h+0zizN55H0CGzLu8F6RGTYJgNlLo=
Message-ID: <643d007e-1041-4b3d-ed5e-ae47804f279d@linux.microsoft.com>
Date:   Mon, 24 Oct 2022 18:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To:     Jan Kara <jack@suse.cz>
Cc:     Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
References: <20220929082716.5urzcfk4hnapd3cr@quack3>
 <d8b18ba8-ea12-b617-6b5e-455a1d7b5e21@linux.microsoft.com>
 <20221004063807.GA30205@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221004091035.idjgo2xyscf6ovnv@quack3>
 <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
 <20221005151053.7jjgc7uhvquo6a5n@quack3>
 <20221010142410.GA1689@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
 <20221014132543.i3aiyx4ent4qwy4i@quack3>
 <d30f4e74-aa75-743d-3c89-80ec61d67c6c@linux.microsoft.com>
 <20221024104628.ozxjtdrotysq2haj@quack3>
Content-Language: en-US
From:   Thilo Fromm <t-lo@linux.microsoft.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
In-Reply-To: <20221024104628.ozxjtdrotysq2haj@quack3>
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

> Yeah, I was pondering about this for some time but still I have no clue who
> could be holding the buffer lock (which blocks the task holding the
> transaction open) or how this could related to the commit you have
> identified. I have two things to try:
> 
> 1) Can you please check whether the deadlock reproduces also with 6.0
> kernel? The thing is that xattr handling code in ext4 has there some
> additional changes, commit 307af6c8793 ("mbcache: automatically delete
> entries from cache on freeing") in particular.

This would be complex; we currently do not integrate 6.0 with Flatcar 
and would need to spend quite some effort ingesting it first (mostly, 
make sure the new kernel does not break something unrelated). Flatcar is 
an image-based distro, so kernel updates imply full distro updates.

> 2) I have created a debug patch (against 5.15.x stable kernel). Can you
> please reproduce the failure with it and post the output of "echo w
>> /proc/sysrq-trigger" and also the output the debug patch will put into the
> kernel log? It will dump the information about buffer lock owner if we > cannot get the lock for more than 32 seconds.

This would be more straightforward - I can reach out to one of our users 
suffering from the issue; they can reliably reproduce it and don't shy 
away from patching their kernel. Where can I find the patch?

Best,
Thilo

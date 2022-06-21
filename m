Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC4553479
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jun 2022 16:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiFUO3J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jun 2022 10:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiFUO3J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jun 2022 10:29:09 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8AA262D9;
        Tue, 21 Jun 2022 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=dD98V
        ez2aD21iNFpk0tg6AZ8kngi+2AB0UFxeAgDYzA=; b=EPnbdMYvAKUIAIkqAogV7
        koFPnM4fK9Ghtb9Wd2rUtZ9UIZDyKCaq3M1bnyZbqe0hyTyXeKEbkXIsLzgxWGNe
        M8eHqj7vpnwmlZdFWA6MqqS/DFWMNhQtPmEEBtMsYgj0zFB27Kx/rHOCwiGDoAaM
        yqa5QJ+1wK6WAYqCx9fJR0=
Received: from [10.20.42.77] (unknown [114.242.206.180])
        by smtp1 (Coremail) with SMTP id GdxpCgCHjcWo1bFiVHd1KQ--.4781S2;
        Tue, 21 Jun 2022 22:28:57 +0800 (CST)
Subject: Re: [PATCH 1/2] ext4: page-io: use 'unsigned int' to bare use of
 'unsigned'
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220518120137.2544-1-liupeibao@163.com>
 <YqtDEfJd5uUxucaS@mit.edu> <c19b8c8f-7c0f-33e6-3f2c-3425dee7fa8d@163.com>
 <Yq9obvFIv8LjAAvg@mit.edu>
From:   Liu Peibao <liupeibao@163.com>
Message-ID: <902000f3-7d9b-3115-0864-3ffa0f87d4d4@163.com>
Date:   Tue, 21 Jun 2022 22:28:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Yq9obvFIv8LjAAvg@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GdxpCgCHjcWo1bFiVHd1KQ--.4781S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4Utw4fZF18ZFWxAw18Zrb_yoW8Cr1xpr
        WfZws8KFs8G3yxAr97XwsxJFWrAw4Fkas8JF18JFy5AF1DXF12grZYkF45uryUCrsIg3Wa
        ga98Z39a9F1qvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCzuZUUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: xolx1vpled0qqrwthudrp/1tbiEwknbGE15DBCuAAAsr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 6/20/22 2:18 AM, Theodore Ts'o wrote:
> On Sun, Jun 19, 2022 at 11:21:27AM +0800, Liu Peibao wrote:
>>
>> Thanks for your reply. What I want do to is rename some temporary variables
>> in the patch2 and when I make the patch, there are the checkpatch warnings.
>>  From the point of view "one patch do one thing", I split the modification
>> into two patches. Thanks!
> 
> I didn't really see the poiont of renaming the temporary variables,
> either.
> 
> In this particular case basically only used to avoid line lengths from
> exceeding ~72 characters, and requiring a line wrap, and bio_start and
> bio_end is used only in one place in the code block below.
> 
> Is it _really_ all that confusing whether they are named
> bio_{start,end} instead of bvec_{start,end}?
> 
> If I was writing that code from scratch, I might have just used start
> and end without any prefixes.  And as far as "only have a patch do one
> thing at a time", this doesn't apply to checkpatch fixes.
> 
> The basic motivation behind "no checkpatch-only fixes" is that it
> tends to introduce code churn which makes interpreting information
> from "git blame" more difficult; and so therefore the costs exceed the
> extremely marginal benefits of fixing most checkpatch complaints.  So
> making a _patch_ be checkpatch clean, whether it's modifying existing
> code or writing new code, is fine, since you're making a subtantive
> change to the code, so this is as good a time as any to fix up tiny
> nits such as checkpatch complaints.
> 
> But the idea behind "no unnecessary code churn since it ruins git
> blame and could potentially induce future patch conflicts" also
> applies to renaming variables.  The benefits are very minor, and they
> don't outweigh the costs.
> 
> 						- Ted
> 

Got it! Thanks for your detailed and comprehensive explanation!

Best Regards,
Peibao


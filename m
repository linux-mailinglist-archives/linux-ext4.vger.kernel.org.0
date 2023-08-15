Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D177D046
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbjHOQpD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 12:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbjHOQo5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 12:44:57 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CBE1B5;
        Tue, 15 Aug 2023 09:44:52 -0700 (PDT)
Received: from p200300cf17418700333267be2b9ea1d1.dip0.t-ipconnect.de ([2003:cf:1741:8700:3332:67be:2b9e:a1d1]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qVx9v-0000wM-7d; Tue, 15 Aug 2023 18:44:43 +0200
Message-ID: <0d6d7b2d-fc01-0e78-8492-e460cce9f6a7@leemhuis.info>
Date:   Tue, 15 Aug 2023 18:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6.1] kernel BUG in ext4_writepages
Content-Language: en-US, de-DE
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     syzbot <syzbot+a8068dd81edde0186829@syzkaller.appspotmail.com>,
        syzkaller-lts-bugs@googlegroups.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stable <stable@vger.kernel.org>,
        regressions@lists.linux.dev, Baokun Li <libaokun1@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
References: <00000000000081f8c905f6c24e0d@google.com>
 <87dcdf62-8a74-1fbf-5f10-f4f3231f774f@collabora.com>
 <4637f58c-1cf3-0691-4fc1-6fbc38ec47ce@collabora.com>
 <0fc2546b-da7c-aac4-b402-3ef4970a1789@collabora.com>
 <20230814220536.GE2247938@mit.edu>
 <1fa9ba26-d6f7-04e7-efb8-c85645857c7f@collabora.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <1fa9ba26-d6f7-04e7-efb8-c85645857c7f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1692117893;48bb5312;
X-HE-SMSGID: 1qVx9v-0000wM-7d
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 15.08.23 18:31, Muhammad Usama Anjum wrote:
> Thank you for looking at the email.
> 
> On 8/15/23 3:05 AM, Theodore Ts'o wrote:
>> On Mon, Aug 14, 2023 at 10:35:57AM +0500, Muhammad Usama Anjum wrote:
>>>> The last refactoring was done by 4e7ea81db53465 on this code in 2013. The
>>>> code segment in question is present from even before that. It means that
>>>> this bug is present for several years. 4.14 is the most old kernel being
>>>> maintained today. So it affects all current LTS and mainline kernels. I'll
>>>> report 4e7ea81db53465 with regzbot for proper tracking. Thus probably the
>>>> bug report will get associated with all LTS kernels as well.
>>>>
>>>> #regzbot title: Race condition between buffer write and page_mkwrite
>>>
>>> #regzbot title: ext4: Race condition between buffer write and page_mkwrite
>>
>> If it's a long-standing bug, then it's really not something I consider
>> a regression.  That being said, you're assuming that the refactoring
>> is what has introduced the bug; that's not necessarily case.
> The bug was introduced by the following patch:
> 9c3569b50f12 ("ext4: add delalloc support for inline data")

Which was v3.8-rc1 afaics.

> https://lore.kernel.org/all/1351047338-4963-7-git-send-email-tm@tao.ma/
> The bug is in the inline data feature addition patches itself.
> 
> Should I remove this regression from regzbot marking it as not regression
> and only a long-standing bug?

Let me do that:

#regzbot inconclusive: regression from the 3.8 days, tracking doesn't
really gain us anything

To explain: not sure how Linus sees it, but if the culprit was merged
that long ago there is not much worth in tracking it, as there is no
easy way to fix it with a revert or something anyway. Sure, the issue
nevertheless should not remain unfixed, but lets trust Ted here that
he'll sooner or later take care of it when he sees fit.

Ciao, Thorsten

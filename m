Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3534364F
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Mar 2021 02:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCVBeW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 21:34:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14836 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCVBeB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Mar 2021 21:34:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F3cRj36j2z927r;
        Mon, 22 Mar 2021 09:32:01 +0800 (CST)
Received: from [10.174.176.202] (10.174.176.202) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 09:33:55 +0800
Subject: Re: [GIT PULL] ext4 fixes for v5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>
CC:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <YFeQ9eBFn5JELyYo@mit.edu>
 <CAHk-=wjahvxdYmEgZEOqSSOVdTP-Njqbh6e8=PDVtt4Md7qHNg@mail.gmail.com>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <ca33cb6a-9be9-1a2c-efa3-1dc5996897f6@huawei.com>
Date:   Mon, 22 Mar 2021 09:33:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjahvxdYmEgZEOqSSOVdTP-Njqbh6e8=PDVtt4Md7qHNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/3/22 6:23, Linus Torvalds wrote:
> On Sun, Mar 21, 2021 at 11:31 AM Theodore Ts'o <tytso@mit.edu> wrote:
>>
>> zhangyi (F) (3):
>>       ext4: find old entry again if failed to rename whiteout
>>       ext4: do not iput inode under running transaction in ext4_rename()
>>       ext4: do not try to set xattr into ea_inode if value is empty
> 
> Side note: this is obviously entirely up to the author, but I think it
> would be nice if we would encourage people to use their native names
> if/when they want to.
> 
> Maybe this "zhangyi (F)" is how they _want_ to write their name in the
> kernel, and that's obviously fine if so.
> 
> But at the same time, coming from Finland, I remember how people who
> had the "odd" characters (åäö) in their name ended up replacing them
> with the US-ASCII version (generally "aa" "ae" and "oe"), and it
> always just looked bad to a native speaker. Particularly annoying in
> public contexts.
> 
> At the same time, for the same reason, I can also understand people
> not wanting to even expose those characters at all, because then
> non-native speakers invariably messed it up even worse...
> 
> Anyway, I think and hope that we have the infrastructure to do it
> right not just for Latin1, but the more complex non-Western character
> sets too.
> 
> And as a result should possibly encourage people to use their native
> names if they want to. At least make people aware that it _should_
> work.
> 
> Again, maybe I'm barking up the wrong tree, and in this case "zhangyi
> (F) <yi.zhang@huawei.com>" is just what zhangyi prefers simply because
> it's easier/more convenient.
> 
> But I just wanted to mention it, because we _do_ have examples of it
> working. Not many, but some:
> 
>     git log --pretty="%an" --since=2.years | sort -u | tail
> 
> including examples of having the Westernized name in parenthesis for
> the "use that one if you can't do the real one" case..
> 
Hi, Linus.

I will use my real name "Yi Zhang" next time.

Thanks,
Yi.

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853B62BAA04
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 13:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgKTMWZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 07:22:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33894 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgKTMWZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 07:22:25 -0500
Received: from [IPv6:2a01:e35:2fb5:1510:aca8:9792:c024:bc1f] (unknown [IPv6:2a01:e35:2fb5:1510:aca8:9792:c024:bc1f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0220C1F45EFF;
        Fri, 20 Nov 2020 12:22:23 +0000 (GMT)
Subject: Re: [PATCH 00/11] e2fsprogs: improve case-insensitive fs support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
References: <20201105161642.87488-1-arnaud.ferraris@collabora.com>
 <20201106181806.GA79496@sol.localdomain>
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
Autocrypt: addr=arnaud.ferraris@collabora.com; keydata=
 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
 xZQG6fKWuIur3RI=
Message-ID: <253ab9d8-b183-7f87-20c7-371a9fdb2f26@collabora.com>
Date:   Fri, 20 Nov 2020 13:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106181806.GA79496@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Eric,

Le 06/11/2020 à 19:18, Eric Biggers a écrit :
> On Thu, Nov 05, 2020 at 05:16:32PM +0100, Arnaud Ferraris wrote:
>> Hello,
>>
>> This patch series improves e2fsprogs for case-insensitive filesystems.
>>
>> First, it allows tune2fs to enable the 'casefold' feature on existing
>> filesystems.
>>
>> Then, it improves e2fsck by allowing it to:
>> - fix entries containing invalid UTF-8 characters
>> - detect duplicated entries
>>
>> By default, invalid filenames are only checked when strict mode is enabled.
>> A new option is therefore added to allow the user to force this verification.
>>
>> This series has been tested by running xfstests, and by manually corrupting
>> the test filesystem using debugfs as well.
>>
>> Best regards,
>> Arnaud
> 
> Can you Cc "Daniel Rosenberg <drosen@google.com>" on future versions of this?
> I'm not sure whether he's subscribed to linux-ext4.

Thanks for your feedback, I completely missed your email until a
coworker pointed it out to me yesterday, my apologies.

I'll send a v2 and Cc Daniel early next week.

Best regards,
Arnaud

> 
> Thanks!
> 
> - Eric
> 

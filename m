Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0EDB4570
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 04:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391951AbfIQCHP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 22:07:15 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:48057 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfIQCHP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 22:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=Subject:Message-ID:From:CC:To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vVkn2O/9lGVNrbPzlDo6XOPFmZ8O6RHYGV95uzIF1K4=; b=xHErRN1qIc/xI/5awjhwSFsV39
        Jd9w5VmsEBkVcocyN4+byYKC0GvQw6HOLfxqIGFvGkmhMLkHpkK7APEYxO1WvsGH0CUhzKlGGbygr
        RAUxRzG0L+yl27dmbBDl2HOHvXNGY76txjx0WFC6l+aRu4i59Oek1fIlAqQE5MpUQLhE=;
Received: from 199-83-223-235.public.monkeybrains.net ([199.83.223.235] helo=[192.168.1.141])
        by cavan.codon.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mjg59@srcf.ucam.org>)
        id 1iA2tG-000305-SF; Tue, 17 Sep 2019 03:06:53 +0100
Date:   Mon, 16 Sep 2019 18:46:07 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whfPwei+yf9vBgfSuG5HDtiYmt3nOu9Js+vkTYSrMf2ow@mail.gmail.com>
References: <20190916042952.GB23719@1wt.eu> <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com> <20190916061252.GA24002@1wt.eu> <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com> <20190916172117.GB15263@mit.edu> <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org> <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com> <20190916231103.bic65ab4ifv7vhio@srcf.ucam.org> <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com> <20190916232922.GA7880@darwi-home-pc> <CAHk-=wh2PuYtuUVt523j20cTceN+ps8UNJY=uRWQuRaDeDyLQw@mail.gmail.com> <BEF07E89-E36D-480F-AB1E-25C80C9DABE7@srcf.ucam.org> <CAHk-=whfPwei+yf9vBgfSuG5HDtiYmt3nOu9Js+vkTYSrMf2ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
From:   Matthew Garrett <mjg59@srcf.ucam.org>
Message-ID: <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
X-SA-Do-Not-Run: Yes
X-SA-Exim-Connect-IP: 199.83.223.235
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: Linux 5.3-rc8
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); Unknown failure
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 16 September 2019 18:41:36 GMT-07:00, Linus Torvalds <torvalds@linux-fou=
ndation=2Eorg> wrote:
>On Mon, Sep 16, 2019 at 6:24 PM Matthew Garrett <mjg59@srcf=2Eucam=2Eorg>
>wrote:
>>
>> Exactly the scenario where you want getrandom() to block, yes=2E
>
>It *would* block=2E Just not forever=2E

It's already not forever - there's enough running in the background of tha=
t system that it'll unblock eventually=2E=20

>And btw, the whole "generate key at boot when nothing else is going
>on" is already broken, so presumably nobody actually does it=2E

If nothing ever did this, why was getrandom() designed in a way to protect=
 against this situation?=20

>See why I'm saying "hypothetical"? You're doing it again=2E
>
>> >Then you have to ignore the big warning too=2E
>>
>> The big warning that's only printed in dmesg?
>
>Well, the patch actually made getrandom() return en error too, but you
>seem more interested in the hypotheticals than in arguing actualities=2E

If you want to be safe, terminate the process=2E


--=20
Matthew Garrett | mjg59@srcf=2Eucam=2Eorg

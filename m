Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6DB4534
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 03:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbfIQBYj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 21:24:39 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:47858 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfIQBYj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 21:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=Subject:Message-ID:From:CC:To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ydAjbIZ5ouf+5lvzLDorhNfi7gBeYR4RWW6tpcxYwTM=; b=cQWiJlTuJPP3r5asTWR/J0Pwk6
        siSevHbSF2sb8NpnS38Yp5DEkk0eKNUWbHdU7/8oHciTwX/J5hhln2h9jQb+4Req/t83u+i40ClND
        XJyWw8IVIOG1XZhZHfSuCpVt+5pfiBhCDdaYymeD5hmkCjvZ1dKPiQWg311SQAuCiN5c=;
Received: from [2607:fb90:8069:6532:f8b6:19c9:6540:8c34]
        by cavan.codon.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mjg59@srcf.ucam.org>)
        id 1iA2E0-0002eo-Nj; Tue, 17 Sep 2019 02:24:15 +0100
Date:   Mon, 16 Sep 2019 18:23:56 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wh2PuYtuUVt523j20cTceN+ps8UNJY=uRWQuRaDeDyLQw@mail.gmail.com>
References: <20190916042952.GB23719@1wt.eu> <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com> <20190916061252.GA24002@1wt.eu> <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com> <20190916172117.GB15263@mit.edu> <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org> <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com> <20190916231103.bic65ab4ifv7vhio@srcf.ucam.org> <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com> <20190916232922.GA7880@darwi-home-pc> <CAHk-=wh2PuYtuUVt523j20cTceN+ps8UNJY=uRWQuRaDeDyLQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
From:   Matthew Garrett <mjg59@srcf.ucam.org>
Message-ID: <BEF07E89-E36D-480F-AB1E-25C80C9DABE7@srcf.ucam.org>
X-SA-Do-Not-Run: Yes
X-SA-Exim-Connect-IP: 2607:fb90:8069:6532:f8b6:19c9:6540:8c34
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: Linux 5.3-rc8
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); Unknown failure
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 16 September 2019 18:05:57 GMT-07:00, Linus Torvalds <torvalds@linux-fou=
ndation=2Eorg> wrote:
>On Mon, Sep 16, 2019 at 4:29 PM Ahmed S=2E Darwish <darwish=2E07@gmail=2E=
com>
>wrote:
>>
>> Linus, in all honesty, the other case is _not_ a hypothetical =2E
>
>Oh yes it is=2E
>
>You're confusing "use" with "breakage"=2E
>
>The _use_ of getrandom(0) for key generation isn't hypothetical=2E
>
>But the _breakage_ from the suggested patch that makes it time out is=2E
>
>See the difference?
>
>The thing is, to break, you have to
>
> (a) do that key generation at boot time
>
> (b) do it on an idle machine that doesn't have entropy

Exactly the scenario where you want getrandom() to block, yes=2E=20

>in order to basically reproduce the current boot-time hang situation
>with the broken gdm, except with an actual "generate key"=2E
>
>Then you have to ignore the big warning too=2E

The big warning that's only printed in dmesg?=20


--=20
Matthew Garrett | mjg59@srcf=2Eucam=2Eorg

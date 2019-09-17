Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E2B44E3
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 02:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbfIQAey (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 20:34:54 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:47627 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIQAey (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 20:34:54 -0400
X-Greylist: delayed 1828 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 20:34:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=Subject:Message-ID:From:CC:To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l3IKMcFp3pF8Yj9IbZO95fl3sTGVdQA6I+JoxhN1omQ=; b=OddDl5cWFC2aHqjj+QoVHM8VXp
        Ef6xGczkV0PZk0RwJ7ksQGn8r8hf9CkBoEie/n30/9xFrc4qQ97aZZ7qZRI6e3G5NyTQmRTJl+Koj
        znz1kFFLLDAaMJ4N3kyvB8Fa80oAeDk1x3wAqrxGy+2e5wOvkl2ipX5rDKasCPeeV2FI=;
Received: from [2607:fb90:27d6:137c:ca37:9d20:ab62:c332]
        by cavan.codon.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mjg59@srcf.ucam.org>)
        id 1iA0yL-00026n-Al; Tue, 17 Sep 2019 01:03:59 +0100
Date:   Mon, 16 Sep 2019 17:03:42 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com>
References: <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com> <20190916024904.GA22035@mit.edu> <20190916042952.GB23719@1wt.eu> <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com> <20190916061252.GA24002@1wt.eu> <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com> <20190916172117.GB15263@mit.edu> <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org> <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com> <20190916231103.bic65ab4ifv7vhio@srcf.ucam.org> <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
From:   Matthew Garrett <mjg59@srcf.ucam.org>
Message-ID: <ADFD1BDA-E512-42B8-8D03-E5894ACD7951@srcf.ucam.org>
X-SA-Do-Not-Run: Yes
X-SA-Exim-Connect-IP: 2607:fb90:27d6:137c:ca37:9d20:ab62:c332
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: Linux 5.3-rc8
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); Unknown failure
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 16 September 2019 16:18:00 GMT-07:00, Linus Torvalds <torvalds@linux-fou=
ndation=2Eorg> wrote:
>On Mon, Sep 16, 2019 at 4:11 PM Matthew Garrett <mjg59@srcf=2Eucam=2Eorg>
>wrote:
>>
>> In one case we have "Systems don't boot, but you can downgrade your
>> kernel" and in the other case we have "Your cryptographic keys are
>weak
>> and you have no way of knowing unless you read dmesg", and I think
>> causing boot problems is the better outcome here=2E
>
>Or: In one case you have a real and present problem=2E In the other
>case, people are talking hypotheticals=2E

We've been recommending that people use getrandom() for key generation sin=
ce it was first added to the kernel=2E Github suggests there are users in t=
he wild - there's almost certainly more cases where internal code depends o=
n the existing semantics=2E


--=20
Matthew Garrett | mjg59@srcf=2Eucam=2Eorg

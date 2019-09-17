Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0236FB44EB
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 02:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfIQAlA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 20:41:00 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:47668 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIQAlA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 20:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=Subject:Message-ID:From:CC:To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dihqQD7YyeCHFuSd2ZY63lRCa0biQHHFoiX32AJkQOc=; b=KCiJ49BmtRanlAbRnpCcqbvlih
        tTFRLeONi8xeN/BdrtcelDsnfJByQwGor1b9F4xEPrwBsYBp5kRIebGADikf/tnqWf+ehtLQFMOd8
        FKhgyXfZ8K07TpBW4ZqN2QVQPHN6WFt50d5UjDA72AdHoEzACsjK7IQbW07pnNvvisIU=;
Received: from [216.9.110.8] (helo=[172.31.95.26])
        by cavan.codon.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <mjg59@srcf.ucam.org>)
        id 1iA1Xo-0002KW-64; Tue, 17 Sep 2019 01:40:38 +0100
Date:   Mon, 16 Sep 2019 17:40:23 -0700
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
Message-ID: <2BEA80F6-6EF5-42D8-8AAA-91D4FD545241@srcf.ucam.org>
X-cavan-blacklisted-at: zen.spamhaus.org
X-SA-Do-Not-Run: Yes
X-SA-Exim-Connect-IP: 216.9.110.8
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

(resending because accidental HTML, sorry about that)=20

We've been recommending that people use the default getrandom() behaviour =
for key generation since it was merged=2E Github shows users, and it's like=
ly there's cases in internal code as well=2E=20


--=20
Matthew Garrett | mjg59@srcf=2Eucam=2Eorg

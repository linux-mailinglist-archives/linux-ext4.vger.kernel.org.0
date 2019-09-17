Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE9DB4529
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 03:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390580AbfIQBNB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 21:13:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39088 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732800AbfIQBNB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 21:13:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id s19so1710243lji.6
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 18:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lT8XkUtBx2w2E6v7+dJIyb5eDtdCj9FGQxpWjTooN2w=;
        b=X3PnxylOAF4xYIhV73JftJsYPExC+6nWRgaCoIehOZ0lRHM8e0vtC4kIiCZ0RfabNQ
         8bMWtZXCNM/jwB6Es3t2aKnvKb1glk5Zq0J4hLHBdUeNxhEvZaoOd3eWC3odXZrrnc7k
         FwH8vqjVTIT59p8Zc+gKYzRmiJqlQqh9ZX6P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lT8XkUtBx2w2E6v7+dJIyb5eDtdCj9FGQxpWjTooN2w=;
        b=btfBmCVlgaQvaiTAidtGPmHQXToi2D82n1avucgSnyIta8f9X3jPiho5jUCL7BRuF9
         4niLE2KOcn7EIcdWbVxxBCfbID4gAyPa3y6+LX950K0V4g1+wSqAC2Eg5iPwTXQO+6PR
         PpY3rqWcvnNXOtpM4/liYhi169zi5PLApaccHfMBYnl7T5jDQShBH6Mn1YLI80l5yeqJ
         vzxjnLytUclZaExPlOQ+jJaZxVtxd3tc5Nl67Lyynoz/wfoTvahWAq9NB35ayYYOaUlD
         E0a7/KFq9JT2FA1WU35sZxo0mSQmWo+PViGmZLO/rB3Cv6RIBrnuV8G537BnKaIef164
         Y5nA==
X-Gm-Message-State: APjAAAW/UhKeaEe/6dCeMrznHg2UFaMpSERmEdIN3eup3InVjAm+4iBs
        6ibmyKzEfjZziAaafyRGVUcGwKWRQnA=
X-Google-Smtp-Source: APXvYqwJyb5jqMNv1uPzbhYmqdt2dRR8VRkO7mywD78CP1eq2bkjXpWAJvhnHaE/lyG88sBm7N8vwA==
X-Received: by 2002:a2e:8942:: with SMTP id b2mr383470ljk.38.1568682778643;
        Mon, 16 Sep 2019 18:12:58 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id l3sm90656lfc.31.2019.09.16.18.12.58
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 18:12:58 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x80so1460484lff.3
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 18:12:58 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr535207lfm.170.1568682373612;
 Mon, 16 Sep 2019 18:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190916042952.GB23719@1wt.eu> <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu> <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu> <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org> <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
 <20190916231103.bic65ab4ifv7vhio@srcf.ucam.org> <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com>
 <20190916232922.GA7880@darwi-home-pc>
In-Reply-To: <20190916232922.GA7880@darwi-home-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 18:05:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2PuYtuUVt523j20cTceN+ps8UNJY=uRWQuRaDeDyLQw@mail.gmail.com>
Message-ID: <CAHk-=wh2PuYtuUVt523j20cTceN+ps8UNJY=uRWQuRaDeDyLQw@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 4:29 PM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> Linus, in all honesty, the other case is _not_ a hypothetical .

Oh yes it is.

You're confusing "use" with "breakage".

The _use_ of getrandom(0) for key generation isn't hypothetical.

But the _breakage_ from the suggested patch that makes it time out is.

See the difference?

The thing is, to break, you have to

 (a) do that key generation at boot time

 (b) do it on an idle machine that doesn't have entropy

in order to basically reproduce the current boot-time hang situation
with the broken gdm, except with an actual "generate key".

Then you have to ignore the big warning too.

              Linus

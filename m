Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE9ADB3FF6
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389732AbfIPSEo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 14:04:44 -0400
Received: from depni-mx.sinp.msu.ru ([213.131.7.21]:25 "EHLO
        depni-mx.sinp.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfIPSEo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 14:04:44 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 14:04:43 EDT
Received: from spider (unknown [109.63.188.125])
        by depni-mx.sinp.msu.ru (Postfix) with ESMTPSA id 218DA1BF402;
        Mon, 16 Sep 2019 20:55:26 +0300 (MSK)
From:   Serge Belyshev <belyshev@depni.sinp.msu.ru>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
References: <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
        <20190915065142.GA29681@gardel-login>
        <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
        <20190916014050.GA7002@darwi-home-pc>
        <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
        <20190916024904.GA22035@mit.edu> <20190916042952.GB23719@1wt.eu>
        <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
        <20190916061252.GA24002@1wt.eu>
        <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
        <20190916172117.GB15263@mit.edu>
        <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
Date:   Mon, 16 Sep 2019 20:55:15 +0300
In-Reply-To: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 16 Sep 2019 10:44:31 -0700")
Message-ID: <8736gwt9bw.fsf@depni.sinp.msu.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


>  - add new GRND_SECURE and GRND_INSECURE flags that have the actual
> useful behaviors that we currently pretty much lack
>
>  - consider the old 0-3 flag values legacy, deprecated, and unsafe
> because they _will_ time out to fix the existing problem we have right
> now because of their bad behavior.

Just for the record because I did not see it mentioned in this thread,
this patch by Andy Lutomirski, posted two weeks ago, adds GRND_INSECURE
and makes GRND_RANDOM a no-op:

https://lore.kernel.org/lkml/cover.1567126741.git.luto@kernel.org/

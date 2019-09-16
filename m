Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CDFB40CE
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390712AbfIPTJ1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 15:09:27 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:46279 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390662AbfIPTJ1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Sep 2019 15:09:27 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8GJ8xTE025965;
        Mon, 16 Sep 2019 21:08:59 +0200
Date:   Mon, 16 Sep 2019 21:08:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
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
Message-ID: <20190916190858.GD24547@1wt.eu>
References: <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
 <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu>
 <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu>
 <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu>
 <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 10:44:31AM -0700, Linus Torvalds wrote:
>  - add new GRND_SECURE and GRND_INSECURE flags that have the actual
> useful behaviors that we currently pretty much lack
> 
>  - consider the old 0-3 flag values legacy, deprecated, and unsafe
> because they _will_ time out to fix the existing problem we have right
> now because of their bad behavior.

I think we can keep a flag to work like the current /dev/random and
deplete entropy for the very rare cases where it's really desired
to run this way (maybe even just for research), but it should require
special permissions as it impacts the whole system.

I think that your GRND_SECURE above means the current 0 situation,
where we wait for initial entropy then not wait anymore, right ? If
so it could remain the default setting, because at least it will not
betray applications which rely on this reliability. And GRND_INSECURE
will be decided on a case by case basis by applications that are caught
waiting like sfdisk in initramfs or a MAC address generator for example.
In this case it could even be called GRND_PREDICTABLE maybe to enforce
its property compared to others.

My guess is that we can fix the situation because nobody likes the
problems that sporadically hit users. getrandom() was adopted quite
quickly to solve issues related to using /dev/*random in chroots,
I think the new flags will be adopted by those experiencing issues.

Just my two cents,
Willy

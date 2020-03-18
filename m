Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD0189471
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Mar 2020 04:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCRD2T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Mar 2020 23:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgCRD2T (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Mar 2020 23:28:19 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19CF5206F1;
        Wed, 18 Mar 2020 03:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584502099;
        bh=z7EATMUeZDCmomys4XPcW2sRjO8J9h7AXVjgzrbFhhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8KXYQI/JaK7CQteBWQc4c3aNb6C6uQUV+xF7+AX355X/g32witL7ra6Ker6vWwZd
         1hXrqZiqJaMS2ycGmxuHrCX28ZakvDyDJHcdNN/SrtY+1D40nlz2dgbUQAi6cg8/NI
         1BjQ5hL4B3p0cZbBZhqo74N+yaHlOUzQqIVLpz0Y=
Date:   Tue, 17 Mar 2020 20:28:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: is there root_fs.arm32 used by xfstests?
Message-ID: <20200318032817.GA893@sol.localdomain>
References: <CAAJeciW-r=+90gMJvEZ8xFMFwUH+rD1Qf9DRmqatD51vMgHbJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAJeciW-r=+90gMJvEZ8xFMFwUH+rD1Qf9DRmqatD51vMgHbJg@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 18, 2020 at 11:16:32AM +0800, xiaohui li wrote:
> hello ted:
> 
> many thanks for your xfstests-bld project which can be deployed on
> android systems and make mobile phone more robust and stable.
> but as is known, many low-end mobile phone’s cpu still use the arm32
> architecture.
> and if these low-end mobile phone also can make full use of xfstests
> to do fs tests,
> there will be more fs bug will be found and our filesystem will become
> more robust.
> 
> but from below link:
> https://www.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests
> there is not arm32 root_fs.
> 
> so if you or anyone can offer me a link which can download arm32
> root_fs needed by xfstests，
> i appreciate it very much.
> 
> best regards.

Great to hear that you're interested in running xfstests on Android!  Probably
Ted stopped providing an arm32 root_fs because arm64 is much more common now.
It should be pretty straightforward to build an arm32 root_fs.tar yourself,
though; have you checked the documentation in
https://github.com/tytso/xfstests-bld/blob/master/Documentation/building-rootfs.md
?

It should just require:

	sudo ./setup-buildchroot --arch=armhf
	./do-all --chroot=buster-armhf --out-tar

I haven't done it in a while so I can't guarantee it hasn't gone stale, but it's
supposed to work.

- Eric

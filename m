Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D7AE8218
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Oct 2019 08:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfJ2HVA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Oct 2019 03:21:00 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:39672 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728547AbfJ2HUi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 29 Oct 2019 03:20:38 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 558EF2E1492;
        Tue, 29 Oct 2019 10:20:35 +0300 (MSK)
Received: from iva8-b53eb3f76dc7.qloud-c.yandex.net (iva8-b53eb3f76dc7.qloud-c.yandex.net [2a02:6b8:c0c:2ca1:0:640:b53e:b3f7])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id z9I2k0eD4G-KYl0QrA6;
        Tue, 29 Oct 2019 10:20:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572333635; bh=ybO1Y2oq7Ib/EvpNL4QHXvV2p9s8Wjfoqf8YgObcVK8=;
        h=In-Reply-To:Message-ID:Date:References:To:From:Subject:Cc;
        b=1gVT2E7Kb5Wqsk8xqwFHfzj7ey/Sl4tf7LsGReR8lVZTJGvNiRGkSpFZ1P5QfOlfu
         RvJTvz7WRKdqCJVKcQwyLkrIDZPWJSPaOtDl0Ot7x+vSMd4u+m8FLisUobJl6N8inN
         gCis+y8CafSp6pnnkNV/iTjpVANuGMIcwXZx4REs=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by iva8-b53eb3f76dc7.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id NZ48FxkpSN-KYWaqv0C;
        Tue, 29 Oct 2019 10:20:34 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] ext4: deaccount delayed allocations at freeing inode in
 ext4_evict_inode()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Eric Whitney <enwlinux@gmail.com>
References: <157233344808.4027.17162642259754563372.stgit@buzz>
Message-ID: <427b6718-0893-0f0f-f5db-5ad45b949a09@yandex-team.ru>
Date:   Tue, 29 Oct 2019 10:20:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157233344808.4027.17162642259754563372.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 29/10/2019 10.17, Konstantin Khlebnikov wrote:
> If inode->i_blocks is zero then ext4_evict_inode() skips ext4_truncate().
> Delayed allocation extents are freed later in ext4_clear_inode() but this
> happens when quota reference is already dropped. This leads to leak of
> reserved space in quota block, which disappears after umount-mount.
> 
> This seems broken for a long time but worked somehow until recent changes
> in delayed allocation.

FYI, perf cannot correctly parse related perf events without this:

https://lore.kernel.org/lkml/157228145325.7530.4974461761228678289.stgit@buzz/

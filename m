Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271F53B1E42
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jun 2021 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhFWQGf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Jun 2021 12:06:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53128 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWQGe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Jun 2021 12:06:34 -0400
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:f4d2:afff:fe2b:18b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2E0231F43830;
        Wed, 23 Jun 2021 17:04:16 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     kernel@collabora.com, linux-ext4@vger.kernel.org
Subject: Re: Potential regression with iomap DIO for 4k writes
Organization: Collabora
References: <87lf7rkffv.fsf@collabora.com> <87zgvq7jd8.fsf@collabora.com>
        <YMzWE5sJeuIeOv1q@mit.edu>
Date:   Wed, 23 Jun 2021 12:04:12 -0400
In-Reply-To: <YMzWE5sJeuIeOv1q@mit.edu> (Theodore Ts'o's message of "Fri, 18
        Jun 2021 13:21:23 -0400")
Message-ID: <878s30in43.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Tue, Jun 15, 2021 at 08:17:55PM -0400, Gabriel Krisman Bertazi wrote:

> Apologies for the delay in responding; somehow I missed your initial
> e-mail on the subject on June 2nd, although I haven't found it in the
> mailing list archives[1].  I don't know if it got caught in a spam
> trap, or was accidentally deleted from my inbox.
>
> [1] https://lore.kernel.org/linux-ext4/87lf7rkffv.fsf@collabora.com/
>
> I didn't do any bs=4k benchmarks before we landed the DIO iomap
> changes, and it's interesting that it largely goes away with a 16k
> block size[2]
>
> [2] https://people.collabora.com/~krisman/dio/week21/bench.png
>
> Looking at your flame graphs[3][4]
>
> [3] https://people.collabora.com/~krisman/dio/week23/clean_flames/5.4.0-dio_original-dio-ext4-write-4k.svg
> [4] https://people.collabora.com/~krisman/dio/week23/clean_flames/5.5.0-dio_old-iomap-ext4-write-4k.svg
>
> ... nothing immediately jumps out at me.
>
> Have you compared the output of /proc/lock_stat for the two kernels?
> And is there anything obvious in the blktrace of the two kernels?

Hi Ted,

I updated and rerun my test script [1] to collect lock_stat and blktrace.
I particularly don't see anything standing out on lock-stat, but I'm
sharing the raw data [2], in case you have a better insight.

blktrace, on the other hand, shows something interesting.  Looks like
the original DIO is always keeping a lower device queue depth than iomap
[3], although I'd expect the opposite if there is FS contention,
correct?  Iff ext4 is taking longer to submit bios, it would be expected
for the device queue depth to be more empty instead of more full, right?

[1] https://people.collabora.com/~krisman/dio/week24/bench-regression.sh
[2] https://people.collabora.com/~krisman/dio/week24/
[3] (LARGE SVG!) https://people.collabora.com/~krisman/dio/week24/iowatcher-charts.svg

-- 
Gabriel Krisman Bertazi

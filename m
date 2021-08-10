Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04A43E7C29
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Aug 2021 17:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbhHJP3W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 10 Aug 2021 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbhHJP3V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Aug 2021 11:29:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAB9C0613C1
        for <linux-ext4@vger.kernel.org>; Tue, 10 Aug 2021 08:28:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 254121F42D9C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     kernel@collabora.com, linux-ext4@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>
Subject: Re: Potential regression with iomap DIO for 4k writes
Organization: Collabora
References: <87lf7rkffv.fsf@collabora.com> <87zgvq7jd8.fsf@collabora.com>
        <YMzWE5sJeuIeOv1q@mit.edu> <878s30in43.fsf@collabora.com>
Date:   Tue, 10 Aug 2021 11:28:51 -0400
In-Reply-To: <878s30in43.fsf@collabora.com> (Gabriel Krisman Bertazi's message
        of "Wed, 23 Jun 2021 12:04:12 -0400")
Message-ID: <87o8a55nf0.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> "Theodore Ts'o" <tytso@mit.edu> writes:
>
>> On Tue, Jun 15, 2021 at 08:17:55PM -0400, Gabriel Krisman Bertazi wrote:
>
>> Apologies for the delay in responding; somehow I missed your initial
>> e-mail on the subject on June 2nd, although I haven't found it in the
>> mailing list archives[1].  I don't know if it got caught in a spam
>> trap, or was accidentally deleted from my inbox.
>>
>> [1] https://lore.kernel.org/linux-ext4/87lf7rkffv.fsf@collabora.com/
>>
>> I didn't do any bs=4k benchmarks before we landed the DIO iomap
>> changes, and it's interesting that it largely goes away with a 16k
>> block size[2]
>>
>> [2] https://people.collabora.com/~krisman/dio/week21/bench.png
>>
>> Looking at your flame graphs[3][4]
>>
>> [3] https://people.collabora.com/~krisman/dio/week23/clean_flames/5.4.0-dio_original-dio-ext4-write-4k.svg
>> [4] https://people.collabora.com/~krisman/dio/week23/clean_flames/5.5.0-dio_old-iomap-ext4-write-4k.svg
>>
>> ... nothing immediately jumps out at me.
>>
>> Have you compared the output of /proc/lock_stat for the two kernels?
>> And is there anything obvious in the blktrace of the two kernels?
>
> Hi Ted,
>
> I updated and rerun my test script [1] to collect lock_stat and blktrace.
> I particularly don't see anything standing out on lock-stat, but I'm
> sharing the raw data [2], in case you have a better insight.
>
> blktrace, on the other hand, shows something interesting.  Looks like
> the original DIO is always keeping a lower device queue depth than iomap
> [3], although I'd expect the opposite if there is FS contention,
> correct?  Iff ext4 is taking longer to submit bios, it would be expected
> for the device queue depth to be more empty instead of more full,
> right?

Hello,

I continued to explore this issue with different parameters and types
of device under test.  In particular, I attempted to isolate the
parameters where the slowdown is observed.  Is anyone also able to
reproduce the issue I'm reporting here?

* Different queue depths

First of all, I attempted to reproduce it with different queue depths
and the results can be seen in Figure [1].  This shows that, for lower
fio queue depths, 4k write performance is much better in iomap than the
original DIO.  But, as the queue depth increases, the original DIO
performance increases, eventually becoming much better than iomap for
higher queue depths.

The odd thing is that this chart suggests a similar behavior for other
types of IO.  The main difference from my previous tests where I
detected it only on 4k-writes is that this test iteration lacks perf/blktrace
instrumentation during the test run.  I don't know if this explains the
difference from what I reported earlier.  Further tests is needed.

* Different block schedulers

Another thing that I attempted to do is using different block
schedulers, as shown in Figure [2].  This result reiterates the previous
queue depth results for different kinds of IO, but also suggests that IO
schedulers are not playing much of a role here.  Despite a change on the
total IOPS, an offset between original DIO and iomap performance
remains.

* Different type of device

I also experimented with using different types of devices.  For that, I
ran the same Fio benchmark with ramfs and nvme.  The results shown in
Figure [3] suggests I'm only able to observe the problem with nvme.
On ramfs, iomap behavior is constantly better than original DIO.

* Differences between original DIO vs. iomap.

By looking at the flame graphs I observed that some of the completions
were happening in the submission path, even if I was doing async IO.
This seemed to happen, if I understand correctly, because from the time
the last BIO was submitted, the last reference was already dropped by
the BIO completion, so iomap_dio_rw calls iomap_dio_complete
synchronously.  I modified it, and could verify through the flame graphs
it was working correctly and all the completions where happening inside
the s_dio_done_wq workqueue.  Nevertheless, this didn't yield gains in
IOPS for the same benchmark[4].

* next steps

I understand there is some mixed information, in particular regarding
the types of IO where the slowdown is observed.  While I believe this is
related to the instrumentation overhead, I want to further verify that
hypothesis.

I also noticed that the actual device queue depth never goes too
high[5], despite the fio settings.  While I suspect this is specific to
my device, I couldn't confirm it.  I plan to test on more NVMes to see
if the behavior is reproducible elsewhere.  For reference, the NVMe I'm
using is a Samsung 970 EVO NVMe® M.2 SSD.

I'd love to know if this is reproducible by someone else, or if anything
in my analysis is wrong.  I'm not an expert in most of this, so I'm
trying to figure out as I go.

[1] https://people.collabora.com/~krisman/dio/week27/per-depth.png
[2] https://people.collabora.com/~krisman/dio/week27/per-depth-per-sched.png
[3] https://people.collabora.com/~krisman/dio/week27/nvme-vs-ramfs.png
[4] https://people.collabora.com/~krisman/dio/week29/iops.png
[5] https://people.collabora.com/~krisman/dio/week24/iowatcher-charts.svg

Thank you,

-- 
Gabriel Krisman Bertazi

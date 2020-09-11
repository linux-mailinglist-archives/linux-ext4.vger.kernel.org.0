Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261612675FD
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Sep 2020 00:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgIKWh6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Sep 2020 18:37:58 -0400
Received: from rome.phoronix.com ([192.211.48.82]:5584 "EHLO rome.phoronix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgIKWhy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 11 Sep 2020 18:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=michaellarabel.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=26+GlDhv5ms1j5kufCFBo47VQYkoUEVidv1aVrfMaMg=; b=MxrJN03povq82TS7UDONZD7nw5
        IG5RPFwvuqshOrs8ESm4HLww6eN6J6rb8Q7Fmp+jw4r1s0M5eVa+7U5KYMxYpbZp8vtAwsog1M1Tz
        gu+jZ4rVscLz/RJ4NdKiUO0pNBDfAbf61je5l+RQylqeeoBYemKH2ZgfQm31JrwEiuEDB6jXTHRDe
        Oitgfj6gqJ2G73aLzKHvO2Kl9UdhGotUDiPK6x9gR4CkC14kwuNu4kcTZdKp+1rbA9I27bDPOAw5V
        fmIR2yUrqBQXzp5DFYSJZHO9WCcRjBbf3Ikpj19OfBkcKty00RqfHIoExuzXsEywcUYrkor5W2k+d
        6TPsmsmw==;
Received: from c-73-176-63-28.hsd1.in.comcast.net ([73.176.63.28]:55440 helo=[192.168.86.21])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <Michael@MichaelLarabel.com>)
        id 1kGrg0-0001ZF-6k; Fri, 11 Sep 2020 18:37:52 -0400
Subject: Re: Kernel Benchmarking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
 <aa90f272-1186-f9e1-8fdb-eefd332fdae8@MichaelLarabel.com>
 <CAHk-=wh_31_XBNHbdF7EUJceLpEpwRxVF+_1TONzyBUym6Pw4w@mail.gmail.com>
 <e24ef34d-7b1d-dd99-082d-28ca285a79ff@MichaelLarabel.com>
 <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
 <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com>
 <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
 <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com>
 <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
From:   Michael Larabel <Michael@MichaelLarabel.com>
Message-ID: <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
Date:   Fri, 11 Sep 2020 17:37:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rome.phoronix.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - MichaelLarabel.com
X-Get-Message-Sender-Via: rome.phoronix.com: authenticated_id: michael@michaellarabel.com
X-Authenticated-Sender: rome.phoronix.com: michael@michaellarabel.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 9/11/20 5:07 PM, Linus Torvalds wrote:
> On Fri, Sep 11, 2020 at 9:19 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> Ok, it's probably simply that fairness is really bad for performance
>> here in general, and that special case is just that - a special case,
>> not the main issue.
> Ahh. It turns out that I should have looked more at the fault path
> after all. It was higher up in the profile, but I ignored it because I
> found that lock-unlock-lock pattern lower down.
>
> The main contention point is actually filemap_fault(). Your apache
> test accesses the 'test.html' file that is mmap'ed into memory, and
> all the threads hammer on that one single file concurrently and that
> seems to be the main page lock contention.
>
> Which is really sad - the page lock there isn't really all that
> interesting, and the normal "read()" path doesn't even take it. But
> faulting the page in does so because the page will have a long-term
> existence in the page tables, and so there's a worry about racing with
> truncate.
>
> Interesting, but also very annoying.
>
> Anyway, I don't have a solution for it, but thought I'd let you know
> that I'm still looking at this.
>
>                  Linus

I've been running your EXT4 patch on more systems and with some 
additional workloads today. While not the original problem, the patch 
does seem to help a fair amount for the MariaDB database sever. This 
wasn't one of the workloads regressing on 5.9 but at least with the 
systems tried so far the patch does make a meaningful improvement to the 
performance. I haven't run into any apparent issues with that patch so 
continuing to try it out on more systems and other database/server 
workloads.

Michael


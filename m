Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7609B2B8E
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbfINOIz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 10:08:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44292 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388939AbfINOIz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 10:08:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id m13so1757266ljj.11;
        Sat, 14 Sep 2019 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yt8tyuKYQY2p30VFOoYIxzYZZsS+APIhfZ7Pw/WaFog=;
        b=ZcfjrRr42cXRtUq267U5CF66b4QHgya/z1P4PKKl4s7j/10NNgLbu7Z2P4y24EEIHm
         1XhF/YK0Yqqbuz5eEECm26K1swGzOFtZM7ZVkDqmCqVVkwqeZzSPSfs8JnAoy4QeJxJ/
         ZIrpMLvBN4HfHLLH5T43PPY8U+EIu9+wTo4UFNLzBRI4tx1L+klB30AB05hPLDHd1bFk
         2vx1YIgM2jR5ZU+yVVrchyg2ZpHq0oFDn3elGr+pXY1T9MUOuuTVSp8kD4GfUQB1pSXu
         qmPiDuz/rmTfNDzXF0i0qvsWEnTxUZUClNEGFIpp3/an3N3PoII0gjmXM2gHYXWHrreb
         Fv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yt8tyuKYQY2p30VFOoYIxzYZZsS+APIhfZ7Pw/WaFog=;
        b=I91qDPGIjT9ybshhzR2f+09gTpc039G6LJXVcxEmhm1yhWke8iCRKJAivyvCkRbQoc
         tMdp95JcnsDGra+Kpkn8oGnJejmQNAws0LXa6eFc86CT6WGZEsnnPAnqFlDViBJ5u/Dd
         c0ib1qrQRsyWONRb6a4j5raQ5KxlkhGjVdzpppDAiF/Z7Uz0aSIU3xZQENN0uo9ceIcj
         jOPtVuztnE5c6Yk/eidg7LXGeI05m3DdxVOEerYT7/jeG1nnGcMy6j0srSCx92LYMShG
         h5DGjX5+ZLu7ktbIlctVf3HylHVJqLLDRrDXl62y0urQhcxREjzvYWc3iDLoQN2PhiPf
         xn9Q==
X-Gm-Message-State: APjAAAWobVmbtcPrUfV+9YVfDvvCP0pl2eto3gnQUUi4tUvjRha5CGwx
        7rQ/txw0ZRJJBJJHrUkzZlZnXO7j87cOWw==
X-Google-Smtp-Source: APXvYqwqUqRmYDb8Xv8lJIn10kAQJkNO+DedmuoA1SwZ5NN0ZEySoKFDiOZRbhtk0kE1vAdTD9pzRQ==
X-Received: by 2002:a2e:7606:: with SMTP id r6mr32606413ljc.41.1568470131521;
        Sat, 14 Sep 2019 07:08:51 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700::a11? ([2a02:17d0:4a6:5700::a11])
        by smtp.googlemail.com with ESMTPSA id r16sm7558959lfi.77.2019.09.14.07.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 07:08:50 -0700 (PDT)
Subject: Re: [PATCH RFC] random: getrandom(2): don't block on non-initialized
 entropy pool
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
Date:   Sat, 14 Sep 2019 19:08:13 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190914122500.GA1425@darwi-home-pc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

(resending without HTML this time, sorry for the duplicate)
14.09.2019 17:25, Ahmed S. Darwish пишет:
> getrandom() has been created as a new and more secure interface for
> pseudorandom data requests.  Unlike /dev/urandom, it unconditionally
> blocks until the entropy pool has been properly initialized.
> 
> While getrandom() has no guaranteed upper bound for its waiting time,
> user-space has been abusing it by issuing the syscall, from shared
> libraries no less, during the main system boot sequence.
> 
> Thus, on certain setups where there is no hwrng (embedded), or the
> hwrng is not trusted by some users (intel RDRAND), or sometimes it's
> just broken (amd RDRAND), the system boot can be *reliably* blocked.
> 
> The issue is further exaggerated by recent file-system optimizations,
> e.g. b03755ad6f33 (ext4: make __ext4_get_inode_loc plug), which
> merges directory lookup code inode table IO, and thus minimizes the
> number of disk interrupts and entropy during boot. After that commit,
> a blocked boot can be reliably reproduced on a Thinkpad E480 laptop
> with standard ArchLinux user-space.
> 
> Thus, don't trust user-space on calling getrandom() from the right
> context. Just never block, and return -EINVAL if entropy is not yet
> available.
> 
> Link: https://lkml.kernel.org/r/CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com
> Link: https://lkml.kernel.org/r/20190912034421.GA2085@darwi-home-pc
> Link: https://lkml.kernel.org/r/20190911173624.GI2740@mit.edu
> Link: https://lkml.kernel.org/r/20180514003034.GI14763@thunk.org

Let me reword the commit message for a hopefully better historical 
perspective.

===
getrandom() has been created as a new and more secure interface for 
pseudorandom data requests. It attempted to solve two problems, as 
compared to /dev/{u,}random: the need to open a file descriptor (which 
can fail) and possibility to get not-so-random data from the 
incompletely initialized entropy pool. It has succeeded in the first 
improvement, but failed horribly in the second one: it blocks until the 
entropy pool has been properly initialized, if called without 
GRND_NONBLOCK, while none of these behaviors are suitable for the early 
boot stage.

The issue is further exaggerated by recent file-system optimizations, 
e.g. b03755ad6f33 (ext4: make __ext4_get_inode_loc plug), which merges 
directory lookup code inode table IO, and thus minimizes the number of 
disk interrupts and entropy during boot. After that commit, a blocked 
boot can be reliably reproduced on a Thinkpad E480 laptop with standard 
ArchLinux user-space.

Thus, on certain setups where there is no hwrng (embedded systems or 
non-KVM virtual machines), or the hwrng is not trusted by some users 
(intel RDRAND), or sometimes it's just broken (amd RDRAND), the system 
boot can be *reliably* blocked. It can be therefore argued that there is 
no way to use getrandom() on Linux correctly, especially from shared 
libraries: GRND_NONBLOCK has to be used, and a fallback to some other 
interface like /dev/urandom is required, thus making the net result no 
better than just using /dev/urandom unconditionally.

While getrandom() has no guaranteed upper bound for its waiting time, 
user-space has been using it incorrectly by issuing the syscall, from 
shared libraries no less, during the main system boot sequence, without 
GRND_NONBLOCK.

We can't trust user-space on calling getrandom() from the right context. 
Therefore, just never block, and return -EINVAL (with some entropy still 
in the buffer) if the requested amount of entropy is not yet available.

Link: 
https://github.com/openbsd/src/commit/edb2eeb7da8494998d0073f8aaeb8478cee5e00b
Link: 
https://lkml.kernel.org/r/CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com
Link: https://lkml.kernel.org/r/20190912034421.GA2085@darwi-home-pc
Link: https://lkml.kernel.org/r/20190911173624.GI2740@mit.edu
Link: https://lkml.kernel.org/r/20180514003034.GI14763@thunk.org
===

That said, I have an issue with the -EINVAL return code here: it is also 
returned in cases where the parameters passed are genuinely not 
understood by the kernel, and no entropy has been written to the buffer. 
Therefore, the caller has to assume that the call has failed, waste all 
the bytes in the buffer, and try some fallback strategy. Can we think of 
some other error code?

The other part of me thinks that triggering a fallback, by returning an 
error code, is never the right thing to do. If the "uninitialized" state 
exists at all, applications and libraries have to care (and I would 
expect their authors who don't pass GRND_RANDOM to just fall back to 
/dev/urandom). Therefore, we are back to square one, except that the 
fallback code in the application is something that is only rarely 
exercised, and thus has higher chances to accumulate bugs. Because the 
only expected/reasonable fallback is to read from /dev/urandom, the 
whole result looks like shifting the responsibility/blame without 
achieving anything useful. As the issue is not really solvable, just 
give the application not-so-random data, as /dev/urandom does, without 
any indication - this would at least keep the benefit of not needing a 
file descriptor. It is simply not possible to do anything better without 
eliminating the userspace-visible "uninitialized" crng state, e.g. with 
the help of entropy input from the boot loader or a configurable config 
or command line option to trust the jitter entropy in-kernel.

> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> ---
> 
> Notes:
>      This feels very risky at the very end of -rc8, so only sending
>      this as an RFC. The system of course reliably boots with this,
>      and the log, as expected, powerfully warns all callers:
> 
>      $ dmesg | grep random
>      [0.236472] random: get_random_bytes called from start_kernel+0x30f/0x4d7 with crng_init=0
>      [0.680263] random: fast init done
>      [2.500346] random: lvm: uninitialized urandom read (4 bytes read)
>      [2.595125] random: systemd-random-: invalid getrandom request (512 bytes): crng not ready
>      [2.595126] random: systemd-random-: uninitialized urandom read (512 bytes read)
>      [3.427699] random: dbus-daemon: uninitialized urandom read (12 bytes read)
>      [3.979425] urandom_read: 1 callbacks suppressed
>      [3.979426] random: polkitd: uninitialized urandom read (8 bytes read)
>      [3.979726] random: polkitd: uninitialized urandom read (8 bytes read)
>      [3.979752] random: polkitd: uninitialized urandom read (8 bytes read)
>      [4.473398] random: gnome-session-b: invalid getrandom request (16 bytes): crng not ready
>      [4.473404] random: gnome-session-b: invalid getrandom request (16 bytes): crng not ready
>      [4.473409] random: gnome-session-b: invalid getrandom request (16 bytes): crng not ready
>      [5.265636] random: crng init done
>      [5.265649] random: 3 urandom warning(s) missed due to ratelimiting
>      [5.265652] random: 1 getrandom warning(s) missed due to ratelimiting
> 
>   drivers/char/random.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 4a50ee2c230d..309dc5ddf370 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -511,6 +511,8 @@ static struct ratelimit_state unseeded_warning =
>   	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
>   static struct ratelimit_state urandom_warning =
>   	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
> +static struct ratelimit_state getrandom_warning =
> +	RATELIMIT_STATE_INIT("warn_getrandom_notavail", HZ, 3);
> 
>   static int ratelimit_disable __read_mostly;
> 
> @@ -1053,6 +1055,12 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
>   				  urandom_warning.missed);
>   			urandom_warning.missed = 0;
>   		}
> +		if (getrandom_warning.missed) {
> +			pr_notice("random: %d getrandom warning(s) missed "
> +				  "due to ratelimiting\n",
> +				  getrandom_warning.missed);
> +			getrandom_warning.missed = 0;
> +		}
>   	}
>   }
> 
> @@ -1915,6 +1923,7 @@ int __init rand_initialize(void)
>   	crng_global_init_time = jiffies;
>   	if (ratelimit_disable) {
>   		urandom_warning.interval = 0;
> +		getrandom_warning.interval = 0;
>   		unseeded_warning.interval = 0;
>   	}
>   	return 0;
> @@ -2138,8 +2147,6 @@ const struct file_operations urandom_fops = {
>   SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
>   		unsigned int, flags)
>   {
> -	int ret;
> -
>   	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM))
>   		return -EINVAL;
> 
> @@ -2152,9 +2159,13 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
>   	if (!crng_ready()) {
>   		if (flags & GRND_NONBLOCK)
>   			return -EAGAIN;
> -		ret = wait_for_random_bytes();
> -		if (unlikely(ret))
> -			return ret;
> +
> +		if (__ratelimit(&getrandom_warning))
> +			pr_notice("random: %s: invalid getrandom request "
> +				  "(%zd bytes): crng not ready",
> +				  current->comm, count);
> +
> +		return -EINVAL;
>   	}
>   	return urandom_read(NULL, buf, count, NULL);
>   }
> --
> 2.23.0
> 


-- 
Alexander E. Patrakov

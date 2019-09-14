Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F7B2B29
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 14:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfINMZM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 08:25:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33800 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbfINMZM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 08:25:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so3731674wmc.1;
        Sat, 14 Sep 2019 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmVqgGwWD104zixL+b9UTNpYfn08VL/GzWBh1q3vkxU=;
        b=njD6j8MRfJCvOD8IaYmxhuhYhto9Z+pjBKA7d8UWEvA06OU8fyOqParzbf1upS6spw
         7CybUU6ytIeUPQEr0ybHLEuBrcskXJPgSJftTb0BYHVfFbzQtspoDp4H5/dFY4aLRT5g
         OYCBfnHFKsLIePeNLuFJ4k9LWFzwpNA8gYDiJAqBB2bVgWT70kOKXfVVya1pQ6sbt4pk
         UNCKj9ZSee0YPYdOptCPZ/vd4/liJ+numH6pYd47sZCby7/6FPz6JEC1ffuN4ZuS47+m
         NnDLiy9Cfd3y8fT2UayhVA/+aFtw225YSEyvyWemWHNjicMiqdm687JgYXbvobPI9qWo
         fJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmVqgGwWD104zixL+b9UTNpYfn08VL/GzWBh1q3vkxU=;
        b=phxpvS9JxkjfShOaqJiS1e1f23Dw96pK/P/oBhVqUmultfb+5oNKdd4fWmTyVWEO+k
         vQFFlsj+IeQRyozBAK9OSVgEpdxgy+fFqTT2hUjY8ISsgTipfk0M2DAeojP8mnd7EEZ/
         2n1sLnt4KVq9g2QwP7833aKxAQDHsU/8bdPTLnkgNHYYrIQFZ9vLlGgFTNyxfpVBVHB/
         7eZyqfYRtH30vwe6QRDOw8cvvRs0kli/sKsHRDgTVqzQ2S7VD4c9AJ8v9PFZbDGO9jV5
         VEyPa/ZUPRyViyILzIngw9aaV4fGGZd0hTP1MuI9DEJwV69f96HDlkyTpGA+u9hAZUb7
         8Syw==
X-Gm-Message-State: APjAAAXPLFiJ0z/WRDHU4lurT34/EbmVhI5xRXz4hzxjoJ7SbfqVD34c
        1IlaOJggYqNKdTUZE+hmTpE=
X-Google-Smtp-Source: APXvYqyaua4dfsp8t2MuvGLJ5trj0tBgTGML6kk+L1HU+962XTdkyK/kCB25ncqNPN3wn4MyVisGPg==
X-Received: by 2002:a1c:cbcc:: with SMTP id b195mr7686638wmg.80.1568463909367;
        Sat, 14 Sep 2019 05:25:09 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D1401AF0812D8DEE03BEC.dip0.t-ipconnect.de. [2003:d0:6f2d:1401:af08:12d8:dee0:3bec])
        by smtp.gmail.com with ESMTPSA id a205sm11775370wmd.44.2019.09.14.05.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 05:25:08 -0700 (PDT)
Date:   Sat, 14 Sep 2019 14:25:00 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] random: getrandom(2): don't block on non-initialized
 entropy pool
Message-ID: <20190914122500.GA1425@darwi-home-pc>
References: <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

getrandom() has been created as a new and more secure interface for
pseudorandom data requests.  Unlike /dev/urandom, it unconditionally
blocks until the entropy pool has been properly initialized.

While getrandom() has no guaranteed upper bound for its waiting time,
user-space has been abusing it by issuing the syscall, from shared
libraries no less, during the main system boot sequence.

Thus, on certain setups where there is no hwrng (embedded), or the
hwrng is not trusted by some users (intel RDRAND), or sometimes it's
just broken (amd RDRAND), the system boot can be *reliably* blocked.

The issue is further exaggerated by recent file-system optimizations,
e.g. b03755ad6f33 (ext4: make __ext4_get_inode_loc plug), which
merges directory lookup code inode table IO, and thus minimizes the
number of disk interrupts and entropy during boot. After that commit,
a blocked boot can be reliably reproduced on a Thinkpad E480 laptop
with standard ArchLinux user-space.

Thus, don't trust user-space on calling getrandom() from the right
context. Just never block, and return -EINVAL if entropy is not yet
available.

Link: https://lkml.kernel.org/r/CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com
Link: https://lkml.kernel.org/r/20190912034421.GA2085@darwi-home-pc
Link: https://lkml.kernel.org/r/20190911173624.GI2740@mit.edu
Link: https://lkml.kernel.org/r/20180514003034.GI14763@thunk.org

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---

Notes:
    This feels very risky at the very end of -rc8, so only sending
    this as an RFC. The system of course reliably boots with this,
    and the log, as expected, powerfully warns all callers:

    $ dmesg | grep random
    [0.236472] random: get_random_bytes called from start_kernel+0x30f/0x4d7 with crng_init=0
    [0.680263] random: fast init done
    [2.500346] random: lvm: uninitialized urandom read (4 bytes read)
    [2.595125] random: systemd-random-: invalid getrandom request (512 bytes): crng not ready
    [2.595126] random: systemd-random-: uninitialized urandom read (512 bytes read)
    [3.427699] random: dbus-daemon: uninitialized urandom read (12 bytes read)
    [3.979425] urandom_read: 1 callbacks suppressed
    [3.979426] random: polkitd: uninitialized urandom read (8 bytes read)
    [3.979726] random: polkitd: uninitialized urandom read (8 bytes read)
    [3.979752] random: polkitd: uninitialized urandom read (8 bytes read)
    [4.473398] random: gnome-session-b: invalid getrandom request (16 bytes): crng not ready
    [4.473404] random: gnome-session-b: invalid getrandom request (16 bytes): crng not ready
    [4.473409] random: gnome-session-b: invalid getrandom request (16 bytes): crng not ready
    [5.265636] random: crng init done
    [5.265649] random: 3 urandom warning(s) missed due to ratelimiting
    [5.265652] random: 1 getrandom warning(s) missed due to ratelimiting

 drivers/char/random.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4a50ee2c230d..309dc5ddf370 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -511,6 +511,8 @@ static struct ratelimit_state unseeded_warning =
 	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
 static struct ratelimit_state urandom_warning =
 	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
+static struct ratelimit_state getrandom_warning =
+	RATELIMIT_STATE_INIT("warn_getrandom_notavail", HZ, 3);

 static int ratelimit_disable __read_mostly;

@@ -1053,6 +1055,12 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 				  urandom_warning.missed);
 			urandom_warning.missed = 0;
 		}
+		if (getrandom_warning.missed) {
+			pr_notice("random: %d getrandom warning(s) missed "
+				  "due to ratelimiting\n",
+				  getrandom_warning.missed);
+			getrandom_warning.missed = 0;
+		}
 	}
 }

@@ -1915,6 +1923,7 @@ int __init rand_initialize(void)
 	crng_global_init_time = jiffies;
 	if (ratelimit_disable) {
 		urandom_warning.interval = 0;
+		getrandom_warning.interval = 0;
 		unseeded_warning.interval = 0;
 	}
 	return 0;
@@ -2138,8 +2147,6 @@ const struct file_operations urandom_fops = {
 SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 		unsigned int, flags)
 {
-	int ret;
-
 	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM))
 		return -EINVAL;

@@ -2152,9 +2159,13 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 	if (!crng_ready()) {
 		if (flags & GRND_NONBLOCK)
 			return -EAGAIN;
-		ret = wait_for_random_bytes();
-		if (unlikely(ret))
-			return ret;
+
+		if (__ratelimit(&getrandom_warning))
+			pr_notice("random: %s: invalid getrandom request "
+				  "(%zd bytes): crng not ready",
+				  current->comm, count);
+
+		return -EINVAL;
 	}
 	return urandom_read(NULL, buf, count, NULL);
 }
--
2.23.0

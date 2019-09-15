Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC60B2F2B
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 10:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfIOIR5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 04:17:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36989 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOIR5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 04:17:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id r195so6856457wme.2;
        Sun, 15 Sep 2019 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kBymuQZwIi7Gt8cus30MN06HsVUiwcZDk2q8kzGa3qs=;
        b=d4hASCZDucjkZXVueuUub7VJ+Bqlk1eoXnkmLQ+FI6b50EAI32VnCUNqx5D7E3Nwy1
         GvVDpgYPuSoRH4iP0pSSk0500J811V7AQ9/PYkaTO65Daz1+qtDNplS9lq1cmFUQup3P
         E3ly20nKsbV+oRAO0CP+7i9DEebvXSm45SkpyZodVtcC403zoYNCjPeZxVKGr/WbQP1v
         AztIDW0QzdGsTzWCj88xDf6vEmgD/uEy+876vh7JOKkL95C0N2CBfbBwsZnd3J8CTer2
         DoRjO43IMWC5cTPGtS9O83kkPMI5vBcWwh994eP8gYM7oQMtKoF9Rrg2pUXV/l3uq6PW
         VbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kBymuQZwIi7Gt8cus30MN06HsVUiwcZDk2q8kzGa3qs=;
        b=Y7z9SXCMpO8yeKBpi0nxJMc3Up/ajNAMeP2OqujKahCwk2JLztE9frz38JLbY5kypQ
         8warZQfRTDFcddDmoXnQvge33UhaeKmPraeYM7iqWctDr2a7ZDVBkBl4eiUxP6gstrGO
         14l5beMi4trOTs0imbqoiOIi4McgXRo0Vfk+XgUXGKB4Ez0k11IPlgt5ckGzxIrRePVA
         uskCNiPqaDEMpZFeE3WJjD/NVjrFJvHxEVjJA0Hlq9xSKzudwkwGFNB5GZjk9xawshRU
         dj5L2UkXmZSO/eljmAIBnDFg2X2TPY32ORh6oQSn0V2QWmEV93re7QjxuR0ZmvlEaHRF
         NnUw==
X-Gm-Message-State: APjAAAXouuIqQOxPsDm9OjVyMewtZdq0rpjO0OlUiqoWLIrkNArcraY7
        T2Xj6Py12q+gSknPs8QgFIc=
X-Google-Smtp-Source: APXvYqyl7qvRExRAJaO/zJz0oRxefFn4deMLiGrhwxr42bS6c7j6f3nlcPcHWpgrnYyuJDeUXXeueg==
X-Received: by 2002:a1c:9a4a:: with SMTP id c71mr9076339wme.99.1568535473519;
        Sun, 15 Sep 2019 01:17:53 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D1401AF0812D8DEE03BEC.dip0.t-ipconnect.de. [2003:d0:6f2d:1401:af08:12d8:dee0:3bec])
        by smtp.gmail.com with ESMTPSA id 33sm42675006wra.41.2019.09.15.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 01:17:52 -0700 (PDT)
Date:   Sun, 15 Sep 2019 10:17:47 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Lennart Poettering <lennart@poettering.net>,
        Willy Tarreau <w@1wt.eu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v3] random: getrandom(2): optionally block when CRNG is
 uninitialized
Message-ID: <20190915081747.GA1058@darwi-home-pc>
References: <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915052242.GG19710@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since Linux v3.17, getrandom() has been created as a new and more
secure interface for pseudorandom data requests. It attempted to solve
three problems as compared to /dev/urandom:

  1. the need to access filesystem paths, which can fail, e.g. under a
     chroot

  2. the need to open a file descriptor, which can fail under file
     descriptor exhaustion attacks

  3. the possibility to get not-so-random data from /dev/urandom, due to
     an incompletely initialized kernel entropy pool

To solve the third problem, getrandom(2) was made to block until a
proper amount of entropy has been accumulated. This basically made the
system call have no guaranteed upper-bound for its waiting time.

As was said in c6e9d6f38894 (random: introduce getrandom(2) system
call): "Any userspace program which uses this new functionality must
take care to assure that if it is used during the boot process, that it
will not cause the init scripts or other portions of the system startup
to hang indefinitely."

Meanwhile, user-facing Linux documentation, e.g. the urandom(4) and
getrandom(2) manpages, didn't add such explicit warnings. It didn't
also help that glibc, since v2.25, implemented an "OpenBSD-like"
getentropy(3) in terms of getrandom(2).  OpenBSD getentropy(2) never
blocked though, while linux-glibc version did, possibly indefinitely.
Since that glibc change, even more applications at the boot-path began
to implicitly reques randomness through getrandom(2); e.g., for an
Xorg/Xwayland MIT cookie.

OpenBSD genentropy(2) never blocked because, as stated in its rnd(4)
manpages, it saves entropy to disk on shutdown and restores it on boot.
Moreover, the NetBSD bootloader, as shown in its boot(8), even have
special commands to load a random seed file and pass it to the kernel.
Meanwhile on a Linux systemd userland, systemd-random-seed(8) preserved
a random seed across reboots at /var/lib/systemd/random-seed, but it
never had the actual code, until very recently at v243, to ask the
kernel to credit such entropy through an RNDADDENTROPY ioctl.

From a mix of the above factors, it began to be common for Embedded
Linux systems to "get stuck at boot" unless a daemon like haveged is
installed, or the BSP provider enabling the necessary hwrng driver in
question and crediting its entropy; e.g. 62f95ae805fa (hwrng: omap - Set
default quality). Over time, the issue began to even creep into
consumer-level x86 laptops: mainstream distributions, like debian
buster, began to recommend installing haveged as a workaround.

Thus, on certain setups where there is no hwrng (embedded systems or VMs
on a host lacking virtio-rng), or the hwrng is not trusted by some users
(intel RDRAND), or sometimes it's just broken (amd RDRAND), the system
boot can be *reliably* blocked.

It can therefore be argued that there is no way to use getrandom() on
Linux correctly, especially from shared libraries: GRND_NONBLOCK has
to be used, and a fallback to some other interface like /dev/urandom
is required, thus making the net result no better than just using
/dev/urandom unconditionally.

The issue is further exaggerated by recent file-system optimizations,
e.g. b03755ad6f33 (ext4: make __ext4_get_inode_loc plug), which merges
directory lookup code inode table IO, and thus minimizes the number of
disk interrupts and entropy during boot. After that commit, a blocked
boot can be reliably reproduced on a Thinkpad E480 laptop with
standard ArchLinux user-space.

Thus, don't trust user-space on calling getrandom(2) from the right
context. Never block, by default, and just return data from the
urandom source if entropy is not yet available. This is an explicit
decision not to let user-space work around this through busy loops on
error-codes.

Note: this lowers the quality of random data returned by getrandom(2)
to the level of randomness returned by /dev/urandom, with all the
original security implications coming out of that, as discussed in
problem "3." at the top of this commit log. If this is not desirable,
offer users a fallback to old behavior, by CONFIG_RANDOM_BLOCK=y, or
random.getrandom_block=true bootparam.

[tytso@mit.edu: make the change to a non-blocking getrandom(2) optional]
Link: https://lkml.kernel.org/r/20190914222432.GC19710@mit.edu
Link: https://lkml.kernel.org/r/20190911173624.GI2740@mit.edu
Link: https://factorable.net ("Widespread Weak Keys in Network Devices")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com
Rreported-by: Ahmed S. Darwish <darwish.07@gmail.com>
Link: https://lkml.kernel.org/r/20190912034421.GA2085@darwi-home-pc
Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---

Notes:
    changelog-v2:
      - tytso: make blocking optional
    
    changelog-v3:
      - more detailed commit log + historical context (thanks patrakov)
      - remove WARN_ON_ONCE. It's pretty excessive, and the first caller
        is systemd-random-seed(8), which we know it will not change.
        Just print errors in the kernel log.
    
    $dmesg | grep random:
    
      [0.235843] random: get_random_bytes called from start_kernel+0x30f/0x4d7 with crng_init=0
      [0.685682] random: fast init done
      [2.405263] random: lvm: CRNG uninitialized (4 bytes read)
      [2.480686] random: systemd-random-: getrandom (512 bytes): CRNG not yet initialized
      [2.480687] random: systemd-random-: CRNG uninitialized (512 bytes read)
      [3.265201] random: dbus-daemon: CRNG uninitialized (12 bytes read)
      [3.835066] urandom_read: 1 callbacks suppressed
      [3.835068] random: polkitd: CRNG uninitialized (8 bytes read)
      [3.835509] random: polkitd: CRNG uninitialized (8 bytes read)
      [3.835577] random: polkitd: CRNG uninitialized (8 bytes read)
      [4.190653] random: gnome-session-b: getrandom (16 bytes): CRNG not yet initialized
      [4.190658] random: gnome-session-b: getrandom (16 bytes): CRNG not yet initialized
      [4.190662] random: gnome-session-b: getrandom (16 bytes): CRNG not yet initialized
      [4.952299] random: crng init done
      [4.952311] random: 3 urandom warning(s) missed due to ratelimiting
      [4.952314] random: 1 getrandom warning(s) missed due to ratelimiting

 drivers/char/Kconfig  | 33 +++++++++++++++++++++++++++++++--
 drivers/char/random.c | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 3e866885a405..337baeca5ebc 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -557,8 +557,6 @@ config ADI
 	  and SSM (Silicon Secured Memory).  Intended consumers of this
 	  driver include crash and makedumpfile.
 
-endmenu
-
 config RANDOM_TRUST_CPU
 	bool "Trust the CPU manufacturer to initialize Linux's CRNG"
 	depends on X86 || S390 || PPC
@@ -573,3 +571,34 @@ config RANDOM_TRUST_CPU
 	has not installed a hidden back door to compromise the CPU's
 	random number generation facilities. This can also be configured
 	at boot with "random.trust_cpu=on/off".
+
+config RANDOM_BLOCK
+	bool "Block if getrandom is called before CRNG is initialized"
+	help
+	  Say Y here if you want userspace programs which call
+	  getrandom(2) before the Cryptographic Random Number
+	  Generator (CRNG) is initialized to block until
+	  secure random numbers are available.
+
+	  Say N if you believe usability is more important than
+	  security, so if getrandom(2) is called before the CRNG is
+	  initialized, it should not block, but instead return "best
+	  effort" randomness which might not be very secure or random
+	  at all; but at least the system boot will not be delayed by
+	  minutes or hours.
+
+	  This can also be controlled at boot with
+	  "random.getrandom_block=on/off".
+
+	  Ideally, systems would be configured with hardware random
+	  number generators, and/or configured to trust CPU-provided
+	  RNG's.  In addition, userspace should generate cryptographic
+	  keys only as late as possible, when they are needed, instead
+	  of during early boot.  (For non-cryptographic use cases,
+	  such as dictionary seeds or MIT Magic Cookies, other
+	  mechanisms such as /dev/urandom or random(3) may be more
+	  appropropriate.)  This config option controls what the
+	  kernel should do as a fallback when the non-ideal case
+	  presents itself.
+
+endmenu
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4a50ee2c230d..689fdb486785 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -511,6 +511,8 @@ static struct ratelimit_state unseeded_warning =
 	RATELIMIT_STATE_INIT("warn_unseeded_randomness", HZ, 3);
 static struct ratelimit_state urandom_warning =
 	RATELIMIT_STATE_INIT("warn_urandom_randomness", HZ, 3);
+static struct ratelimit_state getrandom_warning =
+	RATELIMIT_STATE_INIT("warn_getrandom_randomness", HZ, 3);
 
 static int ratelimit_disable __read_mostly;
 
@@ -854,12 +856,19 @@ static void invalidate_batched_entropy(void);
 static void numa_crng_init(void);
 
 static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
+static bool getrandom_block __ro_after_init = IS_ENABLED(CONFIG_RANDOM_BLOCK);
 static int __init parse_trust_cpu(char *arg)
 {
 	return kstrtobool(arg, &trust_cpu);
 }
 early_param("random.trust_cpu", parse_trust_cpu);
 
+static int __init parse_block(char *arg)
+{
+	return kstrtobool(arg, &getrandom_block);
+}
+early_param("random.getrandom_block", parse_block);
+
 static void crng_initialize(struct crng_state *crng)
 {
 	int		i;
@@ -1053,6 +1062,12 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
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
 
@@ -1915,6 +1930,7 @@ int __init rand_initialize(void)
 	crng_global_init_time = jiffies;
 	if (ratelimit_disable) {
 		urandom_warning.interval = 0;
+		getrandom_warning.interval = 0;
 		unseeded_warning.interval = 0;
 	}
 	return 0;
@@ -1984,8 +2000,8 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	if (!crng_ready() && maxwarn > 0) {
 		maxwarn--;
 		if (__ratelimit(&urandom_warning))
-			printk(KERN_NOTICE "random: %s: uninitialized "
-			       "urandom read (%zd bytes read)\n",
+			pr_err("random: %s: CRNG uninitialized "
+			       "(%zd bytes read)\n",
 			       current->comm, nbytes);
 		spin_lock_irqsave(&primary_crng.lock, flags);
 		crng_init_cnt = 0;
@@ -2152,9 +2168,16 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 	if (!crng_ready()) {
 		if (flags & GRND_NONBLOCK)
 			return -EAGAIN;
-		ret = wait_for_random_bytes();
-		if (unlikely(ret))
-			return ret;
+
+		if (__ratelimit(&getrandom_warning))
+			pr_err("random: %s: getrandom (%zd bytes): CRNG not "
+			       "yet initialized", current->comm, count);
+
+		if (getrandom_block) {
+			ret = wait_for_random_bytes();
+			if (unlikely(ret))
+				return ret;
+		}
 	}
 	return urandom_read(NULL, buf, count, NULL);
 }
-- 
darwi
http://darwish.chasingpointers.com

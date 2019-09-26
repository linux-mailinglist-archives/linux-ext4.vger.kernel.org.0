Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C50BFAB2
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2019 22:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfIZUoj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Sep 2019 16:44:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40960 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfIZUoi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Sep 2019 16:44:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so271184wrw.8;
        Thu, 26 Sep 2019 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J0ELFrtNhEvPto4OvIVjY2607+9+4UtBs/9Ay2/bZ9I=;
        b=Mns5MqkcmFxWZwic135Y2j8tT3s+/jggpkVbkrxhsOoG+OMaJdCo2JuIhVumuhfxZC
         8JWlCb0H9xeeuG6duImutWRatph0UzNoJ141P74z7kjzDpHg50Kyz7/kPO4iuOzR3uS7
         wuF4NWDwKFyUYWThRkHLQXPLwIYqtv3hnW6+rWop13S5g9VmqWhTv8e2JCn0dWcjyWPE
         hN8fQ0u/ZI372Rd68MOEDOr5PsVTgKah+emvCH5DY3Oq84aI45eWgixj8H1hDWlulMvf
         RIQwaFTThMRjhuzQNXZHTyWDIigleAhmku/Yqo9YHKqOZpF1m313VWdBoDgSilj/yB6s
         Wyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J0ELFrtNhEvPto4OvIVjY2607+9+4UtBs/9Ay2/bZ9I=;
        b=fyH5I4BkGvEjq2R68NuWJN8XxNtx9ssLyHfFHGcldmn1yi+75gNX/p1sWScub5bD1d
         hthoQROz5J/prKDVx5ROdKvFAJBc4p+OEWghF4QmWghsEznUnWF2VnrVtgOWmUTn5M1X
         Mub2ygnD0+nUVS2UdFKrADU+KFMsVJv3s4s49qID8tOHGTR43TZ8MVmrAWVRQasJXu6l
         ZpXIqwxrXQ95bNzbd14e2rjCTjssSVVtl7GVyVnRc9aBo80tXMflIha5w1cfeH0Ao4BN
         pH/2UrknahoftR6N5HVuWWmOnUz5PANi8vGaFqSuPaenq2OF+l9BNd5FWOcVF6ePe+Rp
         WdOg==
X-Gm-Message-State: APjAAAV+SvSWBGrThVMAjJd+pdIeItOv2wiVj3UrOGHWHw/MZ+qsNPTg
        3SCL3WkHxNP47q9bENbVies=
X-Google-Smtp-Source: APXvYqya255nYBnBYzg8c5VjGXRSZfZEVVgu+G/9suhpjnW6KUQPjEPdGPxI42c2ZS/4SIC3li7X8w==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr218824wrt.397.1569530673536;
        Thu, 26 Sep 2019 13:44:33 -0700 (PDT)
Received: from pc ([5.158.153.52])
        by smtp.gmail.com with ESMTPSA id z142sm9729102wmc.24.2019.09.26.13.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 13:44:32 -0700 (PDT)
Date:   Thu, 26 Sep 2019 22:44:25 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Florian Weimer <fweimer@redhat.com>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: [PATCH v5 1/1] random: getrandom(2): warn on large CRNG waits,
 introduce new flags
Message-ID: <20190926204425.GA2198@pc>
References: <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190926204217.GA1366@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926204217.GA1366@pc>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since Linux v3.17, getrandom(2) has been created as a new and more
secure interface for pseudorandom data requests.  It attempted to
solve three problems, as compared to /dev/urandom:

  1. the need to access filesystem paths, which can fail, e.g. under a
     chroot

  2. the need to open a file descriptor, which can fail under file
     descriptor exhaustion attacks

  3. the possibility of getting not-so-random data from /dev/urandom,
     due to an incompletely initialized kernel entropy pool

To solve the third point, getrandom(2) was made to block until a
proper amount of entropy has been accumulated to initialize the CRNG
ChaCha20 cipher.  This made the system call have no guaranteed
upper-bound for its initial waiting time.

Thus when it was introduced at c6e9d6f38894 ("random: introduce
getrandom(2) system call"), it came with a clear warning: "Any
userspace program which uses this new functionality must take care to
assure that if it is used during the boot process, that it will not
cause the init scripts or other portions of the system startup to hang
indefinitely."

Unfortunately, due to multiple factors, including not having this
warning written in a scary-enough language in the manpages, and due to
glibc since v2.25 implementing a BSD-like getentropy(3) in terms of
getrandom(2), modern user-space is calling getrandom(2) in the boot
path everywhere (e.g. Qt, GDM, etc.)

Embedded Linux systems were first hit by this, and reports of embedded
systems "getting stuck at boot" began to be common.  Over time, the
issue began to even creep into consumer-level x86 laptops: mainstream
distributions, like Debian Buster, began to recommend installing
haveged as a duct-tape workaround... just to let the system boot.

Moreover, filesystem optimizations in EXT4 and XFS, e.g. b03755ad6f33
("ext4: make __ext4_get_inode_loc plug"), which merged directory
lookup code inode table IO, and very fast systemd boots, further
exaggerated the problem by limiting interrupt-based entropy sources.
This led to large delays until the kernel's cryptographic random
number generator (CRNG) got initialized.

On a Thinkpad E480 x86 laptop and an ArchLinux user-space, the ext4
commit earlier mentioned reliably blocked the system on GDM boot.
Mitigate the problem, as a first step, in two ways:

  1. Issue a big WARN_ON when any process gets stuck on getrandom(2)
     for more than CONFIG_GETRANDOM_WAIT_THRESHOLD_SEC seconds.

  2. Introduce new getrandom(2) flags, with clear semantics that can
     hopefully guide user-space in doing the right thing.

Set CONFIG_GETRANDOM_WAIT_THRESHOLD_SEC to a heuristic 30-second
default value. System integrators and distribution builders are deeply
encouraged not to increase it much: during system boot, you either
have entropy, or you don't. And if you didn't have entropy, it will
stay like this forever, because if you had, you wouldn't have blocked
in the first place. It's an atomic "either/or" situation, with no
middle ground. Please think twice.

For the new getrandom(2) flags, be much more explicit.  As Linus
mentioned several times in the bug report thread, Linux should've
never provided /dev/random and the getrandom(GRND_RANDOM) APIs. These
interfaces are broken by design due to their almost-permanent
blockage, leading to the current misuse of /dev/urandom and
getrandom(flags=0) calls. Thus introduce the flags:

  1. GRND_INSECURE
  2. GRND_SECURE_UNBOUNDED_INITIAL_WAIT

where both extract randomness _exclusively_ from the urandom source.

Due to the explicit semantics of these new flags, GRND_INSECURE will
never issue a kernel warning message even if the CRNG is not yet
inited.  Similarly, GRND_SECURE_UNBOUNDED_INITIAL_WAIT will never
cause any any kernel WARN, no matter how large the unbounded wait is.

Rreported-by: Ahmed S. Darwish <darwish.07@gmail.com>
Link: https://lkml.kernel.org/r/20190910042107.GA1517@darwi-home-pc
Link: https://lkml.kernel.org/r/20190912034421.GA2085@darwi-home-pc
Link: https://lkml.kernel.org/r/20190914222432.GC19710@mit.edu
Link: https://lkml.kernel.org/r/20180514003034.GI14763@thunk.org
Link: https://lkml.kernel.org/r/CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com
Link: https://lkml.kernel.org/r/20190917052438.GA26923@1wt.eu
Link: https://lkml.kernel.org/r/20190917160844.GC31567@gardel-login
Link: https://lkml.kernel.org/r/CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com
Link: https://lkml.kernel.org/r/CAHk-=wjQeiYu8Q_wcMgM-nAcW7KsBfG1+90DaTD5WF2cCeGCgA@mail.gmail.com
Link: https://factorable.net ("Widespread Weak Keys in Network Devices")
Link: https://man.openbsd.org/man4/random.4
Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |   7 ++
 drivers/char/Kconfig                          |  60 ++++++++++-
 drivers/char/random.c                         | 102 +++++++++++++++---
 include/uapi/linux/random.h                   |  27 ++++-
 4 files changed, 177 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6ef205fd7c97..d82eafc6a62a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3728,6 +3728,13 @@
 			fully seed the kernel's CRNG. Default is controlled
 			by CONFIG_RANDOM_TRUST_CPU.

+	random.getrandom_wait_threshold=
+			Maximum amount, in seconds, for a process to block
+			in a getrandom(,,flags=0) systemcall without a loud
+			warning in the kernel logs. Default is controlled by
+			CONFIG_RANDOM_GETRANDOM_WAIT_THRESHOLD_SEC. Check
+			the config option help text for more information.
+
 	ras=option[,option,...]	[KNL] RAS-specific options

 		cec_disable	[X86]
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index df0fc997dc3e..adc9bc63d27c 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -535,8 +535,6 @@ config ADI
 	  and SSM (Silicon Secured Memory).  Intended consumers of this
 	  driver include crash and makedumpfile.

-endmenu
-
 config RANDOM_TRUST_CPU
 	bool "Trust the CPU manufacturer to initialize Linux's CRNG"
 	depends on X86 || S390 || PPC
@@ -559,4 +557,60 @@ config RANDOM_TRUST_BOOTLOADER
 	device randomness. Say Y here to assume the entropy provided by the
 	booloader is trustworthy so it will be added to the kernel's entropy
 	pool. Otherwise, say N here so it will be regarded as device input that
-	only mixes the entropy pool.
\ No newline at end of file
+	only mixes the entropy pool.
+
+config RANDOM_GETRANDOM_WAIT_THRESHOLD_SEC
+	int
+	default 30
+	help
+	  The getrandom(2) system call, when asking for entropy from the
+	  urandom source, blocks until the kernel's Cryptographic Random
+	  Number Generator (CRNG) gets initialized. This configuration
+	  option sets the maximum wait time, in seconds, for a process
+	  to get blocked on such a system call before the kernel issues
+	  a loud warning. Rationale follows:
+
+	  When the getrandom(2) system call was created, it came with
+	  the clear warning: "Any userspace program which uses this new
+	  functionality must take care to assure that if it is used
+	  during the boot process, that it will not cause the init
+	  scripts or other portions of the system startup to hang
+	  indefinitely.
+
+	  Unfortunately, due to multiple factors, including not having
+	  this warning written in a scary-enough language in the
+	  manpages, and due to glibc since v2.25 implementing a BSD-like
+	  getentropy(3) in terms of getrandom(2), modern user-space is
+	  calling getrandom(2) in the boot path everywhere.
+
+	  Embedded Linux systems were first hit by this, and reports of
+	  embedded system "getting stuck at boot" began to be
+	  common. Over time, the issue began to even creep into consumer
+	  level x86 laptops: mainstream distributions, like Debian
+	  Buster, began to recommend installing haveged as a workaround,
+	  just to let the system boot.
+
+	  Filesystem optimizations in EXT4 and XFS exaggerated the
+	  problem, due to aggressive batching of IO requests, and thus
+	  minimizing sources of entropy at boot. This led to large
+	  delays until the kernel's CRNG got initialized.
+
+	  System integrators and distribution builders are not
+	  encouraged to considerably increase this value: during system
+	  boot, you either have entropy, or you don't. And if you didn't
+	  have entropy, it will stay like this forever, because if you
+	  had, you wouldn't have blocked in the first place. It's an
+	  atomic "either/or" situation, with no middle ground. Please
+	  think twice.
+
+	  Ideally, systems would be configured with hardware random
+	  number generators, and/or configured to trust the CPU-provided
+	  RNG's (CONFIG_RANDOM_TRUST_CPU) or boot-loader provided ones
+	  (CONFIG_RANDOM_TRUST_BOOTLOADER).  In addition, userspace
+	  should generate cryptographic keys only as late as possible,
+	  when they are needed, instead of during early boot.  For
+	  non-cryptographic use cases, such as dictionary seeds or MIT
+	  Magic Cookies, the getrandom2(GRND2_INSECURE) system call,
+	  or even random(3), may be more appropriate.
+
+endmenu
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 566922df4b7b..37c00cff1c08 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -322,6 +322,7 @@
 #include <linux/interrupt.h>
 #include <linux/mm.h>
 #include <linux/nodemask.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/kthread.h>
 #include <linux/percpu.h>
@@ -854,12 +855,21 @@ static void invalidate_batched_entropy(void);
 static void numa_crng_init(void);

 static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
+static int getrandom_wait_threshold __ro_after_init =
+				CONFIG_RANDOM_GETRANDOM_WAIT_THRESHOLD_SEC;
+
 static int __init parse_trust_cpu(char *arg)
 {
 	return kstrtobool(arg, &trust_cpu);
 }
 early_param("random.trust_cpu", parse_trust_cpu);

+static int __init parse_getrandom_wait_threshold(char *arg)
+{
+	return kstrtoint(arg, 0, &getrandom_wait_threshold);
+}
+early_param("random.getrandom_wait_threshold", parse_getrandom_wait_threshold);
+
 static void crng_initialize(struct crng_state *crng)
 {
 	int		i;
@@ -1960,7 +1970,7 @@ random_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 }

 static ssize_t
-urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+_urandom_read(char __user *buf, size_t nbytes, bool warn_on_noninited_crng)
 {
 	unsigned long flags;
 	static int maxwarn = 10;
@@ -1968,7 +1978,7 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)

 	if (!crng_ready() && maxwarn > 0) {
 		maxwarn--;
-		if (__ratelimit(&urandom_warning))
+		if (warn_on_noninited_crng && __ratelimit(&urandom_warning))
 			printk(KERN_NOTICE "random: %s: uninitialized "
 			       "urandom read (%zd bytes read)\n",
 			       current->comm, nbytes);
@@ -1982,6 +1992,13 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	return ret;
 }

+static ssize_t
+urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+{
+	/* warn on non-inited CRNG */
+	return _urandom_read(buf, nbytes, true);
+}
+
 static __poll_t
 random_poll(struct file *file, poll_table * wait)
 {
@@ -2118,13 +2135,55 @@ const struct file_operations urandom_fops = {
 	.llseek = noop_llseek,
 };

+static int geturandom_wait(char __user *buf, size_t count,
+			   bool warn_on_large_wait)
+{
+	long ret, timeout = MAX_SCHEDULE_TIMEOUT;
+
+	if (warn_on_large_wait && (getrandom_wait_threshold > 0))
+		timeout = HZ * getrandom_wait_threshold;
+
+	do {
+		ret = wait_event_interruptible_timeout(crng_init_wait,
+						       crng_ready(),
+						       timeout);
+		if (ret < 0)
+			return ret;
+
+		if (ret == 0) {
+			WARN(1, "random: %s[%d]: getrandom(%zu bytes) "
+			     "is blocked for more than %d seconds. Check "
+			     "getrandom_wait(7)\n", current->comm,
+			     task_pid_nr(current), count,
+			     getrandom_wait_threshold);
+
+			/* warn once per caller */
+			timeout = MAX_SCHEDULE_TIMEOUT;
+		}
+
+	} while (ret == 0);
+
+	return _urandom_read(buf, count, true);
+}
+
 SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 		unsigned int, flags)
 {
-	int ret;
+	unsigned int i, invalid_combs[] = {
+		GRND_INSECURE|GRND_SECURE_UNBOUNDED_INITIAL_WAIT,
+		GRND_INSECURE|GRND_RANDOM,
+	};

-	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM))
+	if (flags & ~(GRND_NONBLOCK | \
+		      GRND_RANDOM   | \
+		      GRND_INSECURE | \
+		      GRND_SECURE_UNBOUNDED_INITIAL_WAIT)) {
 		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(invalid_combs); i++)
+		if ((flags & invalid_combs[i]) == invalid_combs[i])
+			return -EINVAL;

 	if (count > INT_MAX)
 		count = INT_MAX;
@@ -2132,14 +2191,33 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 	if (flags & GRND_RANDOM)
 		return _random_read(flags & GRND_NONBLOCK, buf, count);

-	if (!crng_ready()) {
-		if (flags & GRND_NONBLOCK)
+	/*
+	 * urandom: explicit request *not* to wait for CRNG init, and
+	 * thus no "uninitialized urandom read" warnings.
+	 */
+	if (flags & GRND_INSECURE)
+		return _urandom_read(buf, count, false);
+
+	/* urandom: nonblocking access */
+	if ((flags & GRND_NONBLOCK) && !crng_ready())
 			return -EAGAIN;
-		ret = wait_for_random_bytes();
-		if (unlikely(ret))
-			return ret;
-	}
-	return urandom_read(NULL, buf, count, NULL);
+
+	/*
+	 * urandom: explicit request *to* wait for CRNG init, and thus
+	 * no "getrandom is blocked for more than X seconds" warnings
+	 * on large waits.
+	 */
+	if (flags & GRND_SECURE_UNBOUNDED_INITIAL_WAIT)
+		return geturandom_wait(buf, count, false);
+
+	/*
+	 * urandom: *implicit* request to wait for CRNG init (flags=0)
+	 *
+	 * User-space has been badly abusing this by calling getrandom
+	 * with flags=0 in the boot path, and thus blocking system
+	 * boots forever in absence of entropy. Warn on large waits.
+	 */
+	return geturandom_wait(buf, count, true);
 }

 /********************************************************************
@@ -2458,4 +2536,4 @@ void add_bootloader_randomness(const void *buf, unsigned int size)
 	else
 		add_device_randomness(buf, size);
 }
-EXPORT_SYMBOL_GPL(add_bootloader_randomness);
\ No newline at end of file
+EXPORT_SYMBOL_GPL(add_bootloader_randomness);
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index 26ee91300e3e..5a3df92270a7 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -8,6 +8,7 @@
 #ifndef _UAPI_LINUX_RANDOM_H
 #define _UAPI_LINUX_RANDOM_H

+#include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/ioctl.h>
 #include <linux/irqnr.h>
@@ -23,7 +24,7 @@
 /* Get the contents of the entropy pool.  (Superuser only.) */
 #define RNDGETPOOL	_IOR( 'R', 0x02, int [2] )

-/*
+/*
  * Write bytes into the entropy pool and add to the entropy count.
  * (Superuser only.)
  */
@@ -47,10 +48,28 @@ struct rand_pool_info {
 /*
  * Flags for getrandom(2)
  *
+ * 0			discouraged - don't use (see below)
  * GRND_NONBLOCK	Don't block and return EAGAIN instead
- * GRND_RANDOM		Use the /dev/random pool instead of /dev/urandom
+ * GRND_RANDOM		discouraged - don't use (uses /dev/random pool)
+ * GRND_INSECURE	Use urandom pool, never block even if CRNG isn't inited
+ * GRND_SECURE_UNBOUNDED_INITIAL_WAIT
+ *			Use urandom pool, block until CRNG is inited
+ *
+ * User-space has been badly abusing getrandom(flags=0) by calling
+ * it in the boot path, and thus blocking system boots forever in
+ * the absence of entropy (a blocked system cannot generate more
+ * entropy, by definition).
+ *
+ * Thus if a process blocks on a getrandom(flags=0), waithing for
+ * more than CONFIG_RANDOM_GETRANDOM_WAIT_THRESHOLD_SEC seconds,
+ * the kernel will issue a loud warning.
+ *
+ * In general, don't use flags=0. Always use either GRND_INSECURE
+ * or GRND_SECURE_UNBOUNDED_INITIAL_WAIT instead.
  */
-#define GRND_NONBLOCK	0x0001
-#define GRND_RANDOM	0x0002
+#define GRND_NONBLOCK				BIT(0)
+#define GRND_RANDOM				BIT(1)
+#define GRND_INSECURE				BIT(2)
+#define GRND_SECURE_UNBOUNDED_INITIAL_WAIT	BIT(3)

 #endif /* _UAPI_LINUX_RANDOM_H */
--
2.23.0

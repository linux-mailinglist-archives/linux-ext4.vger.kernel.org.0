Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59585B6EAD
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 23:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbfIRVRY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 17:17:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40783 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfIRVRY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Sep 2019 17:17:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id l3so853831wru.7;
        Wed, 18 Sep 2019 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j2AKpLxnYTmI0SMIF2YXZa4o0ttxwsIthEul6wyExf8=;
        b=oOG3mi2xdJSUYFHGi/+eAOQptkKkk9vFbp/bxJAGX2PLfcJOqk/ovqE3j1D5vJo4f4
         Rs4dyAk+Q5FlAdviA+1QsjWVUxyMyhdbpbeo4IjY4SmoOHDlkGbVxuhYzptbKR/tNkD1
         v1XnUxQ87jt6yLYP4OUHn+7Ogr3h/H3HAsxRzTjUMBCdpiMTuZPvTdmcv0yUa5C/fFpZ
         pTuTaJDfrimVBwunMEtk8IB2GKBPPZLnkjeU0KpENVwDdojEuOcLDLI3hIrtjbSVYq5x
         d15C+PsNESbWCCauZVHyw97HkkZlDUfwcOIEKTVShi3Pfccmw3nKh+lAPiVw1HmqzuUo
         AyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j2AKpLxnYTmI0SMIF2YXZa4o0ttxwsIthEul6wyExf8=;
        b=YzERey2DWP9je27thGMJmbp/qFsxrl5E0He3WKUV30GYHH0v3CeuS07V/mX+tAHad2
         XQcENwc1LflzUz2ypI//px7ywOJUIyex+LqUAjfG4RTO/XBVxt2VXVMYskRtOKwSd4Uk
         2odWDeg1SGVY6L/NoNVVFy5HyteHhWx1p2uy66MBAKBDzqxPDGwZInhMlh7g0wJhYJ/5
         jCw1Z8Zzu8XlwoP/qcsxJKBB89q//c2UQUxmuSFKCfzBDSDIan9T8Wab+qawRqr8Pj0K
         PfGCqdpeQCWoYpQ3HkP6ooHohkpFTaFvdvmBKYG/9Wjuqoke0U9gv6mtg5Vor99qh70V
         RLmQ==
X-Gm-Message-State: APjAAAW3MvkMucqs1gxvSrhuBncWTLRPpvibcvkqwolu3C5t2SPaOVSF
        Li5kGl65OhKKMMNX7UC2Lcc=
X-Google-Smtp-Source: APXvYqxem7MRzkXVkjBCOR1rY1am34K+RWvcJDJHljEDFm1YfuY7XGM79d91y9Mo9im7lB8KfpQhmw==
X-Received: by 2002:a5d:43c6:: with SMTP id v6mr4329766wrr.159.1568841440196;
        Wed, 18 Sep 2019 14:17:20 -0700 (PDT)
Received: from darwi-home-pc ([5.158.153.52])
        by smtp.gmail.com with ESMTPSA id y19sm82781wmi.13.2019.09.18.14.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 14:17:19 -0700 (PDT)
Date:   Wed, 18 Sep 2019 23:17:13 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190918211713.GA2225@darwi-home-pc>
References: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918211503.GA1808@darwi-home-pc>
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
proper amount of entropy has been accumulated to initialize the
CHACHA20 cipher.  This basically made the system call have no
guaranteed upper-bound for its initial waiting time.

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
path everywhere.

Embedded Linux systems were first hit by this, and reports of embedded
systems "getting stuck at boot" began to be common.  Over time, the
issue began to even creep into consumer-level x86 laptops: mainstream
distributions, like Debian Buster, began to recommend installing
haveged as a duct-tape workaround... just to let the system boot. (!)

Moreover, filesystem optimizations in EXT4 and XFS, e.g. b03755ad6f33
("ext4: make __ext4_get_inode_loc plug"), which merged directory
lookup code inode table IO, and very fast systemd boots, further
exaggerated the problem by limiting interrupt-based entropy sources.
This led to large delays until the kernel's cryptographic random
number generator (CRNG) got initialized.

Mitigate the problem, as a first step, in two ways:

  1. Issue a big WARN_ON when any process gets stuck on getrandom(2)
     for more than CONFIG_GETRANDOM_WAIT_THRESHOLD_SEC seconds.

  2. Introduce the new getrandom2(2) system call, with clear semantics
     that can guide user-space in doing the right thing.

On the author's Thinkpad E480 x86 laptop and an ArchLinux user-space,
the ext4 commit earlier mentioned reliably blocked the system on GDM
gnome-session boot. Complain loudly through a WARN_ON if processes
get stuck on getrandom(2). Beside its obvious informational purposes,
the WARN_ON also reliably gets the system unstuck.

Set CONFIG_GETRANDOM_WAIT_THRESHOLD_SEC to a heuristic 30-second
default value. We __deeply encourage__ system integrators and
distribution builders not to increase it much: during system boot, you
either have entropy, or you don't. And if you didn't have entropy, it
will stay like this forever, because if you had, you wouldn't have
blocked in the first place. It's an atomic "either/or" situation, with
no middle ground. Please think twice.

For the new getrandom2(2) system call, it tries to avoid the problems
introduced by its earlier siblings. As Linus mentioned several times
in the bug report thread, Linux should have never provided the
"/dev/random" and "getrandom(GRND_RANDOM)" APIs. These interfaces are
broken by design due to their almost-permanent blockage, leading to
the current misuse of /dev/urandom and getrandom(flags=0) calls. Thus
for getrandom2, introduce the flags:

  1. GRND2_SECURE_UNBOUNDED_INITIAL_WAIT
  2. GRND2_INSECURE

where both extract randomness __exclusively__ from the urandom source.
Due to the clear nature of its new GRND2_* flags, the getrandom2()
system call will never issue any warnings on the kernel log.

OpenBSD, to its credit, got that correctly from the start by making
both of /dev/random and /dev/urandom equivalent.

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
 drivers/char/Kconfig        | 60 ++++++++++++++++++++++++--
 drivers/char/random.c       | 85 ++++++++++++++++++++++++++++++++-----
 include/uapi/linux/random.h | 20 +++++++--
 3 files changed, 148 insertions(+), 17 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index df0fc997dc3e..772765c36fc3 100644
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
+config GETRANDOM_WAIT_THRESHOLD_SEC
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
+	  Filesystem optimizations in EXT4 and XFS exagerated the
+	  problem, due to aggressive batching of IO requests, and thus
+	  minimizing sources of entropy at boot. This led to large
+	  delays until the kernel's CRNG got initialized.
+
+	  System integrators and distribution builderss are not
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
+	  or even random(3), may be more appropropriate.
+
+endmenu
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 566922df4b7b..74057e496303 100644
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
+				CONFIG_GETRANDOM_WAIT_THRESHOLD_SEC;
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
@@ -1982,6 +1992,12 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	return ret;
 }
 
+static ssize_t
+urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
+{
+	return _urandom_read(buf, nbytes, true);
+}
+
 static __poll_t
 random_poll(struct file *file, poll_table * wait)
 {
@@ -2118,11 +2134,41 @@ const struct file_operations urandom_fops = {
 	.llseek = noop_llseek,
 };
 
-SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
-		unsigned int, flags)
+static int getrandom_wait(char __user *buf, size_t count,
+			  bool warn_on_large_wait)
 {
+	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
 	int ret;
 
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
+SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
+		unsigned int, flags)
+{
 	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM))
 		return -EINVAL;
 
@@ -2132,14 +2178,31 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 	if (flags & GRND_RANDOM)
 		return _random_read(flags & GRND_NONBLOCK, buf, count);
 
-	if (!crng_ready()) {
-		if (flags & GRND_NONBLOCK)
+	if ((flags & GRND_NONBLOCK) && !crng_ready())
 			return -EAGAIN;
-		ret = wait_for_random_bytes();
-		if (unlikely(ret))
-			return ret;
-	}
-	return urandom_read(NULL, buf, count, NULL);
+
+	return getrandom_wait(buf, count, true);
+}
+
+SYSCALL_DEFINE3(getrandom2, char __user *, buf, size_t, count,
+		unsigned int, flags)
+{
+	if (flags & ~(GRND2_SECURE_UNBOUNDED_INITIAL_WAIT|GRND2_INSECURE))
+		return -EINVAL;
+
+	if (flags & (GRND2_SECURE_UNBOUNDED_INITIAL_WAIT|GRND2_INSECURE))
+		return -EINVAL;
+
+	if (count > INT_MAX)
+		count = INT_MAX;
+
+	if (flags & GRND2_SECURE_UNBOUNDED_INITIAL_WAIT)
+		return getrandom_wait(buf, count, false);
+
+	if (flags & GRND2_INSECURE)
+		return _urandom_read(buf, count, false);
+
+	unreachable();
 }
 
 /********************************************************************
diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index 26ee91300e3e..3f09a8f6aff3 100644
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
@@ -50,7 +51,20 @@ struct rand_pool_info {
  * GRND_NONBLOCK	Don't block and return EAGAIN instead
  * GRND_RANDOM		Use the /dev/random pool instead of /dev/urandom
  */
-#define GRND_NONBLOCK	0x0001
-#define GRND_RANDOM	0x0002
+#define GRND_NONBLOCK				BIT(0)
+#define GRND_RANDOM				BIT(1)
+
+/*
+ * Flags for getrandom2(2)
+ *
+ * GRND2_SECURE		Use urandom pool, block until CRNG is inited
+ * GRND2_INSECURE	Use urandom pool, never block even if CRNG isn't inited
+ *
+ * NOTE: don't mix flag values with GRND, to protect against the
+ * security implications of users passing the invalid flag family
+ * to system calls (GRND_* vs. GRND2_*).
+ */
+#define GRND2_SECURE_UNBOUNDED_INITIAL_WAIT	BIT(7)
+#define GRND2_INSECURE				BIT(8)
 
 #endif /* _UAPI_LINUX_RANDOM_H */
-- 
Ahmed Darwish
http://darwish.chasingpointers.com

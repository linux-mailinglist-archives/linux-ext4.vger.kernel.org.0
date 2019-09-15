Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47546B2E74
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 07:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfIOFXL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 01:23:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40855 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725827AbfIOFXL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 01:23:11 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8F5MgUi028405
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Sep 2019 01:22:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 416C0420811; Sun, 15 Sep 2019 01:22:42 -0400 (EDT)
Date:   Sun, 15 Sep 2019 01:22:42 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC v2] random: optionally block in getrandom(2) when the
 CRNG is uninitialized
Message-ID: <20190915052242.GG19710@mit.edu>
References: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Thus, add an optional configuration option which stops getrandom(2)
from blocking, but instead returns "best efforts" randomness, which
might not be random or secure at all.  This can be controlled via
random.getrandom_block boot command line option, and the
CONFIG_RANDOM_BLOCK can be used to set the default to be blocking.
Since according to the Great Penguin, only incompetent system
designers would value "security" ahead of "usability", the default is
to be non-blocking.

In addition, modify getrandom(2) to complain loudly with a kernel
warning when some userspace process is erroneously calling
getrandom(2) too early during the boot process.

Link: https://lkml.kernel.org/r/CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com
Link: https://lkml.kernel.org/r/20190912034421.GA2085@darwi-home-pc
Link: https://lkml.kernel.org/r/20190911173624.GI2740@mit.edu
Link: https://lkml.kernel.org/r/20180514003034.GI14763@thunk.org

[ Modified by tytso@mit.edu to make the change of getrandom(2) to be
  non-blocking to be optional. ]

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

Here's my take on the patch.  I really very strongly believe that the
idea of making getrandom(2) non-blocking and to blindly assume that we
can load up the buffer with "best efforts" randomness to be a
terrible, terrible idea that is going to cause major security problems
that we will potentially regret very badly.  Linus Torvalds believes I
am an incompetent systems designer.

So let's do it both ways, and push the decision on the distributor
and/or product manufacturer

 drivers/char/Kconfig  | 33 +++++++++++++++++++++++++++++++--
 drivers/char/random.c | 34 +++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 7 deletions(-)

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
index 5d5ea4ce1442..243fb4a4535f 100644
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
@@ -1045,6 +1054,12 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
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
 
@@ -1900,6 +1915,7 @@ int __init rand_initialize(void)
 	crng_global_init_time = jiffies;
 	if (ratelimit_disable) {
 		urandom_warning.interval = 0;
+		getrandom_warning.interval = 0;
 		unseeded_warning.interval = 0;
 	}
 	return 0;
@@ -1969,8 +1985,8 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
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
@@ -2135,9 +2151,17 @@ SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
 	if (!crng_ready()) {
 		if (flags & GRND_NONBLOCK)
 			return -EAGAIN;
-		ret = wait_for_random_bytes();
-		if (unlikely(ret))
-			return ret;
+		WARN_ON_ONCE(1);
+		if (getrandom_block) {
+			if (__ratelimit(&getrandom_warning))
+				pr_err("random: %s: getrandom blocking for CRNG initialization\n",
+				       current->comm);
+			ret = wait_for_random_bytes();
+			if (unlikely(ret))
+				return ret;
+		} else if (__ratelimit(&getrandom_warning))
+			pr_err("random: %s: getrandom called too early\n",
+			       current->comm);
 	}
 	return urandom_read(NULL, buf, count, NULL);
 }
-- 
2.23.0


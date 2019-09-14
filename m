Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE2C4B2AD3
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Sep 2019 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfINJZU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Sep 2019 05:25:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36940 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfINJZU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Sep 2019 05:25:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so33662955wro.4;
        Sat, 14 Sep 2019 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0ZUbt5qfZhTTFzUgC4IFjqmJyGeXLH3Sp7wB7Ay8158=;
        b=hREe1AemGeI02DKnbQKhfaYRJ3V+qo6uki4vsXF5L/9kEtNxmuXops+bw+97zgd6vN
         xKzGi+LZB5wOsGYwp8Y8MD0zS7klSoatAZcd0YhFv7pg1C61PiHy7HPZWwbrlbk8rVfk
         6ZJW2++O0VDjIJD26DkzDDauLIomdp+GxEpzswU9ahpIiQVgX0Y+VGZkG1uQ17F1+jpO
         Dr0QS6rl150Km4PJ1Cbr5V9rT+sgJWjbdceRHCr5bpMt+osjFJtpL7G3O8/dwmUFYdta
         qsmFuW1Ya+pME91gKOmnI3OHX7gJh4shInqXjSqkWzQCxH/wX/fejlAunk/LUaVm94gz
         Es8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0ZUbt5qfZhTTFzUgC4IFjqmJyGeXLH3Sp7wB7Ay8158=;
        b=ADKOftYJoqwBj3QxcWbWGvy1JbtgjI1L+IDFA/l7imLfz4OIpIAX/17BSQkkw5pFgL
         Kp2RzTe4KJi2yuHPBWgpxajTxQHovLp9jALC2PzQgTcktKhGuoCd2X2fmYLSgh9IRS7Q
         12Jq6cS9j3Bf/n1/6E4amTUDSS6/BumMIXmwbPQUbzc1s/koohqLHTLhSLEr7JdmtzYq
         buwmuMeSPnS5pFXQ2Wzauek9JzyFUe2jp80Fib2cEROWlkLhrOLz9ITcDcf/LT2Gkb+Z
         +i4Thp1TUSL0Ib5kuFjp1mrErH+Rlbt6AfDLIQScVRPzLkCBbocqbEk/6a0q0H32OXX1
         3mmw==
X-Gm-Message-State: APjAAAWDvZYOQYSIUn/Tm0eA9cJb8id7Q8PBEIBK7A7aOH8+4tJPg315
        JM5H8gOedzGi5W39FiKdadg=
X-Google-Smtp-Source: APXvYqwO23/ek3Tphg7mLbnmMjnn8s6DSBISi6Cn99px5e9IfL1YTLUy/D8zFWZOWJxW1MF7ahduuw==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr10780769wrm.112.1568453116848;
        Sat, 14 Sep 2019 02:25:16 -0700 (PDT)
Received: from darwi-home-pc (p200300D06F2D142FF79C0802487FC445.dip0.t-ipconnect.de. [2003:d0:6f2d:142f:f79c:802:487f:c445])
        by smtp.gmail.com with ESMTPSA id z1sm55299338wre.40.2019.09.14.02.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 02:25:15 -0700 (PDT)
Date:   Sat, 14 Sep 2019 11:25:09 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190914092509.GA1138@darwi-home-pc>
References: <20190910042107.GA1517@darwi-home-pc>
 <CAHk-=wimE=Rw4s8MHKpsgc-ZsdoTp-_CAs7fkm9scn87ZbkMFg@mail.gmail.com>
 <20190910173243.GA3992@darwi-home-pc>
 <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu>
 <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912082530.GA27365@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 12, 2019 at 04:25:30AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Sep 12, 2019 at 05:44:21AM +0200, Ahmed S. Darwish wrote:
[...]
> 
> >     1. Cutting down the number of bits needed to initialize the CRNG
> >        to 256 bits (CHACHA20 cipher)
> 
> Does the attach patch (see below) help?
>
[...]
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 5d5ea4ce1442..b9b3a5a82abf 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -500,7 +500,7 @@ static int crng_init = 0;
>  #define crng_ready() (likely(crng_init > 1))
>  static int crng_init_cnt = 0;
>  static unsigned long crng_global_init_time = 0;
> -#define CRNG_INIT_CNT_THRESH (2*CHACHA_KEY_SIZE)
> +#define CRNG_INIT_CNT_THRESH	CHACHA_KEY_SIZE
>  static void _extract_crng(struct crng_state *crng, __u8 out[CHACHA_BLOCK_SIZE]);
>  static void _crng_backtrack_protect(struct crng_state *crng,
>  				    __u8 tmp[CHACHA_BLOCK_SIZE], int used);

Unfortunately, it only made the early fast init faster, but didn't fix
the normal crng init blockage :-(

Here's a trace log, got by applying the patch at [1]. The boot was
continued only after typing some random keys after ~30s:

#
# entries-in-buffer/entries-written: 22/22   #P:8
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
          <idle>-0     [001] dNh.     0.687088: crng_fast_load: crng threshold = 32
          <idle>-0     [001] dNh.     0.687089: crng_fast_load: crng_init_cnt = 0
          <idle>-0     [001] dNh.     0.687090: crng_fast_load: crng_init_cnt, now set to 16
          <idle>-0     [001] dNh.     0.705208: crng_fast_load: crng threshold = 32
          <idle>-0     [001] dNh.     0.705209: crng_fast_load: crng_init_cnt = 16
          <idle>-0     [001] dNh.     0.705209: crng_fast_load: crng_init_cnt, now set to 32
          <idle>-0     [001] dNh.     0.708048: crng_fast_load: random: fast init done
             lvm-165   [001] d...     2.417971: urandom_read: random: crng_init_cnt, now set to 0
 systemd-random--179   [003] ....     2.495669: wait_for_random_bytes.part.0: wait for randomness
     dbus-daemon-274   [006] dN..     3.294331: urandom_read: random: crng_init_cnt, now set to 0
     dbus-daemon-274   [006] dN..     3.316618: urandom_read: random: crng_init_cnt, now set to 0
         polkitd-286   [007] dN..     3.873918: urandom_read: random: crng_init_cnt, now set to 0
         polkitd-286   [007] dN..     3.874303: urandom_read: random: crng_init_cnt, now set to 0
         polkitd-286   [007] dN..     3.874375: urandom_read: random: crng_init_cnt, now set to 0
         polkitd-286   [007] d...     3.886204: urandom_read: random: crng_init_cnt, now set to 0
         polkitd-286   [007] d...     3.886217: urandom_read: random: crng_init_cnt, now set to 0
         polkitd-286   [007] d...     3.888519: urandom_read: random: crng_init_cnt, now set to 0
         polkitd-286   [007] d...     3.888529: urandom_read: random: crng_init_cnt, now set to 0
 gnome-session-b-321   [006] ....     4.292034: wait_for_random_bytes.part.0: wait for randomness
          <idle>-0     [002] dNh.    36.784001: crng_reseed: random: crng init done
 gnome-session-b-321   [006] ....    36.784019: wait_for_random_bytes.part.0: wait done
 systemd-random--179   [003] ....    36.784051: wait_for_random_bytes.part.0: wait done

[1] patch:

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 5d5ea4ce1442..4a50ee2c230d 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -500,7 +500,7 @@ static int crng_init = 0;
 #define crng_ready() (likely(crng_init > 1))
 static int crng_init_cnt = 0;
 static unsigned long crng_global_init_time = 0;
-#define CRNG_INIT_CNT_THRESH (2*CHACHA_KEY_SIZE)
+#define CRNG_INIT_CNT_THRESH (CHACHA_KEY_SIZE)
 static void _extract_crng(struct crng_state *crng, __u8 out[CHACHA_BLOCK_SIZE]);
 static void _crng_backtrack_protect(struct crng_state *crng,
 				    __u8 tmp[CHACHA_BLOCK_SIZE], int used);
@@ -931,6 +931,9 @@ static int crng_fast_load(const char *cp, size_t len)
 	unsigned long flags;
 	char *p;
 
+	trace_printk("crng threshold = %d\n", CRNG_INIT_CNT_THRESH);
+	trace_printk("crng_init_cnt = %d\n", crng_init_cnt);
+
 	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
 		return 0;
 	if (crng_init != 0) {
@@ -943,11 +946,15 @@ static int crng_fast_load(const char *cp, size_t len)
 		cp++; crng_init_cnt++; len--;
 	}
 	spin_unlock_irqrestore(&primary_crng.lock, flags);
+
+	trace_printk("crng_init_cnt, now set to %d\n", crng_init_cnt);
+
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 		invalidate_batched_entropy();
 		crng_init = 1;
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: fast init done\n");
+		trace_printk("random: fast init done\n");
 	}
 	return 1;
 }
@@ -1033,6 +1040,7 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 		process_random_ready_list();
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: crng init done\n");
+		trace_printk("random: crng init done\n");
 		if (unseeded_warning.missed) {
 			pr_notice("random: %d get_random_xx warning(s) missed "
 				  "due to ratelimiting\n",
@@ -1743,9 +1751,16 @@ EXPORT_SYMBOL(get_random_bytes);
  */
 int wait_for_random_bytes(void)
 {
+	int ret;
+
 	if (likely(crng_ready()))
 		return 0;
-	return wait_event_interruptible(crng_init_wait, crng_ready());
+
+	trace_printk("wait for randomness\n");
+	ret = wait_event_interruptible(crng_init_wait, crng_ready());
+	trace_printk("wait done\n");
+
+	return ret;
 }
 EXPORT_SYMBOL(wait_for_random_bytes);
 
@@ -1974,6 +1989,8 @@ urandom_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 			       current->comm, nbytes);
 		spin_lock_irqsave(&primary_crng.lock, flags);
 		crng_init_cnt = 0;
+		trace_printk("random: crng_init_cnt, now set to %d\n",
+			     crng_init_cnt);
 		spin_unlock_irqrestore(&primary_crng.lock, flags);
 	}
 	nbytes = min_t(size_t, nbytes, INT_MAX >> (ENTROPY_SHIFT + 3));

thanks,

-- 
darwi
http://darwish.chasingpointers.com

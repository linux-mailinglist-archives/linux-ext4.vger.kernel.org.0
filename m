Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB836F0EA
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhD2UKu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbhD2UKt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 16:10:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE547C06138B;
        Thu, 29 Apr 2021 13:10:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x2so792505lff.10;
        Thu, 29 Apr 2021 13:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVxRIljlMWj/xaAgQFr2JbubgIjJiWSc0KSUhA2z/UA=;
        b=kWWBpjASwhbzasukQ6Trnitmid+QJ+rW2vQ8FiUZMnmf2AjLMAAyXw+n3RxmbGPOcd
         JKMOoGcxglMZ/niMgUMjYanAeKwzKF3pkgGPxDbSN9WtUgMvWAWzwPn11uLqZ1C/XTbV
         NiW1yWr7bjQ7GKFYXkE3Xt8jmQiD59GVvR5iMoPS6GczTE1dRfTZkvTp/MgbIo0rnEB4
         7r3AbTSIs1FJiIa4VuGpvFTXM7LsB8fSetiFXE61y/ypG19w5uR70MAQEVlrxUGdfVob
         2/pKbVV6pUKgCWHmeCWb0/fv/M72MohQa934Q1JHME+J6sCv8CGmqbfc4DCKg2EcrlSQ
         nrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVxRIljlMWj/xaAgQFr2JbubgIjJiWSc0KSUhA2z/UA=;
        b=BFkbC11W9ueLM78G6mu4BmCcxFYeq/4NjR5cof5wPE1dNTI9Aw38l5BDpi/nIPGTqL
         10KDFckaSN2hytF8w+ASQbOTaFKiI+GOaH4E+6u/Bn6E64v/DZt50KV3/nIjivPa7xlC
         fXVkDDTRZfnCQH79MupqaRrCie/kN9flJR89M5OKGTklft2/px8VzTmduJ5Hwgjuaiii
         Kogvbt7wp1LLUgm1PFMQrayamSpHe7K69YflEDr1dkVoA6ReLcsVl5om3O9TDg1ODo0t
         vT9oHPdgbaEaKBX0HKlJ/OWaxDjNRFbhTQDOA934duRUjxaYfrSgx5TSQXvUOpHxwWpA
         uF2A==
X-Gm-Message-State: AOAM532boRqhtim8nG7REVmOmoZEMg8KlFpgw2JZa4g1oidvpN5KYmvn
        plEsjYJae4KkzOJidilj+04=
X-Google-Smtp-Source: ABdhPJzNquVt0QBgGnf9i8u/yXkXvH6j8PoBe0EQei3rCagyJJ4+mT6EFtpQIrBB60QXUPTyBR76VA==
X-Received: by 2002:a05:6512:15d:: with SMTP id m29mr841726lfo.515.1619726999262;
        Thu, 29 Apr 2021 13:09:59 -0700 (PDT)
Received: from localhost.localdomain ([94.103.226.84])
        by smtp.gmail.com with ESMTPSA id f23sm79067lfh.10.2021.04.29.13.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 13:09:58 -0700 (PDT)
Date:   Thu, 29 Apr 2021 23:09:56 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        akpm@linux-foundation.org, peterz@infradead.org, axboe@kernel.dk,
        pmladek@suse.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fill_super
Message-ID: <20210429230956.6ad23897@gmail.com>
In-Reply-To: <YIrnPXJo/n68NrQs@mit.edu>
References: <20210428172828.12589-1-paskripkin@gmail.com>
        <3c3877a4-fef2-9e24-f99f-2ecc46deb7e4@oracle.com>
        <20210429143354.418248a7@gmail.com>
        <YIrnPXJo/n68NrQs@mit.edu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 29 Apr 2021 13:05:01 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Thu, Apr 29, 2021 at 02:33:54PM +0300, Pavel Skripkin wrote:
> > 
> > There is a chance, that kthread_stop() call will happen before
> > threadfn call. It means, that kthread_stop() return value must be
> > checked everywhere, isn't it? Otherwise, there are a lot of
> > potential memory leaks, because some developers rely on the fact,
> > that data allocated for the thread will be freed _inside_ thread
> > function.
> 
> That's not the only potential way that we could leak memory.  Earlier
> in kthread(), if this memory allocation fails,
> 
> 	self = kzalloc(sizeof(*self), GFP_KERNEL);
> 
> we will exit with -ENOMEM.  So at the very least all callers of
> kthread_stop() also need to check for -ENOMEM as well as -EINTR ---
> or, be somehow sure that the thread function was successfully called
> and started.  In this particular case, the ext4 mount code had just
> started the kmmpd thread, and then detected that something else had
> gone wrong, and failed the mount before the kmmpd thread ever had a
> chance to run.

There is a small problem about -ENOMEM:

static int kmmpd(void *data)
{
...
			retval = read_mmp_block(sb, &bh_check, mmp_block);
			if (retval) {
				ext4_error_err(sb, -retval,
					       "error reading MMP data: %d",
					       retval);
				goto exit_thread;
			}
...

exit_thread:
	EXT4_SB(sb)->s_mmp_tsk = NULL;
	kfree(data);
	brelse(bh);
	return retval;
}

read_mmp_block can return -ENOMEM. In this case double free will happen.
I believe, we can change `return retval;` to `return 0;`, because
kthread return value isn't checked anywhere.

What do You think about it? 


With regards,
Pavel Skripkin

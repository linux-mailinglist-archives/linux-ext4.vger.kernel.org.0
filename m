Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF071165668
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 05:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBTEwm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Feb 2020 23:52:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41359 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727806AbgBTEwl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Feb 2020 23:52:41 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01K4qYUN024408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 23:52:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CD0DC4211EF; Wed, 19 Feb 2020 23:52:33 -0500 (EST)
Date:   Wed, 19 Feb 2020 23:52:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200220045233.GC476845@mit.edu>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218170857.GA28774@pc636>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 18, 2020 at 06:08:57PM +0100, Uladzislau Rezki wrote:
> now it becomes possible to use it like: 
> 	...
> 	void *p = kvmalloc(PAGE_SIZE);
> 	kvfree_rcu(p);
> 	...
> also have a look at the example in the mm/list_lru.c diff.

I certainly like the interface, thanks!  I'm going to be pushing
patches to fix this using ext4_kvfree_array_rcu() since there are a
number of bugs in ext4's online resizing which appear to be hitting
multiple cloud providers (with reports from both AWS and GCP) and I
want something which can be easily backported to stable kernels.

But once kvfree_rcu() hits mainline, I'll switch ext4 to use it, since
your kvfree_rcu() is definitely more efficient than my expedient
jury-rig.

I don't feel entirely competent to review the implementation, but I do
have one question.  It looks like the rcutiny implementation of
kfree_call_rcu() isn't going to do the right thing with kvfree_rcu(p).
Am I missing something?

> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 045c28b71f4f..a12ecc1645fa 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -34,7 +34,7 @@ static inline void synchronize_rcu_expedited(void)
>         synchronize_rcu();
>  }
> 
> -static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func, void *ptr)
>  {
>         call_rcu(head, func);
>  }

Thanks,

					- Ted

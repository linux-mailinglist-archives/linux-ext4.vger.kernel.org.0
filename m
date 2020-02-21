Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A20166BA1
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 01:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgBUAah (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 19:30:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbgBUAag (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Feb 2020 19:30:36 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10569206DB;
        Fri, 21 Feb 2020 00:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582245036;
        bh=RZsb+19dMP9oyhRzEECPS41zLUkoUfU11TvMcCoXqUs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Cw5oSTJCfhTBGEVjDJmTunHLXAr0yUBqHRkROpyJKpP4LMdBhz8uh+6zer5s3n3WP
         wqM5ewFpF00dibTnNlnx9W8qoEZNR8RQ1v1JD8OJi4yYvwQiviRQ0Mr1zQh/lAcWqm
         Rbbc/e0HadMIp0lkwziSKo4FVe0slScon9oVscbU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D47F335208E2; Thu, 20 Feb 2020 16:30:35 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:30:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200221003035.GC2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200220045233.GC476845@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220045233.GC476845@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 19, 2020 at 11:52:33PM -0500, Theodore Y. Ts'o wrote:
> On Tue, Feb 18, 2020 at 06:08:57PM +0100, Uladzislau Rezki wrote:
> > now it becomes possible to use it like: 
> > 	...
> > 	void *p = kvmalloc(PAGE_SIZE);
> > 	kvfree_rcu(p);
> > 	...
> > also have a look at the example in the mm/list_lru.c diff.
> 
> I certainly like the interface, thanks!  I'm going to be pushing
> patches to fix this using ext4_kvfree_array_rcu() since there are a
> number of bugs in ext4's online resizing which appear to be hitting
> multiple cloud providers (with reports from both AWS and GCP) and I
> want something which can be easily backported to stable kernels.
> 
> But once kvfree_rcu() hits mainline, I'll switch ext4 to use it, since
> your kvfree_rcu() is definitely more efficient than my expedient
> jury-rig.
> 
> I don't feel entirely competent to review the implementation, but I do
> have one question.  It looks like the rcutiny implementation of
> kfree_call_rcu() isn't going to do the right thing with kvfree_rcu(p).
> Am I missing something?

Good catch!  I believe that rcu_reclaim_tiny() would need to do
kvfree() instead of its current kfree().

Vlad, anything I am missing here?

							Thanx, Paul

> > diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> > index 045c28b71f4f..a12ecc1645fa 100644
> > --- a/include/linux/rcutiny.h
> > +++ b/include/linux/rcutiny.h
> > @@ -34,7 +34,7 @@ static inline void synchronize_rcu_expedited(void)
> >         synchronize_rcu();
> >  }
> > 
> > -static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > +static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func, void *ptr)
> >  {
> >         call_rcu(head, func);
> >  }
> 
> Thanks,
> 
> 					- Ted

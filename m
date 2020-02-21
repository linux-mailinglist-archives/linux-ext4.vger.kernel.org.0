Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25716168848
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 21:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBUUWw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 15:22:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgBUUWv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Feb 2020 15:22:51 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F782072C;
        Fri, 21 Feb 2020 20:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582316570;
        bh=ahbD4YYmAwROEeD/RD10Vgtd8N1y/+y/7hupmWDmF9k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aCBYH5VQ5ofGntUQg6o0sP2cmkdfffm2felA2nX+dv7QarqZwd0nqh1BaMFk/VdBv
         zMx+oWhOk/STDuxu/3p6P7bBvmWmrlYynhZOlNm/LmnQlhgo5WD05exsHQMcFhOKLm
         Uxga8ZPphz+IDakQ+OV2FrajJRjRptZQKuxBWfs4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B65C635226DB; Fri, 21 Feb 2020 12:22:50 -0800 (PST)
Date:   Fri, 21 Feb 2020 12:22:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200221202250.GK2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200220045233.GC476845@mit.edu>
 <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221131455.GA4904@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 21, 2020 at 02:14:55PM +0100, Uladzislau Rezki wrote:
> On Thu, Feb 20, 2020 at 04:30:35PM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 19, 2020 at 11:52:33PM -0500, Theodore Y. Ts'o wrote:
> > > On Tue, Feb 18, 2020 at 06:08:57PM +0100, Uladzislau Rezki wrote:
> > > > now it becomes possible to use it like: 
> > > > 	...
> > > > 	void *p = kvmalloc(PAGE_SIZE);
> > > > 	kvfree_rcu(p);
> > > > 	...
> > > > also have a look at the example in the mm/list_lru.c diff.
> > > 
> > > I certainly like the interface, thanks!  I'm going to be pushing
> > > patches to fix this using ext4_kvfree_array_rcu() since there are a
> > > number of bugs in ext4's online resizing which appear to be hitting
> > > multiple cloud providers (with reports from both AWS and GCP) and I
> > > want something which can be easily backported to stable kernels.
> > > 
> > > But once kvfree_rcu() hits mainline, I'll switch ext4 to use it, since
> > > your kvfree_rcu() is definitely more efficient than my expedient
> > > jury-rig.
> > > 
> > > I don't feel entirely competent to review the implementation, but I do
> > > have one question.  It looks like the rcutiny implementation of
> > > kfree_call_rcu() isn't going to do the right thing with kvfree_rcu(p).
> > > Am I missing something?
> > 
> > Good catch!  I believe that rcu_reclaim_tiny() would need to do
> > kvfree() instead of its current kfree().
> > 
> > Vlad, anything I am missing here?
> >
> Yes something like that. There are some open questions about
> realization, when it comes to tiny RCU. Since we are talking
> about "headless" kvfree_rcu() interface, i mean we can not link
> freed "objects" between each other, instead we should place a
> pointer directly into array that will be drained later on.
> 
> It would be much more easier to achieve that if we were talking
> about the interface like: kvfree_rcu(p, rcu), but that is not our
> case :)
> 
> So, for CONFIG_TINY_RCU we should implement very similar what we
> have done for CONFIG_TREE_RCU or just simply do like Ted has done
> with his
> 
> void ext4_kvfree_array_rcu(void *to_free)
> 
> i mean:
> 
>    local_irq_save(flags);
>    struct foo *ptr = kzalloc(sizeof(*ptr), GFP_ATOMIC);
> 
>    if (ptr) {
>            ptr->ptr = to_free;
>            call_rcu(&ptr->rcu, kvfree_callback);
>    }
>    local_irq_restore(flags);

We really do still need the emergency case, in this case for when
kzalloc() returns NULL.  Which does indeed mean an rcu_head in the thing
being freed.  Otherwise, you end up with an out-of-memory deadlock where
you could free memory only if you had memor to allocate.

> Also there is one more open question what to do if GFP_ATOMIC
> gets failed in case of having low memory condition. Probably
> we can make use of "mempool interface" that allows to have
> min_nr guaranteed pre-allocated pages. 

But we really do still need to handle the case where everything runs out,
even the pre-allocated pages.

							Thanx, Paul

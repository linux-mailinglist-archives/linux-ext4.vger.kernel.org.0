Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0B1161BA6
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Feb 2020 20:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgBQTdc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Feb 2020 14:33:32 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58953 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726781AbgBQTdc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Feb 2020 14:33:32 -0500
Received: from callcc.thunk.org (75-104-88-254.mobility.exede.net [75.104.88.254] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01HJXG2Q007801
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Feb 2020 14:33:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9E1AD4211EF; Mon, 17 Feb 2020 14:33:14 -0500 (EST)
Date:   Mon, 17 Feb 2020 14:33:14 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200217193314.GA12604@mit.edu>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217160827.GA5685@pc636>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 17, 2020 at 05:08:27PM +0100, Uladzislau Rezki wrote:
> Hello, Joel, Paul, Ted. 
> 
> > 
> > Good point!
> > 
> > Now that kfree_rcu() is on its way to being less of a hack deeply
> > entangled into the bowels of RCU, this might be fairly easy to implement.
> > It might well be simply a matter of a function pointer and a kvfree_rcu()
> > API.  Adding Uladzislau Rezki and Joel Fernandez on CC for their thoughts.
> > 
> I think it makes sense. For example i see there is a similar demand in
> the mm/list_lru.c too. As for implementation, it will not be hard, i think. 
> 
> The easiest way is to inject kvfree() support directly into existing kfree_call_rcu()
> logic(probably will need to rename that function), i.e. to free vmalloc() allocations
> only in "emergency path" by just calling kvfree(). So that function in its turn will
> figure out if it is _vmalloc_ address or not and trigger corresponding "free" path.

The other difference between ext4_kvfree_array_rcu() and kfree_rcu()
is that kfree_rcu() is a magic macro which frees a structure, which
has to contain a struct rcu_head.  In this case, I'm freeing a pointer
to set of structures, or in another case, a set of buffer_heads, which
do *not* have an rcu_head structure.

> struct test_kvfree_rcu {
>        unsigned char array[PAGE_SIZE * 2];
>        struct rcu_head rcu;
> };

I suspect I'd still want to use the ext4_kfree_array_rcu(), for a
couple of reasons.  First of all, the array is variably sized.  So we
don't know how big it is.  That could be fixed via something like 

struct test_kvfree_rcu {
       struct rcu_head rcu;
       struct test_s [];
};

... but the other issue is that we have code where we have arrays of
arrays, e.g.:

	struct ext4_group_info ***s_group_info;

which is an array of array of pointers to ext4_group_info.  Trying to
cram in the rcu_head makes the code more complicated --- and also,
resizing file systems is something that happens often, and I don't
want to optimize it by keeping rcu_head structs around all the time.

This is why at least for *this* use case, it's actually better to
allocate temp array just before callig call_rcu(), and if I can't
allocate it due to memory pressure, we'll it's OK to use
synchronize_rcu() followed by kvfree().

Cheers,

						- Ted

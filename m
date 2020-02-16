Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A116065A
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Feb 2020 21:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgBPUdG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Feb 2020 15:33:06 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54942 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbgBPUdG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Feb 2020 15:33:06 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01GKWwoU016290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Feb 2020 15:32:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 27A3342032C; Sun, 16 Feb 2020 15:32:58 -0500 (EST)
Date:   Sun, 16 Feb 2020 15:32:58 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200216203258.GE566898@mit.edu>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216121246.GG2935@paulmck-ThinkPad-P72>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Feb 16, 2020 at 04:12:46AM -0800, Paul E. McKenney wrote:
> > +void ext4_kvfree_array_rcu(void *to_free)
> > +{
> > +	struct ext4_rcu_ptr *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
> > +
> > +	if (ptr) {
> > +		ptr->ptr = to_free;
> > +		call_rcu(&ptr->rcu, ext4_rcu_ptr_callback);
> > +		return;
> > +	}
> > +	synchronize_rcu();
> > +	kvfree(ptr);
> > +}

Whoops, that last statement should be kvfree(to_free), of course.
I'll fix that up in my tree.

		     	      	       - Ted

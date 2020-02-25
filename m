Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24CC16B78E
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 03:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgBYCLe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 21:11:34 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43400 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgBYCLe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Feb 2020 21:11:34 -0500
Received: by mail-qk1-f194.google.com with SMTP id p7so10599893qkh.10
        for <linux-ext4@vger.kernel.org>; Mon, 24 Feb 2020 18:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mtENMlJAZmFo3hgkNlhKi1IslvUQRA06IrMNjYVS8tI=;
        b=uMkid5thEz9LaTZqeZ1Kn68N0wqffDNu1o4VWGnZApNj5zC7JnKm16DxQBSj2QXkeF
         R+WQfi6bZ5M6h8j1Wx+G8VqWvGDk5Dg2yqqK+sTnG5dPC6Cf1ryHk/C/6lSUq6RkRufV
         NIfsI9DmvlMFZ5ku5VT8V8tSG/NjVL63Yoxgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mtENMlJAZmFo3hgkNlhKi1IslvUQRA06IrMNjYVS8tI=;
        b=Iy9eRnPyeE0Lo63I75x2E9wmhtVeyXXjk+OP2i/Hp4KFcjcMzzggYNmlys3Ecev1zh
         cdMhuQ/bzQJFriuv+yRj9GL+Pm65xFn+2Mv5WKcrhpVf5XiFuk5ZsG4eQANLICGEIuco
         5dEjgegL72RHcUmcFh+9qPpcW79oh1F7up7dIKS3HN2Kren1ICoPNtC3W7cAbW6F3dXO
         i9DTmu45ZUxFtxURhNayt5gxnNLDDyZUnQZ9cttLy1ZgMYUfHCtd4NeL6BVKTjw2fYG1
         JmHZTZKcBjdgHCpUfGX8GaMsA27mGCQN2RSyc3yVbReku2p1ClsEtH/gtTueSSSRx5oI
         2gzw==
X-Gm-Message-State: APjAAAVmwmoFTGsAnL2JaqOmNpvl2hGyD5R1xbPoZT1gotz1GT1euaEd
        XiearwTHTvfX9DVb9rUwINSw3Q==
X-Google-Smtp-Source: APXvYqyo/AHOHks3iLCwaFh1zbfqOtfQEjQ0qQFTdT9FJaGz5646eiDKpGgbV3lLlImiH+rhJY2GEQ==
X-Received: by 2002:a37:2f07:: with SMTP id v7mr50554065qkh.261.1582596693049;
        Mon, 24 Feb 2020 18:11:33 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w2sm6858994qto.73.2020.02.24.18.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 18:11:32 -0800 (PST)
Date:   Mon, 24 Feb 2020 21:11:31 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200225021131.GC253171@google.com>
References: <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200220045233.GC476845@mit.edu>
 <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223011018.GB2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 22, 2020 at 05:10:18PM -0800, Paul E. McKenney wrote:
[...] 
> > I was thinking a 2 fold approach (just thinking out loud..):
> > 
> > If kfree_call_rcu() is called in atomic context or in any rcu reader, then
> > use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
> > queue that.
> > 
> > Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
> > synchronize_rcu() inline with it.
> > 
> > Use preemptible() andr task_struct's rcu_read_lock_nesting to differentiate
> > between the 2 cases.
> > 
> > Thoughts?
> 
> How much are we really losing by having an rcu_head in the structure,
> either separately or unioned over other fields?

It does seem a convenient API at first glance. Also seems like there are a
number of usecases now (ext4, vfree that Vlad mentioned, and all the other
users he mentioned, etc).

> > > > Also there is one more open question what to do if GFP_ATOMIC
> > > > gets failed in case of having low memory condition. Probably
> > > > we can make use of "mempool interface" that allows to have
> > > > min_nr guaranteed pre-allocated pages. 
> > > 
> > > But we really do still need to handle the case where everything runs out,
> > > even the pre-allocated pages.
> > 
> > If *everything* runs out, you are pretty much going to OOM sooner or later
> > anyway :D. But I see what you mean. But the 'tradeoff' is RCU can free
> > head-less objects where possible.
> 
> Would you rather pay an rcu_head tax (in cases where it cannot share
> with other fields), or would you rather have states where you could free
> a lot of memory if only there was some memory to allocate to track the
> memory to be freed?

Depends on the usecase we could use the right API.

> But yes, as you suggested above, there could be an API similar to the
> userspace RCU library's API that usually just queues the callback but
> sometimes sleeps for a full grace period.  If enough people want this,
> it should not be hard to set up.

Sounds good!

thanks,

 - Joel


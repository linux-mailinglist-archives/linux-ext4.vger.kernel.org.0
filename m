Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914FB167E31
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 14:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBUNPG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 08:15:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38038 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgBUNPG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 08:15:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so1458851lfm.5;
        Fri, 21 Feb 2020 05:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CaDjJtC85YNtsj2xpF6xVXxkswCcqeIPuJeW2JV6kJw=;
        b=HqVYXx0ZjkswM+ia3xZW3JJp3IJeX/Iv+EGyg6DWVfYYZ7SgXw1NJHeRw8YjmUZ/T/
         qUcct2FWztWnBnrkOvrQl98MGqKzRZJa5shEHFUgZa77W4+U9hGi5CNrzaHKbqhlB9OX
         tLi144JkGdZUkWFxzbLjzdDlOVsQI6Fs5vxrSOnTFdpLLC2Vj0IVlstSPEKRo65TwTNI
         gUVYldOlVDhvbGJWJgwHey7kMXnSCzho796VTAkxPmzpDr6okfW6AiWoG2WQSBjoSX1c
         6QiLDNsjoWBLM997hJsD7gdArE4/f39W9Wwr/Dx4445TPzc11byaRVZWspFYU6+mMCV5
         4xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CaDjJtC85YNtsj2xpF6xVXxkswCcqeIPuJeW2JV6kJw=;
        b=HgMYLFd421J5jBX/Ii5VLqQtTPqpKKKXqfGe8BUOhqpmykddMXG8GjtfAvZcfqXRyt
         rvCg3vQHoqUUOrfW+eSvSY6x7XDu4KTu/QPWUMMnPtpfl0mx3d97emsK804IF15rJvik
         NMVQCdLxNsLTxslYs/KLL++g42Oumf084FNHVBsQ0O1v25BKVjPc2EAT3i+pSUDKncwp
         z4wbsLcG810usDXzt/EOgj7XKQsHkLgEvJhqWxM1XPokBRySGLsoob/n4enS3wzkD0VI
         3ME/iLjRC0HxrcFjsBJaUPrONkZcQApHy+UFwF6qHePB5uHeSYZONDDoC5A4NWfFlBFm
         he4Q==
X-Gm-Message-State: APjAAAVVQV3KYBMooQ59U4BOvg3mfTH636iU91sJ3JqGZBukj2u+/dLE
        MIHOAMm4j9gdccfb490/IdE=
X-Google-Smtp-Source: APXvYqxbwMkLt2Grc+dtAOcGWx2e7gf5I6J0o52FKlWia8hqKn8FOfNkjSIarfoANstubV2LtsSf3w==
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr20028529lfp.162.1582290903887;
        Fri, 21 Feb 2020 05:15:03 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id u7sm1672921lfn.31.2020.02.21.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 05:15:03 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 21 Feb 2020 14:14:55 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200221131455.GA4904@pc636>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200220045233.GC476845@mit.edu>
 <20200221003035.GC2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221003035.GC2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 20, 2020 at 04:30:35PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2020 at 11:52:33PM -0500, Theodore Y. Ts'o wrote:
> > On Tue, Feb 18, 2020 at 06:08:57PM +0100, Uladzislau Rezki wrote:
> > > now it becomes possible to use it like: 
> > > 	...
> > > 	void *p = kvmalloc(PAGE_SIZE);
> > > 	kvfree_rcu(p);
> > > 	...
> > > also have a look at the example in the mm/list_lru.c diff.
> > 
> > I certainly like the interface, thanks!  I'm going to be pushing
> > patches to fix this using ext4_kvfree_array_rcu() since there are a
> > number of bugs in ext4's online resizing which appear to be hitting
> > multiple cloud providers (with reports from both AWS and GCP) and I
> > want something which can be easily backported to stable kernels.
> > 
> > But once kvfree_rcu() hits mainline, I'll switch ext4 to use it, since
> > your kvfree_rcu() is definitely more efficient than my expedient
> > jury-rig.
> > 
> > I don't feel entirely competent to review the implementation, but I do
> > have one question.  It looks like the rcutiny implementation of
> > kfree_call_rcu() isn't going to do the right thing with kvfree_rcu(p).
> > Am I missing something?
> 
> Good catch!  I believe that rcu_reclaim_tiny() would need to do
> kvfree() instead of its current kfree().
> 
> Vlad, anything I am missing here?
>
Yes something like that. There are some open questions about
realization, when it comes to tiny RCU. Since we are talking
about "headless" kvfree_rcu() interface, i mean we can not link
freed "objects" between each other, instead we should place a
pointer directly into array that will be drained later on.

It would be much more easier to achieve that if we were talking
about the interface like: kvfree_rcu(p, rcu), but that is not our
case :)

So, for CONFIG_TINY_RCU we should implement very similar what we
have done for CONFIG_TREE_RCU or just simply do like Ted has done
with his

void ext4_kvfree_array_rcu(void *to_free)

i mean:

   local_irq_save(flags);
   struct foo *ptr = kzalloc(sizeof(*ptr), GFP_ATOMIC);

   if (ptr) {
           ptr->ptr = to_free;
           call_rcu(&ptr->rcu, kvfree_callback);
   }
   local_irq_restore(flags);

Also there is one more open question what to do if GFP_ATOMIC
gets failed in case of having low memory condition. Probably
we can make use of "mempool interface" that allows to have
min_nr guaranteed pre-allocated pages. 

Thanks!

--
Vlad Rezki

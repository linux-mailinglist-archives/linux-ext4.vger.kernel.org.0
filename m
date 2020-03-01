Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5199F174D13
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2020 13:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgCAMHO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Mar 2020 07:07:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37906 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCAMHO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 1 Mar 2020 07:07:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id u9so2144299wml.3;
        Sun, 01 Mar 2020 04:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g2L1+KgmlL2UuREJ51pRnap9NUM12a+0vrG5ju6s47k=;
        b=cm++SacgY/WsKGaPbcOuT0Uwowg2582zZnNETSWcg7edGvMYVSSMxWSHsyWIHFhGge
         EsjQHldCUqk8Csufplp/EdsNhunbc782WqkC2xOvj556FWgINUyipxApg6A4RwkcDrVk
         pfsxvvw6TCDDM9O4gw/ARz71Vm+0QLYI6lFLQxHfJ4KEfyJU1fn07pr5L7wOxgidcPlJ
         VGKed0Luc1UifI0XW+2kPGClgdke6ZMePUCgpREl7hoXXbZGDI2zt8uEy9kltORrzi6S
         NypIzMkLgdTe+7dJvrvgxAFbeig7XYsHVmvW7MgQ2KcUsLwTlFBVxuZxVjJIvN6CUe1y
         /6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g2L1+KgmlL2UuREJ51pRnap9NUM12a+0vrG5ju6s47k=;
        b=jyelyGe1ZIdf4KmiooVlQ2rbKM/IMCM/AXBtJLAVn8FmZWuSmO5HblCyPNQPDDV/JG
         6dAqMDyuZDWB1htgJ/sy9akq0IMSmJloSjcvQJKq/Vt28tjj9pzUY9cNpHAI98ePCpEE
         iSjNUixbuE2kJbUvJMoJF6OCvU9pcjZ1+Za8QUgdgBy0PdzQQj+qESC87Rfr+F2TShUc
         a+DKaDjo7ptDrB7SNSmWhXqbvzZ3ARALDUb5FPt6h3iyi9tvIe/6gsSLaqM39rPBuj6w
         qTaP3+KU6o5Qt35rjdqWKmNcgdIY1/LyyWOFALLiigTLX92xFJqKwe0toaB7y2f80zYV
         J1gQ==
X-Gm-Message-State: APjAAAVv/ZK+jAJlzC7SaK4YhrluQvMDVWNdbMI0VJghQPEDAM00D5VR
        DamDQHJDgPbEUsxPw3OlFis=
X-Google-Smtp-Source: APXvYqy0flgkNWK99Sh4Q9TC6qt7uHB70U67xM9RkQ7KeAdzHLtey5dLusC0mHMn/2ouDgJTx5PauA==
X-Received: by 2002:a05:600c:149:: with SMTP id w9mr13676684wmm.132.1583064432518;
        Sun, 01 Mar 2020 04:07:12 -0800 (PST)
Received: from pc636 ([80.122.78.78])
        by smtp.gmail.com with ESMTPSA id x8sm9727390wro.55.2020.03.01.04.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 04:07:11 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 1 Mar 2020 13:07:02 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200301120702.GA9762@pc636>
References: <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636>
 <20200225020705.GA253171@google.com>
 <20200225185400.GA27919@pc636>
 <20200227133700.GC161459@google.com>
 <20200301110843.GA8725@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301110843.GA8725@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> > > So in CONFIG_PREEMPT kernel we can identify if we are in atomic or not by
> > > using rcu_preempt_depth() and in_atomic(). When it comes to !CONFIG_PREEMPT
> > > then we skip it and consider as atomic. Something like:
> > > 
> > > <snip>
> > > static bool is_current_in_atomic()
> > 
> > Would be good to change this to is_current_in_rcu_reader() since
> > rcu_preempt_depth() does not imply atomicity.
> >
> can_current_synchronize_rcu()? If can we just call:
> 
> <snip>
>     synchronize_rcu() or synchronize_rcu_expedited();
>     kvfree();
> <snip>
> 
> > > {
> > > #ifdef CONFIG_PREEMPT_RCU
> > >     if (!rcu_preempt_depth() && !in_atomic())
> > >         return false;
> > 
> > I think use if (!rcu_preempt_depth() && preemptible()) here.
> > 
> > preemptible() checks for IRQ disabled section as well.
> > 
> Yes but in_atomic() does it as well, it also checks other atomic
> contexts like softirq handlers and NMI ones. So calling there
> synchronize_rcu() is not allowed.
> 
Ahh. Right you are. We also have to check if irqs are disabled
or not. preemptible() has to be added as well.

<snip>
can_current_synchronize_rcu()
{
    if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
        if (!rcu_preempt_depth() && !in_atomic() && preemptible()) {
            might_sleep();
            return true;
	}
    }

    return false;
}
<snip>

if we can synchronize:
    - we can directly inline kvfree() to current context;
    - we can attached the head using GFP_KERNEL | __GFP_RETRY_MAYFAIL.
    
Otherwise attached the rcu_head under atomic or as we are in RCU reader section.

Thoughts?

--
Vlad Rezki

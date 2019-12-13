Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E625811EE61
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Dec 2019 00:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLMXTl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Dec 2019 18:19:41 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:44260 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfLMXTl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Dec 2019 18:19:41 -0500
Received: by mail-pj1-f67.google.com with SMTP id w5so348879pjh.11
        for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2019 15:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j4OUDi2GWFJr1GQx/XFXLfcptMVLhYOJn6klY92aaOQ=;
        b=SVp8rLnx0teNHRRRm0PRHhUwbvbRCM2wy4jSFOelIlvzDVLv9yNq2vjqZ1mN3mlpOH
         k1bgyxh7/bfJ0EkseK7VPY358DRrjePvhtWMdW9sdeT2ilrvA+tm4CRWplh4/XbECcwH
         wsISc6Usvxqj6Ws7YK0R2/K0qpmR9IABVcmMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j4OUDi2GWFJr1GQx/XFXLfcptMVLhYOJn6klY92aaOQ=;
        b=OiI595Wh1ZkL1zRVV6UsA9hb0Kr0iDhrDbrNELxLqAkwLYlri6VVPsCNGxI6teWonz
         HanYRLaT0kFDXMXpYPCKu03zZBumV0bWmOfjaJ5Tc48vHk/J5PJOSTVDyhLZH8ukji3i
         STxO0fuCt+/D4zb9KSUkuHIMIWJ7tmLuMHdu4fVEKaupxmDSuCuwVMbZCPnlhFtGvYWP
         sy5clOPXVZQuhtAhB9axutsjwJO/y+ON/959afUHoiDU0BDARGLGKfqyiaDvWbG2TuAd
         5llhlcmZqiuB/Suc2pnF4qMgjegDaxH62qlgDoyDjs2KYymaLlBoi55RVe8koh5VIkCF
         i4Bw==
X-Gm-Message-State: APjAAAUQHo3ACzMVsYsWSqJN36RIlBCdXbMm1mmtCM2rpn9RUApmkQgh
        Qe4fJMmJa1toYTWcovkyVn0T3g==
X-Google-Smtp-Source: APXvYqwADL/M0/ouoqApRJjUcc6YwgsphiZr/cd/UqkDLYm8PsIjyhK3SpK4rAoR9Z/WqwufIc40Ig==
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr2287765pjt.131.1576279180818;
        Fri, 13 Dec 2019 15:19:40 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a26sm13060069pfo.5.2019.12.13.15.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:19:40 -0800 (PST)
Date:   Fri, 13 Dec 2019 18:19:39 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Phong Tran <tranmanphong@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu <rcu@vger.kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: [PATCH V2] ext4: use rcu API in debug_print_tree
Message-ID: <20191213231939.GB195887@google.com>
References: <20191213113510.GG15474@quack2.suse.cz>
 <20191213153306.30744-1-tranmanphong@gmail.com>
 <CAEXW_YQwrM6=u1gsij-5SL5+2n9Pk9HFEYdF_JWYjitLvr7Dcg@mail.gmail.com>
 <20191213194943.GA959@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213194943.GA959@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 13, 2019 at 08:49:43PM +0100, Jan Kara wrote:
> On Fri 13-12-19 10:11:50, Joel Fernandes wrote:
> > On Fri, Dec 13, 2019 at 7:39 AM Phong Tran <tranmanphong@gmail.com> wrote:
> > >
> > > struct ext4_sb_info.system_blks was marked __rcu.
> > > But access the pointer without using RCU lock and dereference.
> > > Sparse warning with __rcu notation:
> > >
> > > block_validity.c:139:29: warning: incorrect type in argument 1 (different address spaces)
> > > block_validity.c:139:29:    expected struct rb_root const *
> > > block_validity.c:139:29:    got struct rb_root [noderef] <asn:4> *
> > >
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> > 
> > Thanks Phong! Looks like a real bug fix caught thanks to Sparse. So
> > let us mark for stable as well?
> 
> Well, not really. The code is active only with CONFIG_EXT4_DEBUG enabled
> and in this case there's no race with remount (and thus sbi->system_blks
> changing) possible. So the change is really only to silence the sparse
> warning.

Ok, thanks for clarifying.

-Joel

> 
> 								Honza
> 
> > 
> > - Joel
> > 
> > > ---
> > >  fs/ext4/block_validity.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > ---
> > > change log:
> > > V2: Add Reviewed-by: Jan Kara <jack@suse.cz>
> > >
> > > diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> > > index d4d4fdfac1a6..1ee04e76bbe0 100644
> > > --- a/fs/ext4/block_validity.c
> > > +++ b/fs/ext4/block_validity.c
> > > @@ -133,10 +133,13 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
> > >  {
> > >         struct rb_node *node;
> > >         struct ext4_system_zone *entry;
> > > +       struct ext4_system_blocks *system_blks;
> > >         int first = 1;
> > >
> > >         printk(KERN_INFO "System zones: ");
> > > -       node = rb_first(&sbi->system_blks->root);
> > > +       rcu_read_lock();
> > > +       system_blks = rcu_dereference(sbi->system_blks);
> > > +       node = rb_first(&system_blks->root);
> > >         while (node) {
> > >                 entry = rb_entry(node, struct ext4_system_zone, node);
> > >                 printk(KERN_CONT "%s%llu-%llu", first ? "" : ", ",
> > > @@ -144,6 +147,7 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
> > >                 first = 0;
> > >                 node = rb_next(node);
> > >         }
> > > +       rcu_read_unlock();
> > >         printk(KERN_CONT "\n");
> > >  }
> > >
> > > --
> > > 2.20.1
> > >
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

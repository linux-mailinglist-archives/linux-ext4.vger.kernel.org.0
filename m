Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CA3343798
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Mar 2021 04:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVDrd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 23:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhCVDrb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 21 Mar 2021 23:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616384851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9kawU6n1KhxJBXq1O64HGcGvrwxvRhP2Qm/bXTivEA=;
        b=NZySUY1dW/z3ks4fGlfv9buaLV67/TVmeKVU+AWT6LJjKnCxMtpfbOMpZpMrYgamUrhNY+
        Q5VUd3vEkEOcou8+TCozzw+7mtYccm8s/HKe0ilBUENcCSXP+QuhvxqoQgMR5LXbJj9evT
        fPFGYhTNvvMEkK4wsIGm4Zd0SNfLKAs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-BcbhhSKNNSKlDoKqiQuDdA-1; Sun, 21 Mar 2021 23:47:29 -0400
X-MC-Unique: BcbhhSKNNSKlDoKqiQuDdA-1
Received: by mail-pl1-f200.google.com with SMTP id x7so26246627plg.18
        for <linux-ext4@vger.kernel.org>; Sun, 21 Mar 2021 20:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y9kawU6n1KhxJBXq1O64HGcGvrwxvRhP2Qm/bXTivEA=;
        b=iAgWsy+//eRZ6n2Z7m7yDainDaZV0pjVag+b735kaX9qtz9a6T84bf827Y6qk6RcTN
         U+Kk2socilSLdaabfIl1XRYx1pj/QIdFFoP+lhbIg1b0TR4US5wA8t1P5QsjTOi3LNLg
         bcfnPKnwc78fKlywi5gM6mG5VRiDDxBHE1/njn/f0qfg/LwLme3wlFiz5SSJVWH2oDGF
         R6Hb76o6D6rTd07AqINTh4ZhtRzDw5Jq6e6WACBqRyGCmWneSVL9uipcb9vkvr8VG0+t
         uAbt6dyxfTFNxqoiiUCtKyfwL/P4zBb2dSsbSk7kOcFJrRroaCbEWWSbXMTKOhCDQJHp
         B2cQ==
X-Gm-Message-State: AOAM530KA5Dezx/8k6K/xxlpRU+vZp0WWGyRX3jYPIfyXuA3yki3SXz7
        u+M7u9uVF1KkmqOCKL+/gezGmpqcF0X+/Wev9i18EuSlxTMteclYhufuUwmGjNEOz/FYB96Y/M1
        YfzQxfDU9h/5GTbQv2but+w==
X-Received: by 2002:a17:90a:17c3:: with SMTP id q61mr10714084pja.58.1616384848550;
        Sun, 21 Mar 2021 20:47:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLB8VuWu6DqX0e7uTk+HF2/TnK6sA7AMpTdCiTKQKDuIsxD0l1C3UVhIUT/i6ixUzwNjkM8w==
X-Received: by 2002:a17:90a:17c3:: with SMTP id q61mr10714071pja.58.1616384848271;
        Sun, 21 Mar 2021 20:47:28 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v134sm11785903pfc.182.2021.03.21.20.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 20:47:27 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:47:17 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ext4 fixes for v5.12
Message-ID: <20210322034717.GA1937141@xiangao.remote.csb>
References: <YFeQ9eBFn5JELyYo@mit.edu>
 <CAHk-=wjahvxdYmEgZEOqSSOVdTP-Njqbh6e8=PDVtt4Md7qHNg@mail.gmail.com>
 <ca33cb6a-9be9-1a2c-efa3-1dc5996897f6@huawei.com>
 <20210322030513.GA1925732@xiangao.remote.csb>
 <YFgQqjkSmCmvZ7LK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFgQqjkSmCmvZ7LK@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Mar 21, 2021 at 11:36:10PM -0400, Theodore Ts'o wrote:
> On Mon, Mar 22, 2021 at 11:05:13AM +0800, Gao Xiang wrote:
> > I think the legel name would be "Zhang Yi" (family name goes first [1])
> > according to
> > The Chinese phonetic alphabet spelling rules for Chinese names [2].
> > 
> > Indeed, that is also what the legel name is written in alphabet on our
> > passport or credit/debit cards.
> > 
> > Also, many official English-written materials use it in that way, for
> > example, a somewhat famous bastetball player Yao Ming [3][4][5].
> > 
> > That is what I wrote my own name as this but I also noticed the western
> > ordering of names is quite common for Chinese people in Linux kernel.
> > Anyway, it's just my preliminary personal thought (might be just my
> > own perference) according to (I think, maybe) formal occasions.
> 

Hi Ted,

> Yeah, there doesn't seem to be a lot of consistency with the ordering
> of Chinese names when they are written in Roman characters.  Some
> people put the family name first, and other people will put the
> personal (first) name first.  In some cases it may be because the
> developer in question is living in America, and so they've decided to
> use the American naming convention.  (Two example of this are former
> ext4 developers Mingming Cao and Jiaying Zhang, who live in Portland
> and Los Angelos, and their family names are Cao and Zhang,
> respectively.)

Yes, totally agree. I think that's all our own perference honestly
(yet just showed some local official materials though.)

> 
> My personal opinion is people should use whatever name they are
> comfortable with, using whatever characters they prefer.  The one

Totally agree.

> thing that would be helpful for me is for people to give a hint about
> how they would prefer to be called --- for example, would you prefer
> that start an e-mail with the salutation, "Hi Gao", "Hi Xiang", or "Hi
> Gao Xiang"?

Honestly, I think either way would be fine on this even in Chinese
speaking environment...

> 
> And if I don't know, and I guess wrong, please feel free to correct
> me, either privately, or publically on the e-mail list, if you think
> it would be helpful for more people to understand how you'd prefer to
> be called.

Nope, it's just a minor stuff though. I didn't tend to give any direct/
indirect opinion or hint on this. Sorry about that if some misleading :)

Thanks,
Gao Xiang

> 
> Cheers,
> 
> 					- Ted
> 


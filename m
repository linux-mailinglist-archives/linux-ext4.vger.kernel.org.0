Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8450E343C26
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Mar 2021 09:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCVI4M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Mar 2021 04:56:12 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:59746 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCVI4B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Mar 2021 04:56:01 -0400
Received: from localhost (kaktus.kanapka.ml [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id C91DF9EFE09;
        Mon, 22 Mar 2021 09:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1616403354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xSJ5Ap+46km1aE8osAQyVANKaDuVxgcRqcTd8szaIaU=;
        b=gyjnP6aH/3aA4JB07GBqsIly5SLW1zbnBD3EenNf47HzhdL/z3RBQQ7D36zGqhtq2m/144
        IAecKhZnEROQvlWhPt8LG+gRjS/uW8IZzjAEDKgrZDv4qXkTKBx+JRoRVGIFacCqVIsvZy
        VmDcyiAgqfwmPXwZqNakCTtKON5wJBk=
Date:   Mon, 22 Mar 2021 09:55:54 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Gao Xiang <hsiangkao@redhat.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ext4 fixes for v5.12
Message-ID: <20210322085554.rlnehum5gklvjrzv@spock.localdomain>
References: <YFeQ9eBFn5JELyYo@mit.edu>
 <CAHk-=wjahvxdYmEgZEOqSSOVdTP-Njqbh6e8=PDVtt4Md7qHNg@mail.gmail.com>
 <ca33cb6a-9be9-1a2c-efa3-1dc5996897f6@huawei.com>
 <20210322030513.GA1925732@xiangao.remote.csb>
 <YFgQqjkSmCmvZ7LK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFgQqjkSmCmvZ7LK@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi.

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
> Yeah, there doesn't seem to be a lot of consistency with the ordering
> of Chinese names when they are written in Roman characters.  Some
> people put the family name first, and other people will put the
> personal (first) name first.  In some cases it may be because the
> developer in question is living in America, and so they've decided to
> use the American naming convention.  (Two example of this are former
> ext4 developers Mingming Cao and Jiaying Zhang, who live in Portland
> and Los Angelos, and their family names are Cao and Zhang,
> respectively.)
> 
> My personal opinion is people should use whatever name they are
> comfortable with, using whatever characters they prefer.  The one
> thing that would be helpful for me is for people to give a hint about
> how they would prefer to be called --- for example, would you prefer
> that start an e-mail with the salutation, "Hi Gao", "Hi Xiang", or "Hi
> Gao Xiang"?

Is there a common way to indicate that? Like, erm, SPDX, but for names?

Saying, instead of just writing "Oleksandr Natalenko" in the email
footer, I'll write "Oleksandr Natalenko / RMNA:NS" meaning "read my name
as name-surname".

Hm?

> 
> And if I don't know, and I guess wrong, please feel free to correct
> me, either privately, or publically on the e-mail list, if you think
> it would be helpful for more people to understand how you'd prefer to
> be called.
> 
> Cheers,
> 
> 					- Ted

-- 
  Oleksandr Natalenko (post-factum)

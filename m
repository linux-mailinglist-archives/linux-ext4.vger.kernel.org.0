Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C86434371D
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Mar 2021 04:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCVDGE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 23:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229871AbhCVDFg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 21 Mar 2021 23:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616382335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H18Krr3VPi3XrnC8v8eoUvklLwifS/IayqlYwzdzwmk=;
        b=MaJ28OE+5iKBGPUsjd2R4hHG/BT0YbywT2RasllrZf1XJPpYG0e2KLtqVFrWTj6byzsd5r
        75hpZN4nu9k8tr1HdQUQqFBwonYqbQ6VfK6dk5PMf0aeEvU9p58GhF28fHBinCwrYduY63
        S5i8xDzh6kQgy0QA7WEtsnH6Of9AYMc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-Fc9r7vFdNf6xC14ovqiA9A-1; Sun, 21 Mar 2021 23:05:25 -0400
X-MC-Unique: Fc9r7vFdNf6xC14ovqiA9A-1
Received: by mail-pj1-f69.google.com with SMTP id z21so26071772pjt.0
        for <linux-ext4@vger.kernel.org>; Sun, 21 Mar 2021 20:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H18Krr3VPi3XrnC8v8eoUvklLwifS/IayqlYwzdzwmk=;
        b=iFamZ8TPsFabhLwdvAJiqC69tMVSXyemnc42pa9UIgO8At3Ab8nYJvSUXpbLJy7vIK
         n+OK/EPImd95wgkDkjMpGkrU92H+BWhLt+ElJvUepNR1kxSHkKjJ/xuzQfhG4Xe/yV7U
         z8OUzcwlo9uhiwdOBkQUKNT2ngUx5zLF6kSKUvWYXCUXIHQAZbeIwT5UlGuNglW/b3DN
         3XQGKd0iWCUl46c2sTd5k2JrBbdG7tkqOJkjgxuCM+k58izy6jm0BsW1ZPCJubytdZVG
         OFEjN7UKum4tpYYw65niGv1nDP69XsKrnUQUuJ2segKi51cRuqsJOSi1Uo5kIQWntwzt
         DT9A==
X-Gm-Message-State: AOAM532/4qaX8qN1lK7LK7GjQXynpotn0HRI+Cm6T0dEPAo0DG/PgW2+
        TANusVSISnr1k6RcfNx0F3QlDsabogH7QEX8gUHc/Q2Bk5O7shrqpMYp4nxE6biOeuBocBT7XnR
        maCTRCLav5MSI2cAtBkJN2w==
X-Received: by 2002:a63:181c:: with SMTP id y28mr20697451pgl.175.1616382324708;
        Sun, 21 Mar 2021 20:05:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLB6nUelZG5bkxlZC/d+7zAwvMJEUb0ZmhwiHWMk4RN2AZheqJT7FUr403d9oYlXR980YnuA==
X-Received: by 2002:a63:181c:: with SMTP id y28mr20697438pgl.175.1616382324457;
        Sun, 21 Mar 2021 20:05:24 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l19sm11694616pjt.16.2021.03.21.20.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 20:05:24 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:05:13 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ext4 fixes for v5.12
Message-ID: <20210322030513.GA1925732@xiangao.remote.csb>
References: <YFeQ9eBFn5JELyYo@mit.edu>
 <CAHk-=wjahvxdYmEgZEOqSSOVdTP-Njqbh6e8=PDVtt4Md7qHNg@mail.gmail.com>
 <ca33cb6a-9be9-1a2c-efa3-1dc5996897f6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca33cb6a-9be9-1a2c-efa3-1dc5996897f6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 22, 2021 at 09:33:54AM +0800, zhangyi (F) wrote:
> On 2021/3/22 6:23, Linus Torvalds wrote:
> > On Sun, Mar 21, 2021 at 11:31 AM Theodore Ts'o <tytso@mit.edu> wrote:
> >>
> >> zhangyi (F) (3):
> >>       ext4: find old entry again if failed to rename whiteout
> >>       ext4: do not iput inode under running transaction in ext4_rename()
> >>       ext4: do not try to set xattr into ea_inode if value is empty
> > 
> > Side note: this is obviously entirely up to the author, but I think it
> > would be nice if we would encourage people to use their native names
> > if/when they want to.
> > 
> > Maybe this "zhangyi (F)" is how they _want_ to write their name in the
> > kernel, and that's obviously fine if so.
> > 
> > But at the same time, coming from Finland, I remember how people who
> > had the "odd" characters (Ã¥Ã¤Ã¶) in their name ended up replacing them
> > with the US-ASCII version (generally "aa" "ae" and "oe"), and it
> > always just looked bad to a native speaker. Particularly annoying in
> > public contexts.
> > 
> > At the same time, for the same reason, I can also understand people
> > not wanting to even expose those characters at all, because then
> > non-native speakers invariably messed it up even worse...
> > 
> > Anyway, I think and hope that we have the infrastructure to do it
> > right not just for Latin1, but the more complex non-Western character
> > sets too.
> > 
> > And as a result should possibly encourage people to use their native
> > names if they want to. At least make people aware that it _should_
> > work.
> > 
> > Again, maybe I'm barking up the wrong tree, and in this case "zhangyi
> > (F) <yi.zhang@huawei.com>" is just what zhangyi prefers simply because
> > it's easier/more convenient.
> > 
> > But I just wanted to mention it, because we _do_ have examples of it
> > working. Not many, but some:
> > 
> >     git log --pretty="%an" --since=2.years | sort -u | tail
> > 
> > including examples of having the Westernized name in parenthesis for
> > the "use that one if you can't do the real one" case..
> > 
> Hi, Linus.
> 
> I will use my real name "Yi Zhang" next time.

er.. Try to comment my thoughts about this a bit... just random noise.

I think the legel name would be "Zhang Yi" (family name goes first [1])
according to
The Chinese phonetic alphabet spelling rules for Chinese names [2].

Indeed, that is also what the legel name is written in alphabet on our
passport or credit/debit cards.

Also, many official English-written materials use it in that way, for
example, a somewhat famous bastetball player Yao Ming [3][4][5].

That is what I wrote my own name as this but I also noticed the western
ordering of names is quite common for Chinese people in Linux kernel.
Anyway, it's just my preliminary personal thought (might be just my
own perference) according to (I think, maybe) formal occasions.

[1] https://en.wikipedia.org/wiki/Wikipedia:Naming_conventions_(Chinese)
[2] http://www.moe.gov.cn/ewebeditor/uploadfile/2015/01/13/20150113091249368.pdf
[3] https://en.wikipedia.org/wiki/Yao_Ming
[4] https://www.nbcsports.com/edge/basketball/nba/player/28778/yao-ming
[5] https://news.cgtn.com/news/2020-09-26/Spotlight-Ex-NBA-star-Yao-Ming-05-02-2018-U36mm3dYas/index.html

Thanks,
Gao Xiang

> 
> Thanks,
> Yi.


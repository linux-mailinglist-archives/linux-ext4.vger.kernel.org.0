Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE22034377F
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Mar 2021 04:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCVDgs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 23:36:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40864 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229613AbhCVDgZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Mar 2021 23:36:25 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12M3aBGY017762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Mar 2021 23:36:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DAE1215C39CC; Sun, 21 Mar 2021 23:36:10 -0400 (EDT)
Date:   Sun, 21 Mar 2021 23:36:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ext4 fixes for v5.12
Message-ID: <YFgQqjkSmCmvZ7LK@mit.edu>
References: <YFeQ9eBFn5JELyYo@mit.edu>
 <CAHk-=wjahvxdYmEgZEOqSSOVdTP-Njqbh6e8=PDVtt4Md7qHNg@mail.gmail.com>
 <ca33cb6a-9be9-1a2c-efa3-1dc5996897f6@huawei.com>
 <20210322030513.GA1925732@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322030513.GA1925732@xiangao.remote.csb>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 22, 2021 at 11:05:13AM +0800, Gao Xiang wrote:
> I think the legel name would be "Zhang Yi" (family name goes first [1])
> according to
> The Chinese phonetic alphabet spelling rules for Chinese names [2].
> 
> Indeed, that is also what the legel name is written in alphabet on our
> passport or credit/debit cards.
> 
> Also, many official English-written materials use it in that way, for
> example, a somewhat famous bastetball player Yao Ming [3][4][5].
> 
> That is what I wrote my own name as this but I also noticed the western
> ordering of names is quite common for Chinese people in Linux kernel.
> Anyway, it's just my preliminary personal thought (might be just my
> own perference) according to (I think, maybe) formal occasions.

Yeah, there doesn't seem to be a lot of consistency with the ordering
of Chinese names when they are written in Roman characters.  Some
people put the family name first, and other people will put the
personal (first) name first.  In some cases it may be because the
developer in question is living in America, and so they've decided to
use the American naming convention.  (Two example of this are former
ext4 developers Mingming Cao and Jiaying Zhang, who live in Portland
and Los Angelos, and their family names are Cao and Zhang,
respectively.)

My personal opinion is people should use whatever name they are
comfortable with, using whatever characters they prefer.  The one
thing that would be helpful for me is for people to give a hint about
how they would prefer to be called --- for example, would you prefer
that start an e-mail with the salutation, "Hi Gao", "Hi Xiang", or "Hi
Gao Xiang"?

And if I don't know, and I guess wrong, please feel free to correct
me, either privately, or publically on the e-mail list, if you think
it would be helpful for more people to understand how you'd prefer to
be called.

Cheers,

					- Ted

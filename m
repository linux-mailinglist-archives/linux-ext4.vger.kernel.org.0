Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9123436F7
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Mar 2021 04:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCVDBp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 23:01:45 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36628 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229761AbhCVDBM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Mar 2021 23:01:12 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12M30rIo010178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Mar 2021 23:00:54 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6616815C39CA; Sun, 21 Mar 2021 23:00:53 -0400 (EDT)
Date:   Sun, 21 Mar 2021 23:00:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] ext4 fixes for v5.12
Message-ID: <YFgIZe4vMRDm+g8u@mit.edu>
References: <YFeQ9eBFn5JELyYo@mit.edu>
 <CAHk-=wjahvxdYmEgZEOqSSOVdTP-Njqbh6e8=PDVtt4Md7qHNg@mail.gmail.com>
 <ca33cb6a-9be9-1a2c-efa3-1dc5996897f6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca33cb6a-9be9-1a2c-efa3-1dc5996897f6@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 22, 2021 at 09:33:54AM +0800, zhangyi (F) wrote:
> 
> I will use my real name "Yi Zhang" next time.
>

Hi Yi,

I think what Linus was suggsting was that if people wanted, they could
do something like this in their git commits:

From: 曹子德(Theodore Y Ts'o) <tytso@mit.edu>

I don't do this because my legal name is actually Theodore Yue Tak
Ts'o (where Ts'o Yue Tak is the standard romanization of my Chinese
name in Cantonese --- my parents were from Hong Kong), and even though
Cantonese is technically the first langauge I learned as a child, at
this point I'm probably more fluent in Spanish (my third language)
than Cantonese.  :-)

In any case, git and e-mail should be able to handle non-Roman
characters so if you want to insert your name in Chinese in your Git
authorship, please feel free to do so.  Or not --- it's totally up to
you.

Cheers,

					- Ted

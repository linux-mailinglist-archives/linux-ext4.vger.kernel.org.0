Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55691FDD4
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 04:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfEPC4v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 22:56:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36638 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726084AbfEPC4u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 May 2019 22:56:50 -0400
Received: from callcc.thunk.org (168-215-239-3.static.ctl.one [168.215.239.3] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4G2udBn009305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 May 2019 22:56:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1F19C420024; Wed, 15 May 2019 22:56:39 -0400 (EDT)
Date:   Wed, 15 May 2019 22:56:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Arthur Marsh <arthur.marsh@internode.on.net>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
Message-ID: <20190516025639.GC5394@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net>
 <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com>
 <20190511220659.GB8507@mit.edu>
 <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net>
 <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net>
 <17C30FA3-1AB3-4DAD-9B86-9FA9088F11C9@internode.on.net>
 <20190515045717.GB5394@mit.edu>
 <C24BBE18-1665-4343-9C98-5AF64BACDCA3@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C24BBE18-1665-4343-9C98-5AF64BACDCA3@internode.on.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 15, 2019 at 09:42:11PM +0930, Arthur Marsh wrote:
> I have built kernels with the attached patch applied and run git gc
> on the patched kernels (both the 32 bit kernel on the Pentium-D and
> the 64 bit kernel on the Athlon II X4 640).
> 
> There were a couple of warnings from other processes being blocked
> while the git gc was taking place but no filesystem corruption
> detected. (I ran forced fsck checks on the root filesystems after
> the git gc runs to check for corruption).
> 
> Thanks for the patch!

Thanks for the bug report!  My apologies for the inconvenience; I'm
going to take a look at improving my regression test configurations so
I would have noticed this earlier.

Cheers,

						- Ted

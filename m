Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF13288DD
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Mar 2021 18:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbhCARqW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Mar 2021 12:46:22 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60412 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238647AbhCARnO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Mar 2021 12:43:14 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 121HgMZP017946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Mar 2021 12:42:23 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B952015C3A88; Mon,  1 Mar 2021 12:42:22 -0500 (EST)
Date:   Mon, 1 Mar 2021 12:42:22 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>
Subject: Re: [PATCH] libfs: Fix DIO mode aligment
Message-ID: <YD0nfmr3Oo/+Q2Od@mit.edu>
References: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
 <YDmBmE159JOG8gRk@mit.edu>
 <77366B06-6C34-4515-A630-01534133E92A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77366B06-6C34-4515-A630-01534133E92A@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 01, 2021 at 07:14:00PM +0300, Благодаренко Артём wrote:
> Here is how I reproduced it originally (without the patch)
> 
> # truncate -s 512MB /tmp/lustre-ost
> # losetup -b 4096 /dev/loop0 /tmp/lustre-ost
> # mkfs.ext4 /dev/loop0

Thanks for pointing out that this can be tested using losetup.

> With your patch e2image works fine.
> 
> [root@CO82 e2fsprogs-kernel]# git rev-parse HEAD
> 67f2b54667e65cf5a478fcea8b85722be9ee6e8d
> [root@CO82 e2fsprogs-kernel]# misc/e2image /dev/loop0 /tmp/ost-image
> e2image 1.46.1 (9-Feb-2021)

So commit 67f2b54667e6 is 1.46.2, so I'm not sure that you recompiled
e2image.  More importantly, e2image in upstream doesn't use Direct
I/O.  When I tried using debugfs -D, it looks like Direct I/O on an
Advanced Format HDD isn't working correctly:

# debugfs -D /dev/loop0
debugfs 1.46.2 (28-Feb-2021)
debugfs: Bad magic number in super-block while trying to open /dev/loop0
/dev/loop0 contains a ext4 file system
        created on Mon Mar  1 12:31:43 2021

This isn't a regression since it was broken in upstream before, but it
would be good to get this fixed before e2fsprogs 1.46.3.

Cheers,

						- Ted

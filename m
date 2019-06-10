Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FA23ADA9
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2019 05:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfFJDjc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Jun 2019 23:39:32 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35227 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387462AbfFJDjc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Jun 2019 23:39:32 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5A3dRID031481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 9 Jun 2019 23:39:28 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5F1BB420481; Sun,  9 Jun 2019 23:39:27 -0400 (EDT)
Date:   Sun, 9 Jun 2019 23:39:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jianchao Wang <jianchao.wan9@gmail.com>
Cc:     Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [HELP] What are the allocated blocks on a newly created ext4 fs ?
Message-ID: <20190610033927.GA15963@mit.edu>
References: <b64110a4-8112-a230-2179-5095aa943af9@gmail.com>
 <7FD3148B-1E27-4BFA-965C-9FDC7FC8FD96@gmail.com>
 <22ccd72a-8926-0d12-0fbe-8ad5604d1584@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ccd72a-8926-0d12-0fbe-8ad5604d1584@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 10, 2019 at 11:25:47AM +0800, Jianchao Wang wrote:
> Hi Artem 
> 
> Thanks so much for your help.
> 
> On 2019/6/6 20:32, Artem Blagodarenko wrote:
> > Hello Jianchao,
> > 
> > Not enought input data to give an answer. It depends on mkfs options. For example, if flex_bg option is enabled, then several block groups are tied together as one logical block group; the bitmap spaces and the inode table space in the first block group, so some groups are not totally free just after FS creating.
> 
> In my environment, there are 16 bgs per flex_bg.
> The bitmaps and inode table .etc should lay on the first bg of every flex_bg.
> So I can see there are about 8223 blocks allocated in the 1st bg of every flex_bg.
> 
> But as you can see in the output of mb_groups, there are some bgs
> which get allocated about 1024 blocks.
> 
> I have out figured out what are they for.

The best way to understand what the blocks are used for is to use the
dumpe2fs program, e.g:

% mke2fs -t ext4 -Fq /tmp/foo.img 1T
% dumpe2fs /tmp/foo.img | more
    ...
Group 0: (Blocks 0-32767) csum 0xe6f6 [ITABLE_ZEROED]
  Primary superblock at 0, Group descriptors at 1-128
  Reserved GDT blocks at 129-1152
  Block bitmap at 1153 (+1153), csum 0xb033995a
  Inode bitmap at 1169 (+1169), csum 0x108d3d73
  Inode table at 1185-1696 (+1185)
  23385 free blocks, 8181 free inodes, 2 directories, 8181 unused inodes
  Free blocks: 9383-32767
  Free inodes: 12-8192
Group 1: (Blocks 32768-65535) csum 0xe50b [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
  Backup superblock at 32768, Group descriptors at 32769-32896
  Reserved GDT blocks at 32897-33920
  Block bitmap at 1154 (bg #0 + 1154), csum 0x00000000
  Inode bitmap at 1170 (bg #0 + 1170), csum 0x00000000
  Inode table at 1697-2208 (bg #0 + 1697)
  31615 free blocks, 8192 free inodes, 0 directories, 8192 unused inodes
  Free blocks: 33921-65535
  Free inodes: 8193-16384
    ...


Regards,

						- Ted

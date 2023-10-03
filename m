Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1B7B74D0
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Oct 2023 01:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjJCXZc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Oct 2023 19:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbjJCXZb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Oct 2023 19:25:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E154AC
        for <linux-ext4@vger.kernel.org>; Tue,  3 Oct 2023 16:25:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 393NP5tU020762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 19:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696375508; bh=j9XN+IkTAwuVm7/CBLpjxGCYIwV9bGQ6BJq8lQ3MHz8=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=jGD1xuKehceFXnhiEvHGX6V9ZUa3yJL/uprdYnfQmJ4iWYaaJPnq5wlUPHX+Cu3mT
         WUqXlHHWqhi0hzeA+xDNJ/4QI1YADj9t4dMlJ5tdXzuGbXe4cFoAhYM/AR2ty95ZRu
         yrXpq3hIBI8FrFgXV52oUdhIkDSHNcoWQBPAXAQqQiJoW389XDrZDm33qFuL1rVZb3
         0WRtvotGbcWhyJVfu92jogc2T6B3pEYTyyMAmOerOObLdUXU889V7TT+nnUulCs1D+
         +lE0G1iWYsy584kpnoeCsqOJQH5Tjpu5HV+7ymsa8DPWiRnsMBkpJaNNuccEVtUmbU
         KRKxYjLKtdinA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6967715C0266; Tue,  3 Oct 2023 19:25:05 -0400 (EDT)
Date:   Tue, 3 Oct 2023 19:25:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andres Freund <andres@anarazel.de>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-ext4@vger.kernel.org,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        groeck@google.com, zsm@google.com, garrick@google.com,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [syzbot] INFO: task hung in ext4_fallocate
Message-ID: <20231003232505.GA444157@mit.edu>
References: <d89989ef-e53b-050e-2916-a4f06433798b@collabora.com>
 <ZQjKOjrjDYsoXBXj@mit.edu>
 <20231003141138.owt6qwqyf4slgqgp@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003141138.owt6qwqyf4slgqgp@alap3.anarazel.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 03, 2023 at 07:11:38AM -0700, Andres Freund wrote:
> Hi,
> 
> On 2023-09-18 18:07:54 -0400, Theodore Ts'o wrote:
> > On Mon, Sep 18, 2023 at 08:13:30PM +0530, Shreeya Patel wrote:
> > > When I tried to reproduce this issue on mainline linux kernel using the
> > > reproducer provided by syzbot, I see an endless loop of following errors :-
> > >
> > > [   89.689751][ T3922] loop1: detected capacity change from 0 to 512
> > > [   89.690514][ T3916] EXT4-fs error (device loop4): ext4_map_blocks:577:
> > > inode #3: block 9: comm poc: lblock 0 mapped to illegal pblock 9 (length 1)
> > > [   89.694709][ T3890] EXT4-fs error (device loop0): ext4_map_blocks:577:
> >
> > Please note that maliciously corrupted file system is considered low
> > priority by ext4 developers.
> 
> FWIW, I am seeing occasional hangs in ext4_fallocate with 6.6-rc4 as well,
> just doing database development on my laptop.

Unless you are using a corrupted file system (e.g., there are EXT4-fs
error messages in dmesg), it's likely a different issue.

There is issue here which doesn't involve a corrupted file system
recently reported:

	https://bugzilla.kernel.org/show_bug.cgi?id=217965

However, *please* let's not conflate bug reports unless we know they
are the same thing.  It's better to keep reports separate, as opposed
to having users see multiple bug reports with vaguely the same
symptoms (say, like a headache) and pestering a doctor at a cocktail
party claiming that *of* *course* their issue is the same as the one
they read about in some vlog because the symptoms are the same.

(This is why I hate, hate, HATE bug reports via Launchpad, which tend
very much to be a flaming hott mess....)

Can you give us details about (a) what kind of block device; are you
using dm-crypt, or just a HDD or a SSD?  If an SSD, what kind of SSD?
What CPU architecture is it?  And can you send me the output of
dumpe2fs -h <block device>?  And while the file system is mounted,
please send the contents of /proc/fs/<block-device>/options, e.g.:

% cat /proc/fs/ext4/dm-0/options 
rw
bsddf
nogrpid
block_validity
dioread_nolock
nodiscard
delalloc
nowarn_on_error
journal_checksum
barrier
auto_da_alloc
user_xattr
acl
noquota
resuid=0
resgid=0
errors=remount-ro
commit=5
min_batch_time=0
max_batch_time=15000
stripe=0
data=ordered
inode_readahead_blks=32
init_itable=10
max_dir_size_kb=0

And finally, how full was the file system?  What is the output of "df
<mountpoint>" and "df -i <mountpoint>".

Thanks,

						- Ted

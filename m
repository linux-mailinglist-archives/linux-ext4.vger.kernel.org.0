Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C957169BB
	for <lists+linux-ext4@lfdr.de>; Tue,  7 May 2019 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfEGR7z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 May 2019 13:59:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58301 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726545AbfEGR7z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 May 2019 13:59:55 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x47HxMYQ016129
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 May 2019 13:59:22 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 85F2E420024; Tue,  7 May 2019 13:59:21 -0400 (EDT)
Date:   Tue, 7 May 2019 13:59:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Probir Roy <proy.cse@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Locality of extent status tree traversal
Message-ID: <20190507175921.GD5900@mit.edu>
References: <CALe4XzYNBKhtcYvcuME0A29LvPuZEuirD3DLtHnffObRCUU8Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALe4XzYNBKhtcYvcuME0A29LvPuZEuirD3DLtHnffObRCUU8Rg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 07, 2019 at 11:12:07AM -0500, Probir Roy wrote:
> 
> I am running Phoronix-fio benchmark on Linux kernel 4.18.0-rc5. I
> observe the same nodes have been traversed on the extent status tree
> in "ext4_es_lookup_extent" function when ext4 write begins. What's the
> locality signature of "ext4_es_lookup_extent" in general? Is it
> possible that same logical block being looked up repeatedly
> (Temporal)? Is it possible that co-located logical blocks are searched
> by ext4_es_lookup_extent (spatial)?  Or is it totally random?

I'm not sure what you are asking.  The ext4_es_lookup_extent() is used
as a fast map of an inode's logical block number to find the physical
block number (e.g., the location on disk).  It's a cache; lookups are
fast, and is an in-memory lookup.  Well, it's a little more than a
cache, it also stores some information for delayed allocation buffered
writes.

If the workload is a random read or random write workload, then
accesses to look up logical to physical block maps will be random.  If
the workload is mostly a sequential read or sequential write access,
then the logical blocks looked up via ext4_es_lookup_extent() will
largely be sequential.

						- Ted

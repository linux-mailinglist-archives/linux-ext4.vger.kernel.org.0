Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2495549883A
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jan 2022 19:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbiAXSX3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jan 2022 13:23:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58042 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235901AbiAXSX2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jan 2022 13:23:28 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20OINM5s029075
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 13:23:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7201342011A; Mon, 24 Jan 2022 13:23:21 -0500 (EST)
Date:   Mon, 24 Jan 2022 13:23:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lyu Tao <tao.lyu@epfl.ch>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: How does EXT4 ensures two processes don't modify and synchronize
 one page at the same time.
Message-ID: <Ye7umfsRLkxAeUEv@mit.edu>
References: <6fdeab9535134fc18e86968b10e726c6@epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fdeab9535134fc18e86968b10e726c6@epfl.ch>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 24, 2022 at 05:17:34PM +0000, Lyu Tao wrote:
> 
> I'm new to file system area and have a naive question about the global sync.
> 
> Let's suppose there are two process are writing to the same file. If
> one process issues a sync() syscall, which mechanism can ensures the
> two processes don't modify and synchronize one page at the same
> time.

That's not what the sync() system call purports to do.  To quote from
the sync(2) man page:

       sync() causes all pending modifications to filesystem metadata
       and cached file data to be written to the underlying
       filesystems.

						- Ted

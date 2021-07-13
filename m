Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7848B3C77BF
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 22:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhGMUU5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 16:20:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36227 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231499AbhGMUU5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 16:20:57 -0400
Received: from callcc.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16DKI14s028545
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 16:18:02 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 47CE34202F5; Tue, 13 Jul 2021 16:18:01 -0400 (EDT)
Date:   Tue, 13 Jul 2021 16:18:01 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: Regarding ext4 extent allocation strategy
Message-ID: <YO30+XRGAYnME+vy@mit.edu>
References: <CANT5p=o3i4kWQuMFF5zKQp04JnWEQnYuo+cvyH8asGMvTVBBkw@mail.gmail.com>
 <YO17ZNOcq+9PajfQ@mit.edu>
 <CANT5p=qi8-9iZa0XE70ZaCUdqscKufovjcUAZZPDRmN9W5_uQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANT5p=qi8-9iZa0XE70ZaCUdqscKufovjcUAZZPDRmN9W5_uQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 13, 2021 at 06:27:37PM +0530, Shyam Prasad N wrote:
> 
> Also, is this parameter also respected when a hole is punched in the
> middle of an allocated data extent? i.e. is there still a possibility
> that a punched hole does not translate to splitting the data extent,
> even when extent_max_zeroout_kb is set to 0?

Ext4 doesn't ever try to zero blocks as part of a punch operation.
It's true a file system is allowed to do it, but I would guess most
wouldn't, since the presumption is that userspace is actually trying
to free up disk space, and so you would want to release the disk
blocks in the punch hole case.

The more interesting one is the FALLOC_FL_ZERO_RANGE_FL operation,
which *should* work by transitioning the extent to be uninitialized,
but there might be cases where writing a few zero blocks might be
faster in some cases.  That should use the same code path which
resepects the max_zeroout configuration parameter for ext4.

Cheers,

					- Ted

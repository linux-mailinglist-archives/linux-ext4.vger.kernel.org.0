Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A763B8B6A
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jul 2021 02:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhGAAus (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 20:50:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39744 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236734AbhGAAus (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 20:50:48 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1610m5Do030908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 20:48:05 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DB01315C3C8E; Wed, 30 Jun 2021 20:48:04 -0400 (EDT)
Date:   Wed, 30 Jun 2021 20:48:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 1/2] fs: ext4: Consolidate checks for resize of bigalloc
 into ext4_resize_begin
Message-ID: <YN0QxMh7ymC8obre@mit.edu>
References: <bee03303d999225ecb3bfa5be8576b2f4c6edbe6.1623093259.git.josh@joshtriplett.org>
 <YNSVUy/DTWdhzuci@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSVUy/DTWdhzuci@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 24, 2021 at 10:23:15AM -0400, Theodore Ts'o wrote:
> On Mon, Jun 07, 2021 at 12:15:08PM -0700, Josh Triplett wrote:
> > Two different places checked for attempts to resize a filesystem with
> > the bigalloc feature. Move the check into ext4_resize_begin, which both
> > places already call.
> > 
> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> 
> Applied, thanks.

I'm going to have to revert this change, since it breaks online
resizing for bigalloc file system.  The issue is that
ext4_resize_begin() is called from *three* places: for
EXT4_IOC_GROUP_ADD, EXT4_IOC_GROUP_EXTEND, and EXT4_IOC_RESIZE_FS.
The first two ioctls are used for the "old-style" online resize, and
bigalloc is not supported for those two ioctls.  However, it *is*
supposed to work for EXT4_IOC_RESIZE_FS.

Unfortunately, this just caused some tests to be skipped (assuming
that this was an old kernel that didn't support this feature) and I
didn't notice it right away.

						- Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C289C06E
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Aug 2019 23:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfHXVYz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Aug 2019 17:24:55 -0400
Received: from ms.lwn.net ([45.79.88.28]:50340 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbfHXVYy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 24 Aug 2019 17:24:54 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1BB5B300;
        Sat, 24 Aug 2019 21:24:54 +0000 (UTC)
Date:   Sat, 24 Aug 2019 15:24:53 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ayush Ranjan <ayushr2@illinois.edu>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Ext4 documentation fixes.
Message-ID: <20190824152453.03737143@lwn.net>
In-Reply-To: <DEDD6BA5-6E18-4ED6-9EF6-E11EDA593700@dilger.ca>
References: <CA+UE=SPyMXZUhHFm0KgvihPdaE=yH5ra6n1C4XhKgM6aGheo=A@mail.gmail.com>
        <DEDD6BA5-6E18-4ED6-9EF6-E11EDA593700@dilger.ca>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 15 Aug 2019 09:16:23 -0700
Andreas Dilger <adilger@dilger.ca> wrote:

> On Aug 15, 2019, at 09:11, Ayush Ranjan <ayushr2@illinois.edu> wrote:
> > 
> > This commit aims to fix the following issues in ext4 documentation:
> > - Flexible block group docs said that the aim was to group block
> >   metadata together instead of block group metadata.
> > - The documentation consistly uses "location" instead of "block number".
> >   It is easy to confuse location to be an absolute offset on disk. Added
> >   a line to clarify all location values are in terms of block numbers.
> > - Dirent2 docs said that the rec_len field is shortened instead of the
> >   name_len field.
> > - Typo in bg_checksum description.
> > - Inode size is 160 bytes now, and hence i_extra_isize is now 32.
> > - Cluster size formula was incorrect, it did not include the +10 to
> >   s_log_cluster_size value.
> > - Typo: there were two s_wtime_hi in the superblock struct.
> > - Superblock struct was outdated, added the new fields which were part
> >   of s_reserved earlier.
> > - Multiple mount protection seems to be implemented in fs/ext4/mmp.c.
> > 
> > Signed-off-by: Ayush Ranjan <ayushr2@illinois.edu>  
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

I've applied this to the docs tree.

However, Ayush: the patch was rather badly corrupted by your mail client.
I managed to fix it up, but please in the future verify that you can email
a patch to yourself and apply it before submitting it.  There may be some
useful hints in Documentation/process/email-clients.rst .

Thanks,

jon

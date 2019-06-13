Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F1444EB3
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 23:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfFMVsV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 17:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfFMVsT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Jun 2019 17:48:19 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F14420B7C;
        Thu, 13 Jun 2019 21:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560462499;
        bh=bCgYxX1E/4s6Fxg/0kiaw3LoxcKY2daEMAP11fQA2h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xd9O0nD2Uz5HC3wjaKi4ioxh2QXjLdqborTGlRI5FsShVAfpvJyhlVby3zIIA9z9Q
         IGgo1Q5ZeLMuig9TYB0CBlQHIZLtJSySr3PQLHRfgpHlg0fRQ83dRhHS6Zpg2CWaFW
         Tokaui8lRqTqcnGAOOSHcPwnkNfoSXWd8ADia7ts=
Date:   Thu, 13 Jun 2019 14:48:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Sebastien Buisson <sbuisson@ddn.com>,
        Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>
Subject: Re: [RFC PATCH v2 7/8] fscrypt: wire up fscrypt to use blk-crypto
Message-ID: <20190613214816.GA48831@gmail.com>
References: <20190605232837.31545-1-satyat@google.com>
 <20190605232837.31545-8-satyat@google.com>
 <20190613185556.GD686@sol.localdomain>
 <C58B3116-8BE1-49F5-93ED-A73E8E72703E@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C58B3116-8BE1-49F5-93ED-A73E8E72703E@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[+Satya and Paul]

On Thu, Jun 13, 2019 at 03:30:13PM -0600, Andreas Dilger wrote:
> [reduced CC list, since I don't think this is interesting outside ext4]
> 
> On Jun 13, 2019, at 12:55 PM, Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > What it really enables is a cryptosystem and on-disk format change where, for
> > the purpose of working better with inline encryption, file contents are
> > encrypted with the master key directly (or for v2 encryption policies it will be
> > a per-mode derived key as it really should be, once we can actually get the v2
> > encryption policy support reviewed and merged), and the inode numbers are added
> > to the IVs.  As we know, when ext4 support is added, this will also preclude the
> > filesystem from being resized.
> 
> Just as an aside, I thought that the inode number would *not* be added to the IV,
> exactly so that ext4 filesystem resize would work?
> 
> I guess it shouldn't *strictly* preventing filesystem resizing, only the case of
> shrinking the filesystem and having to relocate encrypted inodes.  Expanding the
> filesystem shouldn't have that problem at all, nor should shrinking if there isn't
> a need to relocate the encrypted inodes.  Moving encrypted blocks should be OK,
> since the logical block numbers (and hence derived block IV) would stay the same.
> 

Yes, this is all correct.  The limitation on ext4 filesystem shrinking will be a
tradeoff to get inline encryption support to work efficiently.  Satya hasn't
implemented ext4 support yet, but as part of it I think we'll need to add an
ext4 superblock feature flag that forbids filesystem shrinking.

So unless we find a better way, people who need ext4 filesystem shrinking will
need to use the existing ext4 encryption format instead, which isn't optimized
for inline encryption.

This isn't an issue for Android (the motivating use case for this) since the
user data partition on Android devices is never shrunk.

> Something like https://patchwork.ozlabs.org/patch/960766/ "Add block_high_watermark
> sysfs tunable" would allow pre-migrating encrypted files in userspace via data copy
> (read/decrypt+write/encrypt) before doing the resize, if necessary, so that files
> do not use inode numbers that will be cut off the end of the filesystem.

If I understand that patch correctly, it only implements a high watermark for
data blocks, not inode numbers?  We need to ensure that an inode number is never
changed without also decrypting + encrypting the data.

- Eric

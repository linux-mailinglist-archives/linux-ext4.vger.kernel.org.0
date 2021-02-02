Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C114030CDC8
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 22:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhBBVNF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 16:13:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234123AbhBBVNE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 2 Feb 2021 16:13:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 118AF64E2C;
        Tue,  2 Feb 2021 21:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612300343;
        bh=03p+YG0k6cqhvv/p/PcMm18f46IbvV/TYJlsk3PX5b0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHydzpg6QbVaGqiors7IsACDmtwdYiisP/21fqrszCLrIMtss70kiyoQrV1hbEzrT
         8S6XmP1+LvgnU4UyA0HfaksMAYUem16aeFDHEo1WndYo53/xCPtBXeZQnKju/UjKWm
         9xQGzDdOs9/qQRIIRfKlhf/Cp1HMhXv5RCxMGOQlk9P8wVxYdUZf5cOKrFiACoSBTM
         1Cs+X3LiMRfieFW7tEM6SSMDpapYwh7ZV9rNAfPY0+Db0r0ikuV8PhseQFRpGFn1oz
         gJ3nR8MXxcMgpx4cwll93562IyL24R86q/lS/5gXgvu7zzzPItLELIJeGY8eKLdnlq
         hx3aaGgYlfLCQ==
Date:   Tue, 2 Feb 2021 13:12:21 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [ANNOUNCE] e2fsprogs v1.46.0
Message-ID: <YBnANYriLeiVUM1K@gmail.com>
References: <YBmMlwBaoC58CARb@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBmMlwBaoC58CARb@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 02, 2021 at 12:32:07PM -0500, Theodore Ts'o wrote:
> E2fsprogs now supports the stable_inodes (COMPAT_STABLE_INODES) feature.
> This needed to support the siphash file system encryption algorithm,
> which calculates the initial vector (IV) for encryption based on the
> UUID and the inode number.  This means that we can't renumber inodes
> (for example, when shrinking a file system) and the UUID can't be
> changed without breaking the ability to decrypt the encryption.

Note that in the new encryption formats which stable_inodes allows, the
encryption algorithm is still AES-256-XTS, not SipHash.  (SipHash is a hash
function, not an encryption algorithm.)  It's the key derivation and IV
generation method that change.

> E2fsprogs now supports file systems which have both file system
> encryption and the casefold feature enabled.  This requires Linux
> version 5.10.

The kernel patches for encrypt + casefold on ext4 haven't been merged yet.  So
this combination actually won't be supported until Linux 5.12 at the earliest.

- Eric

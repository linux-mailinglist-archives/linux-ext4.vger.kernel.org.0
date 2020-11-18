Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5AE2B8705
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 22:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgKRVxN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 16:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgKRVxN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Nov 2020 16:53:13 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F8D624248;
        Wed, 18 Nov 2020 21:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605736392;
        bh=2hRMJXn1Lfa/wpfL9ecCTLnlSVGpeSrlpdya+fY7mEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/mhjmUuI376PMzR/VUkdNb7FKC1PmPOwlp3LTVFOYMkjZXYzJ8nP4uIBmH8bj+TU
         MOx4EAPoTQZmFKeWZyRSSQlpOWwFk4EE21jMIxp6YY+vLyU4j/QOxcwXJ8kl08r347
         /fUMrvjiJNZrqQ5qPUknbKz9kE22xNqqkZP8bCGM=
Date:   Wed, 18 Nov 2020 13:53:10 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix bogus warning in ext4_update_dx_flag()
Message-ID: <X7WXxl4gQEuvLxyO@sol.localdomain>
References: <20201118153032.17281-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153032.17281-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 04:30:32PM +0100, Jan Kara wrote:
> The idea of the warning in ext4_update_dx_flag() is that we should warn
> when we are clearing EXT4_INODE_INDEX on a filesystem with metadata
> checksums enabled since after clearing the flag, checksums for internal
> htree nodes will become invalid. So there's no need to warn (or actually
> do anything) when EXT4_INODE_INDEX is not set.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Fixes: 48a34311953d ("ext4: fix checksum errors with indexed dirs")
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
